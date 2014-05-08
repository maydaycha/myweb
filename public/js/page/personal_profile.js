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
			autocomplete_url:'/skills/autocomplete'
		});
	}

	var initAddWorksSkillTags = function(){
		$('#addWorks-skill-tags').tagsInput({
			width: 'auto',
			autocomplete_url:'/skills/autocomplete'
		});
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
	var initAddExperience = function(){
		$('.date-picker').datepicker({
			autoclose: true
		});
		$('#btn-addExperience').on('click',function(){
			if($('#experience-modal input[name=start]').val() == "") {
				alert('請填寫工作開始時間');
				return;
			} else if($('#experience-modal input[name=organization]').val() == "" && $('#experience-modal input[name=office]').val() == ""){
				alert('公司 職位/職責 需填選至少一個');
				return;
			}

			var tr = $('<tr></tr>');
			var td1 = $('<td></td>');
			var td2 = $('<td></td>');
			var td3 = $('<td></td>');
			var td4 = $('<td></td>');
			var td5 = $('<td></td>');
			var td6 = $('<td class="edit"><button type="button" class="btn btn-danger btn-xs btn-delete">刪除</button></td>');
			td1.append($('#experience-modal input[name=start]').val());
			td2.append($('#experience-modal input[name=end]').val());
			td3.append($('#experience-modal input[name=organization]').val());
			td4.append($('#experience-modal input[name=office]').val());
			td5.append($('#experience-modal textarea[name=description]').val());
			tr.append(td1);
			tr.append(td2);
			tr.append(td3);
			tr.append(td4);
			tr.append(td5);
			tr.append(td6);
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
		if($('#education-modal input[name=start]').val() == "") {
			alert('請填寫教育開始時間');
			return;
		} else if($('#education-modal input[name=organization]').val() == "") {
			alert('請填寫學校');
			return;
		} else if($('#education-modal input[name=office]').val() == "") {
			alert('請填寫系所/專長');
			return;
		}

		var tr = $('<tr></tr>');
		var td1 = $('<td></td>');
		var td2	 = $('<td></td>');
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


var initCertificateTable = function(){
	$('#certificate-table .btn-delete').off('click');
	$('#certificate-table .btn-delete').on('click',function(){
		$(this).parent().parent().remove();
	});
}
var initAddCertificate = function(){
	$('#btn-addCertificate').on('click', function(){
		if($('#certificate-modal input[name=certificate]').val() == "") {
			alert('請填寫證照名稱');
			return;
		}
		var tr = $('<tr></tr>');
		var td1 = $('<td></td>');
		var td2 = $('<td></td>');
		var td3 = $('<td></td>');
		var td4 = $('<td></td>');
		var td5 = $('<td class="edit"><button type="button" class="btn btn-danger btn-xs btn-delete">刪除</button></td>');
		td1.append($('#certificate-modal input[name=certificate]').val());
		td2.append($('#certificate-modal input[name=cer-source]').val());
		td3.append($('#certificate-modal input[name=start]').val());
		td4.append($('#certificate-modal textarea[name=work-description]').val());
		tr.append(td1);
		tr.append(td2);
		tr.append(td3);
		tr.append(td4);
		tr.append(td5);
		var obj = {
			name: $('#certificate-modal input[name=certificate]').val(),
			source: $('#certificate-modal input[name=cer-source]').val(),
			get_time: $('#certificate-modal input[name=start]').val(),
			description: $('#certificate-modal textarea[name=work-description]').val()
		};
		certificate_add_list.push(obj);
		console.log(certificate_add_list);
		$('#certificate-table').append(tr);
		$('#certificate-modal input[name=certificate]').val('');
		$('#certificate-modal input[name=cer-source]').val('');
		$('#certificate-modal input[name=start]').val('');
		$('#certificate-modal textarea[name=work-description]').val('');
		initCertificateTable();
		$("#certificate-modal").modal('toggle');
	});
}


var initAddWorks = function() {
	$("#btn-addWorks").on('click', function() {
		console.log($('#works-modal input[name=subClass]').val());
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
		// fd.append('document', $("#works-modal input[name=thumbnail]")[0].files[0]);
		// fd.append('name', $("#works-modal input[name=title]").val());
		// fd.append('description', $("#works-modal textarea[name=description]").val());
		// fd.append('main_skill_id', $("#work_main_class").val());
		// fd.append('sub_skill_id', $("#work_subClass_select2").val());
		// fd.append('date', $("#works-modal input[name=start]").val());
		// fd.append('skill', $("#works-modal input[name=skill]").val());
		// fd.append('request', "update_portfolio");

		// // var obj = {
		// // 	name: $("#works-modal input[name=title]").val(),
		// // 	description: $("#works-modal textarea[name=description]").val(),
		// // 	main_skill_id: $("#work_main_class").val(),
		// // 	sub_skill_id: $("#work_subClass_select2").val(),
		// // 	date: $("#works-modal input[name=start]").val(),
		// // 	skill: $("#works-modal input[name=skill]").val(),
		// // 	document: fd
		// // }
		// works_add_list.push(fd);
		var main_class_text = $("#work_main_class option:selected").text();
		var sub_class_text = $("#work_subClass_select2 option:selected").text();
		console.log(works_add_list);

		// $("#works-modal input[name=title]").val('');
		// $("#works-modal textarea[name=description]").val('');
		// $("#work_main_class").val('');
		// $("#work_subClass_select2").val('');
		// $("#works-modal input[name=start]").val('');
		// $("#works-modal input[name=skill]").val('');
		$("#works-modal").modal('toggle');

		// 圖片目前寫死
		var content ="<hr><div class='row profile'> <div class='col-md-5'> <div class='row'> <div class='col-sm-4 title'><h4>"+obj.name+"</h4><p>"+obj.date+"</p></div> <div class='col-sm-8 text'><p style='font-size:1.2em;'>"+main_class_text+"/"+sub_class_text+"</p><p class='form-control-static'>"+obj.skill+"</p></div> </div> <hr> <div><p>"+obj.description+"</p></div></div><div class='col-md-7'><div class='row'><div class='col-sm-6'><img class='img-responsive' src='/img/class/class_6.jpg' alt='img'></div><div class='col-sm-6'><img class='img-responsive'  src='/img/class/class_5.jpg' alt='img'></div></div></div></div>";
		$(".row.profile:last").after(content);
	});
}




return {
	init:function(){
		initEditSaveBtnTip();
		initSkillTags();
		initAddWorksSkillTags();
		initSubClassSelect2();
		initExperienceTable();
		initAddExperience();
		initEducationTable();
		initAddEducation();
		initCertificateTable();
		initAddCertificate();
		initAddWorks();

	}
}
}();


