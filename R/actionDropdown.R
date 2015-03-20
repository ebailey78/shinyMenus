#'@export
actionDropdown <- function(inputId, label, choices, icons = NULL) {
 
  if(!is.null(icons)) {
    if(length(icons) != length(choices)) {
      stop("If provided, icons vector must be same length as choices list.")
    } else {
      icons <- sapply(icons, function(i) {
        if(class(i) == "shiny.tag") {
          if(i$name == "i" & hasClass(i, "fa")) {
            if(!hasClass(i, "fa-fw")) {
              i <- addClass(i, "fa-fw")
            }
          }
        } else if(is.character(i)) {
          i <- icon(i, class = "fa-fw")
        } else if(is.null(i)) {
          i <- HTML("<i class = 'fa fa-fw'></i>")
        } else {
          stop("Unrecognized icon element.")
        }
        
        return(i)
      })
    }
  }
  
  choices <- getLabels(choices)
    
  items <- tagList(lapply(seq_along(choices), function(i) {
    
    if(!is.null(choices[[i]])) {
      li.label <- names(choices)[i]
      if(!is.null(icons)) {
        li.label <- tagList(icons[i], li.label)
      } 
      li <- tags$li(tags$a(href = "#", id = choices[[i]], class = "smb-label action-button", li.label))
    } else {
      li <- tags$li(class = "divider")
    }
    
  }))
  
  mbTag <- tags$li(id = inputId, class = "dropdown smb-action-dropdown",
      tags$a(href="#", class = "dropdown-toggle", 
             "data-toggle" = "dropdown", label, tags$span(class = "caret")),
      tags$ul(class="dropdown-menu", items)
  )
  
  return(mbTag)
  
}

getLabels <- function(choices, id.check = TRUE) {
  
  labels <- sapply(seq_along(choices), function(i) {
    
    if(id.check) {
      x <- choices[[i]]
      if(is.null(x)) x <- ""
      if(grepl(" ", i, fixed = TRUE)) {
        stop("choices cannot contain spaces. Use a named list if you want more complex labels in the dropdown.")  
      }
    }
    
    if(is.null(names(choices))) {
      op <- choices[[i]]
    } else if(names(choices)[i] == "") {
      op <- choices[[i]]
    } else {
      op <- names(choices)[i]
    }
    
  })
  
  names(choices) <- labels
  
  return(choices)
  
}

getDDItems <- function(choices, icons = NULL) {
  

  
  return(items)
  
}