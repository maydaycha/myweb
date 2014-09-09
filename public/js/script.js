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

function constrain_Eng_and_num(e) {
    var keynum, keychar, check
     // IE
    if(window.event) {
        keynum = e.keyCode
    } else if(e.which) {  // Netscape/Firefox/Opera
        keynum = e.which
    }
    if( keynum == 8 || keynum == 9 || keynum == 13 || keynum == 189 || keynum == 229) return true
    keychar = String.fromCharCode(keynum)
    check = /\w/
    check_digital = /[0-9]/
    return check.test(keychar) && !check_digital.test(keychar)
}