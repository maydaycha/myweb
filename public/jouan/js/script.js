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


/*call tab in same page*/
$("a[data-tab-destination]").on('click', function() {
        var tab = $(this).attr('data-tab-destination');
        $("#"+tab).click();
    });


 //grabs the hash tag from the url
  var hash = window.location.hash;
  //checks whether or not the hash tag is set
  if (hash != "") {
    //removes all active classes from tabs
    $('#myTab li').each(function() {
      $(this).removeClass('active');
    });
    $('#myTabContent div').each(function() {
      $(this).removeClass('active');
    });
    //this will add the active class on the hashtagged value
    var link = "";
    $('#myTab li').each(function() {
      link = $(this).find('a').attr('href');
      if (link == hash) {
        $(this).addClass('active');
      }
    });
    $('#myTabContent div').each(function() {
      link = $(this).attr('id');
      if ('#'+link == hash) {
        $(this).addClass('active');
      }
    });
  }