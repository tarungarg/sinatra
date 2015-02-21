$("document").ready(function(){
	// send json api as a request
  $('form#new_product_form').submit(function(e) {
      e.preventDefault();
      var valuesToSubmit = $(this).serialize();
      var isvalidate=$("#new_product_form").valid();
      if (isvalidate) {
	      $.ajax({
	          type: "POST",
	          url: $(this).attr('action'), //sumbits it to the given url of the form
	          data: valuesToSubmit,
	          dataType: "JSON"
	      }).done(function(data){
	      	window.location.href = '/products?message="Product Created"'
	      }).fail(function(error){
	      	var html = "<ul>"
			jQuery.each( error.responseJSON.errors, function( index, value ) {
			  html+="<li>"+value+"</li>"
			});
			html+= "</ul>"
			$("#server-product-errors").html(html);
	      });
	    }
  });

	$('form#update_product_form').submit(function(e) {
	  e.preventDefault();
	  var valuesToSubmit = $(this).serialize();
	  var isvalidate=$("#update_product_form").valid();
	  if (isvalidate) {
	      $.ajax({
	          type: "PUT",
	          url: $(this).attr('action'), //sumbits it to the given url of the form
	          data: valuesToSubmit,
	          dataType: "JSON"
	      }).done(function(data){
	      	window.location.href = "/products?message='Product Updated'"
	      		      }).fail(function(error){
	      	var html = "<ul>"
			jQuery.each( error.responseJSON.errors, function( index, value ) {
			  html+="<li>"+value+"</li>"
			});
			html+= "</ul>"
			$("#server-product-errors").html(html);
	      });
	    }
	});

});