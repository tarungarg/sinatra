$("document").ready(function(){
	var isvalidate=$("#myform").valid();
	if (isvalidate) {
	  $('form#signup_form').submit(function(e) {
	      e.preventDefault();
	      var valuesToSubmit = $(this).serialize();
	      $.ajax({
	          type: "POST",
	          url: $(this).attr('action'), //sumbits it to the given url of the form
	          data: valuesToSubmit,
	          dataType: "JSON"
	      }).success(function(json){
	          //act on result.
	      });
	      return false; // prevents normal behaviour
	  });
	}
});