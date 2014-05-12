jQuery.validator.addMethod("myUsername", function(value, element) {
    var result;
	$.ajax({
		url: "/users/check_username",
		type: "get",
		dataType: "json",
		data: {username: value},
        success: function(data) {
            result = data.status
        },
        error: function(data) {
            //console.log(data);
        },
        async: false
    });
    return !result;
}, "帳號已經存在");

jQuery.validator.addMethod("myImgVerification", function(value, element) {
	var verification='vsdee';
	return value.toLowerCase() == verification.toLowerCase();
}, "驗證碼錯誤");

jQuery.validator.addMethod("myEmail", function(value, element) {
    //console.log(value);
    //console.log(element);
	var result;
	$.ajax({
		url: "/users/check_email",
		type: "get",
		dataType: "json",
		data: {email: value},
        success: function(data) {
            result = data.status
        },
        error: function(data) {
            //console.log(data);
        },
        async: false
    });
    //console.log("email: " + result);
    return !result;
}, "Email已經存在");


jQuery.validator.addMethod("myPasswordMatch", function(value, element) {
    var result = true;
    if( value == $("input[name='user[password]'").val() ) result = false;
    return !result;
}, "密碼與先前輸入的不一致");
