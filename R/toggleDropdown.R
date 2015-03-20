#'@export
toggleDropdown <- function(inputId, label, choices, selected, type = "checkbox") {
  
  choices <- getLabels(choices, FALSE)
  
  if(type == "checkbox") {
    default.icon <- icon("square-o", class = "fa-fw")
    selected.icon <- icon("check-square-o", class = "fa-fw")
  } else {
    default.icon <- icon("circle-o", class = "fa-fw")
    selected.icon <- icon("dot-circle-o", class = "fa-fw")
  }
  
  if(type != "checkbox") {
    selected <- selected[[1]]
  }
  
  icons <- lapply(choices, function(i) {
    if(is.null(i)) {
      op <- NULL
    } else if(i %in% selected) {
      op <- selected.icon 
    } else {
      op <- default.icon
    }
    return(op)
  })
  
  items <- tagList(lapply(seq_along(choices), function(i) {
    
    if(!is.null(choices[[i]])) {
      li.label <- names(choices)[i]
      if(!is.null(icons)) {
        li.label <- tagList(icons[i], li.label)
      } 
      li <- tags$li(tags$a(href = "#", "data-smb-value" = choices[[i]], class = "smb-label", li.label))
    } else {
      li <- tags$li(class = "divider")
    }
    
  }))
  
  mbTag <- tags$li(id = inputId, class = paste0("dropdown smb-", type, "-dropdown"),
                   tags$a(href="#", class = "dropdown-toggle", 
                          "data-toggle" = "dropdown", label, tags$span(class = "caret")),
                   tags$ul(class="dropdown-menu", items)
  )
  
  return(mbTag)
    
}