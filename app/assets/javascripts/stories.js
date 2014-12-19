$(document).on('ready page:load', function () {
  $('.fancybox').fancybox({
    helpers: {
      overlay: {
        locked: false
      }
    }
  });
  $('search-form').submit(function(event) {
  	event.preventDefault();
  	var searchValue = $('#search').val();

  	$.getScript('/stories?search=' + searchValue);
  });
  $('button').click(function() {
    $("#likers").toggle("medium");
  });
   if ($('.pagination').length) {
    $(window).scroll(function() {
      var url = $('.pagination span.next').children().attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').text("Fetching more stories...");
        return $.getScript(url);
      }
    });
  };
  $('.toggle-search').click(function() {
    $("#search").toggle("medium");
  });
});







// $(document).on('ready page:load', function() {
//   if ($('.pagination').length) {
//     $(window).scroll(function() {
//       var url = $('.pagination span.next').children().attr('href');
//       if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
//         $('.pagination').text("Fetching more stories...");
//         return $.getScript(url);
//       }
//     });
//   }
// });