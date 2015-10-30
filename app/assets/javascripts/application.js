// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$('document').ready(function() {

  if (window.location.pathname.indexOf('search') > -1) {
    $('#search-container').removeClass('search-container-transition');
    $('#search-box').focus();
  }

  $('#search-box').keyup(function(event) {
    // Clicks the search button when the user presses enter in the search box
    if (event.keyCode == 13) {
      $('#search-btn').click();
    }
  });

  $('#search-btn').click(function() {
    // Uses user input as search query
    var searchText = document.getElementById('search-box').value;
    window.location.href = '/search?q=' + encodeURIComponent(searchText);
  });
});
