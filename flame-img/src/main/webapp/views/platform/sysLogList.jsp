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
				<li class="active"><a href="#">日志管理</a></li>
			</ul>
			<!-- /.nav-search -->

		</div>


		<div class="page-content">
			<!-- setting box goes here if needed -->
			<div class="hr"></div>
		</div>
		<!-- /.col -->

		<div class="col-xs-12">
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

	<script type="text/javascript">
							
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
					url:'${cxt}/sysLog/list',
					datatype : "json",
					height : 370,
					colNames : [  '操作用户', '操作类型','描述','操作时间' ],
					colModel : [
					 {
						name : 'userName',
						index : 'userName',
						width : 100,
						sortable : false,
						editable : true,
						align : 'center'
					}
					, {
						name : 'operationType',
						index : 'operationType',
						width : 100,
						sortable : false,
						editable : true,
						align : 'center'
					}, {
						name : 'description',
						index : 'description',
						width : 160,
						sortable : false,
						editable : true,
						align : 'center'
					}
					, {
						name : 'ctime',
						index : 'ctime',
						width : 100,
						formatter:formatDateHHMMSS,
						sortable : false,
						editable : true,
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
		
		//编辑
		function _edit(id){
			window.location.href = "<%=ctxpath%>/user/edit/"+id;
		}
		
		
	</script>
</body>
</html>