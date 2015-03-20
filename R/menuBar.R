#'@export
menuBar <- function(id, brand = NULL, ..., full.width = TRUE, 
                    fixed = FALSE, inverse = FALSE) {
  
  leftItems <- list(...)
  
  leftItemsGrouped <- list(list())
  
  if(grepl("form-group", leftItems[[1]]$attribs$class)) {
    attr(leftItemsGrouped[[1]], "nav.type") <- "nav.form"
  } else {
    attr(leftItemsGrouped[[1]], "nav.type")  <- "nav.list"
  }
  
  for(i in seq_along(leftItems)) {
    
    group.form <- attr(leftItemsGrouped[[length(leftItemsGrouped)]], "nav.type") == "nav.form"
    item.form <- grepl("form-group", leftItems[[i]]$attribs$class)
    
    if(group.form != item.form) {
      leftItemsGrouped[[length(leftItemsGrouped) + 1]] <- list()
      if(item.form) {
        attr(leftItemsGrouped[[length(leftItemsGrouped)]], "nav.type") <- "nav.form"
      } else {
        attr(leftItemsGrouped[[length(leftItemsGrouped)]], "nav.type") <- "nav.list"
      }
    }
    
    group <- leftItemsGrouped[[length(leftItemsGrouped)]]
    new.item <- convertElement(leftItems[[i]])
    group[[length(group) + 1]] <- new.item
    leftItemsGrouped[[length(leftItemsGrouped)]] <- group
    
  }

  leftItems <- tagList(lapply(leftItemsGrouped, function(x) {
    if(attr(x, "nav.type") == "nav.list") {
      op <- tags$ul(class = "nav navbar-nav", tagList(x))
    } else {
      op <- tags$form(class = "navbar-form navbar-left", tagList(x))
    }
    return(op)
  }))
  
  class <- "navbar"
  if(inverse) {
    class <- paste(class, "navbar-inverse")
  } else {
    class <- paste(class, "navbar-default")
  }
  
  if(fixed) {
    class <- paste(class, "navbar-fixed-top")
  } 
  
  head <- tags$div(class = "navbar-header",
            tags$button(type = "button", class = "navbar-toggle collapsed", "data-toggle" = "collapse", "data-target" = paste0("#", id),
              tags$span(class = "icon-bar"),
              tags$span(class = "icon-bar"),
              tags$span(class = "icon-bar")
            ),
            tags$a(class = "navbar-brand", href = "#", brand)
  )
  
  if(full.width) {
    container = "container-fluid"
  } else {
    container = "container"
  }

  nb <- tags$div(class = class, tags$div(class = container, head, tags$div(class = "collapse navbar-collapse", id = id, leftItems)))

  htmltools::attachDependencies(nb, shinyMBDep)
  
}

convertElement <- function(el) {
  if(el$name == "button") {
    el <- tags$li(addClass(el, "navbar-btn"))
  } else if(el$name == "a") {
    el <- tags$li(el) 
  } else if(grepl("form-group", el$attribs$class)) {
    el <- removeClass(el, "shiny-input-container")
    if(grepl("shiny-input-checkboxgroup", el$attribs$class) | grepl("shiny-input-radiogroup", el$attribs$class)) {
      if(!grepl("shiny-input-container-inline", el$attribs$class)) {
        el <- addClass(el, "shiny-input-container-inline")
      }
    }
    el <- tags$form(class = "navbar-form navbar-left", el) 
  } else if(grepl("shiny-text-output", el$attribs$class)) {
    el <- addClass(el, "navbar-text")
  } else if(el$name == "li" & grepl("dropdown", el$attribs$class)) {
    el <- el
  } else {
#    el <- NULL
  }
  return(el)
  
}
