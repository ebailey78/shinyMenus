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
                 smRadio("testRB", "rb3", "Third Radio", selected = TRUE),
                 smSubDropdown("Submenu",
                               smAction("sact1", "Sub Action"),
                               smAction("sact2", "Another Sub Action")
                 )
      ),
      smQuickDropdown("qdTest", "Quick Dropdown", c("Action 1", "Action 2", "Action 3")),
      plotOutput("testPlot"),
      HTML("<p>Right-click on plot to see context menu.</p>"),
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
