library(shiny)
library(shinyBS)
library(shinyMB)

app <- shinyApp(
  ui = 
    fluidPage(
      menuBar("testMenu", "shinyMB", full.width = TRUE, fixed = TRUE, 
              actionLink("testLink", "Link"),
              actionLink("testLink2", "Link #2"),
              textInput("testTextInput", "Testing"),
              actionDropdown("testDD", "Action", list("Cat", "Dog", NULL, "Rat", "Sheep", "Goat", "Horse and Buggy" = "hnb"),
                             icons = list("github-alt", NULL, NULL, NULL, "child", NULL, NULL)),
              toggleDropdown("testTogDD", "Checkbox", list("Ant", "Grasshopper", "cricket", "spider"), selected = c("spider", "Ant")),
              toggleDropdown("testTogDD2", "Radio", list("Ant", "Grasshopper", "cricket", "spider"), selected = c("spider", "Ant"), type = "radio")
      )
    ),
  server = 
    function(input, output, session) {
      observeEvent(input$testTogDD, ({print(input$testTogDD)}))
      observeEvent(input$testTogDD2, ({print(input$testTogDD2)}))
    }
)

runApp(app)
