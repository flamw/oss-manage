
$(function () {

// 加载模板
	  $('.m-head').load(contextPath+'/static/pub/head.jsp?ttime='+new Date().toLocaleTimeString(),function(){
	    Init(nav_id);
	  });
	if($('.j-datetime').datetimepicker){
		var now = new Date();
		var str = now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();
		$('.j-datetime').datetimepicker({
			language:'zh-CN',
			weekStart: 1, 
			todayBtn:1, 
			autoclose: 1, 
			todayHighlight: 1,
			startView: 2, 
			forceParse: 0,
			showMeridian: 1,
			'setStartDate': str
		});
	}
	// 初始化控件
	  var Init = function (nav_id) {
	    // 日期控件初始化
		if($('.datetimepicker').length>0)
			$('.datetimepicker').not('.j-datetime').datepicker({
			  format: "yyyy-mm-dd",
			  orientation: "top auto",
			  weekStart: 1,
			  autoclose: true,
			  todayHighlight: true,
			  language: 'zh-CN'
			});
	    // 提示控件
	    try{
	    $('[data-toggle="tooltip"]').tooltip();
	    }catch(e){}
	  }
	  
	  $('.m-sideNav').load(contextPath+'/static/pub/nav.jsp?v='+Math.random(),function(){
	    Init(nav_id);
	  });

	  
	  // 导航二级菜单
	  $('.m-sideNav').on('click', '>ul>li>a', function () {
	    $('.m-sideNav>ul li').not($(this).parent()).removeClass('active')
	    $(this).parent().toggleClass('active');
	  });

	  
});










