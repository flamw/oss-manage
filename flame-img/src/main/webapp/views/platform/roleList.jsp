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
				<li class="active"><a href="#">系统设置</a></li>
				<li class="active"><a href="#">角色管理</a></li>
			</ul>

			<!-- #section:basics/content.searchbox -->
			<div class="nav-search" id="nav-search">
				<form class="form-search">
					<span class="input-icon"> <input type="text"
						placeholder="Search ..." class="nav-search-input"
						id="nav-search-input" autocomplete="off" /> 
						<i class="ace-icon fa fa-search nav-search-icon"></i>
					</span>
				</form>
			</div>
			<!-- /.nav-search -->

		</div>

		<div class="page-content">
			<!-- setting box goes here if needed -->

			<div class="row">
				<div class="col-xs-12">
					<!-- page content goes here -->
					<form class="form-horizontal" role="form" id="roleSeach">
						<div class="form-group">
							<table>
								<tr height="60">
									<td><label for="form-field-1">&nbsp;&nbsp;&nbsp;&nbsp;角色名称:</label>
										<input type="text" placeholder="请输入角色名称" id="form-field-1" name="roleName"/>
									</td>
									
									<!-- <td><label for="form-field-1">&nbsp;&nbsp;&nbsp;&nbsp;角色状态:</label>
										<select name="state">
											<option value="">全部类型</option>
											<option value="ENABLED">激活</option>
											<option value="DISABLED">冻结</option>
										</select>
									</td> -->
									
									<td>
										<button type="button" class="btn btn-sm btn-primary" onclick="search();">
											<i class="ace-icon fa fa-search"></i> 查询
										</button>
										<button type="button" class="btn btn-sm btn-primary" onclick="roleSeach.reset()">
											<i class="ace-icon fa fa-undo"></i> 重置
										</button>
										<input type="hidden" id="operate-message" value="${message}">
									</td>
							</table>
						</div>
					</form>
					<div class="hr"></div>
				</div>
				<!-- /.col -->

				<div class="col-xs-12">
					<!-- PAGE CONTENT BEGINS -->
					<shiro:hasPermission name="role:create">
					<button type="button" class="btn btn-sm btn-primary"
						onclick="document.location='<%=ctxpath%>/platform/role/create'">
						<i class="ace-icon glyphicon glyphicon-plus"></i> 新增
					</button>
					</shiro:hasPermission>
					<!-- <button type="button" class="btn btn-sm btn-primary" 
						onclick="edit()">
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
	 <!--不能删除弹框  -->
     <div id="deletenot" class="hide">
        
     </div>
        
	<!-- 删除弹框的div -->
	<div id="deleted" class="hide">
		<div>
			删除效验码：
			<input id="J-input-code" type="text" value=""/>
		</div>
		<div>
	 		效验码：
			<span id="J-codeText" style="margin-left:25px;"></span>
			<span id="J-clipContainer">
				<button id="J-yzmCodeBtn" type="button" onclick="yzmCodeBtn()"  data-flag='true'>复制此效验码</button> 
			</span>
		</div>	
    </div>
    <script src="<%=ctxpath%>/static/js/del-verify.js"></script>
    
    

	<!-- PAGE CONTENT ENDS -->
	<!-- </div> -->
	<!-- /.col -->
	<!-- </div> -->
	<!-- /.row -->


	<!-- </div> -->
	<!-- /.page-content -->
	<!-- <!-- </div> --> -->
	<!-- /.main-content -->


	<script type="text/javascript">
	function edit(){
		var ids=$('#grid-table').jqGrid('getGridParam','selarrrow');
      	if(ids.length>0){
      		if(ids.length >  1){
      			alert("一次只能编辑一条数据！");
      		}else{
      			_edit(ids[0]);
      		}
      	}else{
      		alert("请勾选需要编辑的数据！");
      	}
		
	}
	
	function del(){
		var ids=$('#grid-table').jqGrid('getGridParam','selarrrow');
      	if(ids.length>0){
      		if(confirm('确定删除吗 ？')){
      			$.ajax({
  				  type:"get",
  				  url:"<%=ctxpath%>/platform/role/delete",
  				  data:{"ids":ids.join(",")},
  				  success: function(data) {
  					  alert(data.results)
  					  window.location.reload()
  				  }
  			});
      		}
      	}else{
      		alert("请勾选需要删除的数据！");
      	}
	}
	
	
	jQuery(function($) {
		var grid_selector = "#grid-table";
		var pager_selector = "#grid-pager";
										
		var parent_column = $(grid_selector).closest('[class*="col-"]');
		//resize to fit page size
		$(window).on('resize.jqGrid', function () {
		    $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
		})
					
		jQuery(grid_selector).jqGrid({
								//direction: "rtl",
								ajaxGridOptions: { contentType: 'application/json; charset=UTF-8' },
								url:'<%=ctxpath%>/platform/role/list',
								datatype : "json",
								height : 270,

								colNames : [ '序号', '类型状态', '角色名称','角色编码','创建人','创建时间','操作' ],
								colModel : [
								{
									name : 'id',
									index : 'id',
									key : true,
									width : 60,
									sorttype : "int",
									editable : true,
									hidden:true,
									align : 'center'
								}, {
									name : 'state',
									index : 'state',
									width : 120,
									sortable : false,
									editable : true,
									formatter:formatState,
									hidden:true,
									align : 'center'
								}, {
									name : 'roleName',
									index : 'roleName',
									width : 120,
									sortable : false,
									align : 'center'
								}, {
									name : 'roleCode',
									index : 'roleCode',
									width : 90,
									sortable : false,
									align : 'center'
								},{
									name : 'creator',
									index : 'creator',
									width : 90,
									sortable : false,
									align : 'center'
								},{
									name : 'createdDate',
									index : 'createdDate',
									width : 90,
									sortable : false,
									sorttype : "date",
									align : 'center'
								}, {
									name : 'oper',
									index : 'oper',
									width : 80,
									fixed : true,
									sortable : false,
									align : 'center'
								} ],

								viewrecords : true,
								rowNum : 10,
								pager : pager_selector,
								rownumbers:true,
								onPaging : function(first, last, prev, next) {
									
								},
								altRows : true,
								//toppager: true,

								multiselect : false,
								//multikey: "ctrlKey",
								multiboxonly : false,

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
										var editBtn = "<shiro:hasPermission name='role:update'><a href='#' style='color:#f60' onclick='_edit(\""+ id+ "\")' >编辑</a></shiro:hasPermission>&nbsp;&nbsp;";
											editBtn	+= "<shiro:hasPermission name='role:delete'><a href='#' style='color:#f60' onclick='_delete(\""+ id + "\")' >删除</a></shiro:hasPermission>";

										jQuery("#grid-table").jqGrid('setRowData', ids[i], {oper : editBtn});
									}

								},

								// 读取返回的数据格式
								jsonReader : {
									repeatitems : true,
									root : "results.results", // 返回的具体的数据的数组
									row : "results.size", // 返回的行数
									//page:"pageCurrNum", // 当前的页数
									total : "results.maxPage", // 返回的总页数 
									records : "results.size", // 返回的总记录条数 
									repeatitems : true,
								    // id: "tsortMark"
								},

								editurl : "/dummy.html",//nothing is saved
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
				$(
						'.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon')
						.each(
								function() {
									var icon = $(this);
									var $class = $.trim(icon.attr('class')
											.replace('ui-icon', ''));

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

			//var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

			$(document).one('ajaxloadstart.page', function(e) {
				$.jgrid.gridDestroy(grid_selector);
				$('.ui-jqdialog').remove();
			});
			
			function formatState(cellvalue){
				var state = "冻结";
				if("ENABLED" == cellvalue){
					state = "激活";
				}
				return state;
			}
			
		});
	
	
	function _edit(id){
		window.location.href = "<%=ctxpath%>/platform/role/update/"+id;
	}
	
	//删除
	function _delete(id){
		<%-- if(confirm('确定删除吗 ？')){
			$.ajax({
				  type:"get",
				  url:"<%=ctxpath%>/platform/role/delete",
				  data:{"id":id},
				  success: function(data) {
					  alert(data.results)
					  window.location.reload()
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
               		text: "OK",
					"class" : "btn btn-primary btn-minier",
					click: function() {
						if(!validateYzm()){
					          alert('效验码错误');
					          return false;
					        }
					
							$.ajax({
  			 					 type:"post",
  			 					 url:"<%=ctxpath%>/platform/role/delete",
  			 					 data:{"id":id}, 
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
					text: "Cancel",
					"class" : "btn btn-white btn-default btn-round",
					click: function() {
						$( this ).dialog( "close" ); 
					} 
				}	
			]
		});	
		
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
	
	//search
	function search(){
		var formParam = $('#roleSeach').serialize();
		 var url = "${ctx}/platform/role/list";
		 url += '?'+formParam;
		$("#grid-table").jqGrid('setGridParam',{ 
            url:url, 
            page:1
        }).trigger("reloadGrid"); //重新载入 
	}
	
	 if ($('#operate-message').val() != null && $('#operate-message').val() != '') {
		 	if($('#operate-message').val() =='false'){
		 		$.dndcAlert.fail({title:"保存失败",text:"对象保存失败",remove_time:4000});
		 	}else if($('#operate-message').val() =='exist'){ 
		 		$.dndcAlert.fail({title:"保存失败",text:"对象用户名已存在！",remove_time:4000});
		 	}else{
		 		$.dndcAlert.success({title:"保存成功",text:"对象保存成功",remove_time:4000});
		 		
		 	}
	      }
	 
	</script>

</body>
</html>