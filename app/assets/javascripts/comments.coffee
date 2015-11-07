commentBodyCounterError = false

# Document on ready
$ ->
  # Tracks the number of characters in an input field for the user
  if $('#comment-body-count').length
    commentBody = $('#comment_body')
    commentBodyCount = $('#comment-body-count')

    commentBodyCount.html commentBody.val().length
    commentBody.keyup ->
      charCount = commentBody.val().length
      commentBodyCount.html charCount
      if charCount > 1000
        $('#comment-body-counter').addClass 'counter-error'
        commentBodyCounterError = true
      else if commentBodyCounterError
        $('#comment-body-counter').removeClass 'counter-error'
        commentBodyCounterError = false
