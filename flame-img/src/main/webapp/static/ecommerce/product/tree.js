
	function getCategoryTree(){
		var categoryId ='${baseProduct.categoryId}';
		$.post(ctx + '/ecm/category/categoryTree', {"categoryType":""},
			function(data) {
		//	alert(sssssssss);
			   var treeJson=formatMenu(data);
			   		alert(JSON.stringify(treeJson));
			   $('#cc').combotree('loadData',treeJson);
			});
	}

	
	$(function(){
		$.post(ctx + '/ecm/category/categoryTree', {"categoryType":""},
			function(data) {
			   var treeJson=formatMenu(data);
			   $('#cc').combotree('loadData',treeJson);
			}
		);
		//商品分类单击事件
		$('#cc').combotree({
			onClick:function(node) {
				$('#categoryId').val(node.id);
				$.ajax({
		 			'url':ctx+'/ecm/baseproduct/getGroups2',
		 			'type':'POST',
		 			'data':{"categoryId":node.id},
		 			'dataType':'json',
		 			'success':function(result){
						$("#categoryId").append('<dt style="margin-left: -80px;" class="wn_color">sku属性</dt>')

						if(result!=null){
							var datas = result.results;
							//分类名与分类id
							var cataName = datas.categoryName;
							var cataId = datas.categoryId;
							//对应的属性
							var aList = datas.property;
							var vcarTypeId = 0
							var strs= "";
							$("#Sku").empty();
							$("#Sku").append('<dt style="margin-left: -80px;" class="wn_color">sku属性</dt>');
							
							if(aList!=null){
								for(var a=0;a<aList.length;a++){
									var gList = aList[a].proItem;
									for(var i=0;i< gList.length; i++){
										if(vcarTypeId<8){
											if(gList[i].isSku == 1){
												var arr = gList[i].propertyOptions.split(",");
												for(var b=0;b<arr.length;b++){
													$("#Sku").append("<dd><label><input type='checkbox' id='skuName"+a+"' name='skuName' value='"+gList[i].id+"'>"+arr[b]+"</label></dd>");
													vcarTypeId=vcarTypeId+1;
												}
											}
										}else{
											vcarTypeId=0;
											$("#Sku").append("<dd><label><br><div class='control-label  col-sm-3 no-padding-right'></div>");
											continue;
										}	
									}
								}
							}
							$("#carTypeId").append("</dl>")
						 }
						$("#J-result-table").empty();
		 			}
		 		});
				
				//用于获取自定义属性
				$.ajax({
					type:'POST',
					dataType:"json",
					data:{"categoryId":node.id},
					url:ctx + '/ecm/baseproduct/getGroups',
					success:function(result){
						if(result!=null){
							var datas = result.results;
							//判断是否为空对象
							if(!$.isEmptyObject(datas)){
								var groupAll = new Array();
								//循环属性
								$(".my_group_table").empty();
								var num = 0;
								for(var sk in datas){
									$(".my_group_table").append('<div style="float:left;"><label id="my_group_table_label'+num+'" class="my_group_table_label"></label><div id="my_group_prop'+num+'" class="my_group_prop"></div></div>')
									$("#my_group_table_label"+num).text(sk);
									var sPropAll = datas[sk];
									for(var i = 0;i<sPropAll.length;i++){
										var sProp = sPropAll[i];
										//是否必填
										var requireds = false;
										if(sProp.IS_MANDATORY==1){
											requireds = true;
										}
										//属性 对象
										var properies = {};
										var proList = sProp.OPTIONS;
										if(!$.isEmptyObject(proList)){
											for(var j = 0; j<proList.length;j++){
												properies[proList[j].id]=proList[j].value;
											}
										}
										//js对象
										var obj = {
											    "type" : "div",
											    "class" : "field-form",
											    "html" :
											    [
											     	{
											     		"type" : "label",
											     		"html" : sProp.name
											     	},
											        {
										        	"id":sProp.ID,
										        	"groupId":sProp.groupId,
										        	"default_value":sProp.default_value,
										        	"name":sProp.name,
										        	"GROUP_NAME":sProp.GROUP_NAME,
										        	"IS_SKU":sProp.IS_SKU,
										        	"CATEGORY_ID":sProp.CATEGORY_ID,
										        	"required" : requireds,
										        	"PROPERTY_OPTIONS":sProp.PROPERTY_OPTIONS,
										        	"PROPERTY_DATA_TYPE":sProp.PROPERTY_DATA_TYPE,
										        	"PROPERTY_CODE":sProp.PROPERTY_CODE,
										        	"type" : sProp.type,
										        	"options" : properies
											        }
											    ]};
										groupAll.push(obj);
									}
									console.log(groupAll);
									//调用插件得到表单
									$("#my_group_prop"+num).dform({
										"method" : "get",
										"html" :groupAll
									});
									num+=1;
								}
								
							}
							
						}
					}
				});
				
			
			  }
		});
	});
	

	