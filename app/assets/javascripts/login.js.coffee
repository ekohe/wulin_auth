loginFormSubmission = (form) ->
  ajaxOptions =
    type: 'POST'
    url: form.attr('action')
    data: form.serializeArray()
    dataType: 'json'
    success: (data) ->
      handleLoginResponse data
    failure: (data) ->
      displayFlashNotice("An unexpected error occured. Please try again.")
      enableForm()

  $.ajax ajaxOptions
  disableForm()
  false

disableForm = ->
  $("input").attr('disabled', 'disabled').css('opacity', 0.3)
  $("label").css('opacity', 0.3)
  $("#password-img").css('opacity', 0.3)
  $("#submit").hide()
  $("#preloader").show()

enableForm = ->
  $("input").removeAttr('disabled').css('opacity', 1.0)
  $("label").css('opacity', 1.0)
  $("#password-img").css('opacity', 1.0)
  $("input#email").focus()
  $("#submit").show()
  $("#preloader").hide()

displayFlashNotice = (message) ->
  M.toast({html: message, displayLength: 3000})

handleLoginResponse = (response) ->
  if response.status == "wrong_credentials"
    displayFlashNotice response.message
    #$("#login_panel form").effect('bounce', {direction: 'right', mode: 'effect', times: 3, distance: 10}, 'fast')
    enableForm()
    # Empty password field
    $("input#password").val('')
  else
    if response.status=="success"
      $("input").remove()
      $("label").remove()
      displayFlashNotice(response.message)
      document.location = response.redirect_to
    else
      displayFlashNotice("An unexpected error occured. Please try again.")
      enableForm()

window.toast = (message) ->
  if message
    M.toast({html: message, displayLength: 3000});

window.initializeLoginForm = () ->
  # Initial focus on the email field
  $("input#email").focus()
  # Ajaxify the form
  $("form").submit(-> loginFormSubmission($(this)))
  true
