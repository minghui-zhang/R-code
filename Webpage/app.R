library(shiny)
library(leaflet)
library(dplyr)

# TUTORIAL: https://rstudio.github.io/leaflet/shiny.html

df <- readRDS("./cell_spdf.rds")

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

ui <- navbarPage("Crop Timing", id = "nav",
                 
  tabPanel("Interactive Map",
  
    radioButtons("user_intensity", "Cropping intensity:",
                 c("Single Cropping" = "SC",
                   "Double Cropping" = "DC")),
    
    selectInput("user_year", "Year:", vars),
    
    leafletOutput("mymap",height = 1000)
  ),
  
  tabPanel("Data Explorer")
)

server <- function(input, output) {
  
  data <- reactive({
    x <- df[df$intensity == input$user_intensity & df$year == input$user_year,]
  })
  
  pal <- colorNumeric(
    palette = "YlOrRd",
    domain = df$plant
  )
  
  output$mymap <- renderLeaflet({
    df <- data()
    
    m <- leaflet(data = df) %>%
      addTiles %>%
      #addProviderTiles(providers$CartoDB.Positron) %>%
      #fitBounds(lng - dist, lat - dist, lng + dist, lat + dist) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 0, fillOpacity = 1,
                  fillColor = ~pal(plant),
                  #fillColor = ~colorQuantile("YlOrRd", plant)(plant),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = paste("Plant: ", round(df$plant), " days after Aug 1 <br>",
                                "Onset: ", df$onset, "days after Aug 1")
                  ) %>%
      addLegend("bottomright", pal = pal, values = ~plant,
                title = "Planting date (DOY after Aug 1)",
                opacity = 1
      ) 
      #addLayersControl(
      #  overlayGroups = c("Plant 2014"),
      #  options = layersControlOptions(collapsed = TRUE)
      #)
  })
  
  observe({
    dist <- 0.5
    lng <- data()$long
    lat <- data()$lat
    
    leafletProxy("map") %>%
       fitBounds(lng - dist, lat - dist, lng + dist, lat + dist)
    })

  
}

shinyApp(ui = ui, server = server)