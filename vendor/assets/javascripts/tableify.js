/*!
 * Tableify v0.1 Beta
 * Copyright (c) 2017 Eduardo Azevedo
 * Licensed under MIT http://www.opensource.org/licenses/MIT
 */
;(function ($, window, undefined) {

  $.fn.tableify = function(options) {
    // Global variables
    var that = this;
    var id = this.attr("id") || ("tableify-" + Math.random().toString(36).substring(7));
    var alreadyRendered = this.data("rendered") == true;

    // Tableify settings
    var settings = $.extend({
      checkable: this.data("checkable"),
      onChecked: function(el){}
    }, options);

    /*
     * Tableify initializer
     */
    function initialize() {
      that.addClass("tableify");
      that.attr("data-rendered", "true");

      var order = getUrlParameter('order');
      var sort = getUrlParameter('sort');
      var column = that.find("thead > tr > th[data-column='"+sort+"']");

      if (order == "desc") {
        var css = "down";
      } else {
        var css = "up";
      }

      if (column.data('column') == sort) {
        column.append("<div class='pull-right arrow-"+css+"'></div>");
      }
    }

    /*
     * Checkable tableify
     */
    function renderCheckable() {
      // Append checkbox on thead
      that.find("thead > tr > th:first-child").before(
        '<th class="text-center tableify-checkable" style="width: 40px"><input type="checkbox"></th>'
      );

      // Append checkbox on tbody
      that.find("tbody > tr").each(function(i, tr){
        var identifier = $(tr).find("td[data-identifier=true]").html();

        $(tr).find("td:first-child").before(
          '<td class="text-center tableify-checkable" style="width: 40px"><input type="checkbox" value="'+identifier+'"></td>'
        );
      });

      // Trigger on check theader checkbox
      that.find("thead > tr > th:first-child > input[type=checkbox]").change(function(){
        $(this).closest("table").find("tbody > tr > td:first-child > input[type=checkbox]").prop("checked", this.checked);
        if (this.checked) {
          $(this).closest("table").find("tbody > tr").addClass("select-row");
        } else {
          $(this).closest("table").find("tbody > tr").removeClass("select-row");
        }
        settings.onChecked(this);
      });

      // Trigger on check tbody checkbox
      that.find("tbody > tr > td:first-child > input[type=checkbox]").change(function(){
        var headerCheckbox = $(this).closest("table").find("thead > tr > th:first-child > input[type=checkbox]");
        if ($(this).closest("tbody").find("tr > td:first-child > input[type=checkbox]:not(:checked)").length > 0) {
          headerCheckbox.prop("checked", false);
        } else {
          headerCheckbox.prop("checked", true);
        }
        if (this.checked) {
          $(this).closest("tr").addClass("select-row");
        } else {
          $(this).closest("tr").removeClass("select-row");
        }
        settings.onChecked(this);
      });
    }

    /*
     * Visible tableify
     */
    function renderVisible() {
      that.find("thead > tr > th[data-visible=false]").hide();
      that.find("tbody > tr > td[data-visible=false]").hide();
    }

     /*
     * Method for get url parameters
     */
    function getUrlParameter(sParam) {
      var sPageURL = decodeURIComponent(window.location.search.substring(1)),
          sURLVariables = sPageURL.split('&'),
          sParameterName,
          i;

      for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
          return sParameterName[1] === undefined ? true : sParameterName[1];
        }
      }
    }

     /*
     * Data Sortable
     */
    function dataSortable() {
      var th = that.find("thead > tr > th[data-sortable]");
      th.click(function(event) {
        var column = $(this).data("column");
        var order = getUrlParameter("order") == "asc" ? "desc" : "asc";
        var sort = getUrlParameter("sort");
        var params = "?sort=" + column + "&order=";
        var url = window.location.href.split("?")[0];
        if (typeof Turbolinks !== "undefined") {
          Turbolinks.visit(url + params + order)
        } else {
          window.location = url + params + order;
        }
      });
    }

    /*
     * Table actions
     */
    function tableActions(){
      var dropdownHtml = '<div class="dropdown">' +
                         '  <button type="button" class="btn btn-white btn-normal btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">' +
                         '    <span class="dropdown-text"></span>' +
                         '    <span class="caret"></span>' +
                         '  </button>' +
                         '  <ul class="dropdown-menu dropdown-action-links-items" role="menu">' +
                         '  </ul>' +
                         '</div>';

      that.find("td.tableify-actions").each(function(i, element){
        $dropdown = $(dropdownHtml);
        $(element).find('a, div.dropdown-divider').each(function(i, aTag){
          $dropdown.find(".dropdown-menu").append(
            $("<li></li>").append(aTag)
          )
        });
        $(element).html($dropdown);
      });

      that.find("tr > td:not(.tableify-actions, .select-cell)").click(function(){
        var button = $(this).parent().find(".tableify-default-action");
        if (!button.length) return;

        if (button.data("remote") || button.data("modal")) {
          button.trigger("click");
        } else {
          Turbolinks.visit(button.attr("href"));
        }
        loading.show();
      });
    }

    /*
     * Get selected rows
     */
    function getSelectedRows() {
      var rows = [];
      that.find("tbody > tr > td:first-child > input[type=checkbox]:checked").each(function(i, checkbox){
        rows.push(parseInt(checkbox.value));
      });
      return rows;
    }

    /*
     * Initialize plugin
     */
    if (options == undefined || options instanceof Object) {
      if ( ! alreadyRendered) {
        // Initializer method
        initialize();

        // Render checkboxes
        if (settings.checkable) {
          renderCheckable();
        }
        // Hide columns
        renderVisible();
        dataSortable();
        tableActions();

        // Show tableify
        $("[data-toggle=tableify] tbody, [data-toggle=tableify] tfoot").show();
      }

    } else if (options === "getSelectedRows") {
      return getSelectedRows();

    } else {
      throw new ReferenceError('tableify "'+options+'" is not defined');
    }

  };

})(jQuery, window);
