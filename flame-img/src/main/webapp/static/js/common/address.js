
var ctx;
var needHidden = false;
function createAddress(context,isNeedHidden) {
	ctx = context;
	
	var regionId;
	var hasRegionId = false;
	if($("#regionId") && $("#regionId").length > 0) {
		regionId = $("#regionId").attr("value");
		hasRegionId = true;
	}
		
	var provinceId = $("#provinceId").attr("value");
	var cityId = $("#cityId").attr("value");
	var countyId = $("#countyId").attr("value");
	
	//需不需要隐藏
	needHidden = isNeedHidden;
	if(needHidden){
		if(hasRegionId)
			$("#provinceId").hide();
		$("#cityId").hide();
		$("#countyId").hide();
	}else{
		if(hasRegionId)
			$("#provinceId").append('<option value="">--省份--</option>');
		$("#cityId").append('<option value="">--城市--</option>');
		$("#countyId").append('<option value="">--县区--</option>');
	}
	
	if(regionId) {
		regionSelect(regionId);
	}else if(hasRegionId) {
		regionSelect(null);
		return;
	}
	
	if(provinceId) {
		provinceSelect(regionId,provinceId);
	}else{
		provinceSelect(regionId,null);
		return;
	}
	
	if(cityId) {
		citySelect(provinceId,cityId);
	}else{
		citySelect(provinceId,null);
		return;
	}

	if(countyId) {
		countySelect(cityId,countyId);
	}else{
		countySelect(cityId,null);
		return;
	}
	
}

function regionSelect(regionId) {
	$("#regionId").html('');
	var url = ctx + '/public/platform/listAllRegion';
	$.post(url,{},function(data){
		var regionHtml = '<option value="">--区域--</option>';
		var regionList = data.results;
		for(var i = 0; i < regionList.length; i++) {
			if(regionId && regionId == regionList[i].id) {
				regionHtml += '<option selected="selected" value="' + regionList[i].id + '">' + regionList[i].regionName + '</option>';
			}else{
				regionHtml += '<option value="' + regionList[i].id + '">' + regionList[i].regionName + '</option>';
			}
		}
		$("#regionId").append(regionHtml);
	},'json');
	$("#regionId").show();
}

function provinceSelect(regionId, provinceId) {
	$("#provinceId").html('');
	var url = ctx + '/public/platform/listProByRegionId';
	$.ajax({
		url:url,
		type:"post",
		data:{"regionId":regionId},
		dataType:'json',
		success:function(data){
		var provinceHtml = '<option value="">--省份--</option>';
		var pList = data.results;
		for(var i = 0; i < pList.length; i++) {
			if(provinceId && provinceId == pList[i].provinceId) {
				provinceHtml += '<option selected="selected" value="' + pList[i].provinceId + '">' 
							+ pList[i].provinceName + '</option>';
			}else{
				provinceHtml += '<option value="' + pList[i].provinceId + '">' + pList[i].provinceName + '</option>';
			}
		}
		$("#provinceId").append(provinceHtml);
	}
		});
	$("#provinceId").show();
}

function citySelect(provinceId,cityId) {
	$("#cityId").html('');
	var url = ctx + '/public/platform/listCityByProId';
	$.ajax({
		url:url,
		type:"post",
		data:{"provinceId":provinceId},
		dataType:"json",
		async:false,
		success:function(data){
		var cityHtml = '<option value="">--城市--</option>';
		var cityList = data.results;
		for(var i = 0; i < cityList.length; i++) {
			if(cityId && cityId == cityList[i].cityId) {
				cityHtml += '<option selected="selected" value="' + cityList[i].cityId + '">' 
							+ cityList[i].cityName + '</option>';
			}else{
				cityHtml += '<option value="' + cityList[i].cityId + '">' + cityList[i].cityName + '</option>';
			}
		}
		$("#cityId").append(cityHtml);
	}
	});
	$("#cityId").show();
}

function countySelect(cityId,countyId) {
	$("#countyId").html('');
	var url = ctx + '/public/platform/listCountyByCityId';
	$.post(url,{"cityId":cityId},function(data){
		var countyHtml = '';
		if(!countyId){
			countyHtml += '<option value="">--区县--</option>';
		}
		var ctList = data.results;
		for(var i = 0; i < ctList.length; i++) {
			if(countyId && countyId == ctList[i].countyId) {
				countyHtml += '<option selected="selected" value="' + ctList[i].countyId + '">' 
							+ ctList[i].countyName + '</option>';
			}else{
				countyHtml += '<option value="' + ctList[i].countyId + '">' + ctList[i].countyName + '</option>';
			}
		}
		$("#countyId").append(countyHtml);
	},'json');
	$("#countyId").show();
}

$("#regionId").change(function(){
	if(needHidden) {
		$("#cityId").hide();
		$("#countyId").hide();
	}
	var regionId = $("#regionId").val();
	if(regionId) {
		provinceSelect(regionId);
	}else{
		$("#provinceId").html('<option value="">--省份--</option>');
		if(needHidden) {
			$("#provinceId").hide();
		}
	} 
	$("#cityId").html('<option value="">--城市--</option>');
	$("#countyId").html('<option value="">--区县--</option>');
})

$("#provinceId").change(function(){
	if(needHidden) {
		$("#countyId").hide();
	}
	var provinceId =$.trim( $("#provinceId").val());
	if(provinceId) {
		citySelect(provinceId);
	}else {
		$("#cityId").html('<option value="">--城市--</option>');
		if(needHidden) {
			$("#cityId").hide();
		}
	}
	$("#countyId").html('<option value="">--区县--</option>');
})

$("#cityId").change(function(){
	var cityId = $.trim($("#cityId").val());
	if(cityId) {
		countySelect(cityId);
	}else {
		$("#countyId").html('<option value="">--区县--</option>');
		if(needHidden) {
			$("#countyId").hide();
		}
	}
})

