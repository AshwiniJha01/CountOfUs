server <- function(input, output, session){
  
  
  # Reading in the pre-processed datasets (for the math behind preparation of this data, refer to RMarkdown file "")
  wrldPopData <- readRDS("data/wrldPopData.RDS")
  wrldBirthsData <- readRDS("data/wrldBirthsData.RDS")
  
  
  # Updating the input slider for time span depending on the radio button selection of modern vs historic
  observe({
    inputEra <- input$ipEra
    
    if(inputEra == "modern"){
      updateSliderInput(
        session = session,
        "ipSpan",
        min = 1950, max = 2020, value = c(1990,2020), step = 5
      )
    }
    
    if(inputEra == "historic"){
      updateSliderInput(
        session = session,
        "ipSpan",
        min = -10000, max = 2020, value = c(-2000,2020), step = 25
      )
    }
  })
  
  # Calculating the number of humans in the time span selected by user
  uhc <- eventReactive(eventExpr = input$ipSpan, valueExpr = {
    timeSpan <- input$ipSpan
    op <- wrldPopData[wrldPopData$Year == timeSpan[1],"PopulationX1000"] + sum(wrldBirthsData[wrldBirthsData$YearMod >= timeSpan[1] & wrldBirthsData$YearMod <= (timeSpan[2] - 5),"BirthsX1000"])
    return(op*1000)
  })
  output$uhco <- renderText({format(uhc(),big.mark=",",scientific=FALSE)})
  
  # Calculating total people as a multiple of population in 2020
  multCurrPop <- eventReactive(eventExpr = input$ipSpan, valueExpr = {
    return(uhc()/wrldPopData[wrldPopData$Year == 2020,"PopulationX1000"]/1000)
  })
  output$multCurrPopOp <- renderText({round(multCurrPop(),3)})
  
  # Calculating number of people born in selected period
  bornPop <- eventReactive(eventExpr = input$ipSpan, valueExpr = {
    timeSpan <- input$ipSpan
    op <- sum(wrldBirthsData[wrldBirthsData$YearMod >= timeSpan[1] & wrldBirthsData$YearMod <= (timeSpan[2] - 5),"BirthsX1000"])
    return(op*1000)
  })
  output$bornPopOp <- renderText({format(bornPop(),big.mark=",",scientific=FALSE)})
  
  
  # Calculating number of people dying in selected period
  deadPop <- eventReactive(eventExpr = input$ipSpan, valueExpr = {
    timeSpan <- input$ipSpan
    op <- wrldPopData[wrldPopData$Year == timeSpan[1],"PopulationX1000"] + sum(wrldBirthsData[wrldBirthsData$YearMod >= timeSpan[1] & wrldBirthsData$YearMod <= (timeSpan[2] - 5),"BirthsX1000"]) - wrldPopData[wrldPopData$Year == timeSpan[2],"PopulationX1000"]
    return(op*1000)
  })
  output$deadPopOp <- renderText({format(deadPop(),big.mark=",",scientific=FALSE)})
  
  
  # Content of Read Me tab:
  readMe <- HTML("There is a word in English - 'sonder', which means 'a realization that each individual around you has a vivid and complex life like you'. So, how many such vivid and complex lives ever come to live by on the Earth? Curiosity behind this question led to this app.<br><br>

My initial thoughts on the math that would go into figuring out the answer was more complex and involved than the end result. I was planning on simulating population from beginning to end of timeline using probability distributions for life span, mortality rates, fertility rates, etc. But, looking for these data I discovered researchers at UN had already made available data that I could build upon. There are two different datasets from UN website that I am using - population data and fertility data. The population data gives number of people at different points of time between 1950 and 2020. The fertility data gave number of children born in the same period, with an interval of 5 years. Along with these, there was a third dataset - this one had population estimates from 10,000 BC to 2015 AD. This data came from https://ourworldindata.org. A caveat is that the further we go back in time, the more margin of error is possible in these data.<br><br>

But, what about the births information before 1950? Over here I have applied my creative input and built a linear regression model, bridged the gap by estimating the births before 1950. The details can be found in the approach document.<br><br>

The app estimates the total population of individual human beings between 10,000 BC and 2020 AD at about 65.6 billion. Well, that is about 8.4 times the Earth's current human population.<br><br>

Although humans are said to have come into existence between 30,000 BC and 70,000 BC, human population is estimated to have started growing exponentially around 10,000 BC when humans started transitioning into agriculture practise and settling in villages, rather than lead a nomadic hunter-gatherer life (source - my memory of these facts from reading Sapiens by Yuval Noah Harrari). So, margin of error in estimating from 10,000 BC instead of 30,000 BC or 70,000 BC should be small. Apart from this reason, when including the modern period in estimation along with historical period, the numbers from modern period tend to outweigh historical period, and we have better estimates of data from modern period. So, it is fine at present, with space for improvement in future.<br><br>

Apart from UN and the website OurWorldInData for providing the aforementioned datasets, I would like to acknowledge:<br>
1) Authors of the base R functions and following packages: dplyr, DT, shiny, shinythemes, shinydashboard, shinyWidgets, markdown<br>

2) The community of R users whose contribution through many programming solutions over the internet has always helped me resolve my code bugs<br><br>


Hope you find this app interesting!<br>
<a href='https://www.linkedin.com/in/ashwini-jha-009646125/'>Ashwini Jha <br>
Data Scientist <br>Connect with me on LinkedIn</a>")
 
  ## Read Me:
  output$readMeNote <- renderText({return(readMe)}) 
}