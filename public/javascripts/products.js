$("document").ready(function(){
  $("#order_items").hide();
    // send json api as a request
  $('form#new_product_form').submit(function(e) {
    e.preventDefault();
    var valuesToSubmit = $(this).serialize();
    var isvalidate=$("#new_product_form").valid(); // check if form is valid
    if (isvalidate) {
      $.ajax({
        type: "POST",
        url: $(this).attr('action'),
        data: valuesToSubmit,
        dataType: "JSON"
      }).done(function(data){
        window.location.href = "/products"
      }).fail(function(error){
        // show errors
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

  // add to cart code
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

  $('form#braintree-payment-form').submit(function(e) {
    e.preventDefault();
    var valuesToSubmit = $(this).serialize();
    var isvalidate=$("#braintree-payment-form").valid(); // check if form is valid
    if (isvalidate) {
      $.ajax({
        type: "POST",
        url: $(this).attr('action'),
        data: valuesToSubmit,
        dataType: "JSON"
      }).done(function(data){
        $("#tracation-response").html("<h1><b>"+data.message+"</b></h1>")
        setTimeout(function () {
          window.location.href = "/order_history"
        }, 5000);
      }).fail(function(error){
        $("#tracation-response").html(error.responseJSON.errors)
      });
    }
  });  

});