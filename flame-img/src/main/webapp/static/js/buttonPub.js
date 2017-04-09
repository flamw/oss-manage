var staticmethod;
var statictotal;
var staticoffect;
var staticpage;

function toPages(total,limit,offset,method){
	if(total<=0 || limit<=0 ||offset<=0 ||method==null ||method==''){
		$("#fenye").html("");
		return;
	}
	var page = total / limit;

	page = Math.ceil(page);
	staticmethod = method;
	statictotal = total;
	staticoffset = offset;
	staticpage = page;
	var ui = $("#fenye");
	var htmltext='';
	htmltext = htmltext + "<tr align='center'><td id='first' name='page' class='right'><a onclick='javascript:buttonClick(1)'>首页</a></td>&nbsp;&nbsp;&nbsp;&nbsp;";
	if(offset>1){
		htmltext = htmltext + "<td>&nbsp;&nbsp;<td><td id='prev' name='page' class='right'><a onclick='javascript:buttonClick("+(offset-1)+")'>上一页</a></td>";
	}else{
		htmltext = htmltext + "&nbsp;&nbsp;<td style='display:none' id='prev' name='page' class='right '><a onclick='javascript:buttonClick("+(offset-1)+")'>上一页</a></td>";
	}
	for(var i = 1;i<offset;i++){
		htmltext = htmltext + "&nbsp;&nbsp;<td style='display:none' id='"+i+"' name='page' own='number' class='right'><a onclick='javascript:buttonClick("+i+")'><font id='textcolor"+i+"' name='textcolor'>"+i+"</font></a></td>";
	}
	for(var i = offset;i<=page&&i<=(offset+4);i++){
		if(i==offset){
			htmltext = htmltext + "&nbsp;&nbsp;<td class='z-active right ' id='"+i+"' name='page' own='number' ><a onclick='javascript:buttonClick("+i+")'><font id='textcolor"+i+"' name='textcolor'>"+i+"</font></a></td>";
		}else{
			htmltext = htmltext + "&nbsp;&nbsp;<td id='"+i+"' name='page' own='number' class='right'><a onclick='javascript:buttonClick("+i+")'><font id='textcolor"+i+"' name='textcolor'>"+i+"</font></a></td>";
		}
	}
	for(var i = (offset+5);i<=page;i++){
		htmltext = htmltext +"&nbsp;&nbsp;<td style='display:none' id='"+i+"' name='page' own='number' class='right'><a onclick='javascript:buttonClick("+i+")'><font id='textcolor"+i+"' name='textcolor'>"+i+"</font></a></td>";
	}
	if(offset<page){
		htmltext = htmltext + "&nbsp;&nbsp;<td id='next' name='page'  class='right'><a onclick='javascript:buttonClick("+(offset+1)+")'>下一页</a></td>&nbsp;&nbsp;";
	}else{
		htmltext = htmltext + "&nbsp;&nbsp;<td style='display:none' id='next' name='page' class='right '><a onclick='javascript:buttonClick("+(offset+1)+")'>下一页</a></td>&nbsp;&nbsp;";
	}
	htmltext = htmltext + "&nbsp;&nbsp;<td id='last' name='page' class=' right'><a onclick='javascript:buttonClick("+page+")'>尾页</a></td>&nbsp;<td>共"+total+"条记录</td></tr>";
	ui.html(htmltext);
}

function setprev(){
	var number = parseInt(staticoffset);
	if(number<=1){
		$("#prev").hide();
	}else{
		$("#prev").show();
		$("#prev").find("a").attr("onclick","javascript:buttonClick("+(number-1)+")");
	}
}

function setnext(){
	var number = parseInt(staticoffset);
	if(number>=staticpage){
		$("#next").hide();
	}else{
		$("#next").show();
		$("#next").find("a").attr("onclick","javascript:buttonClick("+(number+1)+")");
	}
}

function buttonClick(nextpage){
	$.each($("font[name='textcolor']"),function(){
		$(this).removeClass("current");
	})
	var textcolor = "#textcolor"+nextpage;
	$(textcolor).addClass("current");
	staticoffset = parseInt(nextpage);
	var offset = parseInt(staticoffset);
	setprev();
	setnext();
	$.each($("td[name='number']"),function(){
		$(this).hide();
		$(this).removeClass("current");
		var text = $(this).find("a").text();
		if(text == offset){
			$(this).addClass("current");
		}
		if(text == offset
				||text == offset+1
				||text == offset+2
				||text == offset-1
				||text == offset-2){
			$(this).show();
		}
	})
	if(staticoffset<=1){
		$("#4").show();
		$("#5").show();
	}else if(staticoffset<=2){
		$("#5").show();
	}
	if(staticoffset>=staticpage){
		$("#"+(parseInt(staticpage)-3)).show();
		$("#"+(parseInt(staticpage)-4)).show();
	}else if(staticoffset>=(parseInt(staticpage)-1)){
		$("#"+(parseInt(staticpage)-4)).show();
	}
	eval(staticmethod+"("+staticoffset+")");
	 pageSearch(offset);
		
}