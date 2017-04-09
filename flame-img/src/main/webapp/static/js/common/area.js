
var ctx;
function createArea(context, bigAreaId, smallAreaId) {
	ctx = context;
	$("#bigAreaId").hide();
	$("#smallAreaId").hide();
	
	if(bigAreaId) {
		bigAreaSelect(bigAreaId);
	}else{
		bigAreaSelect(null);
		return;
	}
	
	if(smallAreaId) {
		smallAreaSelect(bigAreaId,smallAreaId);
	}else{
		smallAreaSelect(bigAreaId,null);
		return;
	}
	
}

function bigAreaSelect(bigAreaId) {
	$("#bigAreaId").html('');
	var url = ctx + '/base/bigarea/getAllBigarea';
	$.post(url,{},function(data){
		var bigAreaHtml = '';
		if(!bigAreaId){
			bigAreaHtml += '<option value="">--大区--</option>';
		}
		var baList = data.results;
		for(var i = 0; i < baList.length; i++) {
			if(bigAreaId && bigAreaId == bigarea.id) {
				bigAreaHtml += '<option selected="selected" value="' + baList[i].bigAreaId + '">' + baList[i].selGoalName + '</option>';
			}else{
				bigAreaHtml += '<option value="' + baList[i].bigAreaId + '">' + baList[i].selGoalName + '</option>';
			}
		}
		$("#bigAreaId").append(bigAreaHtml);
	});
	$("#bigAreaId").show();
}

function smallareaSelect(bigAreaId, smallAreaId) {
	$("#smallAreaId").html('');
	var url = ctx + '/base/smallarea/getSmallByBigId';
	$.post(url,{"bigAreaId":bigAreaId},function(data){
		var smallAreaHtml = '';
		if(!smallAreaId){
			smallAreaHtml += '<option value="">--省份--</option>';
		}
		var saList = data.results;
		for(var i = 0; i < saList.length; i++) {
			if(smallAreaId && smallAreaId == smallarea.smallAreaId) {
				smallAreaHtml += '<option selected="selected" value="' + saList[i].smallAreaId + '">' 
							+ saList[i].smallAreaName + '</option>';
			}else{
				smallAreaHtml += '<option value="' + saList[i].smallAreaId + '">' + saList[i].smallAreaName + '</option>';
			}
		}
		$("#smallAreaId").append(smallAreaHtml);
	});
	$("#smallAreaId").show();
}

$("#bigAreaId").change(function(){
	var bigAreaId = $("#bigAreaId").val();
	if(bigAreaId) {
		smallareaSelect(bigAreaId);
	}else{
		$("#smallAreaId").hide();
	}
})