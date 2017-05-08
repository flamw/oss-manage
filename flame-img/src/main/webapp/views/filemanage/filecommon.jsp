<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet"
	href="${ctx}/public/jquery-ui/themes/base/jquery-ui.min.css" />
<link rel="stylesheet"
	href="${ctx}/public/assets/fileManager/style/fileManager2.css" />
<link rel="stylesheet"
	href="${ctx}/public/assets/fileManager/style/style2.css" />
<link rel="stylesheet" href="${ctx}/public/stylesheets/style.css" />


<%-- <script src="${ctx}/public/jquery/dist/jquery.min.js"></script> --%>
<%-- <script src="${ctx}/public/jquery-ui/jquery-ui.min.js"></script> --%>
<script>
var globalFileType='${param.fileType}';
</script>
</head>
<body class="no-skin">

	<script src="${ctx}/public/jsrender/jsrender.min.js"></script>
	<script src="${ctx}/public/underscore/underscore-min.js"></script>
	<script src="${ctx}/public/javascripts/mainCommon.js"></script>

	<div class="fManagerWrapper">
		<div class="fManager" style="width:; height:">
			<div class="fManagerContent">
				<div class="fManagerSider">
					<ul class="ServiceList"></ul>
				</div>
				<div class="fManagerBody">
					<div class="fManagerBody-content">
						<div class="fM-module-context-menu">
							<ul class="menu-node">
								<li data-key="createnew">新建文件夹</li>
								<li data-key="share">共享文件夹</li>
								<li data-key="cancelShare">取消共享</li>
								<li data-key="delete">删除</li>
							</ul>
							<ul class="service-node">
							</ul>
							<ul class="grid-view-context">
								<li data-key="rename">重命名</li>
								<li data-key="delete">删除</li>
							</ul>
							<ul class="list-view-context">
							</ul>
						</div>
						<div class="fM-module-toolbal">
							<div class="fM-bar">
								<a class="" href="javascript:void(0)"> </a> <a
									class="toolbar-new-dir tool" href="javascript:void(0)"> </a> <a
									class="toolbar-grid-view tool" href="javascript:void(0)"> <span
									class="fm-icon grid"></span>
								</a> <a class="toolbar-list-view tool" href="javascript:void(0)">
									<span class="fm-icon list-selected"></span>
								</a> <a class="toolbar-search-view tool" href="javascript:void(0)">
									<input type="text" name="filename" placeholder="输入搜索文件名"
									class="box"> <span data-type="file-search"
									class="fm-icon fm-icon-sure sure"></span>
								</a>
							</div>
						</div>
						<div class="fM-module-curmbs">
							<div class="crumbs-status">
								<span class="Loaded"></span> <span class="LoadError"
									style="display: none">加载出错</span> <span class="Loading"
									style="display: none">正在加载中...</span>
							</div>
							<div class="crumbs">
								<!-- 								<a class="crumb-item " data-path="/" href="javascript:void(0)">返回上一级 -->
								<!-- 									｜</a> <a class="crumb-item " data-path="/" data-bucket="0" -->
								<!-- 									href="javascript:void(0)">主页</a> -->
							</div>
						</div>
						<div class="fM-module-list-view">
							<table class="list-view-table">
								<thead class="list-view-head">
									<tr class="list">
										<th class="col1"><span node-type="chkall"
											class="list-check list-checkall"> <span
												class="fm-icon blank"></span>
										</span></th>
										<th class="col2">大小</th>
										<th class="col3">修改日期</th>
									</tr>
								</thead>
								<tbody class="list-view-content">
<!-- 									<tr class="list" data-suffix="" -->
<!-- 										data-address="http://flame-file.oss-cn-shenzhen.aliyuncs.com/0241e8cb-54b0-4b66-a59a-14e74b0ea31a" -->
<!-- 										data-key="93" data-name="error.txt"> -->
<!-- 										<th class="col1"><span class="list-check" node-type="chk"> -->
<!-- 												<span class="fm-icon blank"></span> -->
<!-- 										</span> <span class="list-filename"> <span -->
<!-- 												class="list-icon object-icon icon-txt"></span> error.txt -->
<!-- 										</span> <span class="list-action list-icon"> <a -->
<!-- 												data-key="share" class="action oss-icon share" -->
<!-- 												href="javascript:void(0)"></a> <a data-key="share" -->
<!-- 												class="action oss-icon download" href="javascript:void(0)"></a> -->
<!-- 												<span class="action more-wrapper"> <span -->
<!-- 													node-type="btn-more" class="oss-icon more"></span> -->
<!-- 											</span> -->
<!-- 										</span></th> -->
<!-- 										<th class="col2">13KB</th> -->
<!-- 										<th class="col3">2017-05-02 13:05:24</th> -->
<!-- 									</tr> -->
								</tbody>
							</table>
							<div></div>
						</div>
						<div class="fM-module-grid-view" style="display: none">
							<div class="grid-view-content">
							</div>
						</div>
					</div>
					<div class="fManagerBody-foot">
					<div class="tool">
						<!-- 							<div class="process-log"> -->
						<!-- 								<span class="fm-icon log"></span> -->
						<!-- 							</div> -->
						<!-- 							<div class="upload-list-switch"> -->
						<!-- 								<span class="fm-icon upload-list"></span> -->
						<!-- 							</div> -->
					</div>
					<div class="fM-module-checkAction">
						<span class="text"> 已选中 <span node-type="num"></span>
							个文件/文件夹
						</span> <a node-type="check-btn-option" data-key="delete"> <span
							class="fm-icon delete"></span> <span class="btn-value">删除</span>
						</a> <a node-type="check-btn-option" data-key="download"> <span
							class="fm-icon download-light"></span> <span class="btn-value">下载</span>
						</a> <a node-type="check-btn-option" data-key="getimage"> <span
							class="fm-icon drapout"></span> <span class="btn-value">获取分享链接</span>
						</a>
					</div>
				</div>
				</div>
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
	</script>
</body>

</html>

