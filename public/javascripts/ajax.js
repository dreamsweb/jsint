$(document).ready(function() {

  function ajaxSend(form) {
    $.ajax({
      url: "/",
      type: 'POST',
      data: form.serialize(),
      success: function(response) {
       $('#msg').html(response).slideDown();
      },
      error: function(request, errorType, errorMessage) {
       $("#msg").html('<p style="color: red;">' + errorMessage + '</p>');
      },
      beforeSend: function() {
       $('.loader').show();
      },
      complete: function() {
       $('.loader').hide();
      }
    });

    // $('.loader').show();
    // $.post("/", form.serialize(), function(response) {
    //   $('#msg').html(response).slideDown();
    // }).always(function() {
    //   $('.loader').hide();
    // });
  }

  // basic ajax form submit
  $('form').on('submit', function(e) {
    e.preventDefault();
    var form = $(this);
    ajaxSend(form);
  });

  // popover form submit
  $('.popover').on('click', function() {
    $("#dialog-form").dialog("open");
  });

  $("#dialog-form").dialog({
    autoOpen: false,
    height: 390,
    width: 300,
    modal: true,
    buttons: {
      Send: function() {
        var form = $(this).find('form');
        ajaxSend(form);
        $(this).dialog("close");
      },
      Cancel: function() {
        $(this).dialog("close");
      }
    }
  });

});