// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery.override
//= require jquery.livequery.min
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-datepicker.min
//= require bootstrap-datepicker.pt-BR.min
//= require rails-ujs
//= require maskedinput.min
//= require maskmoney.min
//= require jquery.chosen
//= require activestorage
//= require turbolinks
//= require tableify
//= require loading
//= require_tree ./layout

(function(window, document, $, undefined){

  var ready = function(){
    $("form[data-disabled=true] input").livequery(function(){ $(this).attr("disabled", true); });
    $("form[data-disabled=true] textarea").livequery(function(){ $(this).attr("disabled", true); });
    $("form[data-disabled=true] select").livequery(function(){ $(this).attr("disabled", true); });

    $("[data-toggle=\"tooltip\"]").livequery(function(){ $(this).tooltip(); });
    $("[data-toggle=\"tableify\"]").livequery(function(){ $(this).tableify(); });
    $(".app-loading > div").hide();

    $("input.postal_code, input.cep").livequery(function(){ $(this).mask("99999-999"); });
    $("input.cpf").livequery(function(){ $(this).mask("999.999.999-99"); });
    $("input.pis").livequery(function(){ $(this).mask("999.99999.99-9"); });
    $("input.date").livequery(function(){ $(this).mask("99/99/9999"); });
    $("input.datetime").livequery(function(){ $(this).mask("99/99/9999 99:99"); });
    $("input.date_m-y").livequery(function(){ $(this).mask("99/9999"); });
    $("input.cnpj").livequery(function(){ $(this).mask("99.999.999/9999-99"); });
    $("input.issn").livequery(function(){ $(this).mask("9999-9999"); });
    $("input.time").livequery(function(){ $(this).mask("99:99"); });

    $(".mask-money").livequery(function(){ $(this).maskMoney({ thousands: '.', decimal: ',', allowZero: true }).maskMoney("mask"); });
    $(".mask-weight").livequery(function(){ $(this).maskMoney({ thousands: '', decimal: '.', precision: 2, allowZero: true }).maskMoney("mask"); });
    $(".mask-number").livequery(function(){ $(this).maskMoney({ thousands: '.', decimal: '.', precision: 3, allowZero: true }).maskMoney("mask"); });
    $(".mask-decimal").livequery(function(){ $(this).maskMoney({ thousands: '.', decimal: '.', precision: 2, allowZero: true }).maskMoney("mask"); });

    $(".datepicker").datepicker({
      format: "dd/mm/yyyy",
      language: "pt-BR",
      todayHighlight: true
    }).on("changeDate", function(e) {
      $(this).datepicker("hide");
    });

    $("select.chosen-select").livequery(function(){
      $(this).chosen({
        no_results_text: "Nenhum resultado sobre",
        placeholder_text_single: " ",
        allow_single_deselect: true,
        search_contains: true,
        width: "100%"
      });
    });

    $(".input-group > .has-error > span").each(function(i, element){
      var $parent = $(element).closest(".input-group");
      var $inputs = $parent.find(".has-error > *");
      var $inputPrepend = $parent.find(".input-group-prepend");
      var $inputAppend = $parent.find(".input-group-append");

      if ($inputPrepend.length > 0) {
        $inputPrepend.after($inputs);
      }
      if ($inputAppend.length > 0) {
        $inputAppend.before($inputs);
      }
      $parent.find(".has-error").remove();
      $parent.parent().addClass("has-error");
      $parent.after($(element));
    });

    var formatMoney = function(c, d, t) {
      var n = parseFloat(this),
          c = isNaN(c = Math.abs(c)) ? 2 : c,
          d = d == undefined ? "." : d,
          t = t == undefined ? "," : t,
          s = n < 0 ? "-" : "",
          i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
          j = (j = i.length) > 3 ? j % 3 : 0;

      return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
    };

    String.prototype.formatMoney = formatMoney;
    Number.prototype.formatMoney = formatMoney;
  }

  $(document).on("turbolinks:load", ready);

})(window, document, window.jQuery);
