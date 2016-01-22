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

workTitleCounterError = false;
userNameCounterError = false;
userAboutCounterError = false;

(function($) {
    $.fn.goTo = function() {
        $('html, body').animate({
            scrollTop: $(this).offset().top + 'px'
        }, 800);
        return this; // for chaining...
    }
})(jQuery);

// Adds formatting tags to a text area's input
adjustTextAreaFormatting = function(textArea, format) {
  // Determining the tags to be added
  if (format == 'bold') {
    startFormat = '<b>'
    endFormat = '</b>'
  } else if (format == 'italic') {
    startFormat = '<i>'
    endFormat = '</i>'
  }

  // Getting the location of the cursor/selected text in the textarea
  cursorStart = textArea.prop('selectionStart')
  cursorEnd = textArea.prop('selectionEnd')
  body = textArea.val()

  if (cursorStart == cursorEnd) {
    // If no text is selected, just add the tags next to each other
    textArea.val(body.substr(0, cursorStart) + startFormat + endFormat + body.substr(cursorStart))
  } else {
    // If text is selected, wrap the selection in the tags
    textArea.val(body.substr(0, cursorStart) + startFormat + body.substr(cursorStart, cursorEnd - cursorStart) + endFormat + body.substr(cursorEnd))
  }
}

$('document').ready(function() {
  if (window.location.pathname.indexOf('search') > -1) {
    // TODO: decide whether or not to remove transition on searching page
    // If not removed, every time search page is loaded, the search box fades to white with auto focus
    //$('#search-container').removeClass('search-container-transition');
    $('#search-box').focus();
  }

  if ($('#goto-comments').length) {
    $('#goto-comments').click(
      function() {
        $('#comments').goTo();
      }
    );
  }

  $('#nav').hover(
    function() {
      var search = document.getElementById('search-slider');
      search.style.left = 0;
    }, function() {
      var search = document.getElementById('search-slider');
      search.style.left = '211px';
    }
  );

  $('#search-box').keyup(
    function(event) {
      // Clicks the search button when the user presses enter in the search box
      if (event.keyCode == 13) {
        $('#btn-search').click();
      }
    }
  );

  $('#btn-search').hover(
    function() {
      // When search button is hovered, the cursor is placed in the search box
      $('#search-box').focus();
    }
  );

  $('#btn-search').click(
    function() {
      // Uses user input as search query
      var searchText = document.getElementById('search-box').value;
      window.location.href = '/search?q=' + encodeURIComponent(searchText);
    }
  );

  // Shows / hides the relevant nav hint on hover
  $('#profile-link').hover(
    function() {
      $('#profile-hint').addClass('nav-hint-visible');
    }, function() {
      $('#profile-hint').removeClass('nav-hint-visible');
    }
  );
  $('#inbox-svg').hover(
    function() {
      $('#inbox-hint').addClass('nav-hint-visible');
    }, function() {
      $('#inbox-hint').removeClass('nav-hint-visible');
    }
  );
  $('#inbox-badge').hover(
    function() {
      $('#inbox-hint').addClass('nav-hint-visible');
    }, function() {
      $('#inbox-hint').removeClass('nav-hint-visible');
    }
  );
  $('#work-svg').hover(
    function() {
      $('#work-hint').addClass('nav-hint-visible');
    }, function() {
      $('#work-hint').removeClass('nav-hint-visible');
    }
  );
  $('#fave-svg').hover(
    function() {
      $('#fave-hint').addClass('nav-hint-visible');
    }, function() {
      $('#fave-hint').removeClass('nav-hint-visible');
    }
  );
  $('#admin-profile-svg').hover(
    function() {
      $('#admin-profile-hint').addClass('nav-hint-visible');
    }, function() {
      $('#admin-profile-hint').removeClass('nav-hint-visible');
    }
  );
  $('#new-svg').hover(
    function() {
      $('#new-hint').addClass('nav-hint-visible');
    }, function() {
      $('#new-hint').removeClass('nav-hint-visible');
    }
  );
  $('#logout-svg').hover(
    function() {
      $('#logout-hint').addClass('nav-hint-visible');
    }, function() {
      $('#logout-hint').removeClass('nav-hint-visible');
    }
  );
});
