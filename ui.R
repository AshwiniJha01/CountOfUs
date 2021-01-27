# Installing and reading in the necessary libraries:
libList <- c("dplyr", "DT", "shiny","shinythemes","shinydashboard","shinyWidgets","markdown")

new.packages <- libList[!(libList %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos = "https://cloud.r-project.org/")
lapply(libList, require, character.only = TRUE)


## Building the ui.R -----------------------------------------------------------

## 1. Header ----------------------------------------------

header <- dashboardHeader(
  tags$li(class = "dropdown",
          tags$style(".main-header {max-height: 20px;font-size:20px;font-weight:bold;line-height:20px;"),
          tags$style(".navbar {min-height:1px !important;font-weight:bold;")), title ="Count of Us",
  tags$li(a(img(src = 'nameLogo.png'),href='https://www.linkedin.com/in/ashwini-jha-009646125/',
            style = "padding-top:4px; padding-bottom:1px;"),class = "dropdown"),titleWidth = 200)


## 3. Body --------------------------------
bodyD <- dashboardBody(
  
  ## 3.0 Setting skin color, icon sizes, etc. ------------
  
  ## modify the dashboard's skin color
  tags$style(HTML('
                       /* logo */
                       .skin-blue .main-header .logo {
                       background-color: #006272;
                       }
                       /* logo when hovered */
                       .skin-blue .main-header .logo:hover {
                       background-color: #006272;
                       }
                       /* navbar (rest of the header) */
                       .skin-blue .main-header .navbar {
                       background-color: #006272;
                       }
                       /* active selected tab in the sidebarmenu */
                       .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                       background-color: #006272;
                                 }
                       ')
  ),
  
  ## modify icon size in the sub side bar menu
  tags$style(HTML('
                       /* change size of icons in sub-menu items */
                      .sidebar .sidebar-menu .treeview-menu>li>a>.fa {
                      font-size: 15px;
                      }
                      .sidebar .sidebar-menu .treeview-menu>li>a>.glyphicon {
                      font-size: 13px;
                      }
                      /* Hide icons in sub-menu items */
                      .sidebar .sidebar-menu .treeview>a>.fa-angle-left {
                      display: none;
                      }
                      '
  )) ,
  
  ## making background black
  setBackgroundColor(
    color = "black",
    gradient = "radial",
    shinydashboard = T
  ),
  
  
  ## 3.1 Dashboard body --------------
  
  tabsetPanel(
    
    ############################## First tab "App" ##############################
    tabPanel(
      
      # Tab name
      h2("Count of us"),
      
      # Tab content
      
      # Radio button for different eras
      fluidRow(
        width = 6,
        align = "center",
        radioButtons(inputId = "ipEra",label = h4("Select Era", style = "background-color:#000000; color:#FFFFFF;"), choiceNames = list(
          tags$span(style = "color:white", "Modern"),
          tags$span(style = "color:white", "Historic")),
          choiceValues = c("modern","historic"), selected = "modern", width = "900px",inline = T)
      ),
      
      
      # Slider Inputs for selecting time span
      fluidRow(
        width = 6,
        style = "background-color: #000000;",
        align = "center",
        
        # Slider input for the years:
        chooseSliderSkin(skin = "Flat", color = "#006272"),
        sliderInput(inputId = "ipSpan", label = h3("Select Time Span", style = "background-color:#000000; color:#FFFFFF;"), min = 1950, max = 2020, value = c(1990,2020), step = 5, round = F, ticks = F, animate = F, width = "400px")
      ),
      
      
      # Value box for the population count:
      fluidRow(
        column(
          width = 12,
          offset = 4,
          align = "center",
          valueBox(value = textOutput("uhco"), subtitle = "NUMBER OF HUMANS",color = "yellow", width = 4, icon = icon("users"))
        )
      ),
      
      # Value box for comparison with 2020 population size:
      fluidRow(
        column(
          width = 12,
          offset = 4,
          align = "center",
          valueBox(value = textOutput("multCurrPopOp"), subtitle = "MULTIPLE OF 2020 POPULATION",color = "yellow", width = 4, icon = icon("times"))
        )
      ),
      
      # Count of born people:
      fluidRow(
        column(
          width = 12,
          offset = 4,
          align = "center",
          valueBox(value = textOutput("bornPopOp"), subtitle = "PEOPLE BORN IN SELECTED PERIOD",color = "olive", width = 4, icon = icon("users"))
        )
      ),
      
      
      # Count of dead people:
      fluidRow(
        column(
          width = 12,
          offset = 4,
          align = "center",
          valueBox(value = textOutput("deadPopOp"), subtitle = "PEOPLE DYING IN SELECTED PERIOD",color = "red", width = 4, icon = icon("users"))
        )
      )
      
    ),
    
    
    
    
    
    ############################## Read me note tab ############################## 
    tabPanel(
      h2("About the app and idea"),
      
      fluidRow(
        column(10, align="left", offset = 1,
               h1("Namaste",style = "background-color:#000000; color:#FFFFFF;font-style: italic;")
        )
      ),
      
      column(10, align="left", offset = 1,
             htmlOutput("readMeNote"),
             tags$head(tags$style("#readMeNote{color: #FFFFFF;
                                 font-size: 15px;
                                 font-style: italic;
                                 }"
             )
             )
      )
    ),
    
    
    ############################## Approach explanation tab ##############################
    tabPanel(
      h2("Approach"),
      
      fluidRow(
        includeHTML("UniqueHumanCount_Document.html")
      )
      # fluidRow(
      #   column(
      #     width = 8,
      #     align = "center",
      #     offset = 2,
      #     tags$iframe(style="height:600px; width:100%", src="http://localhost/UniqueHumanCount_Document.pdf")
      #   )
      # )
    )
    
    
  )
  
)# dashboardBody closes here

## put UI together --------------------
ui <-  dashboardPage(header, dashboardSidebar(disable = T), bodyD)


