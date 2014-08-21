var EditProfile = function(){
	var initSelectClass = function() {
        $(".class-form input[type=radio][name='user_skill_category[main_skill_id]']").on('change', function(){
            $(".class-form input[type=radio][name='user_skill_category[main_skill_id]']").removeClass('active');
            $(this).addClass('active');
            this.blur();
        });
    }
    var initFormSubmit = function(){
        $('.class-form').on('submit',function(e){
            var count = 0;
            $(".class-form input[type=radio][name='user_skill_category[main_skill_id]']").each(function(i, e) {
                if($(this).prop('checked')){
                    count++;
                }
            });
            if(count<=0){
                e.preventDefault();
                var text = $('.class-form').attr('data-isempty');
                bootbox.alert(text);
            }
        });
    }

	return {
		init:function(){
			initSelectClass();
            initFormSubmit();
		}
	}
}();

