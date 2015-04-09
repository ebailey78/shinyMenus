# shinyMenus

menus for shiny apps

I've renamed the repository from shinyMB to shinyMenus to be more discriptive and to reflect the fact that it isn't just menu bars, but other menus as well.

This is loosely based on the `bsNavBar` functions that used to be part of shinyBS. It is just a beginning but hopefully 
it will eventually be an improvement to those functions.

The idea is that you will be able to add standard shiny inputs to a menubar and shinyMB will make the necessary changes 
to make them work within the menubar. There will also be dropdowns that work like actionButtons, checkboxGroupInputs, 
or radioButtons. I hope also to reintroduce the ability to nest dropdowns, a feature that was removed from bootstrap3.

Install it with devtools:

`devtools::install_github("ebailey78/shinyMenus")`

Here is an example that shows what the package can do so far:

```R
library(shiny)
library(shinyBS)
library(shinyMenus)

app <- shinyApp(
  ui = 
    fluidPage(
      smNavBar("testMenu", "shinyMB", full.width = TRUE, fixed = FALSE, 
              actionLink("testLink", "Link"),
              actionLink("testLink2", "Link #2"),
              textInput("n", "Sample Size", value = 1000),
              smNavDropdown("Distribution",
                 smRadio("dist", "norm", "Normal", selected = TRUE),
                 smRadio("dist", "lnorm", "Lognormal"),
                 smRadio("dist", "unif", "Uniform")
              ),
              smQuickDropdown("qd2Test", parent = "navbar", "Quick Dropdown", c("Action 1", "Action 2", "Action 3"))
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
      smQuickDropdown("qdTest", "Quick Dropdown", c("Action 1", "Action 2", "Action 3")),
      plotOutput("testPlot"),
      smContextMenu("context1", "testPlot", 
                    smRadio("dist", "norm", "Normal", selected = TRUE),
                    smRadio("dist", "lnorm", "Lognormal"),
                    smRadio("dist", "unif", "Uniform")
      )

    ),
  server = 
    function(input, output, session) {
      observeEvent(input$testCB2, ({print(input$testCB2)}))
      observeEvent(input$testRB, ({print(input$testRB)}))
      observeEvent(input$qdTest, ({print(input$qdTest)}))
      observeEvent(input[["Action 1"]], ({print(input[["Action 1"]])}))
      output$testPlot <- renderPlot({
        dist <- switch(input$dist,
                       norm = rnorm,
                       lnorm = rlnorm,
                       unif = runif
        )
        plot(dist(input$n))
      })
    }
)

runApp(app)

```

If you have ideas or suggestions please let me know in the issues section.
