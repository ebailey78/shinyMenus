#'@export
smSubDropdown <- function(label, ..., el.list) {
 
  parent <- tags$a(href = "#", class = "dropdown-toggle", 
                   "data-toggle" = "dropdown", label)
  
  if(missing(el.list)) {
    el.list <- list(...)
  }
  
  dd <- smDropdown(parent, el.list)
  dd$name <- "li"
  dd <- addClass(dd, "dropdown-submenu")
  
  return(dd)
  
}