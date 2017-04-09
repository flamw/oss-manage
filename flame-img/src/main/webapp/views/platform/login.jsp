<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html>
<html class="index">
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="renderer" content="webkit">
  <title>车巴巴-专营店营销平台</title>
  	<link href="${ctx}/static/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/css/ace-fonts.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/css/ace.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/css/ace-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/static/css/ace-rtl.min.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="${ctx}/static/css/jquery-ui.min.css" />
	<style type="text/css">
	.help-bolck-red{
	color: #d16e6c;
	}
	</style>
	
</head>
	<body class="login-layout light-login">
		<div class="main-container">
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
						<div class="login-container">

							<div class="center">
								<h1>
<%-- 									<img src="${ctx}/static/images/chx/df_logo.png" width="35%"> --%>
									<span class="red">图片管理系统</span>
<!-- 									<span class="white" id="id-text2">运营平台</span> -->
								</h1>
								<!-- <h4 class="blue" id="id-company-text">&copy; 东风日产</h4> -->
							</div>

							<div class="space-6"></div>
							
							<div class="position-relative">
								<div id="login-box" class="login-box visible widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-coffee green"></i>
												账户登录
											</h4>

											<div class="space-6"></div>

											<form id="loginForm" method="post" action="${ctx}/login/userLogin">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="用户名"  name="userName" value="${username}"/>
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="密码"   autocomplete="off" id="password" onfocus="this.type='password'" name="password"/>
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>

													<div class="space"></div>
														<div class="space-4"></div>
													
<!-- 													<div class="alert-error input-form-control" -->
<!-- 													style="color: #F00"> -->
<!-- 													<a class="close" data-dismiss="alert"></a> -->
<%-- 													${message} --%>
<!-- 												  </div> -->
												<div class="clearfix">
														<button type="submit" class="width-35 pull-right btn btn-sm btn-primary"  id="login-button">
															<i class="ace-icon fa fa-key"></i>
															<span class="bigger-110">登录</span>
														</button>
														<a href="/login/forgetPassword">忘记密码</a>
													</div>

												</fieldset>
												<input type="hidden" id="operate-message" value="${message}">
												<input type="hidden" id="operate-flag" value="${operate-flag}">
											</form>
										</div><!-- /.widget-main -->
									</div><!-- /.widget-body -->
								</div><!-- /.login-box -->
							</div><!-- /.position-relative -->

							<div class="navbar-fixed-top align-right">
								<br />
								&nbsp;
								<a  href="/login/register">注册</a>
								&nbsp;
								<a id="btn-login-dark" href="#">Dark</a>
								&nbsp;
								<span class="blue">/</span>
								&nbsp;
								<a id="btn-login-blur" href="#">Blur</a>
								&nbsp;
								<span class="blue">/</span>
								&nbsp;
								<a id="btn-login-light" href="#">Light</a>
								&nbsp; &nbsp; &nbsp;
							</div>
						</div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.main-content -->
		</div>


<!-- list of script files -->
        <script type="text/javascript" src="${ctx}/static/js/jquery1x.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/ace-elements.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/ace.min.js"></script>
       <%-- <script type="text/javascript" src="${ctx}/static/js/chx/chx.js"></script> --%>
        <script type="text/javascript"  src="${ctx}/static/js/md5.js"></script>
        <script type="text/javascript"  src="${ctx}/static/js/jquery.validate.min.js"></script>
	<script src="${ctx}/static/js/jquery.dndc-alert.js"></script>


<script type="text/javascript">
if(!(document.cookie || navigator.cookieEnabled)){
	$('.j-tip').show(300);
}

//表单校验
function validateForm(){
	 $('#loginForm').validate(
				{
					errorElement : 'div',
					errorClass : 'help-bolck-red',
					focusInvalid : true,
					ignore : "",
					rules : {
							userName : {
								required : true,
								maxlength : 32
							},
							
							password : {
								maxlength : 16,
								minlength : 6,
								required :true
							}
							
					},

					messages : {
							userName : {
								required : "请输入用户名称！",
								maxlength : "用户名称长度不能大于{0}个字 符"
							},
							password : {
								required : "请输入密码!",
								maxlength : "密码长度不能大于{0}个字 符",
								minlength : "密码长度不能小于{0}个字 符",
								regexPwd  : "密码必须是字母、数字、符号的组合"
							}
							
					},

					highlight : function(e) {
						$(e).closest('.form-group').removeClass(
								'has-info').addClass('has-error');
					},

					success : function(e) {
						$(e).closest('.form-group').removeClass(
								'has-error');//.addClass('has-info');
						$(e).remove();
					},

					errorPlacement : function(error, element) {
						if (element.is('input[type=checkbox]')
								|| element.is('input[type=radio]')) {
							var controls = element
									.closest('div[class*="col-"]');
							if (controls.find(':checkbox,:radio').length > 1)
								controls.append(error);
							else
								error.insertAfter(element.nextAll(
										'.lbl:eq(0)').eq(0));
						} else if (element.is('.select2')) {
							error
									.insertAfter(element
											.siblings('[class*="select2-container"]:eq(0)'));
						} else if (element.is('.chosen-select')) {
							error
									.insertAfter(element
											.siblings('[class*="chosen-container"]:eq(0)'));
						} else
							error.insertAfter(element.parent());
					},

					submitHandler : function(form) {
						form.submit();
					},
					invalidHandler : function(form) {

					}
				});
	
	
}


$(document).ready(function() {
	validateForm();
	setTimeout(function(){
		$("#password").val('');
	},200)
	
	$("body").keydown(function(event) {
		if (event.keyCode == "13") {// keyCode=13是回车键
			validateForm();
		}
	});
	
	$("input").focus(function(){
		  $(".controls").hide();
		});
});


<!-- inline scripts related to this page -->
	jQuery(function($) {
	 $(document).on('click', '.toolbar a[data-target]', function(e) {
		e.preventDefault();
		var target = $(this).data('target');
		$('.widget-box.visible').removeClass('visible');//hide others
		$(target).addClass('visible');//show target
	 });
	});
	
	//you don't need this, just used for changing background
	jQuery(function($) {
	 $('#btn-login-dark').on('click', function(e) {
		$('body').attr('class', 'login-layout');
		$('#id-text2').attr('class', 'white');
		$('#id-company-text').attr('class', 'blue');
		
		e.preventDefault();
	 });
	 $('#btn-login-light').on('click', function(e) {
		$('body').attr('class', 'login-layout light-login');
		$('#id-text2').attr('class', 'grey');
		$('#id-company-text').attr('class', 'blue');
		
		e.preventDefault();
	 });
	 $('#btn-login-blur').on('click', function(e) {
		$('body').attr('class', 'login-layout blur-login');
		$('#id-text2').attr('class', 'white');
		$('#id-company-text').attr('class', 'light-blue');
		
		e.preventDefault();
	 });
	 
	});
</script>
<script>
      if ($('#operate-message').val() != null && $('#operate-message').val() != '') {
    	  if($('#operate-flag').val()=='0'){
    		  $.dndcAlert.fail({title:"",text:$('#operate-message').val(),remove_time:6000});
    	  }else{
	      	$.dndcAlert.success({title:"",text:$('#operate-message').val(),remove_time:4000});
    	  }
      	
      }
  </script>
</body>
</html>