var didScroll;
var lastScrollTop = 0;
var minimumScrollThreshold = 5;
var navbarHeight = $('header').outerHeight();

// Sets a boolean when the user scrolls
$(window).scroll(function(event){
  didScroll = true;
});

// Checks if the user has scrolled every 250ms
setInterval(function() {
  if (didScroll) {
    hasScrolled();
    didScroll = false;
  }
}, 250);

// Hides the header on scroll down, shows it on scroll up
function hasScrolled() {
  var scrollTop = $(this).scrollTop();

  // Make sure they scroll more than the threshold
  if(Math.abs(lastScrollTop - scrollTop) <= minimumScrollThreshold)
    return;

  // If they scrolled down and are past the navbar, add class .nav-up.
  if (scrollTop > lastScrollTop && scrollTop > navbarHeight + minimumScrollThreshold) {
    console.log("up");
    $('header').removeClass('nav-down').addClass('nav-up');
  } else {
    console.log("down");
    if(scrollTop + $(window).height() < $(document).height())
      $('header').removeClass('nav-up').addClass('nav-down');
  }

  lastScrollTop = scrollTop;
}
