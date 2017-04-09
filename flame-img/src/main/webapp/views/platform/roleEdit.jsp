<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%
	String ctxpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" href="${ctx}/static/ztree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="${ctx}/static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>

<body class="no-skin">
	<div class="main-content" style="overflow:auto">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">

			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>
				<li class="active"><a href="#">系统设置</a></li>
				<li class="active"><a href="#">新增角色</a></li>
			</ul>

			<!-- #section:basics/content.searchbox -->
			<div class="nav-search" id="nav-search">
				<form class="form-search">
					<span class="input-icon"> 
					<input type="text" placeholder="Search ..." class="nav-search-input"
						id="nav-search-input" autocomplete="off" /> 
						<i class="ace-icon fa fa-search nav-search-icon"></i>
					</span>
				</form>
			</div>
			<!-- /.nav-search -->

		</div>
		<!-- /.breadcrumb -->
		<div class="page-content">
			<!-- setting box goes here if needed -->
			<div class="page-header">
			</div>
			<!-- /.page-header -->

			<!-- #section:plugins/fuelux.wizard -->
			<div id="fuelux-wizard-container">
				<!-- page content goes here -->

				<hr />
			</div>

			<form class="form-horizontal" id="roleForm">
				
				<input  type="hidden" name="roleId" id="roleId" value="${role.id}"/>
				<input  type="hidden" name="roleState" id="roleState" value="ENABLED"/>
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">角色编码:</label>
					<div class="clearfix  col-sm-6">
						<input type="text" name="roleCode" id="roleCode" size="50" value="${role.roleCode}"/>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">角色名称:</label>
					<div class="clearfix  col-sm-6">
						<input type="text" name="roleName" id="roleName" size="50" value="${role.roleName}"/>
					</div>
				</div>

				<!-- <div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleState">状态:</label>
					<div class="clearfix  col-sm-6">
						<input type="radio" name="state" id="state" value="ENABLED" size="50"/>激活
						<input type="radio" name="state" id="state" value="DISABLED"  size="50"/>冻结
					</div>
				</div> -->
				
				<div class="form-group" >
					<ul  id="menusList" class="ztree"></ul>
					
				</div>
				
				<div class="form-actions" align="center">
					<!-- <input type="button" class="btn pull-center" onclick="saveForm()" value="保存">  -->
					 <input type="submit" class="btn pull-center"  value="保存">
					<input type="button" class="btn pull-center" onclick="document.location='<%=ctxpath%>/platform/role'" value="返回">
				</div>
			</form>

			<!-- PAGE CONTENT ENDS -->

		</div>
		<!-- /.page-content -->
	</div>
	<!-- /.main-content -->


	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		jQuery(function($) {
			
			validateForm();
			
			/* var state = $('#roleState').val();
			if(state == 'DISABLED'){
				$("input[name=state]:eq(1)").attr("checked",'checked'); 
			}else{
				$("input[name=state]:eq(0)").attr("checked",'checked'); 
			}
			 */
			
			var roleId = $("#roleId").val();
			queryMenus(roleId);
			
			
		});
		
		function queryMenus(roleId){
			var setting = {
					check:{
						enable: true
					},
					data: {
						simpleData: {
							enable: true
						}
					}
				};
			$.post('<%=ctxpath%>/public/platform/getMenusList',
					{'roleId':roleId},
					function(data){
						  var zNodes = data.results;    
						$.fn.zTree.init($("#menusList"), setting, zNodes);
					},'json');
		}
		
		
		
		function validateForm(){
			
		 	jQuery.validator.addMethod("regexCode", function(value, element) {
				var regexCode = /^[a-zA-Z][a-zA-Z0-9_]*$/; 
				//var regexCode = /^[a-zA-Z][0-9a-zA-Z_]{1,}$/;
				return this.optional(element) || (regexCode.test(value));
			}, "以英文字母开头，只含有英文字母、数字和下划线。");
			 
			$('#roleForm').validate(
				{
						errorElement : 'div',
						errorClass : 'help-block',
						focusInvalid : true,
						ignore : "",
						
						rules : {
							roleCode : {
									required : true,
									maxlength : 60,
									regexCode : true
								},
							roleName : {
									required : true,
									maxlength : 60
								}
						},

						messages : {
							roleCode : {
									required : "请输入角色编码！",
									maxlength : "角色编码长度不能大于{0}个字 符",
									regexCode : "角色编码以英文字母开头，只含有英文字母、数字和下划线。"
								},
							roleName : {
									required : "请输入角色名称！",
									maxlength : "角色名称长度不能大于{0}个字 符"
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
							var treeObject = $.fn.zTree.getZTreeObj("menusList");
							var nodes = treeObject.getCheckedNodes(true);
							var msg = "name--id--pid\n";
							var funcIds = new Array();
					        for (var i = 0; i < nodes.length; i++) {
					            msg += nodes[i].name+"--"+nodes[i].id+"--"+nodes[i].pId+"\n";
					            funcIds.push(nodes[i].id);
					        }
					        var defaultNode = treeObject.getNodeByParam("code","workbench",null);
					        funcIds.push(defaultNode.id);
					        
					        $.post('<%=ctxpath%>/platform/role/create',
									{'funcIds':funcIds,'id':$('#roleId').val(),
					        		 'state':$("#roleState").val(),
					        		 'roleCode':$("#roleCode").val(),
					        		 'roleName':$("#roleName").val()},
									function(data){
										var message = "true";
										if(data.retnCode == "999"){
											message = "false";
										}else if(data.retnCode == "102"){
											message = "exist";
										}
										window.location.href="<%=ctxpath%>/platform/role?message="+message;
									},'json');
						},
						invalidHandler : function(form) {
						}
					});
		}
	</script>
</body>
</html>