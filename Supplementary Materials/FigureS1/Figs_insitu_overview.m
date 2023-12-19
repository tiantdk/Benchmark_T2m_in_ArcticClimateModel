%% Figures displaying the coverage of the in situ data used for IST validation
clear all
addpath m_map1.4

saveplot = 0;
Ddays    = 1; 
alldays  =  datenum(1982,1,1,0,0,0):Ddays:datenum(2021,05,31,0,0,0); 
lwidth   = 7;
colorvec = [0 0.4470 0.7410; 0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250];

% load NP data info
load('matchups/NP_date_list.mat');

% All in one figure
figure('position', [4   193   560   700],'PaperPositionMode','auto')
subplot(4,1,1:3)
m_proj('Stereographic','lon',0,'lat',90,'radius',40,'rectbox','on')
j=1;
for dd = [ 4 3 7]
    load(['matchups/Matchup_ARC_0.05_T2m_L3_L4_daily_avgs_' num2str(dd) '__1982010112_2021053112.mat']);


    for i=1:length(Data)
        IA = find(Data(i).L4_sic>0.15);
        m_scatter(Data(i).long(IA),Data(i).lat(IA),15,colorvec(j,:).*ones(length(Data(i).long(IA)),1),'filled')
        hold on
    end
j = j +1;
end
m_coast('color','k');
m_grid
set(gcf,'PaperPositionMode','auto')
set(gca, 'FontSize', 14, 'LineWidth', 1.5); %<- Set properties

CRREL     = datenum(2001,4,14,0,0,0):Ddays:datenum(2017,9,4,0,0,0);
ECMWF     = datenum(1993,9,15,0,0,0):Ddays:datenum(2015,01,01,0,0,0);
NP        = datenum(NP_date_list);
d1 = datenum(NP_date_list(1));
d2 = datenum(NP_date_list(end));
YNP = d1:d2;

[y,m,d] = ymd(NP_date_list');
ymi = [y,m];
ymu = unique(ymi,'rows');

for i=1:length(ymu)
    idates = datetime(ymu(i,1),ymu(i,2),1:eomday(ymu(i,1),ymu(i,2)));
    if i == 1
        alldates = idates;
    else
        alldates = [alldates idates];
    end
end
[C,IA,IB] = intersect(YNP,datenum(alldates)') 
YYNP=YNP*0+6;
YYNP(setdiff(1:end,IA)) = NaN;

subplot(4,1,4)
plot(ECMWF,ECMWF*0+1,'color',colorvec(1,:),'LineWidth',lwidth)
hold on
plot(CRREL,CRREL*0+2,'color',colorvec(2,:),'LineWidth',lwidth)
plot(YNP,YYNP*0+3,'color',colorvec(3,:),'LineWidth',lwidth)
datetick('x',10)
set(gca,'Xtick',[datenum(1985,1,1,0,0,0) datenum(1990,1,1,0,0,0)  datenum(1995,1,1,0,0,0)   datenum(2000,1,1,0,0,0)   datenum(2005,1,1,0,0,0)   datenum(2010,1,1,0,0,0)  datenum(2015,1,1,0,0,0) datenum(2020,1,1,0,0,0) ])    
set(gca,'Xticklabel',['1985' ;'1990' ; '1995'; '2000'; '2005';  '2010'; '2015' ; '2020'])
xlabel('Year')
set(gca,'YTick',[]);
axis([alldays(1) alldays(end) 0 4])
set(gcf,'PaperPositionMode','auto')
set(gca, 'FontSize', 11); %<- Set properties
legend('ECMWF','CRREL','NP','NumColumns',3)
if saveplot == 1; print('-dpng','-r600',['/data/nis/climate/home/pne/projects/CMEMS/matlab/png/insitu_ist_overview.png']); end

%% Separate figs

j=1;
for dd = [ 4 3 7]
    figure('position', [4   193   560   700],'PaperPositionMode','auto')
    m_proj('Stereographic','lon',0,'lat',90,'radius',40,'rectbox','on')
    load(['matchups/Matchup_ARC_0.05_T2m_L3_L4_daily_avgs_' num2str(dd) '__1982010112_2021053112.mat']);

    for i=1:length(Data)
        IA = find(Data(i).L4_sic>0.15);
        m_scatter(Data(i).long(IA),Data(i).lat(IA),15,colorvec(j,:).*ones(length(Data(i).long(IA)),1),'filled')
        hold on
    end
    m_coast('color','k');
    m_grid('xticklabel',[],'yticklabel',[])
    %colorbar
    set(gcf,'PaperPositionMode','auto')
    set(gca, 'FontSize', 14, 'LineWidth', 1.5); %<- Set properties
    j = j +1;
    if saveplot == 1; print('-dpng','-r600',['/data/nis/climate/home/pne/projects/CMEMS/matlab/png/insitu_ist_' num2str(dd) '_overview.png']); end
end

figure('position', [4   193   760   300],'PaperPositionMode','auto')
plot(ECMWF,ECMWF*0+1,'color',colorvec(1,:),'LineWidth',lwidth)
hold on
plot(CRREL,CRREL*0+2,'color',colorvec(2,:),'LineWidth',lwidth)
plot(YNP,YYNP*0+3,'color',colorvec(3,:),'LineWidth',lwidth)
datetick('x',10)
set(gca,'Xtick',[datenum(1985,1,1,0,0,0) datenum(1990,1,1,0,0,0)  datenum(1995,1,1,0,0,0)   datenum(2000,1,1,0,0,0)   datenum(2005,1,1,0,0,0)   datenum(2010,1,1,0,0,0)  datenum(2015,1,1,0,0,0) datenum(2020,1,1,0,0,0) ])
set(gca,'Xticklabel',['1985' ;'1990' ; '1995'; '2000'; '2005';  '2010'; '2015' ; '2020'])
xlabel('Year')
set(gca,'YTick',[]);
axis([alldays(1) alldays(end) 0 4])
set(gcf,'PaperPositionMode','auto')
set(gca, 'FontSize', 11); %<- Set properties
legend('ECMWF','CRREL','NP','NumColumns',3)
if saveplot == 1; print('-dpng','-r600',['/data/nis/climate/home/pne/projects/CMEMS/matlab/png/insitu_ist_barplot_overview.png']); end


