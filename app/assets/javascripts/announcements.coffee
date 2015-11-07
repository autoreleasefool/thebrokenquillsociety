announcementTitleCounterError = false;
announcementBodyCounterError = false;

# On document ready
$ ->

  # Tracks the number of characters in an input field for the user
  if $('#announcement-title-count').length
    announcementTitle = $('#announcement_title')
    announcementTitleCount = $('#announcement-title-count')

    announcementTitleCount.html announcementTitle.val().length
    announcementTitle.keyup ->
      charCount = announcementTitle.val().length
      announcementTitleCount.html charCount
      if charCount > 255
        $('#announcement-title-counter').addClass 'counter-error'
        announcementTitleCounterError = true
      else if announcementTitleCounterError
        $('#announcement-title-counter').removeClass 'counter-error'
        announcementTitleCounterError = false

  # Tracks the number of characters in an input field for the user
  if $('#announcement-body-count').length
    announcementBody = $('#announcement_body')
    announcementBodyCount = $('#announcement-body-count')

    announcementBodyCount.html announcementBody.val().length
    announcementBody.keyup ->
      charCount = announcementBody.val().length
      announcementBodyCount.html charCount
      if charCount > 255
        $('#announcement-body-counter').addClass 'counter-error'
        announcementBodyCounterError = true
      else if announcementBodyCounterError
        $('#announcement-body-counter').removeClass 'counter-error'
        announcementBodyCounterError = false
