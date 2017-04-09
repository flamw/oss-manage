
jQuery(function($) {
	
	$(document).ready(function(){
		loadCarBrandInfo();
		
	});
	// 查询车品牌  1
	function loadCarBrandInfo(){	
			$.ajax({
			   'url':ctx+'/ecm/baseproduct/carbrands',
				'type':'get',
			//	'data':{'id':cid},
				'dataType': 'json',
				'success':function(data){
							for(var s in data)
							{
								$("#carBrand").append("<option value='"+data[s].id+"'>"+data[s].carBrandCn+"</option>");
							}
						}
				})
			}
	 //  车系 2
	function loadCarSeriesBycarBrand(carBrand){
		$.ajax({
			'url':ctx+'/ecm/baseproduct/carseries',
			'type':'get',
			'data':{'carBrand':carBrand},
			'dataType': 'json',
			'success':function(data){
				var selectHtml = "<option value=''>请选择对应车系</option>";
					for(var s in data){
						selectHtml = selectHtml+" <option value='"+data[s].id+"'>"+data[s].carSeriesCn+"</option>";
					}
						$("#carSeries").html(selectHtml);
			}
		});
	}
		// 	车型 3
	function loadCarTypeBycarSeries(carSeries){
			$.ajax({
			  'url':ctx+'/ecm/baseproduct/cartypes',
		      'type':'get',
			  'data':{'carSeries':carSeries},
				'dataType': 'json',
				'success':function(data){
					var selectHtml = "<option value=''>请选择对应车型</option>";
						for(var s in data){
								selectHtml = selectHtml+" <option value='"+data[s].id+"'>"+data[s].carTypeName+"</option>";
						}
							$("#carModel").html(selectHtml);
					}
			});
	}
			
	 	// 车型 4
	function loadSaftePriceBycarModel(carModel){
		$.ajax({
		   'url':ctx+'/ecm/baseproduct/safetyprice',
			'type':'get',
			'data':{'carModel':carModel},
			'dataType': 'json',
			'success':function(data){
				var guidePrice = data.guidePrice;
				var safetyPrice = data.offerPriceSection;
				var safetyPrices = safetyPrice.split("-");
				$("#guidePrice").val(guidePrice);
				$("#safetyPrice1").val(safetyPrices[0]);
				$("#safetyPrice2").val(safetyPrices[1]);
							
			}
		});
	}
	

	$("#carBrand").change(function(){
		var carBrand=$(this).val();
		loadCarSeriesBycarBrand(carBrand);
		loadCarTypeBycarSeries();
		$("#BIGAREA").html("");
		$("#SMALLAREA").html("");
		$("#DEALER").html("");
		smallcount = 0;
		n = 1;
		dealercount = 0;
		dn = 1;
		$("#bigAll").prop("checked",false);
		$("#smallAll").prop("checked",false);
		$("#dealerAll").prop("checked",false);
		loadBigAreaInfo(carBrand);
	
	});
	$("#carModel").change(function(){
		var carSeries=$(this).val();
		loadSaftePriceBycarSeries(carSeries);
	});
	
	$("#carSeries").change(function(){
		var carSeries=$(this).val();
		loadCarTypeBycarSeries(carSeries);
	});
	
	
	
		function loadBigAreaInfo(carBrand){
			$.ajax({
				   'url':ctx+'/ecm/baseproduct/bigareas',
					'type':'get',
					'data':{'carBrand':carBrand},
					'dataType': 'json',
					'success':function(data){
						var count=0;
						for(var s in data)
						{
							if(count<=8){
								$("#BIGAREA").append("<input type='checkbox' id='bigAreaId"+s+"' name='bigAreaId' value='"+data[s].bigAreaId+"' onclick='bigChange(this.id)'>"+data[s].bigAreaName+"&nbsp;&nbsp;&nbsp;&nbsp;");
								count=count+1;
							}else{
								count=0;
								$("#BIGAREA").append("<input type='checkbox' id='bigAreaId"+s+"' name='bigAreaId' value='"+data[s].bigAreaId+"' onclick='bigChange(this.id)'>"+data[s].bigAreaName+"&nbsp;&nbsp;&nbsp;&nbsp;");
								$("#BIGAREA").append("<br><div class='control-label  col-sm-3 no-padding-right'></div>");
								continue;
							}
						}
					}
			});
		}
	var smallcount = 0;
	var n = 1;
	// 区域
	function loadSmallAreaByBigAreaId(bigAreaId){
		$.ajax({
			   'url':ctx+'/ecm/baseproduct/smallareas',
				'type':'get',
				'data':{'bigAreaId':bigAreaId},
				'dataType': 'json',
				'success':function(data){
					for(var s in data){
						if(smallcount<=8){
							$("#SMALLAREA").append("<input type='checkbox' id='smallAreaId"+n+"' name='smallAreaId' value='"+data[s].id+"' onclick='smallChange(this.id)'/><input type='hidden'  id='smallcount"+n+"' value='"+smallcount+"' size='50' /><font id='t"+n+"'>"+data[s].smallAreaName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							smallcount=eval(smallcount+1);
							n++;
						}else{
							smallcount=0;
							$("#SMALLAREA").append("<input type='checkbox' id='smallAreaId"+n+"' name='smallAreaId' value='"+data[s].id+"' onclick='smallChange(this.id)'><input type='hidden'  id='smallcount"+n+"' value='"+smallcount+"' size='50' /><font id='t"+n+"'>"+data[s].smallAreaName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							$("#SMALLAREA").append("<br id='br"+n+"'><div class='control-label  col-sm-3 no-padding-right' id='huanhang"+n+"' ></div>");
							n++;
							continue;
						}
					}
					
				}
		});
	}
	// 小区
	function loadAllSmallArea(bigIds){
		$.ajax({
			   'url':ctx+'/ecm/baseproduct/smallareas',
				'type':'get',
				'data':{'bigAreaId':bigIds},
				'dataType': 'json',
				'success':function(data){
					for(var s in data){
						if(smallcount<=8){
							$("#SMALLAREA").append("<input type='checkbox' id='smallAreaId"+n+"' name='smallAreaId' value='"+data[s].id+"' onclick='smallChange(this.id)'/><input type='hidden'  id='smallcount"+n+"' value='"+smallcount+"' size='50' /><font id='t"+n+"'>"+data[s].smallAreaName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							smallcount=smallcount+1;
							n++;
						}else{	
							$("#SMALLAREA").append("<input type='checkbox' id='smallAreaId"+n+"' name='smallAreaId' value='"+data[s].id+"' onclick='smallChange(this.id)'><input type='hidden'  id='smallcount"+n+"' value='"+smallcount+"' size='50' /><font id='t"+n+"'>"+data[s].smallAreaName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							$("#SMALLAREA").append("<br id='br"+n+"'><div class='control-label  col-sm-3 no-padding-right' id='huanhang"+n+"' ></div>");
							smallcount=0;
							n++;
							continue;
						}
					}
					
				}
		});
	}
	// 经销商
	function resetSmallArea(smalAreaIds){
		$.ajax({
			   'url':ctx+'/ecm/baseproduct/smallareas',
				'type':'get',
				'data':{'smalAreaIds':smalAreaIds},
				'dataType': 'json',
				'success':function(data){
					for(var s in data){
						if(smallcount<=8){
							$("#SMALLAREA").append("<input type='checkbox' id='smallAreaId"+n+"' name='smallAreaId' value='"+data[s].id+"' onclick='smallChange(this.id)'/><input type='hidden'  id='smallcount"+n+"' value='"+smallcount+"' size='50' /><font id='t"+n+"'>"+data[s].smallAreaName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							smallcount=smallcount+1;
							n++;
						}else{
							
							$("#SMALLAREA").append("<input type='checkbox' id='smallAreaId"+n+"' name='smallAreaId' value='"+data[s].id+"' onclick='smallChange(this.id)'><input type='hidden'  id='smallcount"+n+"' value='"+smallcount+"' size='50' /><font id='t"+n+"'>"+data[s].smallAreaName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							$("#SMALLAREA").append("<br id='br"+n+"'><div class='control-label  col-sm-3 no-padding-right' id='huanhang"+n+"' ></div>");
							smallcount=0;
							n++;
							continue;
						}
					}
					
				}
		});
	}
	
	
	
	var dealercount = 0;
	var dn = 1;
	
	function loaddealersBySmallAreaId(smallAreaId){
		$.ajax({
			   'url':ctx+'/ecm/baseproduct/dealers',
				'type':'get',
				'data':{'smallAreaId':smallAreaId},
				'dataType': 'json',
				'success':function(data){
					for(var s in data){
						if(dealercount<=3){
							$("#DEALER").append("<input type='checkbox' id='dealerId"+dn+"' name='dealerIds' value='"+data[s].id+"'/><input type='hidden'  id='dealercount"+dn+"' value='"+dealercount+"' size='50' /><font id='tn"+dn+"'>"+data[s].dlrShortName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							dealercount=dealercount+1;
							dn++;
						}else{
							dealercount=0;
							$("#DEALER").append("<input type='checkbox' id='dealerId"+dn+"' name='dealerIds' value='"+data[s].id+"' ><input type='hidden'  id='dealercount"+dn+"' value='"+dealercount+"' size='50' /><font id='tn"+dn+"'>"+data[s].dlrShortName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							$("#DEALER").append("<br id='brn"+dn+"'><div class='control-label  col-sm-3 no-padding-right' id='huanhangn"+dn+"' ></div>");
							dn++;
							continue;
						}
					}
				}
		});
	}
	function loadAllDealer(smallIds){
		$.ajax({
			   'url':ctx+'/ecm/baseproduct/dealers',
				'type':'get',
				'data':{'smallAreaId':smallIds},
				'dataType': 'json',
				'success':function(data){
					for(var s in data){
						if(dealercount<=3){
							$("#DEALER").append("<input type='checkbox' id='dealerId"+dn+"' name='dealerIds' value='"+data[s].id+"'/><input type='hidden'  id='dealercount"+dn+"' value='"+dealercount+"' size='50' /><input type='hidden'  id='dealercount"+dn+"' value='"+dealercount+"' size='50' /><font id='tn"+dn+"'>"+data[s].dlrShortName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							dealercount=dealercount+1;
							dn++;
						}else{
							dealercount=0;
							$("#DEALER").append("<input type='checkbox' id='dealerId"+dn+"' name='dealerIds' value='"+data[s].id+"' ><input type='hidden'  id='dealercount"+dn+"' value='"+dealercount+"' size='50' /><input type='hidden'  id='dealercount"+dn+"' value='"+dealercount+"' size='50' /><font id='tn"+dn+"'>"+data[s].dlrShortName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							$("#DEALER").append("<br id='brn"+dn+"'><div class='control-label  col-sm-3 no-padding-right' id='huanhangn"+dn+"' ></div>");
							dn++;
							continue;
						}
					}
					
				}
		});
	}

	function resetDealer(dealerIds){
		$.ajax({
			   'url':ctx+'/ecm/baseproduct/dealers',
				'type':'get',
				'data':{'dealerIds':dealerIds},
				'dataType': 'json',
				'success':function(data){
					for(var s in data){
						if(dealercount<=3){
							$("#DEALER").append("<input type='checkbox' id='dealerId"+dn+"' name='dealerIds' value='"+data[s].id+"'/><input type='hidden'  id='dealercount"+dn+"' value='"+dealercount+"' size='50' /><input type='hidden'  id='dealercount"+dn+"' value='"+dealercount+"' size='50' /><font id='tn"+dn+"'>"+data[s].dlrShortName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							dealercount=dealercount+1;
							dn++;
						}else{
							dealercount=0;
							$("#DEALER").append("<input type='checkbox' id='dealerId"+dn+"' name='dealerIds' value='"+data[s].id+"' ><input type='hidden'  id='dealercount"+dn+"' value='"+dealercount+"' size='50' /><input type='hidden'  id='dealercount"+dn+"' value='"+dealercount+"' size='50' /><font id='tn"+dn+"'>"+data[s].dlrShortName+"&nbsp;&nbsp;&nbsp;&nbsp;</font>");
							$("#DEALER").append("<br id='brn"+dn+"'><div class='control-label  col-sm-3 no-padding-right' id='huanhangn"+dn+"' ></div>");
							dn++;
							continue;
						}
					}
					
				}
		});
	}
	
	function loadSmallAreaByBigAreaIdOff(bigAreaId){
		$.ajax({
			   'url':ctx+'/ecm/baseproduct/smallareas',
				'type':'get',
				'data':{'bigAreaId':bigAreaId},
				'dataType': 'json',
				'success':function(data){
					var smallArea = $("input[name='smallAreaId']");
					for(var s in data){
						for(var i in smallArea){
							if(smallArea[i].value==data[s].id){
								var small = "#"+smallArea[i].id;
								var flag = smallArea[i].id.substring(11);
								var t = "#t"+ flag;
								var huanhang = "#huanhang"+flag;
								var br = "#br"+flag;
								var count = "#smallcount"+flag;
								$(small).remove();
								$(t).remove();
								$(huanhang).remove();
								$(br).remove();
								if(i==0){
									smallcount = parseInt($(count).val());
								}
								$(count).remove();
								n--;
							}
						}
					}
					var smallArea1 = $("input[name='smallAreaId']");
					var smalAreaIds = "";
					for(var k in smallArea1){
						var smallAreaValue = smallArea1[k].value;
						if(smallAreaValue){
							smalAreaIds = smalAreaIds+","+smallAreaValue;
							
						}
					}
					
					$("#SMALLAREA").html("");
					n=0;
					smallcount=0;
					resetSmallArea(smalAreaIds);
				}
		});
	}
	function loaddealersBySmallAreaIdOff(smallAreaId){
		dealercount = 0;
		$.ajax({
			   'url':ctx+'/ecm/baseproduct/dealers',
				'type':'get',
				'data':{'smallAreaId':smallAreaId},
				'dataType': 'json',
				'success':function(data){
					var dealer = $("input[name='dealerIds']");
					for(var s in data){
						for(var i in dealer){
							if(dealer[i].value==data[s].id){
								var de = "#"+dealer[i].id;
								var flag = dealer[i].id.substring(8);
								var t = "#tn"+ flag;
								var huanhang = "#huanhangn"+flag;
								var br = "#brn"+flag;
								var count = "#dealercount"+flag;
								$(de).remove();
								$(t).remove();
								$(huanhang).remove();
								$(br).remove();
								if(i==0){
									dealercount = parseInt($(count).val());
								}
								dn--;
							}
						}
					}
					var dealer1 = $("input[name='dealerIds']");
					var dealerIds = "";
					for(var j in dealer1){
						var dealerValue = dealer1[j].value;
						if(dealerValue){
							dealerIds = dealerIds+","+dealerValue;
							
						}
					}
					
					$("#DEALER").html("");
					n=0;
					smallcount=0;
					resetDealer(dealerIds);
					
				}
		});
	}
	function bigChange(bigAreaIds){
		var bigArea = "#"+bigAreaIds;
		if($(bigArea).prop("checked")==true){
			var bigAreaId=$(bigArea).val();
			loadSmallAreaByBigAreaId(bigAreaId);
		}else{
			var bigAreaId=$(bigArea).val();
			loadSmallAreaByBigAreaIdOff(bigAreaId);
		}
		
	}
	
	function smallChange(smallAreaIds){
		var smallArea = "#"+smallAreaIds;
		if($(smallArea).prop("checked")==true){
			var smallAreaId=$(smallArea).val();
			loaddealersBySmallAreaId(smallAreaId)
		}else{
			var smallAreaId=$(smallArea).val();
			loaddealersBySmallAreaIdOff(smallAreaId);
		}
		
	}
	
	
		$("#publicOfferPrice").change(function(){
			var guidePrice = $("#guidePrice").val();
			var publicOfferPrice = $(this).val();
			var discount = guidePrice-publicOfferPrice;
			$("#discount").val(discount);
			
		});
	
		$("#bigAll").click(function(){
			var bigArea = $("input[name='bigAreaId']");
			var bigIds="";
			if($("#bigAll").prop("checked")==true){
			
					 for(var i in bigArea){
							var bigAreaId = "#"+bigArea[i].id;
							if($(bigAreaId).prop("checked")==false){
								$(bigAreaId).prop("checked",true);
								var bigAreaIds=$(bigAreaId).val();
								if(i==0){
									bigIds = bigIds+bigAreaIds;
								}else{
									bigIds = bigIds+","+bigAreaIds;
								}
							}
							
						}
					 loadAllSmallArea(bigIds);
					 
					 }else if($("#bigAll").prop("checked")==false){
							 for(var i in bigArea){
									var bigAreaId = "#"+bigArea[i].id;
										$(bigAreaId).prop("checked",false);
										$("#SMALLAREA").html("");
								}
							 n=0;
							 smallcount=0;
			}
			
		});
	
		$("#smallAll").click(function(){
			var smallArea = $("input[name='smallAreaId']");
			var smallIds="";
			if($("#smallAll").prop("checked")==true){
			
					 for(var i in smallArea){
							var smallAreaId = "#"+smallArea[i].id;
							if($(smallAreaId).prop("checked")==false){
								$(smallAreaId).prop("checked",true);
								var smallAreaIds=$(smallAreaId).val();
								if(i==0){
									smallIds = smallIds+smallAreaIds;
								}else{
									smallIds = smallIds+","+smallAreaIds;
								}
							}
							
						}
					 loadAllDealer(smallIds);
					 
					 }else if($("#smallAll").prop("checked")==false){
							 for(var i in smallArea){
									var smallAreaId = "#"+smallArea[i].id;
										$(smallAreaId).prop("checked",false);
										$("#DEALER").html("");
								}
							 n=0;
							 dealercount=0;
			}
		});
	
		$("#dealerAll").click(function(){
			var dealer = $("input[name='dealerIds']");
			if($("#dealerAll").prop("checked")==true){
					 for(var i in dealer){
							var dealerId = "#"+dealer[i].id;
							if($(dealerId).prop("checked")==false){
								$(dealerId).prop("checked",true);
							}
						}
					 }else if($("#dealerAll").prop("checked")==false){
							 for(var i in dealer){
									var dealerId = "#"+dealer[i].id;
										$(dealerId).prop("checked",false);
								}
			}
			
		});
		
	
});