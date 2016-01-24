# On document ready
$ ->

  # When clicking on a row in the notification table, the link associated with it is opened
  $(".clickable-row").click ->
    window.document.location = $(this).data("url");
