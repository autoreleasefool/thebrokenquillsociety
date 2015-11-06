# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

workTitleCounterError = false

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
