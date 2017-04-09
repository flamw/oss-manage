<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html>
<html lang="cn">
<head>
<title>flame</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />

<meta name="description" content="overview &amp; stats" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="${ctx}/static/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/static/css/font-awesome.min.css" />

<!-- page specific plugin styles -->
<link rel="stylesheet" href="${ctx}/static/css/jquery-ui.min.css" />
<link rel="stylesheet"
	href="${ctx}/static/css/bootstrap-datepicker3.min.css" />
<link rel="stylesheet" href="${ctx}/static/css/ui.jqgrid.min.css" />
<link rel="stylesheet" href="${ctx}/static/css/custom.css" />

<!-- text fonts -->
<link rel="stylesheet" href="${ctx}/static/css/ace-fonts.min.css" />

<!-- ace styles -->
<link rel="stylesheet" href="${ctx}/static/css/ace.min.css"
	class="ace-main-stylesheet" id="main-ace-style" />

<!--[if lte IE 9]>
			<link rel="stylesheet" href="${ctx}/static/css/ace-part2.min.css" class="ace-main-stylesheet" />
		<![endif]-->

<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${ctx}/static/css/ace-ie.min.css" />
		<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->
<script src="${ctx}/static/js/ace-extra.min.js"></script>

<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

<!--[if lte IE 8]>
		<script src="${ctx}/static/js/html5shiv.min.js"></script>
		<script src="${ctx}/static/js/respond.min.js"></script>
		<![endif]-->
		
<sitemesh:write property='head' />


<!-- list of script files -->
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/js/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/js/ace-elements.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ace.min.js"></script>
<script src="${ctx}/static/js/ace-extra.min.js"></script>

<script src="${ctx}/static/js/jqGrid/jquery.jqGrid.js"></script>
<script src="${ctx}/static/js/jqGrid/i18n/grid.locale-cn.js"></script>
<script src="${ctx}/static/js/jquery-ui.min.js"></script>
<script src="${ctx}/static/js/jquery-ui.custom.min.js"></script>
<script src="${ctx}/static/js/jquery.ui.touch-punch.min.js"></script>
<script type="text/javascript" src="${ctx}/static/ztree/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ctx}/static/ztree/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="${ctx}/static/ztree/formatTree.js"></script>
<script src="${ctx}/static/js/jquery.dndc-alert.js"></script>
<script src="${ctx}/static/js/select2.min.js"></script>
<script src="${ctx}/static/js/jquery.tmpl.js"></script>
<script src="${ctx}/static/js/jquery.dndc-alert.js"></script>
<script src="${ctx}/static/js/common/dateutil.js"></script>
<script src="${ctx}/static/js/common/dateutil.js"></script>
<script type="text/javascript" src="${ctx}/static/js/common/delete.js"></script>
<style  type="text/css">
/* jqgrid表头居中 */
.ui-jqgrid .ui-jqgrid-labels th{
text-align: center!important;
}
</style>
<script type="text/javascript">

// 公共js变量

var  ctx='${ctx}';
var  userId='${user.userId}';


//     jqgrid公共js
	//对话框标题
	$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
		_title : function(title) {
			var $title = this.options.title || '&nbsp;'
			if (("title_html" in this.options)
					&& this.options.title_html == true)
				title.html($title);
			else
				title.text($title);
		}
	}));

	$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
	//replace icons with FontAwesome icons like above
	function updatePagerIcons(table) {
		var replacement = {
			'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
			'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
			'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
			'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
		};
		$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon')
				.each(
						function() {
							var icon = $(this);
							var $class = $.trim(icon.attr('class').replace(
									'ui-icon', ''));
							if ($class in replacement)
								icon.attr('class', 'ui-icon '
										+ replacement[$class]);
						})
	}
	function enableTooltips(table) {
		$('.navtable .ui-pg-button').tooltip({
			container : 'body'
		});
		$(table).find('.ui-pg-div').tooltip({
			container : 'body'
		});
	}
	
	
	$.extend($.validator.messages, {
	    required: "必选字段",
	    remote: "请修正该字段",
	    email: "请输入正确格式的电子邮件",
	    url: "请输入合法的网址",
	    date: "请输入合法的日期",
	    dateISO: "请输入合法的日期 (ISO).",
	    number: "请输入合法的数字",
	    digits: "只能输入整数",
	    creditcard: "请输入合法的信用卡号",
	    equalTo: "请再次输入相同的值",
	    accept: "请输入拥有合法后缀名的字符串",
	    maxlength: $.validator.format("请输入一个长度最多是 {0} 的字符串"),
	    minlength: $.validator.format("请输入一个长度最少是 {0} 的字符串"),
	    rangelength: $.validator.format("请输入一个长度介于 {0} 和 {1} 之间的字符串"),
	    range: $.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
	    max: $.validator.format("请输入一个最大为 {0} 的值"),
	    min: $.validator.format("请输入一个最小为 {0} 的值")
	});
	
	/* $(function(){
// 		$("#sidebar").find("a:first").trigger("click");
        var userId='${user.userId}';
		$.get("http://localhost:3001/?userId=${user.userId}"+userId);
// 		alert($("#sidebar").find("a:first").html());
	}); */

</script>
</head>

<body class="no-skin">
	<div class="navbar" id="navbar">
		<!-- navbar goes here -->
		<%@ include file="/common/navibar.jsp"%>
	</div>

	<div class="main-container" id="main-container">
		<!-- menu area -->
		<%@ include file="/common/menu.jsp"%>
		<!-- body area -->
		<sitemesh:write property='body'/>
		<!-- 中间内容页面  -->
			<!-- footer area -->
		<%@ include file="/common/footer.jsp"%>
	</div>
	<!-- /.main-container -->

<script type="text/javascript"></script>
</body>
</html>