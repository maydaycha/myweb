jQuery.validator.addMethod("myUsername", function(value, element) {
	if(value=="123456"){
		return false;
	}
	else{
		return true;
	}
}, "帳號已經重複");

jQuery.validator.addMethod("myImgVerification", function(value, element) {
	var verification='vsdee';
	return value.toLowerCase() == verification.toLowerCase();
}, "認證碼錯誤");
