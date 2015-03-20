# shinyMB
menubars for shiny apps

This is loosely based on the `bsNavBar` functions that used to be part of shinyBS. It is just a beginning but hopefully 
it will eventually be an improvement to those functions.

The idea is that you will be able to add standard shiny inputs to a menubar and shinyMB will make the necessary changes 
to make them work within the menubar. There will also be dropdowns that work like actionButtons, checkboxGroupInputs, 
or radioButtons. I hope also to reintroduce the ability to nest dropdowns, a feature that was removed from bootstrap3.

Here is an example that shows what the package can do so far:

```R
library(shiny)
library(shinyMB)

app <- shinyApp(
  ui = 
    fluidPage(
      menuBar("testMenu", "shinyMB", full.width = TRUE, fixed = TRUE, 
              actionLink("testLink", "Link"),
              actionLink("testLink2", "Link #2"),
              textInput("testTextInput", "Testing"),
              actionDropdown("testDD", "Action", list("Cat", "Dog", NULL, "Rat", "Sheep", 
                                                      "Goat", "Horse and Buggy" = "hnb"),
                             icons = list("github-alt", NULL, NULL, NULL, "child", NULL, 
                                          NULL)),
              toggleDropdown("testTogDD", "Checkbox", 
                              list("Ant", "Grasshopper", "cricket", "spider"), 
                              selected = c("spider", "Ant"))
      )
    ),
  server = 
    function(input, output, session) {
      observeEvent(input$testTogDD, ({print(input$testTogDD)}))
    }
)

runApp(app)
```

If you have ideas or suggestions please let me know in the issues section.
