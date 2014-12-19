var EditCategory = function(){
	var initSelectClass = function() {
        $('.class-form input[type=checkbox][name=class]').on('change', function(){
            $(this).removeClass('active');
            if($(this).prop('checked')){
                $(this).addClass('active');
            }
            this.blur();
        });
    }
    var initTip = function(){
        $('.class-form .item label').tooltip({'container': 'body'});
    }
    var initFormSubmit = function(){
        $('.class-form').on('submit',function(e){
            var count = 0;
            $('.class-form input[type=checkbox][name=class]').each(function(i, e) {
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
            initTip();
            initFormSubmit();
		}
	}
}();

