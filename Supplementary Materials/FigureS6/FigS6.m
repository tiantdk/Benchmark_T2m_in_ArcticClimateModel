close all;clear all
fz=14;C2K=273.15;
t1=[4:13];  t2=[14:23]; t3=[24:33];
t=[1:33];
load('../../fig2/cmip6_Tfldmean_sic70_m15pct.mat')
for iy=1:33
tt(iy,:)=squeeze(mean(t0(:,iy,:),1))
end
figure;hold on;
set(gcf,'position',[10 10 900 500]);
CC=get(gca,'ColorOrder');
C1=CC(1,:); %blue
C2=CC(6,:); %light blue
C3=[1 0.8 0.7];
C4=[0.8 0.8 0.8];
x1=1984.5:1994.5;curve1(1:11)=-24;curve2(1:11)=-8;
h1=patch([x1 flip(x1)], [curve1 flip(curve2)], C2, 'FaceAlpha',0.25, 'EdgeColor','none')
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
x2=1994.5:2004.5;
h1=patch([x2 flip(x2)], [curve1 flip(curve2)], C3, 'FaceAlpha',0.25, 'EdgeColor','none')
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
x3=2004.5:2014.5;
h1=patch([x3 flip(x3)], [curve1 flip(curve2)], 'r', 'FaceAlpha',0.1, 'EdgeColor','none')
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
%
load('../../fig3/fig3.mat')  % ERA5
dobs=squeeze(mean(O1,1))-C2K;
dera5=squeeze(mean(E1,1))-C2K;
dmip47=squeeze(mean(P1,1))-C2K;    % ensemble mean monthly mean of ensemble mean T, area-averaged
% for individual models
plot(1982:2014,tt,'-','color',C4);
%
a1(1:10)=mean(dobs(t1));b1(1:10)=mean(dera5(t1));c1(1:10)=mean(dmip47(t1));
a2(1:10)=mean(dobs(t2));b2(1:10)=mean(dera5(t2));c2(1:10)=mean(dmip47(t2));
a3(1:10)=mean(dobs(t3));b3(1:10)=mean(dera5(t3));c3(1:10)=mean(dmip47(t3));
%
hold on;plot(1982:2020,dobs,'k-','linewidth',2);
hold on;plot(1982:2020,dera5,'r-','linewidth',2);
hold on;plot(1982:2014,dmip47,'b-','linewidth',2);
%--
b = polyfit(t,dobs(t), 1);tr(1)=round(10*b(1),2);
text(1987,-20,'$\mathrm{{\it T}_{2m}^{\,SAT}}$','interpreter','latex','color','k','FontWeight','bold','fontsize',fz+4)
text(1990,-20,['+' sprintf('%04.2f', tr(1)) ' ^{o}C per decade'],'color','k','FontWeight','normal','fontsize',fz);
b = polyfit(t,dera5(t), 1);b=round(b(1),4); tr(2)=round(10*b,2); % b1=0.0555
text(1987,-21.5,'$\mathrm{{\it T}_{2m}^{\,ERA5}}$','interpreter','latex','color','r','FontWeight','bold','fontsize',fz+4)
text(1990,-21.5,['+' sprintf('%04.2f', tr(2)) ' ^{o}C per decade'],'color','r','FontWeight','normal','fontsize',fz);
b = polyfit(t,dmip47(t), 1);tr(3)=round(10*b(1),2);
text(1987,-23,'$\mathrm{{\it T}_{2m}^{\,CMIP6}}$','interpreter','latex','color','b','FontWeight','bold','fontsize',fz+4)
text(1990,-23,['+' sprintf('%04.2f', tr(3)) ' ^{o}C per decade'],'color','b','FontWeight','normal','fontsize',fz);
%--
title('a) Annual mean')
ylabel('T2m (^{\circ}C)');
[mean(dmip47(t1)-dobs(t1)) mean(dmip47(t2)-dobs(t2)) mean(dmip47(t3)-dobs(t3))]
[mean( dera5(t1)-dobs(t1))    mean(dera5(t2)-dobs(t2))   mean(dera5(t3)-dobs(t3))]
box on;grid on
%----------------------------------------------
set(findall(gcf,'-property','FontSize'),'FontSize',fz);
set(gcf,'PaperPositionMode','auto');
figname='FigS6_annual'
print('-depsc2','-r300', [figname '.eps']);
%% h=1 significant can rejected; 
       % h=0 insignificant, cannot rejected 
%  When the null hypothesis was rejected at the .05 level of significance, 
% that implies the obtaind p value was less than .05.
% [h,p,ci,stats] = ttest1(dobs(t));
% p1=h
% [h,p,ci,stats] = ttest1(dera5(t));
% p2=h 
% [h,p,ci,stats] = ttest1(dmip47(t));
% p3=h
%% DJFM
figure;hold on;
set(gcf,'position',[10 10 900 500]);
CC=get(gca,'ColorOrder');
seas=[1 2 3 12];
x1=1984.5:1994.5;curve1(1:11)=-40;curve2(1:11)=-15;
h1=patch([x1 flip(x1)], [curve1 flip(curve2)], C2, 'FaceAlpha',0.25, 'EdgeColor','none')
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
x2=1994.5:2004.5;
h1=patch([x2 flip(x2)], [curve1 flip(curve2)], C3, 'FaceAlpha',0.25, 'EdgeColor','none')
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
x3=2004.5:2014.5;
h1=patch([x3 flip(x3)], [curve1 flip(curve2)], 'r', 'FaceAlpha',0.1, 'EdgeColor','none')
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
for iy=1:33
tt(iy,:)=squeeze(mean(t0(seas,iy,:),1)); 
end
for n=1:47
b = polyfit(1:33,tt(:,n), 1); 
trw(n)=round(10*b(1),2);
end
dobs=squeeze(mean(O1(seas,:),1))-C2K;
dera5=squeeze(mean(E1(seas,:),1))-C2K;       
dmip47=squeeze(mean(P1(seas,:),1))-C2K;
a1(1:10)=mean(dobs(t1));b1(1:10)=mean(dera5(t1));c1(1:10)=mean(dmip47(t1));
a2(1:10)=mean(dobs(t2));b2(1:10)=mean(dera5(t2));c2(1:10)=mean(dmip47(t2));
a3(1:10)=mean(dobs(t3));b3(1:10)=mean(dera5(t3));c3(1:10)=mean(dmip47(t3));
plot(1982:2014,tt,'-','color',C4);
%
hold on;plot(1982:2020,dobs,'k-','linewidth',2);
hold on;plot(1982:2020,dera5,'r-','linewidth',2);
hold on;plot(1982:2014,dmip47,'b-','linewidth',2);
%--
b = polyfit(t,dobs(t), 1);tr(1)=round(10*b(1),2);
text(1987,-35,'$\mathrm{{\it T}_{2m}^{\,SAT}}$','interpreter','latex','color','k','FontWeight','bold','fontsize',fz+4)
text(1990,-35,['+' sprintf('%04.2f', tr(1)) ' ^{o}C per decade'],'color','k','FontWeight','normal','fontsize',fz);
b = polyfit(t,dera5(t), 1);tr(2)=round(10*b(1),2);
text(1987,-37,'$\mathrm{{\it T}_{2m}^{\,ERA5}}$','interpreter','latex','color','r','FontWeight','bold','fontsize',fz+4)
text(1990,-37,['+' sprintf('%04.2f', tr(2)) ' ^{o}C per decade'],'color','r','FontWeight','normal','fontsize',fz);
b = polyfit(t,dmip47(t), 1);tr(3)=round(10*b(1),2);
text(1987,-39,'$\mathrm{{\it T}_{2m}^{\,CMIP6}}$','interpreter','latex','color','b','FontWeight','bold','fontsize',fz+4)
text(1990,-39,['+' sprintf('%04.2f', tr(3)) ' ^{o}C per decade'],'color','b','FontWeight','normal','fontsize',fz);
%--
title('b) DJFM mean');ylabel('T2m (^{\circ}C)');
[mean(dmip47(t1)-dobs(t1)) mean(dmip47(t2)-dobs(t2)) mean(dmip47(t3)-dobs(t3))]
[mean( dera5(t1)-dobs(t1))    mean(dera5(t2)-dobs(t2))   mean(dera5(t3)-dobs(t3))]
[mean( dera5(t1)-dobs(t1))    mean(dera5(t2)-dobs(t2))   mean(dera5(t3)-dobs(t3))]-[mean(dmip47(t1)-dobs(t1)) mean(dmip47(t2)-dobs(t2)) mean(dmip47(t3)-dobs(t3))]
[mean(dmip47(t2)-dmip47(t1)) mean(dmip47(t3)-dmip47(t2))]
[mean(dera5(t2)-dera5(t1)) mean(dera5(t3)-dera5(t2))]
[mean(dobs(t2)-dobs(t1)) mean(dobs(t3)-dobs(t2))]
box on;grid on
%----------------------------------------------
set(findall(gcf,'-property','FontSize'),'FontSize',fz);
set(gcf,'PaperPositionMode','auto');
figname='FigS6_DJFM'
print('-depsc2','-r300', [figname '.eps']);
% print('-dpng','-r300',[figname '.png']);
% [h,p,ci,stats] = ttest1(dobs(t));
% p1=h
% [h,p,ci,stats] = ttest1(dera5(t));
% p2=h  
% [h,p,ci,stats] = ttest1(dmip47(t));
% p3=h 
%% JJAS
figure;hold on;
set(gcf,'position',[10 10 900 500]);
seas=[6 7 8 9];
x1=1984.5:1994.5;curve1(1:11)=-8;curve2(1:11)=0;
h1=patch([x1 flip(x1)], [curve1 flip(curve2)], C2, 'FaceAlpha',0.25, 'EdgeColor','none')
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
x2=1994.5:2004.5;
h1=patch([x2 flip(x2)], [curve1 flip(curve2)], C3, 'FaceAlpha',0.25, 'EdgeColor','none')
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
x3=2004.5:2014.5;
h1=patch([x3 flip(x3)], [curve1 flip(curve2)], 'r', 'FaceAlpha',0.1, 'EdgeColor','none')
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
for iy=1:33
tt(iy,:)=squeeze(mean(t0(seas,iy,:),1)); 
end
for n=1:47
b = polyfit(1:33,tt(:,n), 1); 
trs(n)=round(10*b(1),2);
end
dobs=squeeze(mean(O1(seas,:),1))-C2K;
dera5=squeeze(mean(E1(seas,:),1))-C2K;       
dmip47=squeeze(mean(P1(seas,:),1))-C2K;
plot(1982:2014,tt,'-','color',C4);
%
a1(1:10)=mean(dobs(t1));b1(1:10)=mean(dera5(t1));c1(1:10)=mean(dmip47(t1));
a2(1:10)=mean(dobs(t2));b2(1:10)=mean(dera5(t2));c2(1:10)=mean(dmip47(t2));
a3(1:10)=mean(dobs(t3));b3(1:10)=mean(dera5(t3));c3(1:10)=mean(dmip47(t3));
%
hold on;plot(1982:2020,dobs,'k-','linewidth',2);
hold on;plot(1982:2020,dera5,'r-','linewidth',2);
hold on;plot(1982:2014,dmip47,'b-','linewidth',2);
%-
b = polyfit(t,dobs(t), 1);tr(1)=round(10*b(1),2);
text(1987,-6,'$\mathrm{{\it T}_{2m}^{\,SAT}}$','interpreter','latex','color','k','FontWeight','bold','fontsize',fz+4)
text(1990,-6,['+' sprintf('%04.2f', tr(1)) ' ^{o}C per decade'],'color','k','FontWeight','normal','fontsize',fz);
b = polyfit(t,dera5(t), 1);tr(2)=round(10*b(1),2);
text(1987,-6.8,'$\mathrm{{\it T}_{2m}^{\,ERA5}}$','interpreter','latex','color','r','FontWeight','bold','fontsize',fz+4)
text(1990,-6.8,['+' sprintf('%04.2f', tr(2)) ' ^{o}C per decade'],'color','r','FontWeight','normal','fontsize',fz);
b = polyfit(t,dmip47(t), 1);tr(3)=round(10*b(1),2);
text(1987,-7.6,'$\mathrm{{\it T}_{2m}^{\,CMIP6}}$','interpreter','latex','color','b','FontWeight','bold','fontsize',fz+4)
text(1990,-7.6,['+' sprintf('%04.2f', tr(3)) ' ^{o}C per decade'],'color','b','FontWeight','normal','fontsize',fz);
%-
title('c) JJAS mean');ylabel('T2m (^{\circ}C)');
[mean(dmip47(t1)-dobs(t1)) mean(dmip47(t2)-dobs(t2)) mean(dmip47(t3)-dobs(t3))]
[mean( dera5(t1)-dobs(t1))    mean(dera5(t2)-dobs(t2))   mean(dera5(t3)-dobs(t3))]
[mean( dera5(t1)-dobs(t1))    mean(dera5(t2)-dobs(t2))   mean(dera5(t3)-dobs(t3))]-[mean(dmip47(t1)-dobs(t1)) mean(dmip47(t2)-dobs(t2)) mean(dmip47(t3)-dobs(t3))]
box on;grid on
%----------------------------------------------
set(findall(gcf,'-property','FontSize'),'FontSize',fz);
set(gcf,'PaperPositionMode','auto');
figname='FigS6_timeseries_JJAS'
print('-depsc2','-r300', [figname '.eps']);
%print('-dpng','-r300',[figname '.png']);
% [h,p,ci,stats] = ttest1(dobs(t));
% p1=h
% [h,p,ci,stats] = ttest1(dera5(t));
% p2=h  
% [h,p,ci,stats] = ttest1(dmip47(t));
% p3=h 