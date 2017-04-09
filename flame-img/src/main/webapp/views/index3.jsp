<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${ctx}/static/ztree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="${ctx}/static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">

</head>
<body>
${msg}wwwwww
<c:forEach items="${msg2}" var="item">hi :${item.name}</c:forEach>


<div class="form-group" >
					<ul  id="menusList" class="ztree"></ul>
					
				</div>

<script type="text/javascript">

$(function(){
	renderMenus();
});
function renderMenus(){
	var setting = {
			check:{
				enable: true
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};
	var zNodes = [
			{name: "子节点1",id:1,pid:0},
			{name: "子节点2",id:2,pid:1},
			{name: "子节点2",id:3,pid:1},
			{name: "子节点3",id:4,pid:3}
	];
	zNodes =formatMenu(zNodes); 
	var zNodes1 =[
		{ id:1, pId:0, name:"ordinary parent", t:"I am ordinary, just click on me"},
		{ id:11, pId:1, name:"leaf node 1-1", t:"I am ordinary, just click on me"},
		{ id:12, pId:1, name:"leaf node 1-2", t:"I am ordinary, just click on me"},
		{ id:13, pId:1, name:"leaf node 1-3", t:"I am ordinary, just click on me"},
		{ id:2, pId:0, name:"strong parent", t:"You can click on me, but you can not click on the sub-node!"},
		{ id:21, pId:2, name:"leaf node 2-1", t:"You can't click on me..", click:false},
		{ id:22, pId:2, name:"leaf node 2-2", t:"You can't click on me..", click:false},
		{ id:23, pId:2, name:"leaf node 2-3", t:"You can't click on me..", click:false},
		{ id:3, pId:0, name:"weak parent", t:"You can't click on me, but you can click on the sub-node!", open:true, click:false },
		{ id:31, pId:3, name:"leaf node 3-1", t:"please click on me.."},
		{ id:32, pId:3, name:"leaf node 3-2", t:"please click on me.."},
		{ id:33, pId:3, name:"leaf node 3-3", t:"please click on me.."}
	];
// 	alert(JSON.stringify(zNodes));/* /*  */ */
/* 	var zNodes = [
		{name: "父节点1", children: [
			{name: "子节点1",id:1},
			{name: "子节点2",id:2,pid:1}
		]}
	]; */
	var treeObj=$.fn.zTree.init($("#menusList"), setting, zNodes);
	treeObj.expandAll(true); 
	<%-- $.post('<%=ctxpath%>/public/platform/getMenusList',
			{'roleId':roleId},
			function(data){
				  var zNodes = data.results;    
				$.fn.zTree.init($("#menusList"), setting, zNodes);
			},'json'); --%>
}

</script>
</body>
</html>