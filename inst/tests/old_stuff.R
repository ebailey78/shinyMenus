
#'@export
radioDropdown <- function(inputId, label, choices, selected) {
  
}

#'@export
checkboxDropdown <- function(inputId, label, choices, selected) {
  
}

quickDropdown <- function(inputID, label, choices, type, selected) {
  
  if(is.null(names(choices))) {
    names(choices) <- choices
  }
  
  for(i in seq_along(choices)) {
    if(is.null(choices[[i]])) {
      choices[i] <- ddDivider()
    } else {
      choices[i] <- ddElement(label = names(choices)[i], 
                              type = type, 
                              value = choices[[i]], 
                              selected = (choices[[i]] %in% selected)
      )
    }
  }
  
  tags$li(class = "dropdown", "data-type" = type,
          tags$a(href = "#", class = "dropdown-toggle", "data-toggle" = "dropdown",
                 label, tags$span(class = "caret")),
          tags$ul(class = "dropdown-menu", choices)
  )
  
}

ddElement <- function(id, label, type, value) {
  
  icon <- tags$i(class = "fa fa-fw")
  if(type == "checkbox") {
    if(value == TRUE) {
      icon <- addClass(icon, "check-square-o")
    } else {
      icon <- addClass(icon, "square-o")
    }
  } else if(type == "radio") {
    if(value == TRUE) {
      icon <- addClass(icon, "dot-circle-o")
    } else {
      icon <- addClass(icon, "circle-o")
    }
  }
  
  label <- tags$span(icon, label)
  
  dde <- tags$li(tags$a(href = "#", id = id, value = value, label))
  
}

ddDivider <- function() {
  return(tags$li(class = "divider")) 
}