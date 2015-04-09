library(shiny)
library(shinyBS)
library(shinyMenus)

app <- shinyApp(
  ui = 
    fluidPage(
      menuBar("testMenu", "shinyMB", full.width = TRUE, fixed = FALSE, 
              actionLink("testLink", "Link"),
              actionLink("testLink2", "Link #2"),
              textInput("testTextInput", "Testing"),
              actionDropdown("testDD", "Action", list("Cat", "Dog", NULL, "Rat", "Sheep", "Goat", "Horse and Buggy" = "hnb"),
                             icons = list("github-alt", NULL, NULL, NULL, "child", NULL, NULL)),
              toggleDropdown("testTogDD2", "Radio", list("Ant", "Grasshopper", "cricket", "spider"), selected = c("spider", "Ant"), type = "radio")
      ),
      smDropdown(actionLink("ddTest", "Dropdown"),
                 smHeader("Action Elements"),
                 smAction("action1", "Action"),
                 smAction("action2", "Another Action"),
                 smDivider(),
                 smHeader("Checkbox Elements"),
                 smCheckbox("testCB", "cb1", "First Checkbox"),
                 smCheckbox("testCB", "cb2", "Second Checkbox"),
                 smCheckbox("testCB", "cb3", "Third Checkbox", selected = TRUE),
                 smDivider(),
                 smHeader("More Checkboxes"),
                 smCheckbox("testCB2", "cb21", "First Checkbox", selected = TRUE),
                 smCheckbox("testCB2", "cb22", "Second Checkbox", selected = TRUE),
                 smCheckbox("testCB2", "cb23", "Third Checkbox"),
                 smDivider(),
                 smHeader("Radio Elements"),
                 smRadio("testRB", "rb1", "First Radio"),
                 smRadio("testRB", "rb2", "Second Radio", selected = TRUE),
                 smRadio("testRB", "rb3", "Third Radio", selected = TRUE)
      ),
      smDropdown(actionButton("ddTest2", "Dropdown Too"),
                 smHeader("Linked Checkboxes"),
                 smCheckbox("testCB2", "cb21", "First Checkbox"),
                 smCheckbox("testCB2", "cb22", "Second Checkbox", selected = TRUE),
                 smCheckbox("testCB2", "cb23", "Third Checkbox", selected = TRUE),
                 smDivider(),
                 smHeader("Linked Radio Elements"),
                 smRadio("testRB", "rb1", "First Radio"),
                 smRadio("testRB", "rb2", "Second Radio"),
                 smRadio("testRB", "rb3", "Third Radio")
    )

      
    ),
  server = 
    function(input, output, session) {
#      observeEvent(input$testTogDD, ({print(input$testTogDD)}))
#      observeEvent(input$testTogDD2, ({print(input$testTogDD2)}))
      observeEvent(input$testCB2, ({print(input$testCB2)}))
      observeEvent(input$testRB, ({print(input$testRB)}))
    }
)

runApp(app)
