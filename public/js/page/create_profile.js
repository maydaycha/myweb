var CreateProfile = function(){
	var form = $('#submit_form');
    var error = $('.alert-danger', form);
    var success = $('.alert-success', form);

	var initWizard = function(){
		if (!jQuery().bootstrapWizard) {
            return;
        }

        var displayConfirm = function() {
            $('#tab3 .form-control-static', form).each(function(){
                var input = $('[name="'+$(this).attr("data-display")+'"]', form);
                if (input.is(":radio")) {
                    input = $('[name="'+$(this).attr("data-display")+'"]:checked', form);
                }
                if (input.is(":text")) {
                    $(this).html(input.val());
                }
                if (input.is("textarea")) {
                    $(this).html(input.val().replace(/  /g, "&nbsp;&nbsp;").replace(/\n/g,"<br>"));
                } else if (input.is("select")) {
                    $(this).html(input.find('option:selected').text());
                } else if (input.is(":radio") && input.is(":checked")) {
                    $(this).html(input.attr("data-title"));
                    //console.log("13123");
                } else if ($(this).attr("data-display") == 'user[hourly_pay]') {
                    //console.log("1@@@");
                    $(this).html(input.val()+' / HR');
                }
            });
        }

        var handleTitle = function(tab, navigation, index) {
            var total = navigation.find('li').length;
            var current = index + 1;
            // set wizard title
            $('.step-title', $('#form_wizard_1')).text('Step ' + (index + 1) + ' of ' + total);
            // set done steps
            jQuery('li', $('#form_wizard_1')).removeClass("done");
            var li_list = navigation.find('li');
            for (var i = 0; i < index; i++) {
                jQuery(li_list[i]).addClass("done");
            }

            if (current == 1) {
                $('#form_wizard_1').find('.button-previous').hide();
                $('#form_wizard_1').find('.button-previous﹣page').show();
            } else {
                $('#form_wizard_1').find('.button-previous').show();
                $('#form_wizard_1').find('.button-previous﹣page').hide();
            }

            if (current >= total) {
                $('#form_wizard_1').find('.button-next').hide();
                $('#form_wizard_1').find('.button-submit').show();
                displayConfirm();
            } else {
                $('#form_wizard_1').find('.button-next').show();
                $('#form_wizard_1').find('.button-submit').hide();
            }
            Web.scrollTo($('.page-title'));
        }

        // default form wizard
        $('#form_wizard_1').bootstrapWizard({
            'nextSelector': '.button-next',
            'previousSelector': '.button-previous',
            onTabClick: function (tab, navigation, index, clickedIndex) {
                success.hide();
                error.hide();
                if (form.valid() == false || clickedIndex>(index+1)) {
                    return false;
                }
                handleTitle(tab, navigation, clickedIndex);
            },
            onNext: function (tab, navigation, index) {
                success.hide();
                error.hide();

                if (form.valid() == false) {
                    return false;
                }

                handleTitle(tab, navigation, index);
            },
            onPrevious: function (tab, navigation, index) {
                success.hide();
                error.hide();

                handleTitle(tab, navigation, index);
            },
            onTabShow: function (tab, navigation, index) {
                var total = navigation.find('li').length;
                var current = index + 1;
                var $percent = (current / total) * 100;
                $('#form_wizard_1').find('.progress-bar').css({
                    width: $percent + '%'
                });
            }
        });
        $('#form_wizard_1').find('.button-previous').hide();
        $('#form_wizard_1 .button-submit').hide();
    }

    var initForm = function(){
        form.validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                'user[worker_type]': {
                    required: true
                },
                'user[hourly_pay]': {
                    required: true
                },
                'user[zip]': {
                    required: true
                },
                'user[city]': {
                    required: true
                },
                'user[brief_introduction]': {
                    maxlength: 20
                },
                'user[introduction]': {
                    maxlength: 1000
                },
                'user[website]': {
                    complete_url: true
                },
                'user[vat_number]': {
                    digits: true,
                    maxlength: 8
                }
            },

            errorPlacement: function (error, element) { // render error placement for each input type
            	var text;
            	if(error.text()=='This field is required.'){
            		text = form.find('input[id="'+error.attr('for')+'"]').attr('data-isempty');
            		error.text(text);
            	}
            	else if(error.text()!=''){
            		text = form.find('input[id="'+error.attr('for')+'"]').attr('data-isError');
            		error.text(text);
            	}
                var icon = $(element).parent('.input-icon').children('i');
                icon.removeClass('fa-check').addClass("fa-warning");
                icon.attr("data-original-title", error.text()).tooltip({'container': 'body'});
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
                success.hide();
                error.show();
                Web.scrollTo(error, -200);
            },

            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
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

    var validateSkillExist = function(value){
        var result = false;
        $.ajax({
            url: "/skills/exist",
            type: "get",
            dataType: "json",
            data: {name: value},
            success: function(data) {
                result = data.status;
            },
            error: function(data) {
            },
            async: false
        });
        if (result == false)
            $(this).removeTag(value);

        var skills_arr = $(this).val().split(',');
        if (skills_arr.length > 5) {
            alert($('#skill-tags').attr('alert-limit'));
            $(this).removeTag(value);
        }
    }

    var initSkillTags = function(){
		$('#skill-tags').tagsInput({
            width: 'auto',
            autocomplete_url:'/skills/autocomplete',
            onAddTag: validateSkillExist
        });
	}
    var initShowTip = function(){
    	$('.show-tip').on('click',function(e){
    		e.preventDefault();
            var text = $(this).attr('data-original-title');
            bootbox.alert(text);
    	});
	}

	return {
		init:function(){
			initSkillTags();
			initShowTip();
			initForm();
			initWizard();
		}
	}
}();

