$ ->
  userId = $('#current-user-id').text()
  console.log(userId)
  if userId == '-1'
    $('#header').css('height', '60px')
    $('body').css('padding-top', '60px')
    $('#sidebar').css('top', '60px')
    $('#sidebar').css('padding-bottom', '60px')