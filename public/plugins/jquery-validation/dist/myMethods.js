jQuery.validator.addMethod("myUsername", function(value, element) {
    var result;
	$.ajax({
		url: "/users/check_username",
		type: "get",
		dataType: "json",
		data: {username: value},
        success: function(data) {
            result = data.status;
        },
        error: function(data) {
        },
        async: false
    });
    return !result;
}, "This field has already existed");

jQuery.validator.addMethod("myEmail", function(value, element) {
	var result;
	$.ajax({
		url: "/users/check_email",
		type: "get",
		dataType: "json",
		data: {email: value},
        success: function(data) {
            result = data.status;
        },
        error: function(data) {
        },
        async: false
    });
    return !result;
}, "This field has already existed");

jQuery.validator.addMethod("myPasswordCheck", function(value, element) {
    var result;
    $.ajax({
        url: "/users/profiles/check_password",
        type: "post",
        dataType: "json",
        data: {password: value},
        success: function(data) {
            result = data.status;
        },
        error: function(data) {
        },
        async: false
    });
    return result;
}, "This field has wrong value");

jQuery.validator.addMethod("myPasswordAllow", function(value, element) {
    return value.match(/^([a-zA-Z0-9]*)$/);
}, "This field has illegal characters");

jQuery.validator.addMethod("myPasswordMatch", function(value, element) {
    var result = false
    if( value == $("input[name='user[password]']").val() ) result = true;
    return result;
}, "This field has isInconsistent data");


// scott comment
// jQuery.validator.addMethod("myPassword", function(value, element) {
//     var result;
//     $.ajax({
//         url: "/users/profiles/ajax_verify_password",
//         type: "get",
//         dataType: "json",
//         data: {current_password: value},
//         success: function(data) {
//             result = data.status;
//             console.log("zzz" + result);
//         },
//         error: function(data) {
//             console.log("aaa" + result);
//         },
//         async: false
//     });
//     //console.log("email: " + result);
//     return !result;
// }, "This password is not current");


