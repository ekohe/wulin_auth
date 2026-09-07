var cache = {};
var lastXhr = null;
var searchUrl = "/search_positions";

function loginFormSubmission(form) {
  $.ajax({
    type: "POST",
    url: form.attr("action"),
    data: form.serializeArray(),
    dataType: "json",
    success: function (data) {
      handleLoginResponse(data);
    },
    error: function () {
      displayFlashNotice("An unexpected error occured. Please try again.");
      enableForm();
    }
  });
  disableForm();
  return false;
}

function disableForm() {
  $("input").attr("disabled", "disabled").css("opacity", 0.3);
  $("label").css("opacity", 0.3);
  $("#password-img").css("opacity", 0.3);
  $("#submit").hide();
  $("#preloader").show();
}

function enableForm() {
  $("input").removeAttr("disabled").css("opacity", 1.0);
  $("label").css("opacity", 1.0);
  $("#password-img").css("opacity", 1.0);
  $("input#email").focus();
  $("#submit").show();
  $("#preloader").hide();
}

function displayFlashNotice(message) {
  M.toast({ html: message, displayLength: 3000 });
}

function handleLoginResponse(response) {
  if (response.status === "wrong_credentials") {
    displayFlashNotice(response.message);
    enableForm();
    $("input#password").val("");
  } else if (response.status === "success") {
    $("input").remove();
    $("label").remove();
    displayFlashNotice(response.message);
    document.location = response.redirect_to;
  } else {
    displayFlashNotice("An unexpected error occured. Please try again.");
    enableForm();
  }
}

window.toast = function (message) {
  if (message) {
    M.toast({ html: message, displayLength: 3000 });
    if (message === "Please connect using Microsoft Office 365") {
      $("#microsoft_login").click();
    }
  }
};

window.initializeLoginForm = function () {
  $("input#email").focus();
  $("#wulin_auth_form form").submit(function () {
    return loginFormSubmission($(this));
  });
  return true;
};
