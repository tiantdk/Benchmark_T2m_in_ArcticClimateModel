#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Nov 13 23:28 2023

@author: tian
"""
#This plotting script is adapted from the script published in Rantanen, M. et al.2022.

from cdo import *
cdo = Cdo()
import xarray as xr
import cartopy.crs as ccrs
import matplotlib.pyplot as plt
import numpy as np
from cartopy.util import add_cyclic_point
import cartopy.feature as cfeature
from skimage import measure, segmentation
from scipy import stats
import cmocean.cm as cmo
from scipy.io import loadmat

def plot_background(ax):
    import cartopy.feature as cfeature
    import matplotlib.path as mpath    
    import matplotlib.ticker as mticker
    
    ax.patch.set_facecolor('w')
    ax.spines['geo'].set_edgecolor('k')
    
    ax.set_extent([0, 360, 58,90], crs=ccrs.PlateCarree())
    ax.add_feature(cfeature.COASTLINE.with_scale('110m'), zorder=10)
    

    gl = ax.gridlines(linewidth=2, color='k', alpha=0.5, linestyle='--')
    gl.n_steps = 100
    gl.ylocator = mticker.FixedLocator([66.5])
    gl.xlocator = mticker.FixedLocator([])
    theta = np.linspace(0, 2*np.pi, 100)
    center, radius = [0.5, 0.5], 0.5
    verts = np.vstack([np.sin(theta), np.cos(theta)]).T
    circle = mpath.Path(verts * radius + center)

    ax.set_boundary(circle, transform=ax.transAxes)
    return ax


datapath = './'

ncfile = datapath + 'OBS_T2M_ARCTIC_1deg_1982-2020_m15pct.nc'
ff='obs'

lons = 'lon'
lats = 'lat'
titles = ' '
#titles = 'a) 1995-2014'
titles = 'a) 1982-2020'

print('Calculating mean states for '+ ff)
# define the starting and ending years of the trend
syear = 1982   #1995
eyear = 2020   #2014

# last two files select different year
years = np.arange(syear, eyear+1, 1)
    
# calculate the climatology
#annual_means = cdo.timmean(input =  "-selvar,t2m -selyear,"+str(syear)+"/"+str(eyear)+" -sellonlatbox,0,360,58,90 " + ncfile)

# open the dataset
#ds = xr.open_dataset(annual_means)

# save data
file_npz = 'figS5a_mean_map_'+ ff + '_' +str(syear) + '-' + str(eyear) + '.npz'
#np.savez(file_npz,  lon=ds['lon'], lat=ds['lat'], bias=ds['t2m'])
b = np.load(file_npz)
#print(b.files)

f  = b['bias']
#print(f.shape)
climT = f[0,:,:]

cmin = -18
cmax=  2
inc = 2
newcm = 'cmo.dense'
newcm = cmo.ice.reversed()

f_levels = np.arange(cmin,cmax+inc,inc)
    
print('Plotting ' + ff)
ss = climT - 273.15 
s = np.where(ss == 0, np.nan, ss)

# 1) generate fig1a_*SIC70.npz, using fig1a_absT_IST_SIC70_npz.py 
# 2) convert to *mat, using tmp/savemat.py. so we do loadmat
data = loadmat('fig1a_mean_map_obs_' +str(syear)+'-' +str(eyear)+'_SIC70.mat')
# reading sic70  npz files
SIC2 = data['sic'] 
#Set the projection information
proj = ccrs.NorthPolarStereo()

#Create a figure with an axes object on which we will plot. Pass the projection to that axes.
fig = plt.figure(1, figsize=(5, 6), dpi=200,constrained_layout=False)
ax = fig.add_subplot(projection=proj)
plot_background(ax)

# Add land fill
land_fill = cfeature.LAND.with_scale('50m')
ax.add_feature(land_fill, facecolor='white',alpha=1, zorder=2)

f_new, new_lon = add_cyclic_point(s, coord=b['lon'])

# plot the field
f_contourf = ax.contourf(new_lon, b['lat'], f_new, levels=f_levels, zorder=0, extend='both', 
                            cmap=newcm, transform = ccrs.PlateCarree())

# Overlay the contour line for sea_ice_fraction > 0.7
msk2=SIC2>=0.7
print(msk2.shape)
cs = ax.contour(b['lon'], b['lat'], msk2, levels=[0.7], zorder=1, colors='r', linewidths=2, transform=ccrs.PlateCarree())

ax.set_title(titles, fontsize=16)

fig.subplots_adjust(right=0.8, top=0.75, wspace=0.1)
cbar_ax = fig.add_axes([0.13, 0.08, 0.65, 0.04])

cb = fig.colorbar(f_contourf, orientation='horizontal',pad=0.05,fraction=0.053, cax=cbar_ax)
cb.ax.tick_params(labelsize=16)
cb.set_label(label='$T$$\mathregular{_{2m}}$ ($\mathregular{^o}$C)',fontsize=16)
labels = np.arange(cmin,cmax+inc,inc*2)
cb.set_ticks(labels)

plt.savefig('figS5a_map_'+ ff + '_' +str(syear) + '-' + str(eyear) + '.png',dpi=200,bbox_inches='tight')

