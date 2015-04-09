#'@export
smContextMenu <- function(menuId, target, ...) {
 
  dd <- tags$div(id = menuId, class = "dropdown sm-context-menu", 
                 "data-target" = target, tags$ul(class = "dropdown-menu", ...))
  
}