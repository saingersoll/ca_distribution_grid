#........................dashboardHeader.........................
header <- dashboardHeader(
  
  title = div(
    tags$a(
      # want to redirect to home page
   #   href = "ca_distribution_grid.github.io/",
      tags$img(
        src = "figs/power-generation.png",
        # link to logo
        # <a href="https://www.flaticon.com/free-icons/power-generation" title="power generation icons">Power generation icons created by Smashicons - Flaticon</a>
        alt = "The cartoon of a solar panel next to a shrub powering an energy power line with a white background. Image provided by Smashicons on Flaticon",
        width = "100%"
      )
    ),
    span("CA Energy Distribution Grid Tool", style = "position: absolute; left: -9999px;"),
    align = "left",
    width = "100%",
    style = "padding-right:0px;"
  ),
  titleWidth = 280
  
) # END dashboardHeader

#........................dashboardSidebar........................
sidebar <- dashboardSidebar(width = 280,
                            
                            tags$style(".left-side, .main-sidebar {padding-top: 125px}"),
                            
                            # sidebarMenu ----
                            sidebarMenu(
                              
                              # add tabs to sidebar menu
                              menuItem(text = "Home", tabName = "home", icon = icon("house-user")),
                              menuItem(text = "CA's Energy Distribution Grid", tabName = "distributiongrid", icon = icon("magnifying-glass-location")),
                              # idea but not ready yet, supply and demand trends & emergency events
                              # would be cool to associate by location or area -- need another data source to relate bc current data lacking geoid/ identifiers
                              # maybe something like explore resilency
                              menuItem(text = "Explore Supply & Demand Trends", tabName = "energytrends", icon = icon("magnifying-glass-location")),
                              menuItem(text = "DER Opportunties", tabName = "der", icon = icon("leaf")),
                              menuItem(text = "Data", tabName = "data", icon = icon("database"))
                              
                            ) # END sidebarMenu
                            
) # END dashboardSidebar

#..........................dashboardBody.........................
body <- dashboardBody(
  
  # add CSS styling
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "sass-style.scss"),
  ),
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(tabName = "home",
            
            
            # home fluidRow 1----
            fluidRow(
              
              # home background info box ----
              box(width = 12,
                  
                  # add title to home page
                  title = tags$h1("Welcome to CA's Energy Distribution Grid Tool"),
                  
                  # add markdown file that includes project background info
                  includeMarkdown("text/app_background_info.md"),
                  
                  # insert image of ideal der options
                  tags$img(src = "figs/arno-senoner-6lOxktnqo04-unsplash.jpg", 
                           alt = "Image of a solar field and wind turbine in a field of green, next to an energy storage facility with 3 buildings. The largest building is on the left with a square-like shape and glass windows, the middle is a tubular building with candy-cane stripes, and the right is the smallest and most retangular with glass windows.",
                           style = "max-width: 100%;"),
                  tags$h6(tags$em(tags$h6(href = "https://unsplash.com/photos/a-wind-farm-with-a-wind-turbine-in-the-background-6lOxktnqo04", "Senoner, Arno, Usplash.")),
                          style = "text-align: left;"), # END image of der options
                  
                  # add markdown file that includes background context
                  includeMarkdown("text/background_context.md")
                  
              ) # END home background info box
              
            ), # END home fluidRow 1
            
            # home fluidRow 2 ----
            fluidRow(
              
              # disclaimer box ----
              box(width = 12,
                  
                  # add disclaimer icon
                  title = tagList(icon("triangle-exclamation")),
                  # add markdown file that includes disclaimer
                  includeMarkdown("text/app_disclaimer.md")
                  
              ) # END disclaimer box
              
            ), # END home fluidRow 2
            
            # home fluidRow 3 ----
            fluidRow(
              
              # authors box ----
              box(width = 12,
                  
                  # add disclaimer icon
                  title = tagList(icon("pen")),
                  # add markdown file that includes disclaimer
                  includeMarkdown("text/app_author.md")
                  
              ) # END authors box
              
            ) # END home fluidRow 3
            
    ), # END welcome tabItem
    

#..............................................................................    
    
    # distributiongrid tabItem ----
    tabItem(tabName = "distributiongrid",
            
            # sitefinder fluidRow 1 ----
            fluidRow(
              
              # sitefinder info box ----
              box(width = 12,
                  
                  includeMarkdown("text/overview_distribution_grid.md"),
                  
              ) # END distributiongrid info box
              
            ), # END distributiongrid fluidRow 1 
            
            
            # leaflet box ----
            box(width = 12,
                # species type checkbox Group Buttons ----
                radioGroupButtons(inputId = "distribution_grid_map_input", label = "Select utility provider:",
                                  choiceNames = c("<em>Southern California Edison ('SCE')</em>", 
                                                  "<em>Pacific Gas & Electric Company ('PG&E')</em>", 
                                                  "<em>San Diego Gas & Electric ('SDG&E')</em>",
                                                  #   "<em>Los Angeles Department of Water & Power ('LADWP')</em>"),
                                                  #   "<em>Sacramento Municipal Utility District('SMUD')</em>"),
                                  ),
                                  choiceValues = c("Southern California Edison ('SCE')", 
                                                   "Pacific Gas & Electric Company ('PG&E')", 
                                                   "San Diego Gas & Electric ('SDG&E')", 
                                                   # "Los Angeles Department of Water & Power ('LADWP')",
                                                   # "Sacramento Municipal Utility District('SMUD')"
                                  ),
                                  selected = "Southern California Edison ('SCE')", 
                                  individual = TRUE,
                                  justified = FALSE,
                                  size = "normal",
                                  direction = "horizontal",
                                  checkIcon = list(yes = icon("circle-check", lib = "font-awesome", 
                                                              class = "fa-solid fa-circle-check", 
                                                              style = "color: $soft-orange"), 
                                                   no = icon("circle", lib = "font-awesome"))), #  END radioGroupButton for utility
                
                # leaflet output of user selected species high priority output ----
                leafletOutput(outputId = "distribution_grid_map_output") %>%  
                  
                  # add loading spinner
                  withSpinner()
                
            ), # END leaflet box
            
            # sitefinder fluidRow 2----
            fluidRow(
              
              # input box ----
              box(width = 12,
                  
                  includeMarkdown("text/distribution_map_table.md"),
                  
                  # add data table that summarizes priority information
                  DT::dataTableOutput("distribution_grid_map_table") %>% 
                    
                    # add loading spinner
                    withSpinner()
                  
              ), # END input box
              
            ) # END distributiongrid fluidRow 2
            
    ), # END distributiongrid locations tabItem
    
#...............................................................................    
    
    # energytrends tabItem ----
    tabItem(tabName = "energytrends",
            
            # distributiongrid fluidRow 1----
            fluidRow(
              
              # distributiongrid info box ----
              box(width = 12,
                  
                  # add markdown file that includes overview of utility supply/demand trends
                  includeMarkdown("text/overview_energy_trends.md"),
                  
                  # utility checkbox Group Buttons ----
                  checkboxGroupButtons(inputId = "utility_input", label = "Select utility provider:",
                                       choiceNames = c("<em>Southern California Edison ('SCE')</em>", 
                                                       "<em>Pacific Gas & Electric Company ('PG&E')</em>", 
                                                       "<em>San Diego Gas & Electric ('SDG&E')</em>",
                                                    #   "<em>Los Angeles Department of Water & Power ('LADWP')</em>"),
                                                    #   "<em>Sacramento Municipal Utility District('SMUD')</em>"),
                                                       ),
                                       choiceValues = c("Southern California Edison ('SCE')", 
                                                        "Pacific Gas & Electric Company ('PG&E')", 
                                                        "San Diego Gas & Electric ('SDG&E')", 
                                                       # "Los Angeles Department of Water & Power ('LADWP')",
                                                       # "Sacramento Municipal Utility District('SMUD')"
                                                       ),
                                       select = "Southern California Edison ('SCE')", 
                                       individual = TRUE,
                                       justified = FALSE,
                                       size = "normal",
                                       direction = "horizontal",
                                       checkIcon = list(yes = icon("square-check", lib = "font-awesome", 
                                                                   class = "fa-solid fa-square-check", 
                                                                   style = "color: $soft-orange"), 
                                                        no = icon("square", lib = "font-awesome"))), #  END checkboxGroupInput for utility
                  
                  # add leaflet output for utility supply/demand trends ----
                  leafletOutput(outputId = "utility_output") %>%  
                    
                    # add loading spinner to leaflet output
                    withSpinner()
                  
              ), # END energytrends box
              
            )  # END energytrends fluidRow 1
            
    ), # END energytrends tabItem
    
   
#................................................................................

    # data tabItem ----
    tabItem(tabName = "data",
            
            # data info box ----
            box(width = NULL,
                
                includeMarkdown("text/overview_data.md")
                
            ) # END data info box
            
    ) # END data tabItem
    
  ) # END tabItems
  
) # END dashboardBody

#..................combine all in dashboardPage and set dashboard title in open tobs..................
dashboardPage(title = "CA Energy Distribution Grid Tool", header, sidebar, body)