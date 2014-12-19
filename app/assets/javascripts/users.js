$(document).on('ready page:load', function () {
  $('a.fancybox').fancybox({
  	padding: 0
  });
  // $('.follow-link').click(function(e) {
  // 	e.stopImmediatePropagation();
  // 	e.preventDefault();
  // 	that = this;
  // 	$.ajax({
  // 		url: "follow_user",
  // 		dataType: "script",
  // 		success: function(data) { 
  // 			if (data === "true")
  // 			$(that).html("Unfollow")
  // 		}
  // 	});
  // });
});

