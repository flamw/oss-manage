//页面可能需要传递的参数;
var offset;
var selectForm;
//初始化最终路径
var searchPath;
var firstin = true;
var ctx;
/**
 * 通用的请求发送处理函数
 */
function sendPost(){
	$.ajax({
		type:'post',	
	    url:searchPath,
	    data:selectForm,
	    dataType:"json",
	    success:function(data){
	    	var size = data.total;
	    	var imgHtml = "<tr>";
	    	var n=1;
	    	var s=1;
	    	var pictype="";
	    	if(data !='' ||data !=undefined ||data!=null){
	    		$.each(data.list, function(i,productImage){
	    			if(productImage.picType==1){
	    				pictype='官方';
	    			}else if(productImage.picType==2){
	    				pictype='外观';
	    			}else if(productImage.picType==3){
	    				pictype='内饰';
	    			}else{
	    				pictype='其他';
	    			}
	    			 imgHtml=imgHtml+"<td  align='center' id='img' class='paixu beijing'><p></p>" +
	    			 		"<p align='left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' name='checkbox' id='checkbox"+s+"' data-labelauty='CSS' >" +
	    			 		"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	    			 		+"<font>"+productImage.imageTypeName+"</font></p>" +
	    			 		"<p><img width='240' height='150' id='il' src='"+productImage.cdnpath+"'> </p>" +
	    			 		"<p><input name='id' id='id"+s+"' value='"+productImage.id+"' type='hidden' size='35'> " +
	    			 		"<input name='localfilepath' id='localfilepath' value='"+productImage.localfilepath+"' type='hidden' size='35'>" +
	    			 				"<font >"+productImage.id+"</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
	    			 						"<font>"+productImage.carSeriseName+"</font></p>" +
	    			 								"<p><font>"+productImage.carTypeName+"</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
	    			 										"<font>"+productImage.colorName+"</font></p>" +
	    			 		"<p><shiro:hasPermission name='productimage:update'><a id='upd' href='#' onclick='update("+productImage.id+")'>编辑</a></shiro:hasPermission>&nbsp;&nbsp;&nbsp;&nbsp;<shiro:hasPermission name='productimage:update'><a id='del'  onclick='del("+productImage.id+")'>删除</a></shiro:hasPermission>&nbsp;&nbsp;&nbsp;&nbsp;<shiro:hasPermission name='productimage:update'><a id='rpic'  onclick='showRpic("+productImage.id+")'>查看原图</a></shiro:hasPermission></p></td>" +
	    			 		"<td class='paixu' id='jiange'>&nbsp;&nbsp;&nbsp;</td>";
			            if(n==5){
			            	imgHtml=imgHtml+"</tr><tr><td class='form-group' id='huanhang'>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>";
			            	n=0;
			            } 
			            n++;
			            s++;
	    		})
	    		$("#imageTable").html(imgHtml+"</tr>");
	    	}
			if(firstin){
				toPages(size,20,1,'pageSearch');
				firstin = false;
			}
	}});
}

/**
 * 通用的翻页函数
 * @param number
 */
function pageSearch(number){
	offset = number;
	searchPath=""+$("#ctx").val()+"/base/productimage/list?offset="+offset;
	sendPost();
}
/**
 * 初始化各参数
 */
function initData(){
	offset = 1;
	firstin = true
	searchPath=""+$("#ctx").val()+"/base/productimage/list?offset="+offset;
}

function initPaper(){
	
}

$(function () {
	initData();
	sendPost();
	ctx=$("#ctx").val();
})
function FormatDate (strTime) {
    var date = new Date(strTime);
    return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
}

function formselect(form){
	selectForm = $(form).serialize()
}
