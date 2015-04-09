#'@export
smNavDropdown <- function(label, ..., el.list) {
 
  if(missing(el.list)) {
    el.list <- list(...)
  }
  
  parent <- tags$a(href = "#", class = "dropdown-toggle", 
                   "data-toggle" = "dropdown", 
                   tagList(label, tags$span(class = "caret")))
  
  dd <- smDropdown(parent, el.list)
  
  dd$name <- "li"
  
  return(dd)
  
}