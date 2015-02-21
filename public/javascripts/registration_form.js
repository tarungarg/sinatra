$("document").ready(function(){
	// send json api as a request
	  $('form#signup_form').submit(function(e) {
	      e.preventDefault();
	      var valuesToSubmit = $(this).serialize();
	      var isvalidate=$("#signup_form").valid();
	      if (isvalidate) {
		      $.ajax({
		          type: "POST",
		          url: $(this).attr('action'), //sumbits it to the given url of the form
		          data: valuesToSubmit,
		          dataType: "JSON"
		      }).done(function(data){
		      	window.location.href = '/products'
		      }).fail(function(error){
		      	var html = "<ul>"
				jQuery.each( error.responseJSON.errors, function( index, value ) {
				  html+="<li>"+value+"</li>"
				});
				html+= "</ul>"
				$("#server-signup_errors").html(html);
		      });
		    }
	  });

	  $('form#signin_form').submit(function(e) {
	      e.preventDefault();
	      var valuesToSubmit = $(this).serialize();
	      var isSignInvalid=$("#signin_form").valid();
		  if (isSignInvalid) {
		      $.ajax({
		          type: "POST",
		          url: $(this).attr('action'), //sumbits it to the given url of the form
		          data: valuesToSubmit,
		          dataType: "JSON"
		      }).done(function(data){
		      	window.location.href = '/products'
		      }).fail(function(error){
				$("#server-signin-errors").html(error.responseJSON.error);
		      });
		    }
	  });

});