close all;clear all;
addpath ~/data/toolbox/trend
dir='./';
%-------------
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
%clear all
load('TableS2_all.mat') % 1:3 [CMIP6, ERA5, BEST]
x=1982:2020;
%--------------------
for i=1:3 %[CMIP6, ERA5, BEST]   
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
for i=1:3 %[CMIP6, ERA5, BEST]   
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