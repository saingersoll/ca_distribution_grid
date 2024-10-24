#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#----   Filtering User-Selected Data    ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function(input, output, session) {
  
  # need to standardize and combine all data for utility providers
  
  # for now, we will use sce and build up later
  
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #----      Distribution Lines Map       ----
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    tmap_mode("view")
    
    map <- tm_shape(sce_circuits) + 
      tm_basemap(leaflet::providers$Esri.WorldImagery) +
      tm_lines(
        col = "circuit_color",  
        lwd = 2,  
        title.col = "Circuit Color",
        popup.vars = pop_up_columns
      ) +  
      tm_layout(
        title = "SCE Distribution Circuits by Substation Voltage (kV)",
        legend.title.size = 1.2,  
        legend.text.size = 0.8,     
        legend.outside = FALSE 
      ) +
      tm_scale_bar(position = c("right", "bottom"), text.size = 0.5) +
      tm_add_legend(
        type = "fill", 
        labels = names(voltage_colors), 
        col = voltage_colors, 
        title = "Substation Distribution Outputs (kV)"
      ) +
      tm_view(legend.position = c("right", "top"), 
              view.legend.position = c("right", "top"))
    
  }
  