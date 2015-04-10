#'@export
smQuickDropdown <- function(id, label, elements, parent = "button", 
                            type = "action", selected = c(), caret = TRUE) {
  
  parID <- paste(id, "parent", sep = "_")
  
  if(parent == "button") {
    par <- actionButton(parID, label = label)
    if(caret) {par <- tagAppendChild(par, tags$span(class = "caret"))}
  } else {
    if(parent == "navbar") {
      label <- tagList(label, tags$span(class = "caret"))
    }
    par <- actionLink(parID, label = label) 
  }
  
  eltype <- switch(type,
                   "action" = function(name, value, label, selected) {
                                smAction(id = value, label = label)
                              },
                   "radio" = smRadio,
                   "checkbox" = smCheckbox
  )
  
  if(is.null(names(elements))) {
    names(elements) <- elements
  }
  
  els <- lapply(seq_along(elements), function(i) {
    sel <- names(elements)[i] %in% selected
    return(eltype(name = id, value = elements[i], label = names(elements)[i], selected = sel)) 
  })
  
  dd <- smDropdown(parent = par, el.list = els)
  
  if(parent == "navbar") {
    dd$name <- "li"
  }
  
  return(dd)
  
}