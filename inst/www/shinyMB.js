// When DOM is ready search for dropdown items and create a shiny binding object 
// for each unique name. 
$(document).ready(function () {

  var ddi = $(".sm-dropdown-input");
  ddi.each(function (i, el) {
    var $el = $(el);
    if ($el.hasClass("action-button") === false) {
      var nam = $el.attr("data-name");
      if ($("#" + nam).length === 0) {
        $("body").append("<div id = '" + nam + "' class = 'sm-dropdown-binding' data-type = '" + $el.attr("data-type") + "'></div>");
      }
    }
  });
  
  $('ul.dropdown-menu [data-toggle=dropdown]').on('click', function(event) {
    // Avoid following the href location when clicking
    event.preventDefault(); 
    // Avoid having the menu to close when clicking
    event.stopPropagation(); 
    // If a menu is already open we close it
    //$('ul.dropdown-menu [data-toggle=dropdown]').parent().removeClass('open');
    // opening the one you clicked on
    $(this).parent().addClass('open');

    var menu = $(this).parent().find("ul");
    var menupos = menu.offset();
  
    if ((menupos.left + menu.width()) + 30 > $(window).width()) {
        var newpos = - menu.width();      
    } else {
        var newpos = $(this).parent().width();
    }
    menu.css({ left:newpos });

  });

});

var shinyMenus = {inputBindings: {}};

shinyMenus.inputBindings.checkboxDropdown = new Shiny.InputBinding();
$.extend(shinyMenus.inputBindings.checkboxDropdown, {
  find: function (scope) {
    return $(scope).find(".sm-dropdown-binding[data-type = 'checkbox']");
  },
  getValue: function (el) {
    return $(el).data("sm-value");
  },
  subscribe: function (el, callback) {
    var $el = $(el),
      id = $el.attr("id");
    $("a.sm-dropdown-input[data-name = '" + id + "']").on("click.sm", function (ev) {
      var $tar = $(ev.target),
        val = $tar.attr('data-value'),
        gval = $el.data('sm-value'),
        i = gval.indexOf(val),
        $mat = $("a.sm-dropdown-input[data-name='" + id + "'][data-value='" + val + "']");

      if (i === -1) {
        $mat.find("i").removeClass("fa-square-o").addClass("fa-check-square-o");
        gval.push(val);
      } else {
        $mat.find("i").removeClass("fa-check-square-o").addClass("fa-square-o");
        gval.splice(i, 1);
      }
      $el.data("sm-value", gval);
      callback();
    });
  },
  unsubscribe: function (el) {
    $("a.sm-dropdown-input[data-name = '" + $(el).attr("id") + "']").off("click.sm");
  },
  initialize: function (el) {

    var gval = [],
      id = $(el).attr("id"),
      $items = $("a.sm-dropdown-input[data-name='" + id + "']");

    $items.children("i").each(function (i, element) {
      if ($(element).hasClass("fa-check-square-o")) {
        var val = $(element).parent().attr("data-value");
        //This ensures that if selected = TRUE on any matching element, they will all be selected. (I hope)
        $("a.sm-dropdown-input[data-name='" + id + "'][data-value='" + val + "']")
          .children("i").removeClass("fa-square-o")
          .addClass("fa-check-square-o");
        if (gval.indexOf(val) === -1) {
          gval.push(val);
        }
      }
    });

    $(el).data("sm-value", gval);

  }
});
Shiny.inputBindings.register(shinyMenus.inputBindings.checkboxDropdown);

shinyMenus.inputBindings.radioDropdown = new Shiny.InputBinding();
$.extend(shinyMenus.inputBindings.radioDropdown, {
  find: function (scope) {
    return $(scope).find(".sm-dropdown-binding[data-type = 'radio']");
  },
  getValue: function (el) {
    return $(el).data("sm-value");
  },
  subscribe: function (el, callback) {
    var $el = $(el),
      id = $el.attr("id");
    $("a.sm-dropdown-input[data-name = '" + id + "']").on("click.sm", function (ev) {
      var $tar = $(ev.target),
        val = $tar.attr('data-value'),
        gval = $el.data('sm-value'),
        i = gval.indexOf(val),
        $all = $("a.sm-dropdown-input[data-name='" + id + "']"),
        $mat = $all.filter("[data-value='" + val + "']");

      if (gval !== val) {
        $all.find("i").removeClass("fa-dot-circle-o").addClass("fa-circle-o");
        $mat.find("i").removeClass("fa-circle-o").addClass("fa-dot-circle-o");
        gval = val;
      }
      $el.data("sm-value", gval);
      callback();
    });
  },
  unsubscribe: function (el) {
    $("a.sm-dropdown-input[data-name = '" + $(el).attr("id") + "']").off("click.sm");
  },
  initialize: function (el) {
    var gval = "",
      id = $(el).attr("id"),
      $items = $("a.sm-dropdown-input[data-name='" + id + "']");

    $items.children("i").each(function (i, element) {
      if ($(element).hasClass("fa-dot-circle-o")) {
        var val = $(element).parent().attr("data-value");
        $items.children("i").removeClass("fa-dot-circle-o").addClass("fa-circle-o");
        //This ensures that if selected = TRUE on any matching element, they will all be selected. (I hope)
        $("a.sm-dropdown-input[data-name='" + id + "'][data-value='" + val + "']")
          .children("i").removeClass("fa-circle-o")
          .addClass("fa-dot-circle-o");
          gval = val;
      }
    });

    $(el).data("sm-value", gval);    
  }
});
Shiny.inputBindings.register(shinyMenus.inputBindings.radioDropdown);

shinyMenus.inputBindings.radioDropdown = new Shiny.InputBinding();
$.extend(shinyMenus.inputBindings.radioDropdown, {
  find: function (scope) {
    return $(scope).find(".smb-radio-dropdown");
  },
  getValue: function (el) {
    return $(el).data("smb-value");
  },
  subscribe: function (el, callback) {
    $(el).find("a.smb-label").on("click", function (ev) {

      var $tar = $(ev.target),
        $sibs = $tar.parent().siblings().find("a.smb-label"),
        val = $tar.data("smb-value");

      $sibs.find("i").removeClass("fa-dot-circle-o").addClass("fa-circle-o");
      $tar.find("i").removeClass("fa-circle-o").addClass("fa-dot-circle-o");
      $(el).data("smb-value", val);

      callback();

    });
  },
  initialize: function (el) {

    var gval = "";

    $(el).find("a.smb-label").each(function (i, element) {
      if ($(element).find("i").hasClass("fa-dot-circle-o")) {
        gval = $(element).data("smb-value");
      }
    });

    $(el).data("smb-value", gval);

  }

});
Shiny.inputBindings.register(shinyMenus.inputBindings.radioDropdown);

shinyMenus.inputBindings.popupMenu = new Shiny.InputBinding();
$.extend(shinyMenus.inputBindings.popupMenu, {
  find: function (scope) {
    return $(scope).find("div.sm-context-menu");
  },
  getValue: function (el) {
    return $(el).hasClass("open");
  },
  setValue: function (el, value) {
    // Strictly speaking, you're never supposed to do this...
    $(el).toggleClass("open", value);
  },
  subscribe: function (el, callback) {
    var $el = $(el),
      $tar = $("#" + $(el).attr("data-target"));
    $tar.on("contextmenu.shiny-menu", function (e) {
      e.preventDefault();
      var x = e.clientX,
        y = e.clientY,
        wh = $(document).height(),
        ww = $(document).width(),
        $p = $el.children("ul"),
        h = $p.outerHeight(),
        w = $p.outerWidth();

      if (x + w > ww) {
        x = ww - w;
      }
      if (y + h > wh) {
        y = wh - h;
      }
      $el.addClass("open").css("top", y).css("left", x);
      callback();
    });
    $(document).on("click", function () {
      if ($el.hasClass("open")) {
        $el.removeClass("open");
        callback();
      }
    });
  },
  unsubscribe: function (el) {
    $(el).off(".shiny-menu");
  }
});
Shiny.inputBindings.register(shinyMenus.inputBindings.popupMenu);