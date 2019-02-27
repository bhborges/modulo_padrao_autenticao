$(function() {
  const modal_holder_selector = '#modal-holder';
  const modal_selector = '.modal';

  $(document).on('click', 'a[data-modal]', function() {
    const location = $(this).attr('href');
    loading.show();
    // Load modal dialog from server
    $.get(location, data => {
      loading.hide();
      $(modal_holder_selector).html(data).find(modal_selector).modal();
    });
    return false;
  });

  $(document).on('ajax:complete', 'form[data-modal]', function(event) {
    const xhr = event.detail[0];
    const url = xhr.getResponseHeader('Location');
    if (url) {
      // Redirect to url
      window.location = url;
    } else {
      // Hide loading
      loading.hide();
      // Remove old modal backdrop
      $('.modal-backdrop').remove();
      // Update modal content
      $(modal_holder_selector).html(xhr.responseText).find(modal_selector).modal();

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
    }
    return false;
  });
});
