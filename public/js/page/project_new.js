var PersonalProfile = function(){

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
	    	alert($('#skill-tags').attr('alert-limit'));
	    	$(this).removeTag(value);
	    }
	}

	var initSkillTags = function(){
		$('#skill-tags').tagsInput({
			width: 'auto',
			defaultText: $('#skill-tags').attr('defaultText'),
			maxCount: 3,
			placeholderColor: '#999',
			autocomplete_url:'/skills/autocomplete',
			onAddTag: validateSkillExist
		});
		$('#addWorks-skill-tags').tagsInput({
			width: 'auto',
			defaultText: $('#skill-tags').attr('defaultText'),
			maxCount: 3,
			placeholderColor: "#999",
			autocomplete_url:'/skills/autocomplete',
			onAddTag: validateSkillExist
		});
		$('.tagsinput').addClass('form-control');
		$('#skill-tags_tag').css('color', '#999');
	}

    return {
    	init:function() {
    		initSkillTags();
    	}
    }
}();


