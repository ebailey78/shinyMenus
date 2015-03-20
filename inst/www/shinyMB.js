var shinyMB = {inputBindings: {}};

shinyMB.inputBindings.checkboxDropdown = new Shiny.InputBinding();
$.extend(shinyMB.inputBindings.checkboxDropdown, {
  find: function(scope) {
    return $(scope).find(".smb-checkbox-dropdown");    
  },
  getValue: function(el) {
    return $(el).data("smb-value");
  },
  subscribe: function(el, callback) {
    $(el).find("a.smb-label").on("click", function(ev) {
      
      var $tar = $(ev.target);
      var val = $tar.data("smb-value");
      var gval = $(el).data("smb-value");
      var i = gval.indexOf(val);
      if(i == -1) {
        $tar.find("i").removeClass("fa-square-o").addClass("fa-check-square-o");
        gval.push(val);
      } else {
        $tar.find("i").removeClass("fa-check-square-o").addClass("fa-square-o");
        gval.splice(i, 1);
      }
      $(el).data("smb-value", gval)
      callback();
    })
  },
  initialize: function(el) {
    
    var gval = [];
    
    $(el).find("a.smb-label").each(function(i, element) {
      if($(element).find("i").hasClass("fa-check-square-o")) {
        gval.push($(element).data("smb-value"));
      }
    })
  
    $(el).data("smb-value", gval);
  
  }
  
})
Shiny.inputBindings.register(shinyMB.inputBindings.checkboxDropdown);