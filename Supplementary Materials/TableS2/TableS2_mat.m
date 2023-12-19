close all;clear all;
addpath ~/data/toolbox/trend
dir='./';
%-------------
% cfile70={'fldmean_CMIP6_T2M_ARCTIC_1deg_1982-2014_2m15pct' ...
%     'fldmean_ERA5_T2M_ARCTIC_1deg_1982-2020_2m15pct' ...
%     'fldmean_OBS_T2M_ARCTIC_1deg_1982-2020_m15pct' ...
%     'fldmean_Berkeley_T2M_ARCTIC_1deg_1982-2020_m15pct' ...
%     'fldmean_ERA5_T2M_ARCTIC_1deg_1982-2020_m15pct'};
% var={'tas' 'tas' 't2m' 't2m' 't2m'};
% mT(1:39,1:5)=NaN;
% for i=1:5
%     data=squeeze(ncread([dir cfile70{i} '_CAO.nc'],var{i}));
%     if i<2
%     ny=33
%     else
%         ny=39
%     end
%     T1=reshape(data(1:12*ny),12,ny);
%     T2=mean(T1,1);
%     mT(1:ny,i)=T2;
% end
% save(['TableS2_sic70.mat'],'cfile70','var','mT');
load('TableS2_sic70.mat')
%%----------
% cfile15={'fldmean_CMIP6_T2M_ARCTIC_1deg_1982-2014_2m15pct' ...
%     'fldmean_ERA5_T2M_ARCTIC_1deg_1982-2020_2m15pct' ...
%     'fldmean_OBS_T2M_ARCTIC_1deg_1982-2020_m15pct' ...
%     'fldmean_Berkeley_T2M_ARCTIC_1deg_1982-2020_m15pct' ...
%     'fldmean_ERA5_T2M_ARCTIC_1deg_1982-2020_m15pct'};
% var={'tas' 'tas' 't2m' 't2m' 't2m'};
% mT(1:39,1:5)=NaN;
% for i=1:5
%     data=squeeze(ncread([dir cfile70{i} '_66.5N.nc'],var{i}));
%     if i<2
%     ny=33
%     else
%         ny=39
%     end
%     T1=reshape(data(1:12*ny),12,ny);
%     T2=mean(T1,1);
%     mT(1:ny,i)=T2;
% end
% save(['TableS2_sic15.mat'],'cfile15','var','mT');
load('TableS2_sic15.mat')
% %----
% cfile_oce={'fldmean_CMIP6_T2M_ARCTIC_1deg_198201-201412_ocean' ...
%     'fldmean_ERA5_T2M_ARCTIC_1deg_198201-202012_ocean' ...
%     'fldmean_665N_OBS_T2M_ARCTIC_1deg_198201-202012_mergeSST' ...
%     'fldmean_Berkeley_T2M_ARCTIC_1deg_198201-202012_ocean'};
%  var={'tas' 'tas' 't2m' 'temperature'};
%  mT(1:39,1:4)=NaN;
% for i=1:4
%     data=squeeze(ncread([dir cfile_oce{i} '.nc'],var{i}));
%     if i<2
%     ny=33
%     else
%         ny=39
%     end
%     T1=reshape(data(1:12*ny),12,ny);
%     T2=mean(T1,1);
%     mT(1:ny,i)=T2;
% end
% save(['TableS2_oce.mat'],'cfile_oce','var','mT');
load('TableS2_oce.mat')
% %--
% dir='trend/circle/'
% cfile_all={'fldmean_665N_CMIP6_T2M_global1_198201-201412' ...
%     'fldmean_665N_ERA5_T2M_global1_198201-202012' ...
%     'fldmean_665N_Berkeley_T2M_global1_198201-202012'};
%  var={'tas' 'tas'  'temperature'};
%  mT(1:39,1:3)=NaN;
% for i=1:3
%     data=squeeze(ncread([dir cfile_all{i} '.nc'],var{i}));
%     if i<2
%     ny=33
%     else
%         ny=39
%     end
%     T1=reshape(data(1:12*ny),12,ny);
%     T2=mean(T1,1);
%     mT(1:ny,i)=T2;
% end
% save(['TableS2_all.mat'],'cfile_all','var','mT');
clear all
load('TableS2_all.mat')
%--
x=1982:2020;
%----------
for i=1:3
    if i<2
        ny=33
    else
        ny=39
    end
    t=[1:ny];
    t=[1:33];
    T2=mT(:,i);    
    b = polyfit(t,T2(t), 1)
    tr(i)=round(10*b(1),3)
    cd ~/2023/IST/data/
    [h,p,ci,stats] = ttest1(T2(t))
    h_significant(i)=h;
    p_value(i)=p;
end
