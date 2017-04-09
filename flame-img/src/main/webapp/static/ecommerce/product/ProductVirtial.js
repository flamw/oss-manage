$(function(){
	//计算值模板
	function publicAccountHtml(){
		var attrHtml =  '<li>'+
						'	<div class="tag">结算方</div>'+
						'	<select name="xx">'+
						'		<option value="DNDC">DNDC</option>'+
						'		<option value="PV">PV</option>'+
						'		<option value="DLR">DLR</option>'+
						'	</select>'+
						'	<div class="unit">,</div>'+
						'	<div class="tag">每笔</div>'+
						'	<input class="fl" type="text" value="" name="xx"/>'+
						'	<div class="unit">元</div>'+
						'	<select name="xx">'+
						'		<option value=1>选择结算方式</option>'+
						'		<option value=2>现金结算</option>'+
						'		<option value=3>车款结算</option>'+
						'		<option value=4>E3S返利补贴</option>'+
						'	</select>'+
						'	<label class="fl">'+
						'		<input type="checkbox" name="xx">资料审核结算'+
						'	</label>'+
						'	<i class="J-delete m-delete fa fa-close"></i>'+
						'</li>';

		return 	attrHtml;	
	}

		//通用删除值
		$('#J-category-extra').delegate('.J-delete', 'click', function(){
			$(this).closest('li').remove();
		})
		//添加结算值
		$('#J-category-extra').delegate('#J-account-add','click',function(){
			var attrHtml =  publicAccountHtml();						
			$('#J-account-ul').append(attrHtml)	
		})

	})

		$("#treeTxt").on('click',function(){
	        $(".select").toggleClass('open');
	    });
		
		$(document).ready(function() {
			$("input[type='radio'][name='reconciliationClearing']").click(function(){
				var aID =$(this).val();
				var extraHtml = '';
				if(aID==1){  
					extraHtml = 
								'<div class="form-group account">'+
								'	<div class="form-group frame" style="margin-left: 100px;">'+
								'		<ul id="J-account-ul">'+
								'			<li>'+
								'				<div class="tag">结算方</div>'+
								'				<select>'+
								'					<option value="DNDC">DNDC</option>'+
								'					<option value="PV">PV</option>'+
								'					<option value="DLR">DLR</option>'+
								'				</select>'+
								'				<div class="unit">,</div>'+
								'				<div class="tag">每笔</div>'+
								'				<input class="fl" type="text" name="reconciliationClearing" value=""/>'+
								'				<div class="unit">元</div>'+
								'				<select>'+
								'					<option value=1>选择结算方式</option>'+
								'					<option value=2>现金结算</option>'+
								'					<option value=3>车款结算</option>'+
								'					<option value=4>E3S返利补贴</option>'+
								'				</select>'+
								'				<label class="fl">'+
								'					<input type="checkbox">资料审核结算'+
								'				</label>'+
								'				<i class="J-delete m-delete fa fa-close"></i>'+
								'			</li>'+
								'		</ul>'+
								'		<a id="J-account-add" class="btn btn-info" href="javascript:void(0);">添加</a>'+
								'	</div>          '+
								'</div>';
					$("#J-category-extra").show();
				}else{
					$("#J-category-extra").hide();
				}
				//$('#J-category-extra').empty().html(extraHtml);
				
				$("#J-category-extra").empty().html(extraHtml);
			});							
		});
		
		// 非汽车商品提交
		$('#J-goods-add-submit').on('click',function(){
			//对账数据封装
			var hexiao = new Array();
			$("#J-account-ul li").each(function(index,domELe){
				var company = $(this).find("select:first").find("option:selected").text();
				var total = $(this).find("input[type='text']").val();
				var settlementMethod = $(this).find("select:eq(1)").find("option:selected").val();
				var che = $(this).find("input[type='checkbox']").is(':checked');
				var verify = 0;
				if(che){
					verify = 1;
				}
				var obj = {
						'company':company,	
						'total':total,
						'settlementMethod':settlementMethod,
						'verify':verify
				};
				hexiao.push(obj);	
			});
			var hexiaoObj={};//封装核销数据的对象
			if($('input:radio[name="reconciliationClearing"]:checked').val() ==1){
				hexiaoObj = {
						'是':hexiao
				};
			}
			//核销数据封装
			var hexiao = new Array();
			$("#Verification").each(function(index,domELe){
				
				var Timetype = $(this).find("select:first").find("option:selected").text();
				var TimetypeValue = $(this).find("select:first").find("option:selected").val();
				var startTime,endTime;
				if(TimetypeValue==1){
					startTime = $(this).find("input[type='text']:eq(0)").val();
					endTime = $(this).find("input[type='text']:eq(1)").val();
				}else{
					startTime =$(this).find("select:eq(1)").find("option:selected").val();
					endTime = $(this).find("input[type='text']:eq(0)").val();
				}
				var obj = {
						'Timetype':Timetype,
						'startTime':startTime,
						'endTime':endTime,
				};
				hexiao.push(obj);	
			});
			var xiaoObj={};//封装核销数据的对象
			if($('input:radio[name="needVerified"]:checked').val() ==1){
			//	var nf = $('input:radio[name="needVerified"]:checked').val();
				xiaoObj = {
							'hexiao':{
									'youxiao':hexiao
							}
				};
			}
			var proArr=[];
			$("#J-result-table").find("tr").each(function(i){
                if(i !=0){
					var dataArrid=$(this).attr("data-arrid");
					var inputArr=$(this).find("input");
						dataArrid+=",salePrice:"+inputArr.eq(0).val();
						dataArrid+=",offPrice:"+inputArr.eq(1).val();
						dataArrid+=",orderPrice:"+inputArr.eq(2).val();
						dataArrid+=",quantityOnhand:"+inputArr.eq(3).val();
						
						dataArrid="{"+dataArrid+"}";
						proArr.push(dataArrid);
                 }
			});
			//商品id+skuid
			var comAndSkuAll=[];
			$("#sku_hidden_value").find("input").each(function(i){
					var dataArrid="{invId:"+$(this).attr("invid")+",comId:"+$(this).attr("comid")+",skuId:"+$(this).attr("skuid")+",skuName:"+$(this).attr("skuname")+"}";
					comAndSkuAll.push(dataArrid);
			});
			// 车系
			var carAll=[];
			$("#carext_commod_id").find("input").each(function(i){
					var dataArrid="{carseriesid:"+$(this).attr("carseriesid")+",comId:"+$(this).attr("comid")+",carextid:"+$(this).attr("carextid")+"}";
					carAll.push(dataArrid);
			});
			// 专营店
			var dealerAll=[];
			$("#dealer_commod_id").find("input").each(function(i){
					var dataArrid="{dealerid:"+$(this).attr("dealerid")+",comId:"+$(this).attr("comid")+",dealerids:"+$(this).attr("dealerids")+"}";
					dealerAll.push(dataArrid);
			});
			
//			console.log(proArr);
		//	alert(JSON.stringify(proArr));
			var arrtJson=JSON.stringify(proArr);
			var comAndSku=JSON.stringify(comAndSkuAll);
			var carJson = JSON.stringify(carAll);
			var delaerJson = JSON.stringify(dealerAll);
			var hexiaoJson = JSON.stringify(hexiaoObj);
			var xiaoObj = JSON.stringify(xiaoObj);
			var _data = $(this).closest('form').serialize();
			_data+="&arrtJson="+arrtJson;
			_data+="&offShelveTime="+$("#offShelveTime_tmp").val();
			_data+="&shelveTime="+$("#shelveTime_tmp").val();
			_data+="&dateFrom="+$("#begin_time").val();
			_data+="&dateTo="+$("#finish_time").val();
			_data+="&hexiaoObj="+hexiaoJson;
			_data+="&xiaoObj="+xiaoObj;
			_data+="&comAndSku="+comAndSku;
			_data+="&carJson="+carJson;
			_data+="&delaerJson="+delaerJson;

			_data = decodeURI(_data);
			alert(_data);
			$.ajax({
				url: ctx+'/ecm/baseproduct/Virtialsave',
				type: 'POST',
				dataType: 'json', 
				data: _data,
				success:function(data){
					console.log(data);
				}
			}).done(function(data) {
				console.log("success"); 
			})
			
			
		});
	