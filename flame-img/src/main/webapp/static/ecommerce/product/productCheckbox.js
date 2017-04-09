	//车型
	$("#carSeriesId").change(function(){
		var cid = $(this).find("option:selected").val();
		carSeriesChange(cid);
		$("#J-result-table").empty();
	});
 	function carSeriesChange(cid){
		if(cid==0){
			$("#carTypeId").empty();
		}else{
			$("#carTypeId").empty();
			$.ajax({
				   'url':ctx+'/ecm/baseproduct/getcarModel',
					'type':'POST',
					'data':{'id':cid},
					'dataType': 'json',
					'success':function(data){
						$("#carTypeId").append('<dt style="margin-left: -80px;" class="wn_color">车型</dt>')
					
					for(var s in data){
						if(carTypeId<=8){
							$("#carTypeId").append("<dd><label><input type='checkbox' id='carName"+s+"' name='carTypeNames' value='"+data[s].id+"'>"+data[s].carTypeName+"</label></dd>");
						   carTypeId=carTypeId+1;
						}else{
							vcarTypeId=0;
							$("#carTypeId").append("<dd><label><input type='checkbox' id='carName"+s+"' name='carTypeNames' value='"+data[s].id+"'>"+data[s].carTypeName+"</label></dd>");
							$("#carTypeId").append("<dd><label><br><div class='control-label  col-sm-3 no-padding-right'></div>");
							continue;
						}	
					}
						
						$("#carTypeId").append("</dl>")
						
				 }
			});
		}
 	}
 

 
	// 组装颜色（多选） 
	function loadBigAreaInfo(){
	$.ajax({
			'url':ctx+'/ecm/baseproduct/colors',
		 	'type':'POST',
		 	'dataType': 'json',
			 'success':function(data){
				var wcount=0;
				var ncount=0;
				var colorType =0;
				var that;
				for(var s in data)
				{
					colorType = data[s].colorType;
					if(colorType==1){   // 外观颜色
						if(wcount<=8){
							$("#wcolor").append("<dd><label><input type='checkbox' id='outColor"+s+"' name='outColor' value='"+data[s].id+"'>"+data[s].colorName+"</label></dd>");
							wcount=wcount+1;
						}else{
							wcount=0;
							$("#wcolor").append("<dd><label><input type='checkbox' id='outColor"+s+"' name='outColor' value='"+data[s].id+"'>"+data[s].colorName+"</label></dd>");
							$("#wcolor").append("<dd><label><br><div class='control-label  col-sm-3 no-padding-right'></div>");
							continue;
						}
					}else{
						// 内饰颜色
						if(ncount<=6){
							$("#ncolor").append("<dd><label><input type='checkbox' id='inColor"+s+"' name='inColor' value='"+data[s].id+"'>"+data[s].colorName+"</label></dd>");
							ncount=ncount+1;
						}else{
							ncount=0;
							$("#ncolor").append("<dd><label><input type='checkbox' id='inColor"+s+"' name='inColor' value='"+data[s].id+"'>"+data[s].colorName+"</label></dd>");
							$("#ncolor").append("<dd><label><br><div class='control-label  col-sm-3 no-padding-right'></div>");
							continue;
						}
					}
					
				} 
				//选择属性搭配
				$('#J-attr-category').delegate('input[type="checkbox"]','click', function() {
					combination({
						arrTh:['优惠价','价格','定金','数量'],                    //表头
						arrTd:['orgPrice','offPrice','orderPrice','quantityOnhand'],           //name值
						arrObj:'#J-attr-category',                               //对象
						container:'#J-result-table'                               //容器
					}).init();
						$("#J-result-table input").each(function(index,domEle){
							//1-优惠价格 2-价格 3-定金
							if((index+5)%4==1){
								$(this).val($("#price_sale").val());
							}else if((index+5)%4==2){
								$(this).val($("#price_o").val());
							}else if((index+5)%4==3){
								$(this).val($("#price_order").val());
							}else if((index+5)%4==0){
								$(this).val($("#onhand").val());
								
							}  
						});
					
				}); 
			}
		});
	}

	// 品牌 
	$(function(){
		loadBigAreaInfo();  // 加载颜色
		//Sku($("#categoryType").find("option:selected").val());   // 加载车型
		$("#brandId").val($(".brandNameCn").val());
		$(".brandNameCn").change(function(){
			var id = $(this).val();
		//	alert("id="+id);
			document.getElementById("brandId").value = id;
		//	alert("000");
		})
	})