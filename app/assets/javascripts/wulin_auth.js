// jQuery should be available globally from the main application bundle
// No need to import jQuery setup files here as they're handled by the main bundle

function loginFormSubmission(form) {
  var ajaxOptions = {
    type: 'POST',
    url: form.attr('action'),
    data: form.serializeArray(),
    dataType: 'json',
    success: function(data) {
      handleLoginResponse(data);
    },
    failure: function(data) {
      displayFlashNotice("An unexpected error occured. Please try again.");
      enableForm();
    }
  };

  $.ajax(ajaxOptions);
  disableForm();
  return false;
}

function disableForm() {
  $("input").attr('disabled', 'disabled').css('opacity', 0.3);
  $("label").css('opacity', 0.3);
  $("#password-img").css('opacity', 0.3);
  $("#submit").hide();
  $("#preloader").show();
}

function enableForm() {
  $("input").removeAttr('disabled').css('opacity', 1.0);
  $("label").css('opacity', 1.0);
  $("#password-img").css('opacity', 1.0);
  $("input#email").focus();
  $("#submit").show();
  $("#preloader").hide();
}

function displayFlashNotice(message) {
  M.toast(message, 3000);
}

function handleLoginResponse(response) {
  if (response.status == "wrong_credentials") {
    displayFlashNotice(response.message);
    //$("#login_panel form").effect('bounce', {direction: 'right', mode: 'effect', times: 3, distance: 10}, 'fast')
    enableForm();
    // Empty password field
    $("input#password").val('');
  } else {
    if (response.status == "success") {
      $("input").remove();
      $("label").remove();
      displayFlashNotice(response.message);
      document.location = response.redirect_to;
    } else {
      displayFlashNotice("An unexpected error occured. Please try again.");
      enableForm();
    }
  }
}

window.toast = function(message) {
  if (message) {
    M.toast(message, 3000);
  }
};

window.initializeLoginForm = function() {
  // Initial focus on the email field
  $("input#email").focus();
  // Ajaxify the form
  $("form").submit(function() {
    return loginFormSubmission($(this));
  });
  return true;
};
