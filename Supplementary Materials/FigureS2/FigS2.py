#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Nov 14 13:08 2023
#This plotting script is adapted from the script published in Rantanen, M. et al.2022.

@author: tian
"""
from cdo import *
cdo = Cdo()
import xarray as xr
import cartopy.crs as ccrs
import matplotlib.pyplot as plt
import numpy as np
from cartopy.util import add_cyclic_point
from scipy import stats


def plotMap():

    #Set the projection information
    proj = ccrs.NorthPolarStereo()
    #Create a figure with an axes object on which we will plot. Pass the projection to that axes.
    fig, axarr = plt.subplots(nrows=1, ncols=2, figsize=(10, 6), constrained_layout=False, dpi=200,
                          subplot_kw={'projection': proj})
    axlist = axarr.flatten()
    for ax in axlist:
        plot_background(ax)
   
    return fig, axlist


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

files = {#'obs'  :datapath + 'OBS_T2M_ARCTIC_1deg_1982-2020_m15pct.nc',
         'era5' :datapath + 'ERA5_T2M_ARCTIC_1deg_1982-2020_2m15pct.nc',
         'cmip6':datapath + 'CMIP6_T2M_ARCTIC_1deg_1982-2014_2m15pct.nc',
         }

variables = {'cmip6': 'tas',
             'era5': 'tas',
             'obs': 't2m',
             }

lons = {'cmip6': 'lon',
        'era5': 'lon',
        'obs': 'lon',
        }

lats = {'cmip6': 'lat',
        'era5': 'lat',
        'obs': 'lat',
        }


titles = {'cmip6': 'CMIP6 (1985-1994)',
        'era5': 'ERA5 (1985-1994)',
        'obs': ' ',
        }
#titles = {'cmip6': 'CMIP6 (1995-2004)',
#        'era5': 'ERA5 (1995-2004)',
#        'obs': ' ',
#        }
#titles = {'cmip6': 'CMIP6 (2005-2014)',
#        'era5': 'ERA5 (2005-2014)',
#        'obs': ' ',
#        }


trendfiles = {}

for ff in files:
    print('Calculating bias for '+ff)
    # define the starting and ending years of the trend
    syear = 1985 #1985  #1995 # 2005
    eyear = 1994 #1994  #2004 # 2014
    years = np.arange(syear, eyear+1, 1)
    
    # calculate the mean bias
    #ana_bias = cdo.sub(input = "-selyear," +str(syear)+"/"+str(eyear)+" -yearmean -selmon,1,2,3,12 -selvar,tas " + files[ff]+" -yearmean -selvar,t2m -selyear,"+str(syear)+"/"+str(eyear)+" -selmon,1,2,3,12 OBS_T2M_ARCTIC_1deg_1982-2020_m15pct.nc")

    #bias_means = cdo.timmean(input = ana_bias)

    # open the dataset
    #ds = xr.open_dataset(bias_means)
    
    file_npz = 'FigS2_bias_map_'+ ff + '_' +str(syear) + '-' + str(eyear) + '_djfm.npz'
    #np.savez(file_npz,  lon=ds['lon'], lat=ds['lat'], bias=ds[variables[ff]])
    b = np.load(file_npz)

    #f = ds[variables[ff]]
    f = b['bias']

    trendfiles[ff] = f[0,:,:]

cmin = -6
cmax=  6
inc = 1
newcm = 'RdYlBu_r'

f_levels = np.arange(cmin,cmax+inc,inc)

#Get a new background map figure
fig, axlist = plotMap()
    
I = 0
for ff in trendfiles:
    
    print('Plotting '+ff)
    s = trendfiles[ff]
    #print(s.shape)
    f_new, new_lon = add_cyclic_point(s, coord=b['lon'])

    # plot the field
    f_contourf = axlist[I].contourf(new_lon, b['lat'], f_new, levels=f_levels, zorder=2, extend='both', 
                            cmap=newcm, transform = ccrs.PlateCarree())
    #
    axlist[I].set_title(titles[ff], fontsize=16)
    I += 1


fig.subplots_adjust(right=0.8, top=0.75, wspace=0.1)
cbar_ax = fig.add_axes([0.15, 0.08, 0.62, 0.04])

cb = fig.colorbar(f_contourf, orientation='horizontal',pad=0.05,fraction=0.053, cax=cbar_ax)
cb.ax.tick_params(labelsize=16)
cb.set_label(label='$\Delta T$$\mathregular{_{2m}}$ ($\mathregular{^o}$C)',fontsize=16)
labels = np.arange(cmin,cmax+inc,inc*2)
cb.set_ticks(labels)

plt.savefig('FigS2_bias_maps_'+ str(syear) + '-' + str(eyear) + '_djfm.png',dpi=200,bbox_inches='tight')
