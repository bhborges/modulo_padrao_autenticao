// Custom Loading
// -----------------------------------

/**
 * Classe Message
 *
 * Exibe notificações na tela
 */
 function Message() {

  var timeMessage = null;

  this.createElement = function() {
    if ($("#custom-loading").length == 0)
      $("body").append('<div id="custom-loading"></div>');
  }

  this.show = function(msg, w, autoHide, millisec){
    this.createElement();
    w = w == undefined ? 500 : w;
    $('#custom-loading').css({
      width : w,
      marginLeft : ((w / 2) - w)
    });

    $('#custom-loading').html(msg).show(0, function(){
      clearTimeout(timeMessage);
      if (autoHide == undefined || autoHide == true){
        timeMessage = setTimeout(function(){
          $('#custom-loading').fadeOut('fast', function(){
            $('#custom-loading').html('');
          });
        }, millisec == undefined ? 10000 : millisec);
      }
    });
  };

  this.hide = function(fadeOut){
    this.createElement();
    if (fadeOut == undefined || fadeOut){
      $('#custom-loading').fadeOut('fast', function(){
        $('#custom-loading').html('');
      });
    }else if ( ! fadeOut){
      $('#custom-loading').hide().html('');
    }
  };

}

function Loading() {
  this.show = function(msg, w){
    message.show(msg != undefined ? msg : 'Carregando...', w != undefined ? w : 100, false);
  };

  this.hide = function(fadeOut){
    message.hide(fadeOut);
  };
}

var message = new Message();
var loading = new Loading();
