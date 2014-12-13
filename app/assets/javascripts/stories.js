$(document).on('ready page:load', function () {
  $('a.fancybox').fancybox({
  	padding: 0
  });
  $('search-form').submit(function(event) {
  	event.preventDefault();
  	var searchValue = $('#search').val();

  	$.getScript('/stories?search=' + searchValue);
  });
});

// $(document).on('ready page:load', function() {
// 	$('#search-form').submit(function(event) {
// 	  event.preventDefault();
// 	  var searchValue = $('#search').val();

// 	 $.getScript('/stories?search=' + searchValue);
// 	});
// });