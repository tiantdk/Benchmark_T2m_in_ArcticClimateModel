clear all; close all;
dir='./';
par='tas';
perd='198201-201412'
C2K=273.15;fz=14;lw=3;mk=10;
cfiles={' 1985-1994 ' ' 1995-2004 ' ' 2005-2014 ' '  ' '  ' ' ' }
%-----------OBS------------------------------------------
% ncname=['../fig2/fldmean_OBS_T2M_ARCTIC_1deg_1982-2020_m15pct_CAO'];
% data1=double(ncread([dir ncname '.nc'],'t2m'));
% obs1=squeeze(data1)%-C2K;
% O1=reshape(obs1(1:468),12,39);
% O1_file=ncname;
%----   -------------------------------------------------
% ncname=['../fig2/fldmean_ERA5_T2M_ARCTIC_1deg_1982-2020_2m15pct_CAO'];
% data3=double(ncread([dir ncname '.nc'],'tas'));
% era1=squeeze(data3)%-C2K;
% E1=reshape(era1(1:468),12,39);
% E1_file=ncname;
%----
% ncname=['../fig2/fldmean_CMIP6_T2M_ARCTIC_1deg_1982-2014_2m15pct_CAO']; 
% data5=double(ncread([dir ncname '.nc'],'tas'));
% mod1=squeeze(data5)%-C2K;
% P1=reshape(mod1,12,33);
% P1_file=ncname;
%save(['fig3.mat'],'E1','O1','P1','E1_file','O1_file','P1_file');
%%
load(['fig3.mat'])
figure;hold on;
set(gcf,'position',[10 10 900 500]);
CC=get(gca,'ColorOrder');
C1=CC(1,:); %blue
C2=CC(6,:); %light blue
C3=[1 0.8 0.7];
C4=CC(2,:); %dark red
t1=[4:13];  t2=[14:23]; t3=[24:33];
%
plot([1:12],mean(E1(:,t1),2)-mean(O1(:,t1),2),'-','color',C2,'LineWidth',lw);
plot([1:12],mean(E1(:,t2),2)-mean(O1(:,t2),2),'-','color',C3,'LineWidth',lw);
plot([1:12],mean(E1(:,t3),2)-mean(O1(:,t3),2),'-','color','r','LineWidth',lw);
%
plot([1:12],mean(P1(:,t1),2)-mean(O1(:,t1),2),'--','color',C2,'LineWidth',lw);
plot([1:12],mean(P1(:,t2),2)-mean(O1(:,t2),2),'--','color',C3,'LineWidth',lw);
plot([1:12],mean(P1(:,t3),2)-mean(O1(:,t3),2),'--','color','r','LineWidth',lw);
%
xlim([1 12.3]);ylim([-3.5 3.5]);
box on;grid on;
legend(cfiles,'NumColumns',2,'Location','southeast');legend('boxoff');
text(8.2,-1.8,'ERA5');text(10.7,-1.8,'CMIP6');
set(gca,'xtick',1:12,...
 'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
ylabel('Temperature difference (^{o}C)')
xlabel('Month')
x=1:12;y(1:12)=0;
h=plot(x,y,'-','color','k');
h.Annotation.LegendInformation.IconDisplayStyle = 'off';
%-------------------------------
h1=plot(12.1,mean(mean(E1(:,t1),2)-mean(O1(:,t1),2)),'+','Markersize',mk,'Color',C2,'LineWidth',lw);
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
h2=plot(12.2,mean(mean(E1(:,t2),2)-mean(O1(:,t2),2)),'+','Markersize',mk+2,'Color',C3,'LineWidth',lw);
h2.Annotation.LegendInformation.IconDisplayStyle = 'off';
h3=plot(12.1,mean(mean(E1(:,t3),2)-mean(O1(:,t3),2)),'+','Markersize',mk,'Color','r','LineWidth',lw);
h3.Annotation.LegendInformation.IconDisplayStyle = 'off';
%
h1=plot(12.1,mean(mean(P1(:,t1),2)-mean(O1(:,t1),2)),'d','Markersize',mk,'MarkerFaceColor',C2,'MarkerEdgeColor',C2);
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
h2=plot(12.2,mean(mean(P1(:,t2),2)-mean(O1(:,t2),2)),'d','Markersize',mk,'MarkerFaceColor',C3,'MarkerEdgeColor',C3);
h2.Annotation.LegendInformation.IconDisplayStyle = 'off';
h3=plot(12.1,mean(mean(P1(:,t3),2)-mean(O1(:,t3),2)),'d','Markersize',mk,'MarkerFaceColor','r','MarkerEdgeColor','r');
h3.Annotation.LegendInformation.IconDisplayStyle = 'off';
for i=-4:1:-1
text(12.4,i,num2str(i),'fontsize',fz);
end
for i=0:1:4
text(12.5,i,num2str(i),'fontsize',fz);
end
%----------------------------------------------
set(findall(gcf,'-property','FontSize'),'FontSize',fz);
set(gcf,'PaperPositionMode','auto');
print('-depsc2','-r300', ['Fig3.eps']);
%print('-dpng','-r200',['Fig3.png']);
%close all;
%decadal annual mean
