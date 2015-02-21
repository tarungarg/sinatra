// all code is to check validaiton form client side

var requiredRule = {
  required: true
}

var requiredLengthRule = {
  required: true,
  minlength: 6,
  maxlength: 10
};

var requiredStringRule = {
  required: true,
  minlength: 1,
  maxlength: 25
};

var requiredTextRule = {
  required: true,
  minlength: 1,
  maxlength: 255
};

var requiredNumberRule = {
  required: true,
  minlength: 1,
  maxlength: 255,
  number: true
};

var requiredEmailRule = {
  required: true,
  email: true,
  minlength: 3,
  maxlength: 255
};

var requiredPasswordRule = {
  equalTo: "#user_password"
};

$('#signup_form').validate({
  rules: { 
   "user[firstname]": requiredStringRule,
   "user[lastname]": requiredStringRule,
   "user[email]": requiredEmailRule,
   "user[password]": requiredLengthRule,
   "user[password_confirmation]": requiredPasswordRule
  },
  errorElement: "div",
  wrapper: "div", 
  highlight: function (element, errorClass, validClass) {
    var elem = $(element);
    elem.addClass('error-input');
  },
  errorPlacement: function(error,element) {
    offset = element.offset();
    error.insertBefore(element)
    error.addClass('message');  // add a class to the wrapper
    error.css('position', 'absolute');
    error.css('left', offset.left + element.outerWidth());
    error.css('top', offset.top);
    error.css('color','red');
    var elem = $(element);
    elem.addClass('error-input');  
  },
  unhighlight: function (element, errorClass, validClass) {
    var elem = $(element);
    elem.removeClass('error-input');
  }
});

$('#signin_form').validate({
  rules: { 
   "user[email]": requiredEmailRule,
   "user[password]": requiredLengthRule
  },
  errorElement: "div",
  wrapper: "div", 
  highlight: function (element, errorClass, validClass) {
    var elem = $(element);
    elem.addClass('error-input');
  },
  errorPlacement: function(error,element) {
    offset = element.offset();
    error.insertBefore(element)
    error.addClass('message');  // add a class to the wrapper
    error.css('position', 'absolute');
    error.css('left', offset.left + element.outerWidth());
    error.css('top', offset.top);
    error.css('color','red');
    var elem = $(element);
    elem.addClass('error-input');  
  },
  unhighlight: function (element, errorClass, validClass) {
    var elem = $(element);
    elem.removeClass('error-input');
  }
});

$('#new_product_form').validate({
  rules: { 
   "product[name]": requiredStringRule,
   "product[price]": requiredNumberRule,
   "product[description]": requiredTextRule
  },
  errorElement: "div",
  wrapper: "div", 
  highlight: function (element, errorClass, validClass) {
    var elem = $(element);
    elem.addClass('error-input');
  },
  errorPlacement: function(error,element) {
    offset = element.offset();
    error.insertBefore(element)
    error.addClass('message');  // add a class to the wrapper
    error.css('position', 'absolute');
    error.css('left', offset.left + element.outerWidth());
    error.css('top', offset.top);
    error.css('color','red');
    var elem = $(element);
    elem.addClass('error-input');  
  },
  unhighlight: function (element, errorClass, validClass) {
    var elem = $(element);
    elem.removeClass('error-input');
  }
});

$('#update_product_form').validate({
  rules: { 
   "product[name]": requiredStringRule,
   "product[price]": requiredNumberRule,
   "product[description]": requiredTextRule
  },
  errorElement: "div",
  wrapper: "div", 
  highlight: function (element, errorClass, validClass) {
    var elem = $(element);
    elem.addClass('error-input');
  },
  errorPlacement: function(error,element) {
    offset = element.offset();
    error.insertBefore(element)
    error.addClass('message');  // add a class to the wrapper
    error.css('position', 'absolute');
    error.css('left', offset.left + element.outerWidth());
    error.css('top', offset.top);
    error.css('color','red');
    var elem = $(element);
    elem.addClass('error-input');  
  },
  unhighlight: function (element, errorClass, validClass) {
    var elem = $(element);
    elem.removeClass('error-input');
  }
});
