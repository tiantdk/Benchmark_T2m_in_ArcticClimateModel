close all;clear all;
addpath ~/data/toolbox/trend
reg='CAO';
dat={'OBS' 'ERA5'  'CMIP6' }
fz=14;C2K=273.15;
%=============== READ DATA T2m in K ===================
%fldmean_OBS_T2M_ARCTIC_1deg_1982-2020_gtc15_mm_CAO.nc
% file1=['fldmean_' dat{1} '_T2M_ARCTIC_1deg_1982-2020_m15pct_' reg]
% data1=double(ncread([dir file1 '.nc'],'t2m'));
% data1=squeeze(data1); D1=reshape(data1(1:468),12,39);obs=mean(D1,1);
% %fldmean_ERA5_T2M_ARCTIC_1deg_1982-2020_gtc15_mm_CAO.nc
% file1=['fldmean_' dat{2} '_T2M_ARCTIC_1deg_1982-2020_2m15pct_' reg ]
% data1=double(ncread([dir file1 '.nc'],'tas'));
% data1=squeeze(data1); D2=reshape(data1(1:468),12,39);
%
% file1=['fldmean_' dat{3} '_T2M_ARCTIC_1deg_1982-2014_2m15pct_' reg ]
% data1=double(ncread([dir file1 '.nc'],'tas'));
% data1=squeeze(data1); data1=[data1 ;nan(6*12,1)];D3=reshape(data1(1:468),12,39);
% DD=[mean(D2,1); mean(D3,1)];
%----
% x = 1982:2020;
% T1=mean(D1,1);
% T2=mean(D2,1)-T1;
% T3=mean(D3,1)-T1;
%-----------OBS---------SIE_OBS_1982-2020_circle.nc------------------------
% convert=1e12; % from m2 to million km 
% var='sea_ice_fraction';
% data2=double(ncread([dir 'SIE_OBS_1982-2020_CAO.nc'],var));
% data2=squeeze(data2)/convert; 
% D2=reshape(data2(1:468),12,39);
% A1=mean(D2,1);
% save(['fig2.mat'],'x','reg','T1','T2','T3','A1');
%%
load('fig2.mat')
figure('Units','pixels','Position',[10 100 800 1200]);
C2= [0.5 0.7 1];C1= [1 0 0]; CC=get(gca,'ColorOrder');
col{1}=[0 0 0];col{2}=CC(2,:);col{3}=CC(1,:);
col{5}=[0.83 0.35 0.99];col{6}=[0 158/256 115/256];col{7}=[0.6 0.6 0.6];
xLimit = [1980 2021];
%--------------------
h(1) = subplot(3,1,1);hold on;
t=[1:33];
load('cmip6_Tfldmean_sic70_m15pct.mat')
bm=squeeze(mean(t0,1))'+273.15-T1(t);
bmax=max(bm);bmin=min(bm);berr=std(bm,1);y=mean(bm,1);
curve1 = y-berr;
curve2 = y+berr;
h1=patch([x(t) flip(x(t))], [curve1 flip(curve2)], CC(6,:), 'FaceAlpha',0.25, 'EdgeColor','none')
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
plot(x,T2,'-','color',col{2},'LineWidth',2);
plot(x,T3,'-','color',col{3},'LineWidth',2);
plot([1980 2021],[0 0],'-','color','k');
plot([1995 1995],[-5 5],'-','color',col{7});
plot([2014 2014],[-5 5],'-','color',col{7});
set(gca,'Color','none','XColor',get(gcf,'color'),'YColor','k','fontsize',fz,...
    'XLim',xLimit,'YLim',[-3.1 3],'Tickdir','out',... 
    'XTick',[1980:5:2020],'XAxisLocation', 'top','YAxisLocation','left','box','off');
ylabel('{\Delta}{\it T}_{2m} (^{o}C)','color','k')
%----------
b = polyfit(t,T2(t), 1);tr(1)=round(10*b(1),2);
fr = polyval(b, t);
plot(x(t),fr,'-','color',col{2},'linewidth',0.5);
b = polyfit(t,T3(t), 1);tr(2)=round(10*b(1),2);
fr = polyval(b, t);
plot(x(t),fr,'-','color',col{3},'linewidth',0.5);
text(1981,3.3,'a)$\mathrm{{\it T}_{2m}^{\,ERA5} -{\it T}_{2m}^{\,SAT}}$','interpreter','latex','color',col{2},'FontWeight','bold','fontsize',fz+4);
text(2004,3,[sprintf('%04.2f', tr(1)) ' ^{o}C per decade'],'color',col{2},'FontWeight','normal','fontsize',fz);
text(1981,-2.,'b)$\mathrm{{\it T}_{2m}^{\,CMIP6} -{\it T}_{2m}^{\,SAT}}$','interpreter','latex','color',col{3},'FontWeight','bold','fontsize',fz+4);
text(2004,-1.2,[sprintf('%04.2f', tr(2)) ' ^{o}C per decade'],'color',col{3},'FontWeight','normal','fontsize',fz);
%--------------------------------------------------
h(2) = subplot(3,1,2);hold on;
plot(x,T1+T2-C2K,'-','color',col{2},'LineWidth',2);
plot(x,T1+T3-C2K,'-','color',col{3},'LineWidth',2);
plot(x,T1-C2K,'color',col{5},'linewidth',2);
set(gca,'Color','none','XColor',get(gcf,'color'),'YColor',col{5},'fontsize',fz,...
    'XLim',xLimit,'YLim',[-16.5 -10],'Tickdir','out',...
    'XTick',[1980:5:2020],'XTickLabel',[],'YAxisLocation','right','box','off');
ylabel('{\it T}_{2m} (^{o}C)','color',col{5});
%---
b = polyfit(t,T1(t)-C2K, 1);tr(3)=round(10*b(1),2);
fr = polyval(b, t);
plot(x(t),fr,'-','color',col{5},'linewidth',0.5);
text(1981,-14.8,'c)$\mathrm{{\it T}_{2m}^{\,SAT}}$','interpreter','latex','color',col{5},'FontWeight','bold','fontsize',fz+4)
text(2003.5,-15,['+' sprintf('%04.2f', tr(3)) ' ^{o}C per decade'],'color',col{5},'FontWeight','normal','fontsize',fz);
plot([1995 1995],[-17 -12],'-','color',col{7});
plot([2014 2014],[-17 -12],'-','color',col{7});
%-----------------------------------------------
h(3) = subplot(3,1,3); hold on;
plot(x,A1,'color',col{6},'linewidth',2);
set(gca,'Color','none','YColor',col{6},'fontsize',fz,...
    'XLim',xLimit,'YLim',[7 10],'Tickdir','out','Ydir','reverse',...
    'YAxisLocation','left','box','off');
xlabel('Year');
ylabel({'     Area with SIC \geq 70% (10^{6} km^{2})'},'Color',col{6});
%---
t=[1:33];
text(1981,8.3,'d) Observed sea ice coverage','interpreter','latex','color',col{6},'FontWeight','bold','fontsize',fz+4)
plot([1995 1995],[7 20],'-','color',col{7});
plot([2014 2014],[7 20],'-','color',col{7});
%       
 pos=get(h(1), 'Position');
 set(h(1), 'Position', [pos(1)-0.05 pos(2)-0.19 pos(3) pos(4)]);
 pos=get(h(2), 'Position');
 set(h(2), 'Position', [pos(1)-0.05 pos(2)-0.1 pos(3) pos(4)]);
 pos=get(h(3), 'Position');
 set(h(3), 'Position', [pos(1)-0.05 pos(2) pos(3) pos(4)]);
linkaxes(h,'x'); 
figname='Fig2';
set(findall(gcf,'-property','FontSize'),'FontSize',fz);
set(gcf,'PaperPositionMode','auto');
%print('-depsc2','-r300', [figname '.eps']);
%print('-dpng','-r300', figname);
%convert -alpha off -density 300 -trim Fig2.png Fig2.png
%
