var Web = function(){
	var initContentHeight = function(){
		contentHeight();
		setTimeout(contentHeight,50);
	    $(window).resize(function () {
	        contentHeight();
	    });
	}
	function contentHeight(){
		var val = $(window).height();
		val = val - $('.navbar').outerHeight();
		val = val - $('.footer').outerHeight();
		val = val - $('.page-content').outerHeight();
		val = val + $('.page-content').height();
		$('.page-content').css('min-height',val);
	}

	var scrollTo = function(el, offeset){
        var pos = (el && el.size() > 0) ? el.offset().top : 0;

        if (el) {
            if ($('body').hasClass('page-header-fixed')) {
                pos = pos - $('.header').height();
            }
            pos = pos + (offeset ? offeset : -1 * el.height());
        }

        jQuery('html,body').animate({
            scrollTop: pos
        }, 'slow');
	}
	return {
		init:function(){
			initContentHeight();
		},
		scrollTo: scrollTo
	}
}();

