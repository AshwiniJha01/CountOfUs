# CountOfUs

There is a word in English - 'sonder', which means 'a realization that each individual around you has a vivid and complex life like you'. So, how many such vivid and complex lives ever come to live by on the Earth? Curiosity behind this question led to this app. 

The app is temporarily hosted here: http://34.70.139.63:3838/AshwiniJha/DataScience/CountOfUs/
Here is the link to a video demo of the app: https://www.youtube.com/embed/NfYR9uTQdIo

My initial thoughts on the math that would go into figuring out the answer was more complex and involved than the end result. I was planning on simulating population from beginning to end of timeline using probability distributions for life span, mortality rates, fertility rates, etc. But, looking for these data I discovered researchers at UN had already made available data that I could build upon. There are two different datasets from UN website that I am using - population data and fertility data. The population data gives number of people at different points of time between 1950 and 2020. The fertility data gave number of children born in the same period, with an interval of 5 years. Along with these, there was a third dataset - this one had population estimates from 10,000 BC to 2015 AD. This data came from https://ourworldindata.org. A caveat is that the further we go back in time, the more margin of error is possible in these data.

But, what about the births information before 1950? Over here I have applied my creative input and built a linear regression model, bridged the gap by estimating the births before 1950. The details can be found in the approach document.

The app estimates the total population of individual human beings between 10,000 BC and 2020 AD at about 65.6 billion. Well, that is about 8.4 times the Earth's current human population.

Although humans are said to have come into existence between 30,000 BC and 70,000 BC, human population is estimated to have started growing exponentially around 10,000 BC when humans started transitioning into agriculture practise and settling in villages, rather than lead a nomadic hunter-gatherer life (source - my memory of these facts from reading Sapiens by Yuval Noah Harrari). So, margin of error in estimating from 10,000 BC instead of 30,000 BC or 70,000 BC should be small. Apart from this reason, when including the modern period in estimation along with historical period, the numbers from modern period tend to outweigh historical period, and we have better estimates of data from modern period. So, it is fine at present, with space for improvement in future.

Apart from UN and the website OurWorldInData for providing the aforementioned datasets, I would like to acknowledge:
1) Authors of the base R functions and following packages: dplyr, DT, shiny, shinythemes, shinydashboard, shinyWidgets, markdown
2) The community of R users whose contribution through many programming solutions over the internet has always helped me resolve my code bugs

Hope you find this app interesting!
