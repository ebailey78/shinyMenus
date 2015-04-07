var shinyMenus = {inputBindings: {}};

shinyMenus.inputBindings.checkboxDropdown = new Shiny.InputBinding();
$.extend(shinyMenus.inputBindings.checkboxDropdown, {
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
Shiny.inputBindings.register(shinyMenus.inputBindings.checkboxDropdown);

shinyMenus.inputBindings.radioDropdown = new Shiny.InputBinding();
$.extend(shinyMenus.inputBindings.radioDropdown, {
  find: function(scope) {
    return $(scope).find(".smb-radio-dropdown");    
  },
  getValue: function(el) {
    return $(el).data("smb-value");
  },
  subscribe: function(el, callback) {
    $(el).find("a.smb-label").on("click", function(ev) {
      
      var $tar = $(ev.target);
      var $sibs = $tar.parent().siblings().find("a.smb-label");
      var val = $tar.data("smb-value");
      
      $sibs.find("i").removeClass("fa-dot-circle-o").addClass("fa-circle-o");
      $tar.find("i").removeClass("fa-circle-o").addClass("fa-dot-circle-o");
      $(el).data("smb-value", val)
      
      callback();
      
    })
  },
  initialize: function(el) {
    
    var gval = "";
    
    $(el).find("a.smb-label").each(function(i, element) {
      if($(element).find("i").hasClass("fa-dot-circle-o")) {
        gval = $(element).data("smb-value");
      }
    })
  
    $(el).data("smb-value", gval);
  
  }
  
})
Shiny.inputBindings.register(shinyMenus.inputBindings.radioDropdown);

var shinyMenus.inputBindings.popupMenu = new Shiny.InputBinding();
$.extend(shinyMenus.inputBindings.popupMenu, {
  find: function(scope) {
    return $(scope).find("div.shiny-popup-menu");
  },
  getValue: function(el) {
    return $(el).hasClass("open");
  },
  setValue: function(el, value) {
    // Strictly speaking, you're never supposed to do this...
    $(el).toggleClass("open", value);
  },
  subscribe: function(el, callback) {
    var $el = $(el);
    var $tar = $("#" + $(el).attr("data-target"));
    $tar.on("contextmenu.shiny-menu", function(e) {
      e.preventDefault();
      var x = e.clientX;
      var y = e.clientY;
      var wh = $(document).height();
      var ww = $(document).width();
      var $p = $el.children("ul");
      var h = $p.outerHeight();
      var w = $p.outerWidth();
      if(x + w > ww) x = ww - w;
      if(y + h > wh) y = wh - h;
      $el.addClass("open").css("top", y).css("left", x);
      callback();
    });
    $(document).on("click", function(e) {
      if($el.hasClass("open")) {
        $el.removeClass("open");
        callback();
      }
    });
  },
  unsubscribe: function(el) {
    $(el).off(".shiny-menu");
  }
});
Shiny.inputBindings.register(shinyMenus.inputBindings.popupMenu);