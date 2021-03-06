var Index = function(){
	var initSwiper = function(){
		var mySwiper = new Swiper('.swiper-1 .swiper-container',{
			onlyExternal : true,
			loop:true,
			paginationClickable: true,
			speed:500,
		})
		$('.swiper-1 .arrow-left').on('click', function(e){
			e.preventDefault()
			mySwiper.swipePrev()
		})
		$('.swiper-1 .arrow-right').on('click', function(e){
			e.preventDefault()
			mySwiper.swipeNext()
		})
		if(getIEVersion()>5){
			onTime();
		}
		function onTime(){
			var ontimeValue = $('.swiper-1 .swiper-slide .content-slide').width()/2;
			$('.swiper-1 .swiper-slide .content-slide img').css('left',ontimeValue+'px')
			setTimeout(onTime,100);
		}
	}
	function getIEVersion()
	{
		var rv = -1;
		if (navigator.appName == 'Microsoft Internet Explorer')
		{
			var ua = navigator.userAgent;
			var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
			if (re.exec(ua) != null)
				rv = parseFloat( RegExp.$1 );
		}
		else if (navigator.appName == 'Netscape')
		{
			var ua = navigator.userAgent;
			var re  = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");  //for IE 11
			if (re.exec(ua) != null)
				rv = parseFloat( RegExp.$1 );
		}
		return rv;
	}
	var worksSwiper1;
	var worksSwiper2;
	var initWork1 = function(){
		worksSwiper1 = new Swiper('#work1 .swiper-container',{
			speed:500,
			loop:true,
		})
		$("#work1 .tabs a").on('touchstart mousedown',function(e){
			e.preventDefault()
			$("#work1 .tabs .active").removeClass('active')
			$(this).addClass('active')
			worksSwiper1.swipeTo( $(this).parent().index()/2 )
		})
		$("#work1 .tabs a").click(function(e){
			e.preventDefault()
		})
		$('#work1 .arrow-left').on('click', function(e){
			e.preventDefault()
			worksSwiper1.swipePrev()

		})
		$('#work1 .arrow-right').on('click', function(e){
			e.preventDefault()
			worksSwiper1.swipeNext()
		})
	}
	var initWork2 = function(){
		worksSwiper2 = new Swiper('#work2 .swiper-container',{
			onlyExternal : true,
			speed:500,
			loop:true,
		})
		$("#work2 .tabs a").on('touchstart mousedown',function(e){
			e.preventDefault()
			$("#work2 .tabs .active").removeClass('active')
			$(this).addClass('active')
			worksSwiper2.swipeTo( $(this).parent().index()/2 )
		})
		$("#work2 .tabs a").click(function(e){
			e.preventDefault()
		})
		$('#work2 .arrow-left').on('click', function(e){
			e.preventDefault()
			worksSwiper2.swipePrev()
		})
		$('#work2 .arrow-right').on('click', function(e){
			e.preventDefault()
			worksSwiper2.swipeNext()
		})
		$('#work2').removeClass('active');
		$('.works>ul.nav-tabs>li>a').on('touchstart mousedown',function(e){
			$('#work1,#work2').removeClass('active');
			$($(this).attr('href')).addClass('active');
			worksSwiperShow();
		})
	}
	var worksSwiperShow = function(){
		worksSwiper1.resizeFix();
		worksSwiper2.resizeFix();
	}
	return {
		init:function(){
			initSwiper();
			initWork1();
			initWork2();
		}
	}
}();

