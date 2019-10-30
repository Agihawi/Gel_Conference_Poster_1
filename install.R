#script to install packages required for poster

list.of.packages <- c('tidyverse','posterdown','ggpubr', 'devtools', 'kableExtra')
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(posterdown)
library(tidyverse)
library(ggpubr)
library(devtools)
library(kableExtra)

new.packages <- !(c('emo') %in% installed.packages()[,"Package"])
if(length(new.packages)) devtools::install_github("hadley/emo")

#load packages required with devtools
library(emo)
