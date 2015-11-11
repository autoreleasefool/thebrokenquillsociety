userNameCounterError = false;
userAboutCounterError = false;
userAdminDescCounterError = false;

# On document ready
$ ->

  # Tracks the number of characters in an input field for the user
  if $('#user-name-count').length
    userName = $('#user_name')
    userNameCount = $('#user-name-count')

    userNameCount.html userName.val().length
    userName.keyup ->
      charCount = userName.val().length
      userNameCount.html charCount
      if charCount > 32
        $('#user-name-counter').addClass 'counter-error'
        userNameCounterError = true
      else if userNameCounterError
        $('#user-name-counter').removeClass 'counter-error'
        userNameCounterError = false

  # Tracks the number of characters in an input field for the user
  if $('#user-admin-desc-count').length
    userAdminDesc = $('#user_admin_description')
    userAdminDescCount = $('#user-admin-desc-count')

    userAdminDescCount.html userAdminDesc.val().length
    userAdminDesc.keyup ->
      charCount = userAdminDesc.val().length
      userAdminDescCount.html charCount
      if charCount > 500
        $('#user-admin-desc-counter').addClass 'counter-error'
        userAdminDescCounterError = true
      else if userAdminDescCounterError
        $('#user-admin-desc-counter').removeClass 'counter-error'
        userAdminDescCounterError = false

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
