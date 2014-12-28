var EditProfile = function(){
	var initSelectClass = function() {
        $('.class-form input[type=radio][name=class]').on('change', function(){
            $('.class-form input[type=radio][name=class]').removeClass('active');
            $(this).addClass('active');
            this.blur();
        });
    }
    var initFormSubmit = function(){
        $('.class-form').on('submit',function(e){
            var count = 0;
            $('.class-form input[type=radio][name=class]').each(function(i, e) {
                if($(this).prop('checked')){
                    count++;
                }
            });
            if(count<=0){
                e.preventDefault();
                var text = $('.class-form').attr('data-isEmpty');
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

