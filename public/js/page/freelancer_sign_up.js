var SingUp = function(){
    console.log("sign");
	var formValidation = function() {
        var recommendIcon = $('#signUp-form input[name=recommend]').parent('.input-icon').children('i');
        console.log("test" + recommendIcon.tooltip());
        recommendIcon.tooltip({'container': 'body'});


        var form = $('#signUp-form');
        var error = $('.alert-danger', form);

        form.validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
            	"user[first_name]": {
                    required: true
            	},
                "user[last_name]": {
                    required: true
                },
                "user[email]": {
                    required: true,
                    email: true,
                    myEmail: true
                },
                "user[country_code]": {
                    required: true
                },
                "user[username]": {
                	minlength: 6,
                    required: true,
                    myUsername: true
                },
                "user[password]": {
                	minlength: 6,
                    required: true,
                },
                "user[password_check]": {
                    required: true,
                    myPasswordMatch: true
                }
                // verification: {
                //     required: true,
                //     myImgVerification: true
                // },
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
                error.show();
                Web.scrollTo(error, -200);
            },

            errorPlacement: function (error, element) { // render error placement for each input type
            	var text;
            	if(error.text()=='This field is required.'){
            		text = form.find('input[name='+error.attr('for')+']').attr('data-isEmpty');
            		error.text(text);
            	}
            	else if(error.text()=='Account already exists'){
            		text = form.find('input[name='+error.attr('for')+']').attr('data-isExists');
            		error.text(text);
            	}
            	else if(error.text()!=''){
            		text = form.find('input[name='+error.attr('for')+']').attr('data-isError');
            		error.text(text);
            	}
                var icon = $(element).parent('.input-icon').children('i');
                icon.removeClass('fa-check').addClass("fa-warning");
                icon.attr("data-original-title", error.text()).tooltip({'container': 'body'});
            },

            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label, element) {
                var icon = $(element).parent('.input-icon').children('i');
                $(element).closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
                icon.removeClass("fa-warning").addClass("fa-check");
            },

            submitHandler: function (form) {
                error.hide();
                form.off('submit');
                form.submit();
            }
        });
    }

	return {
		init:function(){
			formValidation();
		}
	}
}();

