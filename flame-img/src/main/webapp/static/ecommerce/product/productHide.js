//选择实体 隐藏 虚拟对应的内容
function validCar(pa){
	//console.log('${ctx}/views/ecommerce/commodity/ProductVirtialAdd2.jsp');
		
	if(pa==1){
		
	}else if(pa==2){		// 2 虚拟商品
			document.location = "Virtial";
	}else if(pa==3){
			document.location = "else";
			
	}
}

$("#categoryType").change(function(){
	var pa = $("#categoryType").find("option:selected").val();
	if(pa == 1){
		document.location = "create";
	}else{
		validCar(pa);
	}
});
	$(document).ready(function(){
	validCar();
});
		
	// 微信 隐藏
	$("input[name=3]").on('click',function(){
		var ss = $(this).val();
		if(ss=='1'){
			 $('#yin').show();
        }else{
	 	 $('#yin').hide();
 	 	}
	});
	
	// 同步数据
	//价格
	$("#price_o").bind("input propertychange",function(){
		var price = $(this).val();
		$("#J-result-table input").each(function(index,domEle){
			if((index+5)%4==2){
				$(this).val(price);
			}
		});
	});
	//优惠价格
	$("#price_sale").bind("input propertychange",function(){
		var price = $(this).val();
		$("#J-result-table input").each(function(index,domEle){
			if((index+5)%4==1){
				$(this).val(price);
			}
		});
	});
	//定金
	$("#price_order").bind("input propertychange",function(){
		var price = $(this).val();
		$("#J-result-table input").each(function(index,domEle){
			if((index+5)%4==3){
				$(this).val(price);

			}
		});
	});
	//库存
	$("#onhand").bind("input propertychange",function(){
		var price = $(this).val();
		$("#J-result-table input").each(function(index,domEle){
		//alert(price+"ss");
			if((index+5)%4==0){
				$(this).val(price);
			}
		});
	});
	//商品名称与微信的同步
	$("input[name='productName']").bind("input propertychange",function(){
		$("#property_name").val($(this).val());
	});
	
	