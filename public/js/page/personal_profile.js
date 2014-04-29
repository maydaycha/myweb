var PersonalProfile = function(){
	var initEditSaveBtnTip = function(){
		$('.tool-edit,.tool-save,.tool-add').tooltip({'container': 'body'});
		$('.tool-edit').on('click',function(){
			var portlet = $($(this).attr('data-portlet'));
			portlet.removeClass('show-view');
			portlet.addClass('show-edit');
		});
		$('.tool-save').on('click',function(){
			var portlet = $($(this).attr('data-portlet'));
			portlet.removeClass('show-edit');
			portlet.addClass('show-view');
		});
	}
	var initSkillTags = function(){
		$('#skill-tags').tagsInput({
			width: 'auto'
		});
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
	var initAddExperience = function(){
		$('.date-picker').datepicker({
			autoclose: true
		});
		$('#btn-addExperience').on('click',function(){
			var tr = $('<tr></tr>');
			var td1 = $('<td></td>');
			var td2 = $('<td></td>');
			var td3 = $('<td></td>');
			var td4 = $('<td></td>');
			var td5 = $('<td class="edit"><button type="button" class="btn btn-danger btn-xs btn-delete">刪除</button></td>');
			td1.append($('#experience-modal input[name=start]').val());
			td2.append($('#experience-modal input[name=end]').val());
			td3.append($('#experience-modal input[name=organization]').val());
			td4.append($('#experience-modal input[name=office]').val());
			tr.append(td1);
			tr.append(td2);
			tr.append(td3);
			tr.append(td4);
			tr.append(td5);
			update_experience($('#experience-modal input[name=start]').val(), $('#experience-modal input[name=end]').val(), $('#experience-modal input[name=organization]').val(), $('#experience-modal input[name=office]').val(), "add");
			$('#experience-table').append(tr);
			$('#experience-modal input[name=start]').val('');
			$('#experience-modal input[name=end]').val('');
			$('#experience-modal input[name=organization]').val('');
			$('#experience-modal input[name=office]').val('');
			initExperienceTable();
		});
	}

	var initEducationTable = function(){
		$('#education-table .btn-delete').off('click');
		$('#education-table .btn-delete').on('click',function(){
			$(this).parent().parent().remove();
		});
	}
	var initAddEducation = function(){
		$('#btn-addEducation').on('click',function(){
			var tr = $('<tr></tr>');
			var td1 = $('<td></td>');
			var td2 = $('<td></td>');
			var td3 = $('<td></td>');
			var td4 = $('<td></td>');
			var td5 = $('<td class="edit"><button type="button" class="btn btn-danger btn-xs btn-delete">刪除</button></td>');
			td1.append($('#education-modal input[name=start]').val());
			td2.append($('#education-modal input[name=end]').val());
			td3.append($('#education-modal input[name=organization]').val());
			td4.append($('#education-modal input[name=office]').val());
			tr.append(td1);
			tr.append(td2);
			tr.append(td3);
			tr.append(td4);
			tr.append(td5);
			update_education($('#education-modal input[name=start]').val(), $('#education-modal input[name=end]').val(), $('#education-modal input[name=organization]').val(), $('#education-modal input[name=office]').val(), "add");
			$('#education-table').append(tr);
			$('#education-modal input[name=start]').val('');
			$('#education-modal input[name=end]').val('');
			$('#education-modal input[name=organization]').val('');
			$('#education-modal input[name=office]').val('');
			initEducationTable();
		});
	}

	function update_experience(start, end, organization, office, action) {
		var obj = {
			request: "update_experience",
			act: action,
			start_date: start,
			end_date: end,
			organization: organization,
			office: office
		};
		$.ajax({
			url: "/users/profiles/ajax_updae",
			type: "post",
			dataType: "json",
			data: obj,
			success: function(data) {
				console.log(data);
			},
			error: function(data) {
				console.log("error");
			}
		});
	}

	function update_education(start, end, organization, office, action) {
		var obj = {
			request: "update_education",
			act: action,
			start_date: start,
			end_date: end,
			school: organization,
			department: office
		};
		$.ajax({
			url: "/users/profiles/ajax_updae",
			type: "post",
			dataType: "json",
			data: obj,
			success: function(data) {
				console.log(data);
			},
			error: function(data) {
				console.log("error");
			}
		});
	}




return {
	init:function(){
		initEditSaveBtnTip();
		initSkillTags();
		initSubClassSelect2();
		initExperienceTable();
		initAddExperience();
		initEducationTable();
		initAddEducation();

	}
}
}();


