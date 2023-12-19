% Calculate daily validation statistics using daily matchup files
% To obtain the statistics in Table 1, you need to 
% switch L4_source     = 'ERA5' to 'SAT'
% switch IST_stations  = [3 4 7];
clear all

analysis0     = '1982010112';
analysis1     = '2021053112';
mode          = ''; 
surftemp      = 't2m';
L4_source     = 'ERA5'; % choose validate data type 'SAT' or 'ERA5'
matchupdir    = 'matchups/';

IST_stations  = 3;      % choose obs type 3, 4, 7
if IST_stations== 3
    folder = 'CRREL';
elseif IST_stations == 4
    folder = 'ECMWF';
elseif IST_stations == 7
    folder = 'NP';
elseif IST_stations == 8
end

% Load daily matchup files
if strcmp(L4_source,'ERA5')
        ifile = [matchupdir 'Matchup_ERA5_0.05_T2m_L4_daily_avgs_' num2str(IST_stations) '_' mode '_' analysis0 '_' analysis1 '.mat' ];
elseif strcmp(L4_source,'SAT')
        ifile = [matchupdir 'Matchup_ARC_0.05_T2m_L3_L4_daily_avgs_' num2str(IST_stations) '_' mode '_' analysis0 '_' analysis1 '.mat' ];
end

load(ifile);



% Get the time
day0       = datenum(analysis0,'yyyymmddHH');
day1       = datenum(analysis1,'yyyymmddHH');

Nsta = numel(Data);
alldiff_L4 = [];
all_L4_SST = [];
all_insitu_SST = [];

for k = 1:Nsta
   
    Data(k).temp(isnan(Data(k).L4_SST)) = NaN;
    Data(k).L4_SST(isnan(Data(k).temp)) = NaN;
    
    % Only consider matchups with SIC>15%
    IA = find(Data(k).L4_sic>0.15);
    idiff_L4 = (Data(k).L4_SST(IA)-(Data(k).temp(IA)+273.15));
    
 
    alldiff_L4 = [alldiff_L4 idiff_L4];
    
    all_L4_SST = [all_L4_SST Data(k).L4_SST(IA)];
    all_insitu_SST = [all_insitu_SST (Data(k).temp(IA)+273.15)];
    
    N_L4 = numel(find(isnan(idiff_L4) == 0));
    M_L4 = nanmean(idiff_L4);
    M_L4 = nanmean(idiff_L4);
    S_L4 = nanstd(idiff_L4);
    C_L4 = corrcoef(Data(k).L4_SST(IA),(Data(k).temp(IA)+273.15));
    C_L4 = C_L4(2,1);
    
    NN = (strsplit(Data(k).imb_name ));
    %    whos
%     display([' N4: ' num2str(N_L4,'%4.4d')  ' M_L4: ' num2str(M_L4,'%6.2f') ...
%         ' L4 std: ' num2str(S_L4,'%6.2f')   ' L4 corr: ' num2str(C_L4,'%6.2f')  ])
    
    
end
N_L4 = numel(find(isnan(alldiff_L4) == 0));
M_L4 = nanmean(alldiff_L4);
S_L4 = nanstd(alldiff_L4);
R_L4 = sqrt(nanmean(alldiff_L4.^2));
C_L4 = corrcoef(all_L4_SST,all_insitu_SST,'rows','pairwise');
C_L4 = C_L4(2,1);

% display(['ALLDIFF, N4: ' num2str(N_L4,'%4.4d')  ' M_L4: ' num2str(M_L4,'%6.2f') ...
%     ' L4 std: ' num2str(S_L4,'%6.2f') ' RMS L4: ' num2str(R_L4,'%6.2f') ' L4 corr: ' num2str(C_L4,'%6.2f') ])

%3 sigma filter on all observations
all_L4_SST(abs(alldiff_L4-M_L4) >S_L4*3) = NaN;
all_insitu_SST(abs(alldiff_L4-M_L4) >S_L4*3) = NaN;

alldiff_L4(abs(alldiff_L4-M_L4) >S_L4*3) = NaN;

N_L4 = numel(find(isnan(alldiff_L4) == 0));
M_L4 = nanmean(alldiff_L4);
S_L4 = nanstd(alldiff_L4);
R_L4 = sqrt(nanmean(alldiff_L4.^2));
C_L4 = corrcoef(all_L4_SST,all_insitu_SST,'rows','pairwise');
C_L4 = C_L4(2,1);

M_conf   = 1.96*S_L4/sqrt(N_L4); % Emery p. 218
% S_conf_L = sqrt(N_L4*(S_L4)^2/chi2inv(0.95,N_L4));
% S_conf_U = sqrt(N_L4*(S_L4)^2/chi2inv(0.05,N_L4));


disp('Applying a 3-sigma filter')
display(['ALLDIFF2,N4: ' num2str(N_L4,'%4.4d')  ' M_L4: ' num2str(M_L4,'%6.2f') ...
    ' L4 std: ' num2str(S_L4,'%6.2f') ' RMS L4: ' num2str(R_L4,'%6.2f') ' L4 corr: ' num2str(C_L4,'%6.2f') ])
