$(document).ready(function() {
	$(".about-scroll").click(function() {
    $('html, body').animate({
      scrollTop: $(".about-us").offset().top
    }, 1000);
  });
  $(".team-scroll").click(function() {
    $('html, body').animate({
      scrollTop: $(".our-team").offset().top
    }, 1000);
  });
  $(".login-scroll").click(function() {
    $('html, body').animate({
      scrollTop: $(".login").offset().top
    }, 1000);
  });
});