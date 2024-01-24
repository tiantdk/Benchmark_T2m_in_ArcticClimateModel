close all;clear all;
addpath ~/data/toolbox/trend
dir='./';
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
load('TableS2_sic15.mat')% 1:4  %[CMIP6, ERA5, OBS, BEST]
x=1982:2020;
%--------------------
for i=1:4  %[CMIP6, ERA5, OBS, BEST]
    t=[1:33]; %1982-2014
    T2=mT(:,i);    
    b1 = polyfit(t,T2(t), 1);
    tr1(i)=round(10*b1(1),3);
    cd ~/2023/IST/data/
    [h,p,ci,stats] = ttest1(T2(t));
    h_significant(i)=h;
    p1_value(i)=p;
end
tr1
clear t T2 
for i=1:4 %[CMIP6, ERA5, OBS, BEST]
    if i<2
        ny=33;
    else
        ny=39;   %1982-2020, except CMIP6
    end
    t=[1:ny]; %1982-2020, except CMIP6
    T2=mT(:,i);    
    b2 = polyfit(t,T2(t), 1);
    tr2(i)=round(10*b2(1),3);
    [h,p,ci,stats] = ttest1(T2(t));
    h_significant(i)=h;
    p2_value(i)=p;
end
tr2
