#'smDropdown
#'
#'A wrapper for attaching a dropdown menu to a shiny element.
#'
#'Supplied with a \code{parent} and \link{Elements}, \code{smDropdown} 
#'will attach a dropdown menu to \code{parent} that contains the provided
#'\link{Elements}.
#'@param parent A shiny object to attach the dropdown to. Usually a button or link.
#'@param \dots \link{Elements} to add to the dropdown menu. 
#'@param el.list An optional \code{list} of elements to add to the dropdown
#'
#'@examples
#'smDropdown(parent = actionButton("ddEx", "Dropdown"),
#'  smAction("act1", "An Action"),
#'  smAction("act2", "Another Action"),
#'  smDivider(),
#'  smCheckbox("cbEx", "cb1", "A Checkbox"),
#'  smCheckbox("cbEx", "cb2", "Another Checkbox")
#')
#'@export
smDropdown <- function(parent, ..., el.list) {
 
  
  if(!missing(el.list)) {
    ddi <- el.list
  } else {
    ddi <- list(...)
  }
  
  ddi <- tagList(ddi)
  
  ddm <- shiny::tags$ul(class = "dropdown-menu", ddi)
  
  parent <- addClass(parent, "dropdown-toggle")
  parent <- addAttribs(parent, "data-toggle" = "dropdown")
  
  dd <- shiny::tags$div(class = "dropdown", parent, ddm)
  
  return(dd)
  
}