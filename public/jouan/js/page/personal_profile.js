var PersonalProfile = function(){
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
	var initSkillTags = function(){
		$('#skill-tags').tagsInput({
            width: 'auto',
            defaultText: '技能標籤',
            placeholderColor: '#999'
        });
		$('#addWorks-skill-tags').tagsInput({
            width: 'auto',
            defaultText: '技能標籤',
            placeholderColor: '#999'
        });
        $('.tagsinput').addClass('form-control');
        $('#skill-tags_tag').css('color','#999');
	}
	var initSubClassSelect2 = function(){
        $('#subClass_select2').select2({
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
			tr.find('.start').text($('#experience-modal input[name=start]').val());
			tr.find('.end').text($('#experience-modal input[name=end]').val());
			tr.find('.organization').text($('#experience-modal input[name=organization]').val());
			tr.find('.office').text($('#experience-modal input[name=office]').val());
			tr.find('.detail').text($('#experience-modal textarea[name=detail]').val());
			editExperience(tr);

			$('#experience-table').append(tr);
			$('#experience-modal input[name=start]').val('');
			$('#experience-modal input[name=end]').val('');
			$('#experience-modal input[name=organization]').val('');
			$('#experience-modal input[name=office]').val('');
			$('#experience-modal textarea[name=detail]').val('');
			initExperienceTable();
		});
	}
	var initEditExperience = function(tr){
		var tr = $('#experience-table tr');
		for(var i=1;i<tr.length;i++){
			editExperience(tr.eq(i));
		}
	}
	var editExperience = function(tr){
		var modal = $($('.editExperience-simple').html());
		modal.attr('id','editExperience-modal-'+rowExperience_idx);
		modal.find('input[name=start]').val(tr.find('.start').text());
		modal.find('input[name=end]').val(tr.find('.end').text());
		modal.find('input[name=organization]').val(tr.find('.organization').text());
		modal.find('input[name=office]').val(tr.find('.office').text());
		modal.find('textarea[name=detail]').val(tr.find('.detail').text());
		modal.find('.btn-editExperience').on('click',function(){
			tr.find('.start').text(modal.find('input[name=start]').val());
			tr.find('.end').text(modal.find('input[name=end]').val());
			tr.find('.organization').text(modal.find('input[name=organization]').val());
			tr.find('.office').text(modal.find('input[name=office]').val());
			tr.find('.detail').text(modal.find('textarea[name=detail]').val());
			modal.find('.btn-close').click();
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
			var tr = $($('.rowEducation-simple').html());
			tr.find('.start').text($('#education-modal input[name=start]').val());
			tr.find('.end').text($('#education-modal input[name=end]').val());
			tr.find('.organization').text($('#education-modal input[name=organization]').val());
			tr.find('.office').text($('#education-modal input[name=office]').val());
			tr.find('.detail').text($('#education-modal textarea[name=detail]').val());

			editEducation(tr);

			$('#education-table').append(tr);
			$('#education-modal input[name=start]').val('');
			$('#education-modal input[name=end]').val('');
			$('#education-modal input[name=organization]').val('');
			$('#education-modal input[name=office]').val('');
			$('#education-modal textarea[name=detail]').val('');
			initEducationTable();
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
		modal.attr('id','editEducation-modal-'+rowEducation_idx);
		modal.find('input[name=start]').val(tr.find('.start').text());
		modal.find('input[name=end]').val(tr.find('.end').text());
		modal.find('input[name=organization]').val(tr.find('.organization').text());
		modal.find('input[name=office]').val(tr.find('.office').text());
		modal.find('textarea[name=detail]').val(tr.find('.detail').text());
		modal.find('.btn-editEducation').on('click',function(){
			tr.find('.start').text(modal.find('input[name=start]').val());
			tr.find('.end').text(modal.find('input[name=end]').val());
			tr.find('.organization').text(modal.find('input[name=organization]').val());
			tr.find('.office').text(modal.find('input[name=office]').val());
			tr.find('.detail').text(modal.find('textarea[name=detail]').val());
			modal.find('.btn-close').click();
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
		$('#btn-addCertificate').on('click',function(){
			var tr = $($('.rowCertificate-simple').html());
			tr.find('.start').text($('#certificate-modal input[name=start]').val());
			tr.find('.end').text($('#certificate-modal input[name=end]').val());
			tr.find('.organization').text($('#certificate-modal input[name=organization]').val());
			
			tr.find('.detail').text($('#certificate-modal textarea[name=detail]').val());
			editCertificate(tr);

			$('#certificate-table').append(tr);
			$('#certificate-modal input[name=start]').val('');
			$('#certificate-modal input[name=end]').val('');
			$('#certificate-modal input[name=organization]').val('');
			
			$('#certificate-modal textarea[name=detail]').val('');
			initCertificateTable();
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
		modal.attr('id','editCertificate-modal-'+rowCertificate_idx);
		modal.find('input[name=start]').val(tr.find('.start').text());
		modal.find('input[name=end]').val(tr.find('.end').text());
		modal.find('input[name=organization]').val(tr.find('.organization').text());
		
		modal.find('textarea[name=detail]').val(tr.find('.detail').text());
		modal.find('.btn-editCertificate').on('click',function(){
			tr.find('.start').text(modal.find('input[name=start]').val());
			tr.find('.end').text(modal.find('input[name=end]').val());
			tr.find('.organization').text(modal.find('input[name=organization]').val());
			
			tr.find('.detail').text(modal.find('textarea[name=detail]').val());
			modal.find('.btn-close').click();
		});
		modal.find('.date-picker').datepicker();
		tr.find('.btn-edit').attr('data-toggle','modal');
		tr.find('.btn-edit').attr('href','#editCertificate-modal-'+rowCertificate_idx);
		tr.find('.btns').append(modal);

		rowCertificate_idx++;
	}
	
	
	
	
	var initTextareaMaxlength = function(){
		$('#addWoeks-description').maxlength({
            limitReachedClass: "label label-danger",
            alwaysShow: true
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
			initEditCertificate();
			initTextareaMaxlength();
		}
	}
}();

