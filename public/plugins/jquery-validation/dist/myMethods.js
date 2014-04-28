jQuery.validator.addMethod("myUsername", function(value, element) {
	var result;
	$.ajax({
		url: "/users/sign_up_check_username",
		type: "get",
		dataType: "json",
		data: {username: value},
        success: function(data) {
            result = data.status
        },
        error: function(data) {
            console.log(data);
        },
        async: false
    });
    return !result;
}, "Account already exists");

jQuery.validator.addMethod("myImgVerification", function(value, element) {
	var verification='vsdee';
	return value.toLowerCase() == verification.toLowerCase();
}, "image verification error");

jQuery.validator.addMethod("myEmail", function(value, element) {
	var result;
	$.ajax({
		url: "/users/sign_up_check_email",
		type: "get",
		dataType: "json",
		data: {email: value},
        success: function(data) {
            result = data.status
        },
        error: function(data) {
            console.log(data);
        },
        async: false
    });
    return !result;
}, "Email already exists");
