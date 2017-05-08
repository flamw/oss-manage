<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet"
	href="${ctx}/public/jquery-ui/themes/base/jquery-ui.min.css" />
<link rel="stylesheet"
	href="${ctx}/public/assets/fileManager/style/fileManager.css" />
<link rel="stylesheet"
	href="${ctx}/public/assets/fileManager/style/style.css" />
<link rel="stylesheet" href="${ctx}/public/stylesheets/style.css" />


<%-- <script src="${ctx}/public/jquery/dist/jquery.min.js"></script> --%>
<%-- <script src="${ctx}/public/jquery-ui/jquery-ui.min.js"></script> --%>
<style>
.np-comment-list .np-post {
    position: relative;
    padding-left: 40px;
    vertical-align: top;
}
.np-comment-list .np-avatar {
    position: absolute;
    top: 0px;
    left: 0;
}
.np-reply-box-content{
/* margin-top: 100px; */
    position: absolute;
}
#allComments{
height: 400px;
/*     overflow: auto; */
    overflow-y:scroll;
}
.np-post {
/*      border-bottom: solid 1px;  */
}
ul{
list-style: none;
}
</style>
</head>
<body class="no-skin">


	<div id="commentDiv" class="hide">
		<ul id="allComments" class="post-list np-comment-list">
			<li class="np-post  topIco np-label-digest topAll  "
				id="top_6266091091024838370"><div class="np-tip-newpost"></div>
				<img class="np-avatar popClick" post_uid="259458849"
				src="http://q4.qlogo.cn/g?b=qq&amp;k=RjmmQuibiap6uibatSbuia3V4Q&amp;s=40&amp;t=1493913600"
				alt="头像" onerror="errorImg(this)">
				<div class="np-post-body">
					<div class="np-post-header">
						<span style="color: blue;"><h5>有你就好</h5></span>
					</div>
					<div class="np-post-content" data-height="5">
						<p>为什么我压马刺赢结果被火箭血虐。。。压火箭赢被马刺血虐。。。压奇才赢被绿军第四节翻盘。。。压绿军赢被奇才全场崩。。。为什么啊！！！我有这么毒奶吗？？？每次攒起来2000k币，，，一场就GG了。。。</p>
					</div>
					<span>2017-09-09</span>
				</div>
				<hr /></li>
			<li class="np-post  topIco np-label-digest topAll  "
				id="top_6266091091024838370"><div class="np-tip-newpost"></div>
				<img class="np-avatar popClick" post_uid="259458849"
				src="http://q4.qlogo.cn/g?b=qq&amp;k=RjmmQuibiap6uibatSbuia3V4Q&amp;s=40&amp;t=1493913600"
				alt="头像" onerror="errorImg(this)">
				<div class="np-post-body">
					<div class="np-post-header">
						<span class=""><a href="javascript:void(0)" title="有你就好"
							class="np-user popClick " post_uid="259458849">有你就好</a></span>
					</div>
					<div class="np-post-content" data-height="5">
						<p>为什么我压马刺赢结果被火箭血虐。。。压火箭赢被马刺血虐。。。压奇才赢被绿军第四节翻盘。。。压绿军赢被奇才全场崩。。。为什么啊！！！我有这么毒奶吗？？？每次攒起来2000k币，，，一场就GG了。。。</p>
					</div>
					<span>2017-09-09</span>
				</div>
				<hr /></li>
		</ul>

		<div class="np-reply-box-content">
			<textarea id="content" tabindex="1" autocomplete="off" name="content"
				accesskey="u" id="top_textarea" style="height: 60px; padding: 10px;width:480px;"></textarea>
		</div>
	</div>
	<div id="fileManager"></div>
	<script id="commentTmpl" type="text/x-jsrender">
<li class="np-post"><img class="np-avatar popClick"src="http://q4.qlogo.cn/g?b=qq&amp;k=RjmmQuibiap6uibatSbuia3V4Q&amp;s=40&amp;t=1493913600"alt="头像" >
				<div class="np-post-body">
						<div class="np-post-header">
							<span style="color: blue;"><h5>{{:userName}}</h5></span>
						</div>
						<div class="np-post-content" >
							<p>{{:content}}</p>
						</div>
						<span>{{:ctime}}</span>
					</div>
					<hr/>
				</li>
</script>
	<script>
	
		//模版渲染评论列表
		function commentRender(comments, flag) {
			var tmpl = '';
			if (comments.length) {
				$.each(comments, function(index) {
					comment = comments[index];
					comment.ctime = TimeObjectUtil
							.longMsTimeConvertToDateTime(comment.ctime);
					tmpl += $.templates("#commentTmpl").render(comment);
				});
			} else {
				tmpl += $.templates("#commentTmpl").render(comments);
			}
			if (flag) {
				$("#allComments").empty();
			}
			$("#allComments").prepend(tmpl);
		}
		//获取评论
		function getComment(fileId) {
			$.post("/fileCommon/comment/list",{fileId:fileId}, function(comments) {
				commentRender(comments, true);
			});

		}

		function commentFile(fileId) {
			getComment(fileId);
			$("#content").val('');
			
			var dialog = $("#commentDiv").removeClass('hide').dialog(
							{
								modal : true,
								 closable: false,
								 closeOnEscape:false, 
								 open:function(event,ui){$(".ui-dialog-titlebar-close").hide();} ,
								title : '评论',
								// 		title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='ace-icon fa fa-check'></i>确认删除</h4></div>",
								// 		title_html: true,
								width : 500,
								height : 600,
								buttons : [
										{
											text : "发表",
											"class" : "btn btn-primary btn-minier",
											click : function() {
												var currentTime = TimeObjectUtil.longMsTimeConvertToDateTime(TimeObjectUtil
																.getCurrentMsTime());
												var content=$("#content").val();
												if(content==''||content==null){
													alert('评论不能为空！');
													return ;
												}
												var comment = {
														content:content,
														ctime:currentTime,
														userName:'${user.userName}'
												}
												commentRender(comment,false);
												$.post("/fileCommon/comment/save", {content:content,fileId:fileId},function() {
													console.log('评论成功。');
												});
// 												$(this).dialog("close");
											}
										} ,
										{
											text : "返回",
											"class" : "btn btn-white btn-default btn-round",
											click : function() {

												$(this).dialog("close");
											}
										} ]
							});
		}
	</script>
	
	<script src="${ctx}/public/jsrender/jsrender.min.js"></script>
	<script src="${ctx}/public/underscore/underscore-min.js"></script>
	<script src="${ctx}/public/assets/fileManager/fileManagerSharefile.js"></script>
	<script src="${ctx}/public/javascripts/mainSharefile.js"></script>
	
</body>

</html>

