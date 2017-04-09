<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>404 - 页面不存在</title>
</head>

<body>
<div style="TEXT-ALIGN: center; MARGIN-TOP: 50px">
	<div style="FONT: bold 14px Arial, Helvetica, sans-serif; COLOR: #c30">请求的页面不存在，请休息一下，稍后重试，或者<a href="<c:url value="/"/>">返回首页</a></div>
	<div><IMG width="400px" height="199px" src="${displayPath}/images/404.jpg"></div>
</div>
</body>
</html>