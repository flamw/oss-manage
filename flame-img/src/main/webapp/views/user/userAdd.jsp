<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%
	String ctxpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
	type="text/css">
<link rel="stylesheet"
	href="${ctx}/static/ztree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet" type="text/css"
	href="<%=ctxpath%>/static/css/select2.min.css">
	
</head>
<body class="no-skin">
	<div class="main-content" style="overflow: auto">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">

			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>
				<!-- 				<li class="active"><a href="#">系统设置</a></li> -->
				<li class="active"><a href="#">用户新增</a></li>
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

				<hr />
			</div>

			<form class="form-horizontal" id="userinfoForm" method="post"
				action="${ctx}/user/save">
				<input type="hidden" name="user_id" id="user_id"
					" value="${user.userId}">

				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">用户姓名:</label>
					<div class="clearfix  col-sm-6">
						<input type="text" name="userName" id="userName" size="50"
							value="${user.userName}" placeholder="请输入用户名称" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">角色:</label>
					<div class="clearfix  col-sm-6">
					<select id="roleId" name="roleId">
					  <c:forEach var="item" items="${roles }">
					  <option value="${itme.roleId}">${item.roleName}</option>
					  </c:forEach>
					</select>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">用户密码:</label>
					<div class="clearfix  col-sm-6">
						<input type="hidden" name="password" id="password"> 
						<input type="password" name="passwordInput" id="passwordInput" size="50"
							placeholder="请输入密码" />
					</div>
				</div>

				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">确认密码:</label>
					<div class="clearfix  col-sm-6">
						<input type="password" name="rePassword" id="rePassword" size="50"
							placeholder="请确认密码" />
					</div>
				</div>


				<div class="form-actions" align="center">
					<input type="submit" class="btn pull-center" value="保存"> <input
						type="button" class="btn pull-center"
						onclick="document.location='<%=ctxpath%>/user/'" value="返回">
				</div>
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
			var menus=[];
			menus.push({id:1,pid:'',text:'a'});
			menus.push({id:12,pid:1,text:'a1'});
			menus.push({id:13,pid:1,text:'a2'});
			menus.push({id:123,pid:12,text:'a11'});
			menus.push({id:2,pid:'',text:'bb'});
			menus.push({id:21,pid:2,text:'bb1'});
			var treePath='';
			var menuJson=formatMenu(menus);
// 			alert(JSON.stringify(menuJson));/*  */
			//加载角色树
// 			$('#cc').combotree('loadData',menuJson);/*  */
			saveForm();
		});
			
		function saveForm(){
			<%-- var formParam = $('#"userinfoForm"').serialize();
	        $.post('<%=ctxpath%>/platform/userinfo/create?'+formParam,
					function(data){
						alert(data.results);
						window.location.href="<%=ctxpath%>/platform/userinfo";
					}); --%>
			/* jQuery.validator.addMethod("regexPwd", function(value, element) {
				var regexPwd = /(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*.,;'"/?+=-]).{6,16}/;
				return this.optional(element) || (regexPwd.test(value));
			}, "密码必须是字母、数字、符号的组合"); */
			
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
								
								passwordInput : {
									maxlength : 16,
									minlength : 6,
// 									regexPwd : true,
									required :true
								},
								rePassword : {
									required : true,
									maxlength : 32,
									equalTo:"#passwordInput",
									minlength:6,
									required:true
								}
								
						},

						messages : {
								userName : {
									required : "请输入用户名称！",
									maxlength : "用户名称长度不能大于{0}个字 符"
								},
								passwordInput : {
									required : "请输入密码!",
									maxlength : "密码长度不能大于{0}个字 符",
									minlength : "密码长度不能小于{0}个字 符",
									regexPwd  : "密码必须是字母、数字、符号的组合"
								},
								rePassword : {
									required : "请确认密码！",
									maxlength : "密码长度不能大于{0}个字 符",
									minlength : "密码长度不能小于{0}个字 符",
									equalTo : "两次密码输入的不一致！"
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
							$("#password").val($("#passwordInput").val());
							form.submit();
						},
						invalidHandler : function(form) {

						}
					});
			}
			
	</script>
	
	
</body>
</html>

