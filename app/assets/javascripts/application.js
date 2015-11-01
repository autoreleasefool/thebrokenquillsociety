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
//= require jquery.turbolinks
//= require_tree .

$('document').ready(function() {
  if (window.location.pathname.indexOf('search') > -1) {
    // TODO: decide whether or not to remove transition on searching page
    // If not removed, every time search page is loaded, the search box fades to white with auto focus
    //$('#search-container').removeClass('search-container-transition');
    $('#search-box').focus();
  }

  $('#nav').hover(
    function() {
      // Set left of search container to 0, to show profile icons
      var searchContainers = document.getElementsByClassName('search-container');
      for(i = 0; i < searchContainers.length; i++) {
        searchContainers[i].style.left = 0;
      }
    }, function() {
      // Set left of search container to normal, to hide profile icons
      var searchContainers = document.getElementsByClassName('search-container');
      for(i = 0; i < searchContainers.length; i++) {
        searchContainers[i].style.left = '168px';
      }
    });

  $('#search-box').keyup(
    function(event) {
      // Clicks the search button when the user presses enter in the search box
      if (event.keyCode == 13) {
        $('#btn-search').click();
      }
    });

  $('#btn-search').hover(
    function() {
      // When search button is hovered, the cursor is placed in the search box
      $('#search-box').focus();
    });

  $('#btn-search').click(
    function() {
      // Uses user input as search query
      var searchText = document.getElementById('search-box').value;
      window.location.href = '/search?q=' + encodeURIComponent(searchText);
    });
});
