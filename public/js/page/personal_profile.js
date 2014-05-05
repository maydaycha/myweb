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
			width: 'auto',
			autocomplete_url:'/skills/autocomplete',
			// autocomplete:{
			// 	source: function(request, response) {
			// 		$.ajax({
			// 			url: "http://127.0.0.1:3000/skills/autocomplete",
			// 			dataType: "json",
			// 			data: JSON.stringify({ postalcode_startsWith: request.term }),
			// 			contentType: 'application/json',
			// 			success: function(data) {
			// 				response( $.map( data.postalCodes, function( item ) {
			// 					return {
			// 						label: item.countryCode + "-" + item.placeName,
			// 						value: item.postalCode
			// 					}
			// 				}));
			// 			}
			// 		})
			// 	}
			// }
		});
	}
	var initSubClassSelect2 = function(){
		$('#subClass_select2').select2({
			placeholder: "Select a State",
			allowClear: true
		});
	}
	var initSubClassSelect3 = function(){
		$('#subClass_select3').select2({
			placeholder: "Select a State",
			allowClear: true
		});
	}
	var initSubClassSelect4 = function(){
		$('#subClass_select4').select2({
			placeholder: "Select a State",
			allowClear: true
		});
	}
	var initSubClassSelect5 = function(){
		$('#subClass_select5').select2({
			placeholder: "Select a State",
			allowClear: true
		});
	}
	var initSubClassSelect6 = function(){
		$('#subClass_select6').select2({
			placeholder: "Select a State",
			allowClear: true
		});
	}
	var initSubClassSelect7 = function(){
		$('#subClass_select7').select2({
			placeholder: "Select a State",
			allowClear: true
		});
	}
	var initSubClassSelect8 = function(){
		$('#subClass_select8').select2({
			placeholder: "Select a State",
			allowClear: true
		});
	}
	var initSubClassSelect9 = function(){
		$('#subClass_select9').select2({
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
			if($('#experience-modal input[name=start]').val() == "") {
				return;
			}
			td1.append($('#experience-modal input[name=start]').val());
			td2.append($('#experience-modal input[name=end]').val());
			td3.append($('#experience-modal input[name=organization]').val());
			td4.append($('#experience-modal input[name=office]').val());
			tr.append(td1);
			tr.append(td2);
			tr.append(td3);
			tr.append(td4);
			tr.append(td5);
			var obj = {
				start_date: $('#experience-modal input[name=start]').val(),
				end_date: $('#experience-modal input[name=end]').val(),
				organization: $('#experience-modal input[name=organization]').val(),
				office: $('#experience-modal input[name=office]').val(),
				description: $('#experience-modal textarea[name=description]').val()
			};
			experience_add_list.push(obj);
			$('#experience-table').append(tr);
			$('#experience-modal input[name=start]').val('');
			$('#experience-modal input[name=end]').val('');
			$('#experience-modal input[name=organization]').val('');
			$('#experience-modal input[name=office]').val('');
			$('#experience-modal textarea[name=description]').val('');
			initExperienceTable();
			console.log("test");
			$("#experience-modal").modal('toggle');
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
		if($('#education-modal input[name=start]').val() == "") {
			return;
		}
		td1.append($('#education-modal input[name=start]').val());
		td2.append($('#education-modal input[name=end]').val());
		td3.append($('#education-modal input[name=organization]').val());
		td4.append($('#education-modal input[name=office]').val());
		tr.append(td1);
		tr.append(td2);
		tr.append(td3);
		tr.append(td4);
		tr.append(td5);
		var obj = {
			start_date: $('#education-modal input[name=start]').val(),
			end_date: $('#education-modal input[name=end]').val(),
			school: $('#education-modal input[name=organization]').val(),
			department: $('#education-modal input[name=office]').val(),
			description: $('#education-modal textarea[name=description]').val()
		};
		education_add_list.push(obj);
		console.log(education_add_list);
		$('#education-table').append(tr);
		$('#education-modal input[name=start]').val('');
		$('#education-modal input[name=end]').val('');
		$('#education-modal input[name=organization]').val('');
		$('#education-modal input[name=office]').val('');
		$('#education-modal textarea[name=description]').val('');
		initEducationTable();
		$("#education-modal").modal('toggle');
	});
}






return {
	init:function(){
		initEditSaveBtnTip();
		initSkillTags();
		initSubClassSelect2();
		initSubClassSelect3();
		initSubClassSelect4();
		initSubClassSelect5();
		initSubClassSelect6();
		initSubClassSelect7();
		initSubClassSelect8();
		initSubClassSelect9();
		initExperienceTable();
		initAddExperience();
		initEducationTable();
		initAddEducation();

	}
}
}();


