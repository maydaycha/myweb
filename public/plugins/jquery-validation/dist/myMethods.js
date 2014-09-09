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
    if( value == $(element).parents("form").find("input[name='user[password]']").val() ) result = true;
    return result;
}, "This field has isInconsistent data");

jQuery.validator.addMethod("complete_url", function(val, elem) {
    // if no url, don't do anything
    if (val.length == 0) { return true; }

    // if user has not entered http:// https:// or ftp:// assume they mean http://
    if(!/^(https?|ftp):\/\//i.test(val)) {
        val = 'http://'+val; // set both the value
        $(elem).val(val); // also update the form element
    }
    // now check if valid url
    // http://docs.jquery.com/Plugins/Validation/Methods/url
    // contributed by Scott Gonzalez: http://projects.scottsplayground.com/iri/
    return /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&amp;'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&amp;'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&amp;'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&amp;'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&amp;'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(val);
});

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


