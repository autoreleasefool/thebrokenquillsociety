# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

userNameCounterError = false;
userAboutCounterError = false;

$ ->
  # Tracks the number of characters in an input field for the user
  if $('#user-name-count').length
    userName = $('#user_name')
    userNameCount = $('user-name-count')

    userNameCount.html userName.val().length
    userName.keyup ->
      charCount = userName.val().length
      userNameCount.html charCount
      if charCount > 50
        $('#user-name-counter').addClass 'counter-error'
        userNameCounterError = true
      else if userNameCounterError
        $('#user-name-counter').removeClass 'counter-error'
        userNameCounterError = false;

  # Tracks the number of characters in an input field for the user
  if $('#user-about-count').length
    userAbout = $('#user_about')
    userAboutCount = $('#user-about-count')

    userAboutCount.html userAbout.val().length
    userAbout.keyup ->
      charCount = userAbout.val().length
      userAboutCount.html charCount
      if charCount > 1000
        $('#user-about-counter').addClass 'counter-error'
        userAboutCounterError = true
      else if userAboutCounterError
        $('#user-about-counter').removeClass 'counter-error'
        userAboutCounterError = false
