var requiredRule = {
  required: true,
};

var requiredLengthRule = {
  required: true,
  minlength: 2,
  maxlength: 255,
};

var requiredEmailRule = {
  required: true,
  email: true,
  minlength: 2,
  maxlength: 255,
};

$('#signup_form').validate({
  rules: { 
   "user[email]": requiredEmailRule,
   "user[password]": requiredLengthRule,
   "user[password_confirmation]": requiredLengthRule
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
