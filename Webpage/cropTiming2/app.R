library(shiny)
library(leaflet)
library(dplyr)
library(rgdal)
library(raster)
library(leafpop)
library(ggplot2)
library(spatialEco)

# TUTORIAL: https://rstudio.github.io/leaflet/shiny.html

# Note, the interactive graphs generated as all_grpahs_list take a long time to load and can't get different ones to show up
# gave up on this, it uses mapview instead of leaflet: https://stackoverflow.com/questions/32352539/plotting-barchart-in-popup-using-leaflet-library

df <- readRDS("./cell_spdf.rds")
df <- df[df$plant_stat_type == "median", ] # show median planting date only
to_download_csv <- as.data.frame(df) %>%
  dplyr::select(-c("SC_delay", "DC_area_km", "label", "Muni_code", "SC_area_km",
            "onset_rang", "DC_delay", "plant_stat_type", "cell_ID", "region", 
            "year_index", "year_factor")) %>%
  dplyr::rename(soy_area = soy_area_k)

# writes out a shp file for download
#writeOGR(obj=df, dsn="cell_data", layer="cell_data", driver="ESRI Shapefile")

# TEST: filter stuff out
#df <- df[df$intensity == "SC" &  df$year == 2010,]

#all_graphs_list <- readRDS("./all_graphs_list.rds")

MT_outline <- readOGR(dsn = './MatoGrossoOutline', layer = 'MatoGrossoOutline')
crs(MT_outline) <- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")


# years, for drop-downs
vars <- c(
  "2014" = 2014,
  "2013" = 2013,
  "2012" = 2012,
  "2011" = 2011,
  "2010" = 2010,
  "2009" = 2009,
  "2008" = 2008,
  "2007" = 2007,
  "2006" = 2006,
  "2005" = 2005,
  "2004" = 2004
)

documentation_table <- data.frame(
  Variable = c('year','plant', 'onset', 'intensity', 'soy_area', 'lon', 'lat'),
  Description = c("Year of harvest (2014 refers to Aug 1, 2013 to July 31, 2014)",
                  "Planting date [days after Aug 1]",
                  "Wet season onset [days after Aug 1]",
                  "Cropping intensity (SC = single cropped, DC = double cropped)",
                  "Area of soy [square km]",
                  "Longitude of cell center",
                  "Latitude of cell center")
)

###################################################################################################
# UI
###################################################################################################

ui <- navbarPage("Crop Timing", id = "nav",
           
  # map tab -------------------------------------------------------------------------------------      
  tabPanel("Interactive Map",
           
    # side bar
    sidebarLayout(
      sidebarPanel(
      radioButtons("user_intensity", "Cropping intensity:",
                               c("Single Cropping" = "SC",
                                 "Double Cropping" = "DC")),
                  
      #selectInput("user_year", "Year:", vars)
      sliderInput(inputId = "user_year", 
                    label = "Year",
                    value = 2014, min = 2004, max = 2014, 
      	            step = 1, round = TRUE, sep = '', ticks = FALSE),
      
      h6("Click a cell to view its planting and wet season onset trajectory."),
      plotOutput("timeseries"),
      plotOutput("histogram_SC"),
      plotOutput("histogram_DC"),

      width = 6
      
      
      ),
    
    # main bar
    mainPanel(
      leafletOutput("mymap",height = 1000),
      width = 6
    )
    
    ) # end sidebarLayout
  ), # end interactive map tab
  
  # how data created tab -----------------------------------------------------------------------
  tabPanel("Download Data",
           tableOutput('documentation'),
           downloadLink('data_csv', 'Download as CSV')
           #,downloadLink('data_shp', 'Download as SHP')
           )
)

###################################################################################################
# SERVER
###################################################################################################

server <- function(input, output) {
  
  filteredData <- reactive({
    df[df$intensity == input$user_intensity & df$year == input$user_year,]
  })
  
  filteredData_allYears <- reactive({
    df[df$intensity == input$user_intensity,]
  })
  
  filteredData_SC_userYear <- reactive({
    df[df$intensity == "SC" & df$year == input$user_year,]
  })
  
  filteredData_DC_userYear <- reactive({
    df[df$intensity == "DC" & df$year == input$user_year,]
  })

  pal <- colorNumeric(
    palette = "YlOrRd",
    domain = df$plant
  )
  
  output$mymap <- renderLeaflet({
    
    leaflet(data = MT_outline) %>%
      #addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(data = MT_outline, weight = 2, stroke = TRUE, color = "black", fillColor = "white")
    
    
    
  })
  
  # observeEvent for slider change: this is repeat of the observeEvent for clicking a map but with dummy point
  # if don't have this, when only change the user_year with slider, the plot will try to update but it 
  # won't have the new year. if a cell that existed in 2014 but doesn't exist in 2004 is chosen, get error in plot
  observeEvent(input$user_year, {
    #print('slider changed')
    
    point_lat <- max(c(-80,input$mymap_shape_click$lat), na.rm = TRUE) # dummy point
    point_lon <- max(c(-80,input$mymap_shape_click$lng), na.rm = TRUE)
    
    
    point_chosen <- SpatialPoints(matrix(c(point_lon,point_lat), nrow = 1))
    crs(point_chosen) <- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
    
    filteredData_allYears_cell <- reactive({
      over(point_chosen, df, returnList = TRUE) #filteredData_allYears() if want one intensity; use df if want both intensities
    })
    
    #print(filteredData_allYears_cell()$"1")
    
    cell_data <- as.data.frame(filteredData_allYears_cell()$"1")
    #print('cell_data for all years')
    #print(cell_data)
    
    if (nrow(cell_data) >= 1) {
      output$timeseries <- renderPlot({
        ggplot(cell_data, mapping = aes(x = year)) +
          geom_point(mapping = aes(y = plant, col = intensity), size = 3) +
          xlab("Year") +
          ylab("Day of Year") +
          geom_line(mapping = aes(y = onset, color = "zonset")) +
          scale_color_manual(name = "", 
                             labels = c("Double cropped", "Single cropped", "Wet season onset"),
                             values = c("DC" = "darkgreen", "SC" = "green", "zonset" = "darkblue")) +
          
          ggtitle("Timeseries at chosen cell") +
          theme_bw()
      })
    }
    
    if (nrow(cell_data) == 0) {
      output$timeseries <- renderPlot({
        ggplot(as.data.frame(filteredData_allYears()), mapping = aes(x = year)) +
          geom_point(mapping = aes(y = plant, col = intensity), size = 3) +
          xlab("Year") +
          ylab("Day of Year") +
          scale_color_manual(name = "", 
                             labels = c("Double cropped", "Single cropped"),
                             values = c("DC" = "darkgreen", "SC" = "green")) +
          
          ggtitle("Invalid cell chosen. Showing timeseries at all cells") +
          theme_bw()
      })
    }
    
    #print(as.data.frame(filteredData_SC_userYear())$plant)
    
    # histogram for ONE year, one histogram per intensity
    # if cell exists in chosen year
    if (nrow(cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC",]) >= 1) {
      
      output$histogram_SC <- renderPlot({
        ggplot(as.data.frame(filteredData_SC_userYear()), aes(x = plant)) +
          geom_histogram() +
          geom_vline(xintercept = cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC", "plant"], 
                     col = "darkgreen", size = 2) + # get plant date for specific year +
          geom_vline(xintercept = cell_data[cell_data$year == input$user_year, "onset"], 
                     col = "darkblue", size = 2) + # get onset for specific year
          geom_text(x=cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC", "plant"] +50, y=120, 
                    label="SC planting date \n at chosen cell", color = "darkgreen") +
          geom_text(x=cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC", "onset"] - 40, y=120, 
                    label="Wet season \n onset at \n chosen cell", color = "darkblue") +
          ggtitle(paste("Single cropped for", input$user_year)) +
          xlab("Planting date [days after Aug 1]") +
          ylab("Histogram") +
          theme_bw() +
          xlim(-20,250) +
          ylim(0, 130)
      })
    }
    
    # if cell doesn't exist in chosen year
    #print('user year')
    #user_year <- reactive(input$user_year)
    #print(input$user_year)
    #print('new cell_data to check')
    #print(cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC",])
    
    if (nrow(cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC",]) == 0) {
      
      
      output$histogram_SC <- renderPlot({
        ggplot(as.data.frame(filteredData_SC_userYear()), aes(x = plant)) +
          geom_histogram() +
          ggtitle(paste("Single cropped for", input$user_year)) +
          xlab("Planting date [days after Aug 1]") +
          ylab("Histogram") +
          theme_bw() +
          xlim(-20,250) +
          ylim(0, 130)
      })
    }
    
    # if cell exists in chosen year
    if (nrow(cell_data[cell_data$year == input$user_year & cell_data$intensity == "DC",]) >= 1) {
      output$histogram_DC <- renderPlot({
        ggplot(as.data.frame(filteredData_DC_userYear()), aes(x = plant)) +
          geom_histogram() +
          geom_vline(xintercept = cell_data[cell_data$year == input$user_year & cell_data$intensity == "DC", "plant"], 
                     col = "darkgreen", size = 2) + # get plant date for specific year +
          geom_vline(xintercept = cell_data[cell_data$year == input$user_year, "onset"], 
                     col = "darkblue", size = 2) + # get onset for specific year
          geom_text(x=cell_data[cell_data$year == input$user_year & cell_data$intensity == "DC", "plant"] + 50, y=120, 
                    label="DC planting date \n at chosen cell", color = "darkgreen") +
          geom_text(x=cell_data[cell_data$year == input$user_year & cell_data$intensity == "DC", "onset"] - 40, y=120, 
                    label= "Wet season \n onset at \n chosen cell", color = "darkblue") +
          ggtitle(paste("Double cropped for", input$user_year)) +
          xlab("Planting date [days after Aug 1]") +
          ylab("Histogram") +
          theme_bw() +
          xlim(-20,250) +
          ylim(0,130)
      })
    }
    
    # if cell doesn't exist in chosen year
    if (nrow(cell_data[cell_data$year == input$user_year & cell_data$intensity == "DC",]) == 0) {
      output$histogram_DC <- renderPlot({
        ggplot(as.data.frame(filteredData_DC_userYear()), aes(x = plant)) +
          geom_histogram() +
          ggtitle(paste("Double cropped for", input$user_year)) +
          xlab("Planting date [days after Aug 1]") +
          ylab("Histogram") +
          theme_bw() +
          xlim(-20,250) +
          ylim(0,130)
      })
    }
    
    
  })
  
  # observeEvent for map click
  observeEvent(input$mymap_shape_click, { # update the location selectInput on map clicks

    point_lat <- input$mymap_shape_click$lat
    point_lon <- input$mymap_shape_click$lng

    point_chosen <- SpatialPoints(matrix(c(point_lon,point_lat), nrow = 1))
    crs(point_chosen) <- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

    filteredData_allYears_cell <- reactive({
      over(point_chosen, df, returnList = TRUE) #filteredData_allYears() if want one intensity; use df if want both intensities
    })

    #print(filteredData_allYears_cell()$"1")
    
    cell_data <- as.data.frame(filteredData_allYears_cell()$"1")

    
    if (nrow(cell_data) >= 1) {
      output$timeseries <- renderPlot({
        ggplot(cell_data, mapping = aes(x = year)) +
                                geom_point(mapping = aes(y = plant, col = intensity), size = 3) +
                                xlab("Year") +
                                ylab("Day of Year") +
                                geom_line(mapping = aes(y = onset, color = "zonset")) +
                                scale_color_manual(name = "", 
                                                   labels = c("Double cropped", "Single cropped", "Wet season onset"),
                                                   values = c("DC" = "darkgreen", "SC" = "green", "zonset" = "darkblue")) +
  
                                ggtitle("Timeseries at chosen cell") +
                                theme_bw()
      })
    }

    if (nrow(cell_data) == 0) {
      output$timeseries <- renderPlot({
        ggplot(as.data.frame(filteredData_allYears()), mapping = aes(x = year)) +
          geom_point(mapping = aes(y = plant, col = intensity), size = 3) +
          xlab("Year") +
          ylab("Day of Year") +
          scale_color_manual(name = "", 
                             labels = c("Double cropped", "Single cropped"),
                             values = c("DC" = "darkgreen", "SC" = "green")) +
          
          ggtitle("Invalid cell chosen. Showing timeseries at all cells") +
          theme_bw()
      })
    }
    
    #print(as.data.frame(filteredData_SC_userYear())$plant)
    
    # histogram for ONE year, one histogram per intensity
    # if cell exists in chosen year
    if (nrow(cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC",]) >= 1) {
      
      
      output$histogram_SC <- renderPlot({
        ggplot(as.data.frame(filteredData_SC_userYear()), aes(x = plant)) +
          geom_histogram() +
          geom_vline(xintercept = cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC", "plant"], 
                     col = "darkgreen", size = 2) + # get plant date for specific year +
          geom_vline(xintercept = cell_data[cell_data$year == input$user_year, "onset"], 
                     col = "darkblue", size = 2) + # get onset for specific year
          geom_text(x=cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC", "plant"] +50, y=120, 
                    label="SC planting date \n at chosen cell", color = "darkgreen") +
          geom_text(x=cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC", "onset"] - 40, y=120, 
                    label="Wet season \n onset at \n chosen cell", color = "darkblue") +
          ggtitle(paste("Single cropped for", input$user_year)) +
          xlab("Planting date [days after Aug 1]") +
          ylab("Histogram") +
          theme_bw() +
          xlim(-20,250) +
          ylim(0, 130)
      })
    }
    
    # if cell doesn't exist in chosen year
    if (nrow(cell_data[cell_data$year == input$user_year & cell_data$intensity == "SC",]) == 0) {
      

      output$histogram_SC <- renderPlot({
        ggplot(as.data.frame(filteredData_SC_userYear()), aes(x = plant)) +
          geom_histogram() +
          ggtitle(paste("Single cropped for", input$user_year)) +
          xlab("Planting date [days after Aug 1]") +
          ylab("Histogram") +
          theme_bw() +
          xlim(-20,250) +
          ylim(0, 130)
      })
    }
    
    # if cell exists in chosen year
    if (nrow(cell_data[cell_data$year == input$user_year & cell_data$intensity == "DC",]) >= 1) {
      output$histogram_DC <- renderPlot({
        ggplot(as.data.frame(filteredData_DC_userYear()), aes(x = plant)) +
          geom_histogram() +
          geom_vline(xintercept = cell_data[cell_data$year == input$user_year & cell_data$intensity == "DC", "plant"], 
                     col = "darkgreen", size = 2) + # get plant date for specific year +
          geom_vline(xintercept = cell_data[cell_data$year == input$user_year, "onset"], 
                     col = "darkblue", size = 2) + # get onset for specific year
          geom_text(x=cell_data[cell_data$year == input$user_year & cell_data$intensity == "DC", "plant"] + 50, y=120, 
                    label="DC planting date \n at chosen cell", color = "darkgreen") +
          geom_text(x=cell_data[cell_data$year == input$user_year & cell_data$intensity == "DC", "onset"] - 40, y=120, 
                    label= "Wet season \n onset at \n chosen cell", color = "darkblue") +
          ggtitle(paste("Double cropped for", input$user_year)) +
          xlab("Planting date [days after Aug 1]") +
          ylab("Histogram") +
          theme_bw() +
          xlim(-20,250) +
          ylim(0,130)
      })
    }
    
    # if cell doesn't exist in chosen year
    if (nrow(cell_data[cell_data$year == input$user_year & cell_data$intensity == "DC",]) == 0) {
      output$histogram_DC <- renderPlot({
        ggplot(as.data.frame(filteredData_DC_userYear()), aes(x = plant)) +
          geom_histogram() +
          ggtitle(paste("Double cropped for", input$user_year)) +
          xlab("Planting date [days after Aug 1]") +
          ylab("Histogram") +
          theme_bw() +
          xlim(-20,250) +
          ylim(0,130)
      })
    }
    
    
  })

  
  
  observe({
    
    
    
    leafletProxy("mymap", data = filteredData()) %>%
      clearShapes() %>%
      clearControls() %>%
      addPolygons(data = MT_outline, weight = 2, stroke = TRUE, color = "black", fillColor = "white") %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 0, fillOpacity = 1,
                  fillColor = ~pal(plant),
                  #fillColor = ~colorQuantile("YlOrRd", plant)(plant),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = paste("Plant: ", round(df$plant), " days after Aug 1 <br>", "Onset: ", df$onset, "days after Aug 1")
                  #popup = popupGraph(graphs_list) #(cell_ID <- df$cell_ID) # graph_popup(df$cell_ID)
      ) %>%
      addLegend("bottomright", pal = pal, values = ~plant,
                title = "Planting date (DOY after Aug 1)",
                opacity = 1
      )
    
    })

  output$documentation <- renderTable({
    documentation_table
  })
  
  output$data_csv <- downloadHandler('data.csv',
    content = function(file) {
      write.csv(to_download_csv, file, row.names = FALSE)
    }
  )
  
  output$data_shp <- downloadHandler(
    filename = 'cell_data.zip',
    content = function(file) {
      if (length(Sys.glob("cell_data.*"))>0){
        file.remove(Sys.glob("cell_data.*"))
      }
      writeOGR(df, dsn="cell_data.shp", layer="cell_data", driver="ESRI Shapefile")
      zip(zipfile='cell_data.zip', files=Sys.glob("cell_data.*"))
      file.copy("cell_data.zip", file)
      if (length(Sys.glob("cell_data.*"))>0){
        file.remove(Sys.glob("cell_data.*"))
      }
    }
  )
  
  # output$data_shp <- downloadHandler(
  #   filename = "cell_data.zip",
  #   content = function(file) {
  #     data = df # I assume this is a reactive object
  #     # create a temp folder for shp files
  #     temp_shp <- tempdir()
  #     # write shp files
  #     writeOGR(data, temp_shp, "cell_data", "ESRI Shapefile",
  #              overwrite_layer = TRUE)
  #     # zip all the shp files
  #     zip_file <- file.path(temp_shp, "cell_data_shp.zip")
  #     shp_files <- list.files(temp_shp,
  #                             "cell_data",
  #                             full.names = TRUE)
  #     # the following zip method works for me in linux but substitute with whatever method working in your OS
  #     zip_command <- paste("zip -j",
  #                          zip_file,
  #                          paste(shp_files, collapse = " "))
  #     system(zip_command)
  #     # copy the zip file to the file argument
  #     file.copy(zip_file, file)
  #     # remove all the files created
  #     file.remove(zip_file, shp_files)
  #   }
  # )
  
  # output$data_shp <- downloadHandler(
  #   filename = "cell_data.zip",
  #   content = function(file) {
  #     writeOGR(obj=df, dsn="cell_data", layer="cell_data", driver="ESRI Shapefile")
  #   }
  # )
}

shinyApp(ui = ui, server = server)