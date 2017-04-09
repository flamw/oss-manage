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
				<li class="active"><a href="#">新增功能</a></li>
			</ul>

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

			<form class="form-horizontal" id="functionForm">
				
				<input type="hidden"  name="id" id="id" value="${function.id}">
				<input type="hidden"  name="funcType" id="funcType" value="${function.functionType}">
				<input type="hidden"  name="action" id="action" value="${action}">
				
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleState">类型:</label>
					<div class="clearfix  col-sm-6">
						<input type="radio" name="functionType"  value="MENU" size="50"/>菜单
						<input type="radio" name="functionType"  value="FUNCTION"  size="50"/>功能
						<input type="radio" name="functionType"  value="SHIRO"  size="50"/>权限
					</div>
				</div>
				
				<div class="form-group" id="parentDiv">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">父类菜单功能:</label>
					<div class="clearfix  col-sm-6">
						<input type="hidden" name="parentId" id="parentId" size="50" value="${function.parentId}"/>
						<input type="text" name="parentName" id="parentName" size="50" value="${parentName}" disabled="disabled"/>
						<!-- 临时变量 -->
						<input type="hidden" name="tempParentId" id="tempParentId" size="50" value=""/>
						<input type="hidden" name="tempParentName" id="tempParentName" size="50" value=""/>
						<button type="button" class="btn btn-sm btn-primary" id="btn-select-parent">
							<i class="ace-icon fa fa-search"></i> 选择
						</button>
					</div>
					
				</div>
				
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">菜单功能编码:</label>
					<div class="clearfix  col-sm-6">
						<input type="text" name="functionCode" id="functionCode" size="50" value="${function.functionCode}"/>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">菜单功能名称:</label>
					<div class="clearfix  col-sm-6">
						<input type="text" name="functionName" id="functionName" size="50" value="${function.functionName}"/>
					</div>
				</div>
				
				
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName"> 访问Link:</label>
					<div class="clearfix  col-sm-6">
						<input type="text" name="pageLink" id="pageLink" size="50" value="${function.pageLink}"/>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName"> 权限Link:</label>
					<div class="clearfix  col-sm-6">
						<input type="text" name="authcLink" id="authcLink" size="50" value="${function.authcLink}"/>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">排序:</label>
					<div class="clearfix  col-sm-6">
						<input type="text" name="ordering" id="ordering" size="50" value="${function.ordering}"/>
					</div>
				</div>
				
				<div class="form-actions" align="center">
					<input type="submit" class="btn pull-center"   value="保存"/>
					<input type="button" class="btn pull-center" onclick="document.location='<%=ctxpath%>/platform/func'" value="返回">
				</div>
			</form>
			<!-- PAGE CONTENT ENDS -->

		</div>
		<!-- /.page-content -->
	</div>
	<!-- /.main-content -->
	
	<div id="dialog-addattr" class="hide">
          <div class="form-group">
              <ul class="ztree" id="parentFunc"></ul>
		  </div>
        </div>

 	<script src="<%=ctxpath%>/static/js/jquery-ui.min.js"></script>
    <script src="<%=ctxpath%>/static/js/jquery-ui.custom.min.js"></script>
	<script src="<%=ctxpath%>/static/js/jquery.ui.touch-punch.min.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		jQuery(function($) {
			
			var type = $('#funcType').val();
			if(type == 'FUNCTION'){
				$("input[name=functionType]:eq(1)").attr("checked",'checked'); 
			}else if(type == 'SHIRO'){
				$("input[name=functionType]:eq(2)").attr("checked",'checked'); 
				$("#parentDiv").hide();
			}else{
				$("input[name=functionType]:eq(0)").attr("checked",'checked'); 
			}
			
			$('input:radio').click(function(){
				var type = $('input:radio[name="functionType"]:checked').val();
				if(type == "SHIRO" ){
					$("#parentDiv").hide();
				}else{
					$("#parentDiv").show();
				}
			});
			
			
			/* var roleId = $("#roleId").val();
			queryMenus(roleId); */
			
			validateForm();
		});
		
		<%-- function queryMenus(roleId){
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
					});
		}
		 --%>
		
		//隐藏对话框
		$( "#btn-select-parent" ).on('click', function(e) {
			
			e.preventDefault();
			var ids=$('#grid-table').jqGrid('getGridParam','selarrrow');
			var functionType = $("input[name=functionType]:checked").val();
			var dialog = $( "#dialog-addattr" ).removeClass('hide').dialog({
				modal: true,
				title: "选择父类菜单",
				title_html: true,
				width:500,
				height:300,
				buttons: [ 
           			{
                   		text: "确定",
						"class" : "btn btn-primary btn-minier",
						click: function() {
							$("#parentId").val($("#tempParentId").val());
							$("#parentName").val($("#tempParentName").val());
		       				$( this ).dialog( "close" ); 	
						} 
					},
                    {
						text: "取消",
						"class" : "btn btn-white btn-default btn-round",
						click: function() {
							$( this ).dialog( "close" ); 
						} 
					}
					
				]
			});
			
			var setting = {
					data: {
						simpleData: {
							enable: true
						}
					},
					callback: { 
				        onClick: treenodeClick 
				    } 
				};
			
			$.ajax({
				type:"post",
				url:"<%=ctxpath%>/public/platform/func/getFuncListByType",
				data:{"functionType":functionType},
				dataType:'json',
				success:function(data){
					var zNodes = data.results;
					$.fn.zTree.init($("#parentFunc"), setting, zNodes);
					}	
			});
			
			function treenodeClick(event, treeId, treeNode, clickFlag) { 
			    //此处treeNode 为当前节点 
			     var id = treeNode.id; 
			     var name = treeNode.name; 
			     var state  = treeNode.disabled;
			    /*  if(treeNode.isParent){
			         str = getAllChildrenNodes(treeNode,str);
			     }else{
			         str=treeNode.id;
			     } */
			     
			     if(state){
			    	 alert("该节点不可选择，菜单选择一级或二级，功能选择三级");
			    	 $("#tempParentId").val("");
			    	 $("#tempParentId").val("");
			     }else{
			    	 $("#tempParentId").val(id);
				     $("#tempParentName").val(name);
			     }
			    
			}
	
		});
		
		
		function validateForm(){
			
			jQuery.validator.addMethod("regexCode", function(value, element) {
				var regexCode = /^[a-zA-Z][a-zA-Z0-9_:,]*$/;
				return this.optional(element) || (regexCode.test(value));
			}, "以英文字母开头，只含有英文字母、数字、下划线和冒号。");
			
			
			$('#functionForm').validate(
					{
						errorElement : 'div',
						errorClass : 'help-block',
						focusInvalid : true,
						ignore : "",
						rules : {
							parentId : {
								required :function(){
									return ($('input:radio[name="functionType"]:checked').val() != 'SHIRO')
								}
								},
							functionCode : {
									required : true,
									maxlength : 60,
									regexCode : true
								},
							functionName : {
									required : true,
									maxlength : 60
								},
							pageLink : {
									maxlength : 120,
									required:true
								},
							ordering : {
									required : true,
									digits:true,
									max:999,
									min:-1
									
									
								}
						},

						messages : {
							parentId : {
								required : "请选择父类菜单！",
							},
							functionCode : {
									required : "请输入菜单功能编码！",
									maxlength : "菜单功能编码长度不能大于{0}个字 符",
									regexCode : "菜单功能编码以英文字母开头，只含有英文字母、数字和下划线。"
								},
							functionName : {
									required : "请输入菜单功能名称！",
									maxlength : "菜单功能名称长度不能大于{0}个字 符"
								},
							pageLink : {
									required : "请输入路径!",
									maxlength : "路径长度不能大于{0}个字 符"
								},
							ordering : {
									required : "请输入排序值！",
									digits : "排序值必须是整数！",
									max : "排序值不能大于{0}",
									min : "排序值不能小于{0}"
									
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
							 var formParam = $('#functionForm').serialize();
								$.post('<%=ctxpath%>/platform/func/create?'+formParam,
										function(data){
											var message = false;
											if(data.retnCode == 0){
												message = true;
											}else if(data.retnCode == 1){
												message = exist;
											}
											window.location.href="<%=ctxpath%>/platform/func?message="+message;
								},'json');
						},
						invalidHandler : function(form) {

						}
					});
		}

	</script>
</body>
</html>