#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#----            Load Libraries         ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(sf)
library(sass)
library(here)
library(tmap)
library(terra)
library(leaflet)
library(maptiles)
library(tmaptools)
library(sfheaders)
library(tidyverse)
library(leaflet.extras)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#----             Page Styling          ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Compile CSS for styling 
sass(
  input = sass_file("www/sass-style.scss"),
  output = "www/sass-style.css",
  # removes white-space & line-breaks that make css files more human-readable
  options = sass_options(output_style = "compressed")
)

# Set Spinner Options
options(spinner.type = 6, spinner.color = "#556b8e")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#----       Load Distribution Data      ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sce_circuits <- st_read(here("..","data", "sce_processed", "sce_distribution_line_data.shp"),
                        quiet = T)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#---- Load Project Sunroof + Climate &  Economic Justice Screening Tool Data ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# see 2035 CCA repo for the wrangling workflow that made this
rooftop_solar <- st_read(here("..","data", "census_tract_pv", "census_tract_pv.gpkg"),
                              quiet = T) %>% 
  janitor::clean_names() %>% 
  st_transform(crs = 4326) %>% 
  st_make_valid()


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#----              Map Styling          ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# color blind friendly palette for substation distribution voltage categories
voltage_colors <- c(
  "~2 kV distributed" = "#332288",
  
  "~4 kV distributed" =  "#88CCEE", 
  
  "7 kV distributed" =  "#44AA99",
  
  "12 kV distributed" =   "#117733",
  
  "~13 kV distributed" = "#DDCC77", 
  
  "16 kV distributed" = "#CC6677",
  
  "25 kV distributed" = "#AA4499",
  
  "33 kV distributed" = "#882255",
  
  "200 kV distributed, likely a computational error" = "black"
)



