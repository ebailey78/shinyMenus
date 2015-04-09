#'Dropdown Elements
#'
#'Basic elements to create dropdown menus in \code{shinyMenus}
#'
#'@details Use these elements to create custom dropdown menus in your shiny apps. They can
#'be used within standard dropdowns, context menus, navbar dropdowns, or submenus.
#'@name Elements
NULL

#'@name Elements
#'@param label The label to appear on the element
#'
#'@details \code{smHeader} adds a grey, unclickable header to your dropdown menu.
#'Use it help divide your dropdowns into meaningful subsets.
#'@export
smHeader <- function(label) {
  return(shiny::tags$li(class = "dropdown-header", label))
}

#'@name Elements
#'@details \code{smDivider} adds a light, horizontal line to your dropdown menu.
#'It can also help to divide you dropdowns into meaningful subsets.
#'@export
smDivider <- function() {
  return(shiny::tags$li(class = "divider")) 
}

#'@name Elements
#'@param id The id of the action element
#'@param icon An optional \code{\link{icon}} object to add to the element
#'@details \code{smAction} acts exactly like a native \code{\link{actionButton}}
#'or \code{\link{actionLink}} in \code{\link{shiny}}.
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

#'@name Elements
#'@param name A unique name for the group of elements.
#'@param value The value to return when this element is selected.
#'@param selected Should this element be selected at the start?
#'
#'@details \code{smRadio} creates an individual radio dropdown input. When any
#'radio input with the same \code{name} attribute is selected by the user, all
#'other elements with the same \code{name} will be deselected, and the clicked
#'element will become selected. Reference the \code{smRadio}'s \code{name} attribute
#'to retrieve the value from within your Server logic. For example if 
#'\code{name = "foo"}, then from the server, \code{input$foo} would retrieve the 
#'value of the currently selected element within the \code{foo} group.
#'
#'You can have more than one \code{smRadio} input with the same \code{name} and 
#'\code{value}. Doing so will link these inputs so that if one becomes selected,
#'they will all become selected. This allows you to place options in several places
#'in your shiny app. For example, You could allow the user to change the units of the 
#'displayed data from a dropdown in the navbar and from a context menu. These two
#'locations will update based on selections from the other and you will only have
#'to watch one \code{input} from your Server logic.
#'
#'@export
smRadio <- function(name, value, label, selected = FALSE) {
  smToggle(name, value, label, "radio", selected)
}

#'@name Elements
#'@details \code{smCheckbox} works the same as \code{smRadio} but allows for more
#'than one element from a group to be selected at once.
#'@export
smCheckbox <- function(name, value, label, selected = FALSE) {
  smToggle(name, value, label, "checkbox", selected = selected) 
}

#'@name Elements
#'@param type The type of dropdown element to create.
#'@details \code{smToggle} can create radio or checkbox elements depending on the
#'value of \code{type}. \code{smRadio} and \code{smCheckbox} are actually wrappers
#'for \code{smToggle} with \code{type} already specified. Create your dropdowns
#'however you like.
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