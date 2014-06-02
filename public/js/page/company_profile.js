var PersonalProfile = function(){
	var formValidation = function() {
        var form = $('#contact-form2');
        var password_form = $('#password-form');
        var error = $('.alert-danger', form);

        form.validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                "first_name": {
                    required: true
                },
                "last_name": {
                    required: true
                },
                "brief_introduction": {
                    maxlength: 20
                },
                "introduction": {
                    maxlength: 1000
                },
                "website": {
                	complete_url: true
                }
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
                error.show();
                Web.scrollTo(error, 200);
            },

            errorPlacement: function (error, element) { // render error placement for each input type
            	var text;
            	if(error.text()=='This field is required.'){
            		text = form.find('input[id='+error.attr('for')+']').attr('data-isempty');
            		error.text(text);
            	}
            	else if(error.text()=='This field has already existed'){
            		text = form.find('input[id='+error.attr('for')+']').attr('data-isExists');
            		error.text(text);
            	}
                else if(error.text()=='This field has isInconsistent data'){
                    text = form.find('input[id='+error.attr('for')+']').attr('data-isInconsistent');
                    error.text(text);
                }else if(error.text()!=''){
            		text = form.find('input[id='+error.attr('for')+']').attr('data-isError');
            		error.text(text);
            	}
                var icon = $(element).parent('.input-icon').children('i');
                $(element).closest('i')
                icon.removeClass('fa-check').addClass("fa-warning");
                icon.attr("data-original-title", error.text()).tooltip({'container': 'body'});
            },

            highlight: function (element) { // hightlight error inputs
                $(element).closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element).closest('.form-group').removeClass('has-error'); // set error class to the control group
                console.log("no error")
            },

            success: function (label, element) {
                var icon = $(element).parent('.input-icon').children('i');
                $(element).closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
                icon.removeClass("fa-warning").addClass("fa-check");
            },

            // submitHandler: function (form) {
            //     error.hide();
            //     form.off('submit');
            //     form.submit();
            // }
        });


		password_form.validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                "user[current_password]": {
                    required: true,
                    myPasswordCheck: true
                },
                "user[password]": {
                	minlength: 8,
                    required: true,
                    myPasswordAllow: true
                },
                "user[password_confirmation]": {
                	minlength: 8,
                    required: true,
                    myPasswordMatch: true
                }
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
                error.show();
                Web.scrollTo(error, 200);
            },

            errorPlacement: function (error, element) { // render error placement for each input type
            	var text;
            	if(error.text()=='This field is required.'){
            		text = form.find('input[id='+error.attr('for')+']').attr('data-isempty');
            		error.text(text);
            	}
            	else if(error.text()=='This field has already existed'){
            		text = form.find('input[id='+error.attr('for')+']').attr('data-isExists');
            		error.text(text);
            	}
                else if(error.text()=='This field has isInconsistent data'){
                    text = form.find('input[id='+error.attr('for')+']').attr('data-isInconsistent');
                    error.text(text);
                }else if(error.text()!=''){
            		text = form.find('input[id='+error.attr('for')+']').attr('data-isError');
            		error.text(text);
            	}
                var icon = $(element).parent('.input-icon').children('i');
                $(element).closest('i')
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
        });
    }

	var initEditSaveBtnTip = function(){
		$('.tool-edit,.tool-save,.tool-add').tooltip({'container': 'body'});
		$('.tool-edit').on('click',function(e){
			e.preventDefault();
			var portlet = $($(this).attr('data-portlet'));
			portlet.removeClass('show-view');
			portlet.addClass('show-edit');
		});
		$('.tool-save').on('click',function(e){
			e.preventDefault();
			var portlet = $($(this).attr('data-portlet'));
			portlet.removeClass('show-edit');
			portlet.addClass('show-view');
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
	    if (skills_arr.length > 8) {
	    	alert('目前只能擁有8項技能');
	    	$(this).removeTag(value);
	    }
	}

	var initSkillTags = function(){
		$('#skill-tags').tagsInput({
			width: 'auto',
			defaultText: "技能標籤",
			maxCount: 3,
			placeholderColor: '#999',
			autocomplete_url:'/skills/autocomplete',
			onAddTag: validateSkillExist
		});
		$('#addWorks-skill-tags').tagsInput({
			width: 'auto',
			defaultText: "技能標籤",
			maxCount: 3,
			placeholderColor: "#999",
			autocomplete_url:'/skills/autocomplete',
			onAddTag: validateSkillExist
		});
		$('.tagsinput').addClass('form-control');
		$('#skill-tags_tag').css('color', '#999');
	}


	var initSubClassSelect2 = function(){
		$('.subClass_select2').select2({
			placeholder: "Select a State",
			allowClear: true
		});
	}


	var initExperienceTable = function(){
		$('#experience-table .btn-delete').off('click');
		$('#experience-table .btn-delete').on('click',function(){
			$(this).parent().parent().remove();
		});
	}
	var rowExperience_idx = 0;


	var initAddExperience = function(){
		$('.date-picker').datepicker({
			autoclose: true
		});
		$('#btn-addExperience').on('click',function(){
			var tr = $($('.rowExperience-simple').html());
			if( $('#experience-modal input[name=start]').val() == "") {
				alert('請填寫工作開始時間')
				return
			} else if( $('#experience-modal input[name=end]').val() != "" && $('#experience-modal input[name=start]').val() > $('#experience-modal input[name=end]').val()) {
				alert('訖日在起日之前');
				return;
			} else if( $('#experience-modal input[name=organization]').val() == "" ) {
				alert('公司名稱 尚未填寫');
				return;
			} else if( $('#experience-modal input[name=office]').val() == "" ) {
				alert('職位/職責 尚未填寫');
				return;
			}
			tr.find('.start').text($('#experience-modal input[name=start]').val());
			tr.find('.end').text($('#experience-modal input[name=end]').val());
			tr.find('.organization').text($('#experience-modal input[name=organization]').val());
			tr.find('.office').text($('#experience-modal input[name=office]').val());
			tr.find('.description').text($('#experience-modal textarea[name=description]').val());
			editExperience(tr);

			var request_obj = {
				request: "add_experience",
				start_date: $('#experience-modal input[name=start]').val(),
				end_date: $('#experience-modal input[name=end]').val(),
				organization: $('#experience-modal input[name=organization]').val(),
				office: $('#experience-modal input[name=office]').val(),
				description: $('#experience-modal textarea[name=description]').val()
			}
			$("#experience-modal").modal('toggle')
         	$("#loader").show()
	         $.ajax({
	            url: "/users/profiles/ajax_updae",
	            type: "post",
	            dataType: "json",
	            data: JSON.stringify(request_obj),
	            contentType: 'application/json',
	            success: function(data) {
	                $('#experience-table').append(tr)
					$('#experience-modal input[name=start]').val('')
					$('#experience-modal input[name=end]').val('')
					$('#experience-modal input[name=organization]').val('')
					$('#experience-modal input[name=office]').val('')
					$('#experience-modal textarea[name=description]').val('')
					$("#loader").hide()
					initExperienceTable()
	            }
	        });
		});
}

var initEditExperience = function(tr){
	var tr = $('#experience-table tr');
	for(var i = 1; i < tr.length; i++){
		editExperience(tr.eq(i));
	}
}

var editExperience = function(tr){
	var modal = $($('.editExperience-simple').html());
	var id = tr.find('.id').text()
	modal.attr('id','editExperience-modal-'+ rowExperience_idx );
	modal.find('input[name=start]').val(tr.find('.start').text());
	modal.find('input[name=end]').val(tr.find('.end').text());
	modal.find('input[name=organization]').val(tr.find('.organization').text());
	modal.find('input[name=office]').val(tr.find('.office').text());
	modal.find('textarea[name=description]').val(tr.find('.description').text());
	modal.find('.btn-editExperience').on('click',function(){
		// console.log(modal.find('input[name=start]').val());
		// console.log(modal.find('input[name=end]').val());
		if( modal.find('input[name=start]').val() == "") {
			alert('請填寫工作開始時間')
			return;
		}else if( modal.find('input[name=end]').val() != "" && modal.find('input[name=start]').val() > modal.find('input[name=end]').val()) {
			alert('訖日在起日之前');
			return;
		}else if( modal.find('input[name=organization]').val() == "" ) {
			alert('公司名稱 尚未填寫');
			return;
		} else if( modal.find('input[name=office]').val() == "" ) {
			alert('職位/職責 尚未填寫');
			return;
		}

		tr.find('.start').text(modal.find('input[name=start]').val());
		tr.find('.end').text(modal.find('input[name=end]').val());
		tr.find('.organization').text(modal.find('input[name=organization]').val());
		tr.find('.office').text(modal.find('input[name=office]').val());
		tr.find('.description').text(modal.find('textarea[name=description]').val());

		var request_obj = {
			request: "update_experience",
			id: id,
			start_date: modal.find('input[name=start]').val(),
			end_date: modal.find('input[name=end]').val(),
			organization: modal.find('input[name=organization]').val(),
			office: modal.find('input[name=office]').val(),
			description: modal.find('textarea[name=description]').val()
		}
		$("#loader").show()
	         $.ajax({
	            url: "/users/profiles/ajax_updae",
	            type: "post",
	            dataType: "json",
	            data: JSON.stringify(request_obj),
	            contentType: 'application/json',
	            success: function(data) {
	            	$("#loader").hide()
					modal.find('.btn-close').click();
	         }
	     });
	});
	modal.find('.date-picker').datepicker();
	tr.find('.btn-edit').attr('data-toggle','modal');
	tr.find('.btn-edit').attr('href','#editExperience-modal-'+rowExperience_idx);
	tr.find('.btns').append(modal);
	rowExperience_idx++;
}



var initEducationTable = function(){
	$('#education-table .btn-delete').off('click');
	$('#education-table .btn-delete').on('click',function(){
		$(this).parent().parent().remove();
	});
}

var rowEducation_idx = 0;

var initAddEducation = function(){
	$('#btn-addEducation').on('click',function(){
		if($('#education-modal input[name=start]').val() == "") {
			alert('請填寫教育開始時間');
			return;
		} else if( $('#education-modal input[name=end]').val() != "" && $('#education-modal input[name=start]').val() > $('#education-modal input[name=end]').val()) {
			alert('訖日在起日之前');
			return;
		} else if($('#education-modal input[name=organization]').val() == "") {
			alert('請填寫學校');
			return;
		} else if($('#education-modal input[name=office]').val() == "") {
			alert('請填寫系所/專長');
			return;
		}
		var tr = $($('.rowEducation-simple').html());
		tr.find('.start').text($('#education-modal input[name=start]').val());
		tr.find('.end').text($('#education-modal input[name=end]').val());
		tr.find('.organization').text($('#education-modal input[name=organization]').val());
		tr.find('.office').text($('#education-modal input[name=office]').val());
		tr.find('.description').text($('#education-modal textarea[name=description]').val());

		editEducation(tr);

		var request_obj = {
			request: "add_education",
			start_date: $('#education-modal input[name=start]').val(),
			end_date: $('#education-modal input[name=end]').val(),
			school: $('#education-modal input[name=organization]').val(),
			department: $('#education-modal input[name=office]').val(),
			description: $('#education-modal textarea[name=description]').val()
		}
		$("#education-modal").modal('toggle');
		$("#loader").show()
		$.ajax({
	            url: "/users/profiles/ajax_updae",
	            type: "post",
	            dataType: "json",
	            data: JSON.stringify(request_obj),
	            contentType: 'application/json',
	            success: function(data) {
	                $('#education-table').append(tr);
					$('#education-modal input[name=start]').val('');
					$('#education-modal input[name=end]').val('');
					$('#education-modal input[name=organization]').val('');
					$('#education-modal input[name=office]').val('');
					$('#education-modal textarea[name=description]').val('');
					$("#loader").hide()
					initEducationTable();
	            }
	        });
	});
}

var initEditEducation = function(tr){
	var tr = $('#education-table tr');
	for(var i=1;i<tr.length;i++){
		editEducation(tr.eq(i));
	}
}

var editEducation = function(tr){
	var modal = $($('.editEducation-simple').html());
	var id = tr.find('.id').text()

	modal.attr('id','editEducation-modal-'+rowEducation_idx);
	modal.find('input[name=start]').val(tr.find('.start').text());
	modal.find('input[name=end]').val(tr.find('.end').text());
	modal.find('input[name=organization]').val(tr.find('.organization').text());
	modal.find('input[name=office]').val(tr.find('.office').text());
	modal.find('textarea[name=description]').val(tr.find('.description').text());
	modal.find('.btn-editEducation').on('click',function(){
		if(modal.find('input[name=start]').val() == "") {
			alert('請填寫教育開始時間');
			return;
		} else if( modal.find('input[name=end]').val() != "" && modal.find('input[name=start]').val() > modal.find('input[name=end]').val()) {
			alert('訖日在起日之前');
			return;
		} else if(modal.find('input[name=organization]').val() == "") {
			alert('請填寫學校');
			return;
		} else if( modal.find('input[name=office]').val() == "") {
			alert('請填寫系所/專長');
			return;
		}

		tr.find('.start').text(modal.find('input[name=start]').val());
		tr.find('.end').text(modal.find('input[name=end]').val());
		tr.find('.organization').text(modal.find('input[name=organization]').val());
		tr.find('.office').text(modal.find('input[name=office]').val());
		tr.find('.description').text(modal.find('textarea[name=description]').val());
		modal.find('.btn-close').click();

		var request_obj = {
			request: "update_education",
			id: id,
			start_date: modal.find('input[name=start]').val(),
			end_date: modal.find('input[name=end]').val(),
			school: modal.find('input[name=organization]').val(),
			department: modal.find('input[name=office]').val(),
			description: modal.find('textarea[name=description]').val()
		}
		$("#loader").show()
		$.ajax({
	            url: "/users/profiles/ajax_updae",
	            type: "post",
	            dataType: "json",
	            data: JSON.stringify(request_obj),
	            contentType: 'application/json',
	            success: function(data) {
	                $("#loader").hide()
	            }
	     });
});


	modal.find('.date-picker').datepicker();
	tr.find('.btn-edit').attr('data-toggle','modal');
	tr.find('.btn-edit').attr('href','#editEducation-modal-'+rowEducation_idx);
	tr.find('.btns').append(modal);

	rowEducation_idx++;
}



var initCertificateTable = function(){
	$('#certificate-table .btn-delete').off('click');
	$('#certificate-table .btn-delete').on('click',function(){
		$(this).parent().parent().remove();
	});
}
var rowCertificate_idx = 0;
var initAddCertificate = function(){
	$('.date-picker').datepicker({
		autoclose: true
	});

	$('#btn-addCertificate').on('click', function(){
		if($('#certificate-modal input[name=certificate]').val() == "") {
			alert('請填寫證照名稱');
			return;
		}
		var tr = $($('.rowCertificate-simple').html());
		tr.find('.certificate').text($('#certificate-modal input[name=certificate]').val());
		tr.find('.cer-source').text($('#certificate-modal input[name=cer-source]').val());
		tr.find('.start').text($('#certificate-modal input[name=start]').val());
		tr.find('.description').text($('#certificate-modal textarea[name=description]').val());
		editCertificate(tr);

		var request_obj = {
			request: "add_certification",
			name: $('#certificate-modal input[name=certificate]').val(),
			source: $('#certificate-modal input[name=cer-source]').val(),
			get_time: $('#certificate-modal input[name=start]').val(),
			description: $('#certificate-modal textarea[name=description]').val()
		};

		$("#certificate-modal").modal('toggle');
		$("#loader").show()
		$.ajax({
	            url: "/users/profiles/ajax_updae",
	            type: "post",
	            dataType: "json",
	            data: JSON.stringify(request_obj),
	            contentType: 'application/json',
	            success: function(data) {
					$('#certificate-table').append(tr);
					$('#certificate-modal input[name=certificate]').val('');
					$('#certificate-modal input[name=cer-source]').val('');
					$('#certificate-modal input[name=start]').val('');
					$('#certificate-modal textarea[name=description]').val('');
					$("#loader").hide()
					initCertificateTable();
	            }
	     });
	});
}

var initEditCertificate = function(tr){
	var tr = $('#certificate-table tr');
	for(var i=1;i<tr.length;i++){
		editCertificate(tr.eq(i));
	}
}
var editCertificate = function(tr){
	var modal = $($('.editCertificate-simple').html());
	var id = tr.find('.id').text()
	modal.attr('id','editCertificate-modal-'+rowCertificate_idx);
	modal.find('input[name=certificate]').val(tr.find('.certificate').text());
	modal.find('input[name=cer-source]').val(tr.find('.cer-source').text());
	modal.find('input[name=start]').val(tr.find('.start').text());
	modal.find('textarea[name=description]').val(tr.find('.description').text());
	modal.find('.btn-editCertificate').on('click',function(){
		if(modal.find('input[name=certificate]').val() == "") {
			alert('請填寫證照名稱');
			return;
		}

		tr.find('.certificate').text(modal.find('input[name=certificate]').val());
		tr.find('.cer-source').text(modal.find('input[name=cer-source]').val());
		tr.find('.start').text(modal.find('input[name=start]').val());
		tr.find('.description').text(modal.find('textarea[name=description]').val());
		modal.find('.btn-close').click();

		var request_obj = {
			request: "update_certification",
			id: id,
			name: modal.find('input[name=certificate]').val(),
			source: modal.find('input[name=cer-source]').val(),
			get_time: modal.find('input[name=start]').val(),
			description: modal.find('textarea[name=description]').val(),
		}
		$("#loader").show()
		$.ajax({
	            url: "/users/profiles/ajax_updae",
	            type: "post",
	            dataType: "json",
	            data: JSON.stringify(request_obj),
	            contentType: 'application/json',
	            success: function(data) {
	                $("#loader").hide()
	            }
	     });
	});
	modal.find('.date-picker').datepicker();
	tr.find('.btn-edit').attr('data-toggle','modal');
	tr.find('.btn-edit').attr('href','#editCertificate-modal-'+rowCertificate_idx);
	tr.find('.btns').append(modal);

	rowCertificate_idx++;
}

var initWorksTable = function(){
	$('#works-table .btn-delete').off('click');
	$('#works-table .btn-delete').on('click',function(){
		$(this).parent().parent().remove();
	});
}

var initAddWorks = function() {
	$("#btn-addWorks").on('click', function() {
		//console.log($('#works-modal input[name=subClass]').val());
		if($('#works-modal input[name=title]').val() == "") {
			alert('請填寫作品名稱');
			return;
		} else if($('#works-modal input[name=description]').val() == "") {
			alert('請填寫作品描述');
			return;
		} else if($('#works-modal select[name=mainClass]').val() == -1) {
			alert('請填寫主類別');
			return;
		}  else if($('#works-modal select[name=subClass]').val() == -1) {
			alert('請填寫子類別');
			return;
		}
		var fd = new FormData();

		add_portfolio();  // this defined in show.html

		var main_class_text = $("#work_main_class option:selected").text();
		var sub_class_text = $("#work_subClass_select2 option:selected").text();
		$("#works-modal").modal('toggle');

	});
}


return {
	init:function(){
		initEditSaveBtnTip();
		initSkillTags();
		initSubClassSelect2();
		initExperienceTable();
		initAddExperience();
		initEditExperience();
		initEducationTable();
		initAddEducation();
		initEditEducation();
		initCertificateTable();
		initAddCertificate();
		initEditCertificate()
		initWorksTable();
		initAddWorks();
		formValidation();
	}
}
}();


