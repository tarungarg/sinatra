$("document").ready(function(){
  $("#order_items").hide();
	// send json api as a request
  $('form#new_product_form').submit(function(e) {
      e.preventDefault();
      var valuesToSubmit = $(this).serialize();
      var isvalidate=$("#new_product_form").valid();
      if (isvalidate) {
	      $.ajax({
	          type: "POST",
	          url: $(this).attr('action'),
	          data: valuesToSubmit,
	          dataType: "JSON"
	      }).done(function(data){
	      	window.location.href = "/products"
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
	          url: $(this).attr('action'),
	          data: valuesToSubmit,
	          dataType: "JSON"
	      }).done(function(data){
	      	window.location.href = "/products"
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

	$(".add_to_cart").click(function(e){
		var id = $(e.target).attr("data-attr")
		$.ajax({
	          type: "GET",
	          url: "/add_to_cart",
	          data: {product_id: id},
	          dataType: "JSON"
	      }).done(function(data){
	      	window.location.href = "/order_list"
	      }).fail(function(error){
			$("#server-cart-errors").html(error.responseJSON.error);
		  });
	});

	// $("#order_items").click(function(e){
	// 	e.preventDefault();
	// 	var tr_arr = $(e.currentTarget.parentElement).find("table tr")
	// 	var val_arr = []
	// 	jQuery.each(tr_arr, function( index, value ) {
	// 		if(index != 0){
	// 	  		var val = $(value).attr("data-attr");
	// 	  		val_arr.push(val);
	// 	  	}
	// 	});
	// 	$.ajax({
	//           type: "PUT",
	//           url: "/orders_items",
	//           data: {ids: val_arr},
	//           dataType: "JSON"
	//       }).done(function(data){
	//       	alert(3)
	//       }).fail(function(error){
	// 		$("#server-cart-errors").html(error.responseJSON.error);
	// 	  });
	// });

});