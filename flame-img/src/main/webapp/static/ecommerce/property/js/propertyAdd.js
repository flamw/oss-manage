$(function(){

	//计算值模板
//	$('input[name="a"]').on('click',function(){

	function publicAccountHtml(){
		var attrHtml =  '<li>'+
						'	<div class="tag">结算方</div>'+
						'	<select name="xx">'+
						'		<option value="DNDC">DNDC</option>'+
						'		<option value="PV">PV</option>'+
						'		<option value="DNDC">DLR</option>'+
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


    //编辑器
 //   var ue = UE.getEditor('editor');

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
		
		// 实物提交
		$('#J-goods-add-submit').on('click',function(){
		
			//核销数据封装
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
			console.log(proArr);
			var arrtJson=JSON.stringify(proArr);
			var hexiaoJson = JSON.stringify(hexiaoObj);
			var _data = $(this).closest('form').serialize();
			_data+="&arrtJson="+arrtJson;
			_data+="&offShelveTime="+$("#offShelveTime_tmp").val();
			_data+="&shelveTime="+$("#shelveTime_tmp").val();
			_data+="&dateFrom="+$("#begin_time").val();
			_data+="&dateTo="+$("#finish_time").val();
			_data+="&hexiaoObj="+hexiaoJson;
			_data = decodeURI(_data);
		//	console.log(hexiaoObj);
			$.ajax({
				url: ctx+'/ecm/baseproduct/save',
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
	
		
		
		