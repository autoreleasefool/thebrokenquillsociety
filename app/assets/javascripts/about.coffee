aboutTitleCounterError = false;
aboutBodyCounterError = false;
aboutLinkTitleCounterError = false;

# Adds bold tags around a selection in the about body's input
@boldAbout = ->
  adjustTextAreaFormatting($('textarea#about_body'), 'bold')

# Adds italics tags around a selection in the about body's input
@italicizeAbout = ->
  adjustTextAreaFormatting($('textarea#about_body'), 'italic')

# On document ready
$ ->

  # Tracks the number of characters in an input field for the user
  if $('#about-title-count').length
    aboutTitle = $('#about_title')
    aboutTitleCount = $('#about-title-count')

    aboutTitleCount.html aboutTitle.val().length
    aboutTitle.keyup ->
      charCount = aboutTitle.val().length
      aboutTitleCount.html charCount
      if charCount > 255
        $('#about-title-counter').addClass 'counter-error'
        aboutTitleCounterError = true
      else if aboutTitleCounterError
        $('#about-title-counter').removeClass 'counter-error'
        aboutTitleCounterError = false

  # Tracks the number of characters in an input field for the user
  if $('#about-link-title-count').length
    aboutLinkTitle = $('#about_link_title')
    aboutLinkTitleCount = $('#about-link-title-count')

    aboutLinkTitleCount.html aboutLinkTitle.val().length
    aboutLinkTitle.keyup ->
      charCount = aboutLinkTitle.val().length
      aboutLinkTitleCount.html charCount
      if charCount > 255
        $('#about-link-title-counter').addClass 'counter-error'
        aboutLinkTitleCounterError = true
      else if aboutLinkTitleCounterError
        $('#about-link-title-counter').removeClass 'counter-error'
        aboutLinkTitleCounterError = false

  # Tracks the number of characters in an input field for the user
  if $('#about-body-count').length
    aboutBody = $('#about_body')
    aboutBodyCount = $('#about-body-count')

    aboutBodyCount.html aboutBody.val().length
    aboutBody.keyup ->
      charCount = aboutBody.val().length
      aboutBodyCount.html charCount
      if charCount > 1000
        $('#about-body-counter').addClass 'counter-error'
        aboutBodyCounterError = true
      else if aboutBodyCounterError
        $('#about-body-counter').removeClass 'counter-error'
        aboutBodyCounterError = false
