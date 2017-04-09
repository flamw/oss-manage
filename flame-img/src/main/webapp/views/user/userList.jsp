<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%
	String ctxpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="cn">
<head>
</head>

<body class="no-skin">

	<div class="main-content">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<!-- /.breadcrumb -->
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>
<!-- 				<li class="active"><a href="#">系统设置</a></li> -->
				<li class="active"><a href="#">用户管理</a></li>
			</ul>

			<!-- #section:basics/content.searchbox -->
			<div class="nav-search" id="nav-search">
				<form class="form-search">
					<span class="input-icon"> <input type="text"
						placeholder="Search ..." class="nav-search-input"
						id="nav-search-input" autocomplete="off" /> <i
						class="ace-icon fa fa-search nav-search-icon"></i>
					</span>
					<input type="hidden" id="operate-message" value="${message}">
					<input type="hidden" id="operate-flag" value="${operate-flag}">
				</form>
			</div>
			<!-- /.nav-search -->

		</div>


		<div class="page-content">
			<!-- setting box goes here if needed -->
			<div class="hr"></div>
		</div>
		<!-- /.col -->

		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->
<!-- 			<button type="button" class="btn btn-sm btn-primary" -->
<%-- 				onclick="document.location='${ctx}/user/add'"> --%>
<!-- 				<i class="ace-icon glyphicon glyphicon-plus"></i> 新增 -->
<!-- 			</button> -->
			<!-- <button id="id-btn-addattr" type="button" class="btn btn-sm btn-primary" >
						<i class="ace-icon glyphicon glyphicon-edit"></i> 编辑
					</button>

					<button type="button" class="btn btn-sm btn-primary"
						onclick="del()">
						<i class="ace-icon glyphicon glyphicon-minus"></i> 删除
					</button> -->
			<table id="grid-table"></table>

			<div id="grid-pager"></div>

			<!-- PAGE CONTENT ENDS -->
		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->


	</div>
	<!-- /.page-content -->
	</div>
	<!-- /.main-content -->

	<!-- PAGE CONTENT ENDS -->
	<!-- </div> -->
	<!-- /.col -->
	<!-- </div> -->
	<!-- /.row -->
	<!-- </div> -->
	<!-- /.page-content -->
	<!-- </div> -->
	<!-- /.main-content -->

	<!--不能删除弹框  -->
	<div id="deletenot" class="hide"></div>
	<!-- 删除弹框的div -->
	<div id="deleted" class="hide">
		<div>
			删除效验码： <input id="J-input-code" type="text" value="" />
		</div>
		<div>
			效验码： <span id="J-codeText" style="margin-left: 25px;"></span> <span
				id="J-clipContainer">
				<button id="J-yzmCodeBtn" type="button" onclick="yzmCodeBtn()"
					data-flag='true'>复制此效验码</button>
			</span>
		</div>
	</div>

	<script type="text/javascript">
							
		function del(id){
			var ids=$('#grid-table').jqGrid('getGridParam','selarrrow');
	      	if(ids.length>0 || id != null){
	      		
				$.ajax({
					  type:"get",
					  url:"<%=ctxpath%>/cms/catatype/delete",
					  data:{"ids":ids.join(","),"id":id},
					  success: function() {
						  alert("删除成功！")
						  //window.location.reload()
						  jQuery("#grid-table").trigger("reloadGrid"); 
					  }
				});
	      	}else{
	      		alert("请勾选需要删除的数据！");
	      	}
		}
	
		
		jQuery(function($) {
			var grid_selector = "#grid-table";
			var pager_selector = "#grid-pager";
											
			var parent_column = $(grid_selector).closest('[class*="col-"]');
			//对话框标题
				$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
					_title: function(title) {
						var $title = this.options.title || '&nbsp;'
						if( ("title_html" in this.options) && this.options.title_html == true )
							title.html($title);
						else title.text($title);
					}
				}));
			//resize to fit page size
			$(window).on('resize.jqGrid', function () {
			    $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
			})
						
			jQuery(grid_selector).jqGrid({
					//direction: "rtl",
					ajaxGridOptions: { contentType: 'application/json; charset=UTF-8' },
					url:'<%=ctxpath%>/user/list',
					datatype : "json",
					height : 370,
					colNames : [  '用户ID', '用户姓名','角色','创建时间', '操作' ],
					colModel : [
					{
						name : 'userId',
						index : 'userId',
						key : true,
						width : 60,
						sortable : false,
						editable : true,
						hidden:true,
						align : 'center'
					}
					, {
						name : 'userName',
						index : 'userName',
						width : 100,
						sortable : false,
						editable : true,
						align : 'center'
					}
					, {
						name : 'roleName',
						index : 'roleName',
						width : 120,
						sortable : false,
						editable : true,
						align : 'center'
					}
					, {
						name : 'ctime',
						index : 'ctime',
						width : 120,
						sortable : false,
						editable : true,
						formatter:formatDateHHMMSS,
						align : 'center'
					}
					, {
						name : 'oper',
						index : 'oper',
						width : 160,
						fixed : true,
						sortable : false,
						align : 'center'
					} ],
	
					viewrecords : true,
					rowNum : 10,
					rownumbers:true,
					//rowList:[10,20,30],
					pager : pager_selector,
					onPaging : function(first, last, prev, next) {
						
					},
					altRows : true,
					//toppager: true,
					
					//multiselect : true,
					//multikey: "ctrlKey",
					//multiboxonly : true,
	
					loadComplete : function() {
						var table = this;
						setTimeout(function() {
							updatePagerIcons(table);
							enableTooltips(table);
						}, 0);
					},
	
					gridComplete : function() {
						var ids = jQuery("#grid-table").jqGrid('getDataIDs');
						for (var i = 0; i < ids.length; i++) {
							var id = ids[i];
							var rowData = $("#grid-table").getRowData(id);
							var editBtn = "<a href='#' style='color:#f60' onclick='_edit(\""+ id+ "\")' >编辑</a>&nbsp;&nbsp;";
								editBtn  += "<a href='#' style='color:#f60' onclick='_delete(\""+ id + "\")' >删除</a>";
							
							if(rowData.userType == 1){
								editBtn = "";
							}
							jQuery("#grid-table").jqGrid('setRowData', ids[i], {oper : editBtn});
						}
	
					},
	
					// 读取返回的数据格式
					jsonReader : {
						repeatitems : true,
						root : "results.datas", // 返回的具体的数据的数组
						row : "results.size", // 返回的行数
						//page:"pageCurrNum", // 当前的页数
						total : "results.pages", // 返回的总页数 
						records : "results.total", // 返回的总记录条数 
						repeatitems : true,
					    // id: "tsortMark"
					},
	
					editurl : "/dummy.html",
					caption : ""
	
			});
		
			$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

			//replace icons with FontAwesome icons like above
			function updatePagerIcons(table) {
				var replacement = {
					'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
					'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
					'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
					'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
				};
				$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(
						function() {
							var icon = $(this);
							var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
							if ($class in replacement)icon.attr('class', 'ui-icon '
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

			
			//var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

			$(document).one('ajaxloadstart.page', function(e) {
				$.jgrid.gridDestroy(grid_selector);
				$('.ui-jqdialog').remove();
			});
		});
		
		
		//search
		function search(){
			var formParam = $('#userInfoSearchForm').serialize();
			if(formParam){
				var url = "${ctx}/platform/userinfo/list";
				 url += '?'+formParam;
				$("#grid-table").jqGrid('setGridParam',{ 
	            url:url,
	            /* postData:{'userId':propertyvalue}, //发送数据  */
	            page:1
	        }).trigger("reloadGrid"); //重新载入 
			} else{
				$("#grid-table").jqGrid('setGridParam',{ 
		            url:"${ctx}/platform/userinfo/list", 
		            page:1
		        }).trigger("reloadGrid"); //重新载入 
	        }
		}
		//delete
		/* function del(id){
			var ids=$('#grid-table').jqGrid('getGridParam','selarrrow');
	      	if(id != null){
	      		
				$.ajax({
					  type:"get",
					  url:"${ctx}/platform/userinfo/delete/"+id,
					  //data:{"id":id},
					  success: function() {
						  //alert("删除成功！")
						  $.dndcAlert.success({title:"删除成功",text:"对象删除成功",remove_time:4000});
						  //window.location.reload()
						  jQuery("#grid-table").trigger("reloadGrid"); 
					  },
					 error: function(XMLHttpRequest, textStatus, errorThrown){
						 $.dndcAlert.fail({title:"删除失败",text:"对象删除失败",remove_time:4000});
						 jQuery("#grid-table").trigger("reloadGrid");
					 }
				});
	      	}else{
	      		alert("请勾选需要删除的数据！");
	      	}
		} */
		
		//编辑
		function _edit(id){
			window.location.href = "<%=ctxpath%>/user/edit/"+id;
		}
		
		
	    
		function _delete(id){
			<%-- if(confirm("确认删除该条数据？")){
				$.ajax({
					  type:"get",
					  dataType:'json',
					  url:"<%=ctxpath%>/platform/userinfo/delete/"+id,
					  //data:{"id":id},
					  success: function(data) {
						  alert(data.results)
						  $.dndcAlert.success({title:"删除成功",text:"对象删除成功",remove_time:4000});
						  //window.location.reload()
						  jQuery("#grid-table").trigger("reloadGrid"); 
					  }
				});
			} --%>
			
			
			
			$("#J-input-code").val("");
			var dialog = $("#deleted" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='ace-icon fa fa-check'></i>确认删除</h4></div>",
				title_html: true,
				width:400,
				height:200,
				buttons: [ 
	       			{
	               		text: "确定",
						"class" : "btn btn-primary btn-minier",
						click: function() {
							if(!validateYzm()){
						          alert('效验码错误');
						          return false;
						        }
						
								$.ajax({
	  			 					 type:"post",
	  			 					 url:"<%=ctxpath%>/user/delete/"+id,
	  			 					/*  data:{"id":id}, */
	  			 					 dataType:'json',
	  			 					 success: function(data) {
	  			 						 if(data.retnCode == 3){
	  			 							var span = "<span style='font-size: 16px;color: red;'>"+data.results+"</span>";
		  			 						$('#deletenot').html(span);
		  			 						deletenot();
	  			 						 }
	  			 						 else if(data.retnCode == 2){
	  			 							$.dndcAlert.fail({title:"删除失败",text:"删除失败",remove_time:4000});
	  			 							jQuery("#grid-table").trigger("reloadGrid");  
	  			 						 }else{
	  			 							$.dndcAlert.success({title:"删除成功",text:"删除成功",remove_time:4000});
	  			 							jQuery("#grid-table").trigger("reloadGrid"); 
	  			 						 }
	  			  					}
	  								});		
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
		}
		//冻结 或解冻
		function _stop(id){
			window.location.href = "<%=ctxpath%>/platform/userinfo/update/stop/"+id;
		}
		
		function deletenot(){
			$("#deleted").hide();
			var dialog = $("#deletenot" ).removeClass('hide').dialog({
				modal: true,
				title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='ace-icon fa fa-check'></i>温情提示</h4></div>",
				title_html: true,
				width:400,
				height:200,
				buttons: [ 
		   			{
		           		text: "确定",
						"class" : "btn btn-primary btn-minier",
						click: function() {
			
		       				$( this ).dialog( "close" ); 	
						} 
					},
		            {
						text: "关闭",
						"class" : "btn btn-white btn-default btn-round",
						click: function() {
							$( this ).dialog( "close" ); 
						} 
					}	
				]
			});	

		}
	</script>

	<script src="<%=ctxpath%>/static/js/jquery.dndc-alert.js"></script>
	<script>
  	$(function(){
  		deleteframe();
  	})

      if ($('#operate-message').val() != null && $('#operate-message').val() != '') {
    	  if($('#operate-flag').val()=='false'){
    		  $.dndcAlert.fail({title:"保存失败",text:$('#operate-message').val(),remove_time:4000});
    	  }else{
	      	$.dndcAlert.success({title:"保存成功",text:$('#operate-message').val(),remove_time:4000});
    	  }
      	
      }
  	
  	
  </script>
</body>
</html>