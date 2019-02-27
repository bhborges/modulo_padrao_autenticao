(function() {

  $(document).on("turbolinks:load", function(){
    /*
     * Pesquisar do menu esquerdo
     */
    $("#form-sidebar-search").on("submit", function(){
      var pesquisa = $("#search_menu_item").val();
      if (pesquisa == "") {
        return $("#left-menu-accordion > .nav-heading > ul > li").show().parent().collapse("hide").parent(".nav-heading").show();
      }
      $("#left-menu-accordion > .nav-heading:not(:first), #left-menu-accordion > .nav-heading > ul > li").hide();
      $("#left-menu-accordion > .nav-heading > ul span:contains('" + pesquisa + "')").each(function(i, element){
        $(element).closest("li").show().closest(".nav-heading").show().find("ul").collapse("show");
      });
    });

    /*
     * Menu - Encontrar link referente a url da rota
     */
    var aTag = null;
    var requestUri = window.location.pathname + window.location.search;
    if ($("#left-menu-accordion a[href='"+requestUri+"']").length) {
      aTag = $("#left-menu-accordion a[href='"+requestUri+"']");
    } else if ($("#left-menu-accordion a[href='"+requestUri.replace(window.location.search,"")+"']").length) {
      aTag = $("#left-menu-accordion a[href='"+requestUri.replace(window.location.search,"")+"']");
    } else {
      var link = "";
      var selectorMenuSplit = requestUri.split("/");
      for (var i = 1; i < selectorMenuSplit.length; i++) {
        link += "/" + selectorMenuSplit[i];
        if ($("#left-menu-accordion a[href='"+link+"']").length) {
          aTag = $("#left-menu-accordion a[href='"+link+"']");
          break;
        }
      }
    }

    /*
     * Abrir accordion e destacar menu ativo
     */
    if (aTag) {
      var aParentTag = aTag.closest(".collapse");

      aTag.parent().addClass("active");
      if (aParentTag) {
        aParentTag.show();
        aParentTag.parent("li").addClass("active");
        aParentTag.closest("ul").addClass("active");
      }
    }
  });

}).call(this);
