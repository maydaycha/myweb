var SingUp = function(){
    var initFormPersonal = function() {
        var form = $('#signUp-form-personal');
        var error = $('.alert-danger', form);

        form.validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                surname: {
                    required: true
                },
                email: {
                    required: true,
                    email: true
                }
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
                else if(error.text()=='This field has already existed'){
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
    var initFormCompany = function() {
        var form = $('#signUp-form-company');
        var error = $('.alert-danger', form);

        form.validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                surname: {
                    required: true
                },
                email: {
                    required: true,
                    email: true
                },
                organization: {
                    required: true
                }
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
                else if(error.text()=='This field has already existed'){
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
            initFormPersonal();
            initFormCompany();
		}
	}
}();

