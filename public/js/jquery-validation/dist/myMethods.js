jQuery.validator.addMethod("myUsername", function(value, element) {
	if(value=="123456"){
		return false;
	}
	else{
		return true;
	}
}, "Account already exists");

jQuery.validator.addMethod("myImgVerification", function(value, element) {
	var verification='vsdee';
	return value.toLowerCase() == verification.toLowerCase();
}, "image verification error");
