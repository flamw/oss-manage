<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
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
	  <script type="text/javascript" src="${ctx}/static/js/jquery1x.min.js"></script>
         <script type="text/javascript" src="${ctx}/static/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/ace-elements.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/ace.min.js"></script>
        <script type="text/javascript"  src="${ctx}/static/js/md5.js"></script>
        <script type="text/javascript"  src="${ctx}/static/js/jquery.validate.min.js"></script>
	<script src="${ctx}/static/js/jquery.dndc-alert.js"></script>
	
</head>
<body class="no-skin">
	<div class="main-content" style="overflow: auto">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">

			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>
				<!-- 				<li class="active"><a href="#">系统设置</a></li> -->
				<li class="active"><a href="#">忘记密码</a></li>
			</ul>

		</div>
		<!-- /.breadcrumb -->
		<div class="page-content">
			<!-- setting box goes here if needed -->
			<div class="page-header"></div>
			<!-- /.page-header -->

			<!-- #section:plugins/fuelux.wizard -->
			<div id="fuelux-wizard-container">
				<!-- page content goes here -->

			</div>

			<form class="form-horizontal" id="userinfoForm" method="post"
				action="${ctx}/login/forgetPassword">
				<input type="hidden" name="userId" id="userId"
					" value="">
				<input type="hidden" name="roleId" id="oleId" value="2">

				<div class="form-group">
					<label class="control-label  col-sm-4 no-padding-right"
						for="roleName">用户姓名:</label>
					<div class="clearfix  col-sm-6">
						<input type="text" name="userName" id="userName" size="42"
							value="" placeholder="请输入用户名称" />
					</div>
				</div>

					
				  <div class="form-group">
					<label class="control-label  col-sm-4 no-padding-right"
						for="">问题1:</label>
					<div class="clearfix  col-sm-6">
					<select id="questionId1" name="questionId1" class="col-sm-6">
					<c:forEach var="item" items="${questions}">
					<c:if test="${item.question_type==1 }">
					
					<option value="${item.question_id }">${item.question_desc }</option>
					</c:if>
					</c:forEach>
					</select>
					</div>
				</div>
				  <div class="form-group">
					<label class="control-label  col-sm-4 no-padding-right"
						for="">答案:</label>
					<div class="clearfix  col-sm-6">
					<input type="text" name="answer1" id="answer1" size="42" />
					</div>
				</div>
				
				  <div class="form-group">
					<label class="control-label  col-sm-4 no-padding-right"
						for="">问题2:</label>
					<div class="clearfix  col-sm-6">
					<select id="questionId2" name="questionId2" class="col-sm-6">
					<c:forEach var="item" items="${questions}">
					<c:if test="${item.question_type==2 }">
					
					<option value="${item.question_id }">${item.question_desc }</option>
					</c:if>
					</c:forEach>
					</select>
					</div>
				</div>
				  <div class="form-group">
					<label class="control-label  col-sm-4 no-padding-right"
						for="">答案:</label>
					<div class="clearfix  col-sm-6">
					<input type="text" name="answer2" id="answer2" size="42" />
					</div>
				</div>
				
				  <div class="form-group">
					<label class="control-label  col-sm-4 no-padding-right"
						for="">问题3:</label>
					<div class="clearfix  col-sm-6">
					<select id="questionId3" name="questionId3" class="col-sm-6">
					<c:forEach var="item" items="${questions}">
					<c:if test="${item.question_type==3 }">
					
					<option value="${item.question_id }">${item.question_desc }</option>
					</c:if>
					</c:forEach>
					</select>
					</div>
				</div>
				  <div class="form-group">
					<label class="control-label  col-sm-4 no-padding-right"
						for="">答案:</label>
					<div class="clearfix  col-sm-6">
					<input type="text" name="answer3" id="answer3" size="42" />
					</div>
				</div>
				
				

				<div class="form-actions" align="center">
					<input type="submit" class="btn pull-center" value="提交"> <input
						type="button" class="btn pull-center"
						onclick="document.location='${ctx}/login/'" value="返回">
				</div>
				<input type="hidden" id="operate-message" value="${message}">
				<input type="hidden" id="operate-flag" value="${operate-flag}">
			</form>
			<!-- PAGE CONTENT ENDS -->

		</div>
		<!-- /.page-content -->
	</div>
	<!-- /.main-content -->


	<!-- inline scripts related to this page -->
	<script type="text/javascript" src="${ctx}/static/js/md5.js"></script>
	<script type="text/javascript">
		jQuery(function($) {
			saveForm();
		});
			
		function saveForm(){
			$('#userinfoForm').validate(
					{
						errorElement : 'div',
						errorClass : 'help-block',
						focusInvalid : true,
						ignore : "",
						rules : {
								userName : {
									required : true,
									maxlength : 32
								},
								
								answer1 : {
									required : true
								},
								answer2 : {
									required : true
								},
								answer3 : {
									required:true
								}
								
						},

						messages : {
								userName : {
									required : "请输入用户名称！",
									maxlength : "用户名称长度不能大于{0}个字 符"
								},
								answer1 : {
									required:"请输入答案！"
								},
								answer2 : {
									required:"请输入答案！"
								},
								answer3 : {
									required:"请输入答案！"
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
// 							var hash = b64_md5($("#password").val());			
// 							$("#password").val("{MD5}"+hash+"==");
							var formParam = $('#userinfoForm').serialize();
							form.submit();
						},
						invalidHandler : function(form) {

						}
					});
			}
			
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

