# -*- coding: utf-8 -*-
"""
Created on Tue Jul 12 18:22:00 2022

@author: Thomas Finet
"""
#Import panda
import pandas as pd
# Import seaborn
import seaborn as sns
#Import numpy 
import numpy as np
#Import matplotib
import matplotlib.pyplot as plt


#Import the data

ASTAN = pd.read_csv ('ASTAN_dataset.csv', sep=',',quotechar='"',encoding='utf8')
BBMO= pd.read_csv ("BBMO_dataset.csv", sep=',',quotechar='"',encoding='utf8')
SOLA= pd.read_csv ("SOLA_dataset.csv", sep=',',quotechar='"',encoding='utf8')

#Isolate all the years in the different datasets
ASTAN_Year=np.unique(ASTAN.Year)
BBMO_Year=np.unique(BBMO.Year)
#concatenate the years 
All_Year=np.unique(np.concatenate((BBMO_Year,ASTAN_Year), axis=None))


### Plot BBMO ###

#Plot the figure
sns.set(style="white")
g = sns.relplot(x="Year", y="CC_id",
                hue="Season", size="mean_abundance",
                palette=sns.color_palette("rocket_r", n_colors=4),sizes=(100, 1000),
                marker="s", linewidth=0, legend="full",
                aspect=1.3, data=BBMO,height=8)
#Remove the label
g.set( xlabel ="" , ylabel = "")
#Plot all the year on the x axis
g.set(xticks=All_Year)
#Save as svg
plt.savefig("BBMO.svg")

### Plot SOLA ###

#Plot the figure
sns.set(style="white")
g = sns.relplot(x="Year", y="CC_id",
                hue="Season", size="mean_abundance",
                palette=sns.color_palette("Greens", n_colors=4),sizes=(100, 1000),
                marker="s", linewidth=0, legend="full",
                aspect=1.3, data=SOLA,height=8)
#Remove the label
g.set( xlabel ="" , ylabel = "")
#Plot all the year on the x axis
g.set(xticks=All_Year)
#Save as svg
plt.savefig("SOLA.svg")


### Plot ASTAN ###

#Plot the figure
sns.set(style="white")
g = sns.relplot(x="Year", y="CC_id",
                hue="Season", size="mean_abundance",
                palette=sns.color_palette("Greys", n_colors=4),sizes=(100, 360),
                marker="s", linewidth=0, legend="full",
                aspect=1.3, data=ASTAN,height=8)
#Remove the label
g.set( xlabel ="" , ylabel = "")
#Plot all the year on the x axis
g.set(xticks=All_Year)
#Save as svg
plt.savefig("ASTAN.svg")




