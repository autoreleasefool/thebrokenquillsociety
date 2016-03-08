workTitleCounterError = false
didScroll = false
lastScrollTop = 0
minimumScrollThreshold = 5

# // Returns true if the specified element is visible on the screen
# // Retrieved from: http://stackoverflow.com/a/488073
isScrolledIntoView = (elem) ->
  doc = $(window)

  docViewTop = doc.scrollTop()
  docViewBottom = docViewTop + doc.height()

  elemTop = elem.offset().top
  elemBottom = elemTop + elem.height()

  ((elemBottom >= docViewTop) && (elemTop <= docViewBottom))

# Adds bold tags around a selection in the work body's input
@boldWork = ->
  adjustTextAreaFormatting($('textarea#work_body'), 'bold')

# Adds italics tags around a selection in the work body's input
@italicizeWork = ->
  adjustTextAreaFormatting($('textarea#work_body'), 'italic')

# On document ready
$ ->

  # Tracks the number of characters in an input field for the user
  if $('#work-title-count').length
    workTitle = $('#work_title')
    workTitleCount = $('#work-title-count')

    workTitleCount.html workTitle.val().length
    workTitle.keyup ->
      charCount = workTitle.val().length
      workTitleCount.html charCount
      if charCount > 255
        $('#work-title-counter').addClass 'counter-error'
        workTitleCounterError = true
      else if workTitleCounterError
        $('#work-title-counter').removeClass 'counter-error'
        workTitleCounterError = false

  # Hides a button when the comments are in view
  comments = $('#comments')
  gotoComments = $('#goto-comments')
  if comments.length and gotoComments.length

    # Method to run when the user has scrolled
    hasScrolled = ->
      scrollTop = $(window).scrollTop()
      # Make sure they scroll more than the threshold
      if Math.abs(lastScrollTop - scrollTop) <= minimumScrollThreshold
        return
      # If they scrolled down,
      if isScrolledIntoView comments
        gotoComments.css 'opacity', 0
        gotoComments.css 'cursor', 'default'
      else
        gotoComments.css 'opacity', 1
        gotoComments.css 'cursor', 'pointer'
      lastScrollTop = scrollTop
      return

    # Sets boolean when user scrolls up or down
    $(window).on 'scroll':->
      didScroll = true

    # Checks status of user scrolling on an interval
    setInterval (->
      if didScroll
        hasScrolled()
        didScroll = false
      return
    ), 250
