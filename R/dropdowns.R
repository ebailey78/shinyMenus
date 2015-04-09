#'@export
smDropdown <- function(parent, ...) {
 
  ddi <- shiny::tagList(...)
  ddm <- shiny::tags$ul(class = "dropdown-menu", ddi)
  
  parent <- addClass(parent, "dropdown-toggle")
  parent <- addAttribs(parent, "data-toggle" = "dropdown")
  
  dd <- shiny::tags$div(class = "dropdown", parent, ddm)
  
  return(dd)
  
}

#'@export
smHeader <- function(label) {
  return(shiny::tags$li(class = "dropdown-header", label))
}

#'@export
smDivider <- function() {
  return(shiny::tags$li(class = "divider")) 
}

#'@export
smAction <- function(id, label, icon) {
  
  if(missing(icon)) {
    icon <- HTML("<i class = 'fa fa-fw'></i>")
  }
  
  label <- shiny::tagList(icon, label) 
  
  ddi <- shiny::tags$li(shiny::tags$a(id = id, 
                        href = "#", 
                        class = "action-button sm-dropdown-input", 
                        label
                        )
                 )
  
  return(ddi)
  
}

#'@export
smRadio <- function(name, value, label, selected = FALSE) {
  smToggle(name, value, label, "radio", selected)
}

#'@export
smCheckbox <- function(name, value, label, selected = FALSE) {
  smToggle(name, value, label, "checkbox", selected = selected) 
}

#'@export
smToggle <- function(name, value, label, type = "checkbox", selected = FALSE) {
  
  if(!(type %in% c("radio", "checkbox"))) stop("Unrecognized type argument.")
  
  if(type == "checkbox") {
    default.icon <- shiny::icon("square-o", class = "fa-fw")
    selected.icon <- shiny::icon("check-square-o", class = "fa-fw")
  } else {
    default.icon <- shiny::icon("circle-o", class = "fa-fw")
    selected.icon <- shiny::icon("dot-circle-o", class = "fa-fw")
  }
  
  if(selected) {
    label <- shiny::tagList(selected.icon, label)
  } else {
    label <- shiny::tagList(default.icon, label)
  }
  
  ddi <- shiny::tags$li(shiny::tags$a(href = "#",
                        "data-name" = name,
                        "data-value" = value,
                        "data-type" = type,
                        class = "sm-dropdown-input",
                        label
                        )
                 )
  
  return(ddi)
  
}