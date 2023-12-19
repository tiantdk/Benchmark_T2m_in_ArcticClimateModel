clear all; close all;
dir1='sia_cmip/';
dir2='sia_obs/';
fz=14
%-----
figure;hold on; 
set(gcf,'position',[10 10 1200 1200]);
CC=get(gca,'ColorOrder')
%-----
cfiles={'ACCESS-CM2' 'ACCESS-ESM1-5' 'AWI-ESM-1-1-LR' 'CAMS-CSM1-0' 'CanESM5-1' ...
'CESM2-FV2' 'CESM2' 'CESM2-WACCM-FV2' 'CESM2-WACCM' 'CNRM-CM6-1' ...
'CNRM-ESM2-1' 'EC-Earth3-AerChem' 'EC-Earth3-CC' 'EC-Earth3' 'EC-Earth3-Veg' ...
'EC-Earth3-Veg-LR' 'GISS-E2-1-G' 'GISS-E2-1-H' 'MPI-ESM-1-2-HAM' 'MPI-ESM1-2-HR' ...
'MPI-ESM1-2-LR' 'MRI-ESM2-0' ...
'BCC-CSM2-MR' 'BCC-ESM1' 'CAS-ESM2-0' 'CMCC-CM2-HR4' 'CMCC-CM2-SR5' ...
'CMCC-ESM2' 'E3SM-1-0' 'E3SM-1-1-ECA' 'E3SM-1-1' 'FGOALS-f3-L' ...
'FGOALS-g3' 'FIO-ESM-2-0' 'GFDL-ESM4' 'HadGEM3-GC31-LL' 'INM-CM4-8' ...
'INM-CM5-0' 'IPSL-CM5A2-INCA' 'IPSL-CM6A-LR' 'IPSL-CM6A-LR-INCA' 'MIROC6' ...
'MIROC-ES2L' 'NESM3' 'NorESM2-LM' 'NorESM2-MM' 'SAM0-UNICON' ...
'TaiESM1' 'UKESM1-0-LL' 'KIOST-ESM' 'Multi-model mean (47)' 'DMI-SIC' 'ERA5' 'NSIDC 0051' 'HadISST.2.2.0.0' 'OSI-450a'}
% for i=1:50
% ncfile=[dir1 'sia_' cfiles{i} '_T2M_ARCTIC_1deg_198201-201412_mclim.nc'];
% csia(:,i)=squeeze(ncread(ncfile,'siconc'))/1000; %rmse(mean(csia,2)-obs)=0.33
% end
% nsia=[csia(:,1:3) csia(:,5:26) csia(:,29:50)];   %rmse(mean(nsia,2)-obs)=0.27
%------below are reference products  
% obs=squeeze(ncread([dir2 'sia_OSI_v0.1_T2M_ARCTIC_1deg_1982-2014_mclim.nc'],'siconc'))/1000;
% plot(obs,'+','Markersize',10,'color','r','linewidth',4);
% rsia=obs; % 1: DMI-SIC
% obs=squeeze(ncread([dir2 'sia_ERA5_SIC_ARCTIC_1deg_1982-2014_mclim.nc'],'siconc'))/1000;
% plot(obs,'d','Markersize',14,'color','y','linewidth',4);
% rsia=[rsia obs]; % 2: ERA5
% obs=squeeze(ncread([dir2 'sia_NSIDC-0051_SIC_ARCTIC_1deg_1982-2014_mclim.nc'],'siconc'))/1000;
% plot(obs,'o','Markersize',10,'color','c','linewidth',3,'MarkerFaceColor','none');
% rsia=[rsia obs]; % 3: nsidc
% obs=squeeze(ncread([dir2 'sia_HadISST2_SIC_ARCTIC_1deg_1982-2014_mclim.nc'],'siconc'))/1000;
% plot(obs,'x','Markersize',10,'color','k','linewidth',4);
% rsia=[rsia obs]; % 4: HadISST2
% obs=squeeze(ncread([dir2 'sia_OSI-450a_SIC_ARCTIC_1deg_1982-2014_mclim.nc'],'siconc'))/1000;
% plot(obs,'+','Markersize',8,'color','k','linewidth',3);
% rsia=[rsia obs]; % 5: osi-450a
%save(['FigS4_SIA.mat'],'csia','nsia','rsia','CC','x','fz','cfiles');
%%
load('FigS4_SIA.mat')
x=[0:1:13];
plot(csia,'linewidth',1.5)
xticks([1:1:12])
plot(mean(nsia,2),'-','color','k','linewidth',3);
xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
xlim([1 12]);ylim([0 18]);
ylabel('Sea Ice Area (mio km^{2})');
text(1,max(csia(:,4)),cfiles{4},'color',CC(4,:));
text(5,min(csia(6,27)),cfiles{27},'color',CC(27-21,:));
text(6,min(csia(7,28)),cfiles{28},'color',CC(7,:));
% legend(cfiles,'NumColumns',5);legend('boxoff');
%------below are reference products  
% obs=squeeze(ncread([dir2 'sia_OSI_v0.1_T2M_ARCTIC_1deg_1982-2014_mclim.nc'],'siconc'))/1000;
% plot(obs,'+','Markersize',10,'color','r','linewidth',4);
% rsia=obs; % 1: DMI-SIC
% obs=squeeze(ncread([dir2 'sia_ERA5_SIC_ARCTIC_1deg_1982-2014_mclim.nc'],'siconc'))/1000;
% plot(obs,'d','Markersize',14,'color','y','linewidth',4);
% rsia=[rsia obs]; % 2: ERA5
% obs=squeeze(ncread([dir2 'sia_NSIDC-0051_SIC_ARCTIC_1deg_1982-2014_mclim.nc'],'siconc'))/1000;
% plot(obs,'o','Markersize',10,'color','c','linewidth',3,'MarkerFaceColor','none');
% rsia=[rsia obs]; % 3: nsidc
% obs=squeeze(ncread([dir2 'sia_HadISST2_SIC_ARCTIC_1deg_1982-2014_mclim.nc'],'siconc'))/1000;
% plot(obs,'x','Markersize',10,'color','k','linewidth',4);
% rsia=[rsia obs]; % 4: HadISST2
% obs=squeeze(ncread([dir2 'sia_OSI-450a_SIC_ARCTIC_1deg_1982-2014_mclim.nc'],'siconc'))/1000;
% plot(obs,'+','Markersize',8,'color','k','linewidth',3);
% rsia=[rsia obs]; % 5: osi-450a
for i=1:12
h=plot([i i],[min(rsia(i,:)) max(rsia(i,:))],'k-','linewidth',1.5)
h.Annotation.LegendInformation.IconDisplayStyle = 'off';
end
%
plot(rsia(:,1),'+','Markersize',10,'color','r','linewidth',4); % 1: DMI-SIC
plot(rsia(:,2),'d','Markersize',14,'color','y','linewidth',4); % 2: ERA5
plot(rsia(:,3),'o','Markersize',10,'color','c','linewidth',3,'MarkerFaceColor','none'); % 3: nsidc
plot(rsia(:,4),'x','Markersize',10,'color','k','linewidth',4); % 4: HadISST2
plot(rsia(:,5),'+','Markersize',8,'color','k','linewidth',3);  % 5: osi-450a
% OSI_v0.1
h=plot(rsia(:,1),'+','Markersize',10,'color','r','linewidth',4);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';
% OSI-450a;
h=plot(rsia(:,5),'+','Markersize',8,'color','k','linewidth',3);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';
%
legend(cfiles,'NumColumns',4,'Location','southoutside');legend('boxoff');
box on
grid on
%save(['FigS3_SIA.mat'],'csia','nsia','rsia','CC','x','fz','cfiles');
set(findall(gcf,'-property','FontSize'),'FontSize',fz);
set(gcf,'PaperPositionMode','auto');
%print('-dpng','-r200', ['FigS4.png'])
print('-depsc2','-r300', ['FigS4.eps']);
%convert -alpha off -density 300 -trim -border 10x10 -bordercolor white
