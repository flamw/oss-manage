	function edited(id){
		var rowData = $("#grid-table").getRowData(id);
		var s=rowData.id;

		//alert(id);
 		document.location=ctx+'/ecm/property/update/'+id;	
 		
	}
	//删除 
	function del(id){
		deleteframe();
		var dialog = $("#deleted").removeClass('hide').dialog({
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
							$("#error").text("验证码错误");
							
					          return false;
					        }
						else{
							$("#J-input-code").val("");
						}
						$.ajax({
							  type:"post",
							  url:ctx+"/ecm/property/delete/"+id,
							  data:{"id":id},
							  dataType:"json",
							  success: function() {
								  $.dndcAlert.success({title:"删除成功",text:"删除成功",remove_time:4000});
								  jQuery("#grid-table").trigger("reloadGrid"); 
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
	
		jQuery(function($) {
			var grid_selector = "#grid-table";
			var pager_selector = "#grid-pager";
											
			var parent_column = $(grid_selector).closest('[class*="col-"]');
			jQuery(grid_selector).jqGrid({
					//direction: "rtl",
					ajaxGridOptions: { contentType: 'application/json; charset=UTF-8' },
					url:ctx+'/ecm/property/getList',
					type:"post",
					datatype : "json",
					height : 'auto',
					colNames : [ 'ID', '属性名称', '属性组', '录入形式','值是否必填', '操作' ],
					colModel : [
					{
						name: 'ID',
						index: 'ID',
						hidden   :true
					}, {
						name : 'propertyName',
						align:'center'
					}, {
						name : 'groupName',
						align:'center',
                        
					}, {
						name : 'propertyType',
						align:'center',
						formatter: function(cellValue, options, rowObject) {  
							if(cellValue == 1){
								return "文本框";
							}else
							if(cellValue == 2){
								return "日期";
							}else
							if(cellValue == 3){
								return "是/否";
							}else
							if(cellValue == 4){
								return "复选框";
							}else
							if(cellValue == 5){
								return "下拉";
							}else{
								return "";
							}
							
                        } 
					}, {
						name : 'isMandatory',
						align:'center',
						formatter: function(cellValue, options, rowObject) {  
                            return cellValue == 0 ? "是" : "否";  
                        } 
					}, {
						name : 'oper',
						fixed : true,
						align:'center'
					} ],
	
					viewrecords : true,
					rowNum : 10,
					//rowList:[10,20,30],
					pager : pager_selector,
					onPaging : function(first, last, prev, next) {
						
					},
					altRows : true,
                    autowidth:true,
					multiselect : false,
	                rownumbers:true,
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
							var editBtn = "<a href='#' style='color:#f60' onclick='edited(\""
									+ id
									+ "\")' >编辑</a>&nbsp;&nbsp;"
									+ "<a href='#' style='color:#f60' onclick='del(\""
									+ id + "\")' >删除</a>";
	
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
					editurl : "/dummy.html",
					caption : ""
	
			});
			//resize to fit page size
			$(window).on('resize.jqGrid', function() {
				$(grid_selector).jqGrid('setGridWidth', parent_column.width());
			})
		
		});