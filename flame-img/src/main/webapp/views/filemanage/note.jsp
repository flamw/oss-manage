<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet"
	href="${ctx}/public/jquery-ui/themes/base/jquery-ui.min.css" />
<link rel="stylesheet"
	href="${ctx}/public/assets/fileManager/style/note.css" />
<link rel="stylesheet" href="${ctx}/public/stylesheets/style.css" />

<style>
.bnt {
	width: 150px;
	height: 40px;
}

.bnt1 {
	width: 150px;
	margin-left: 650px;
	height: 40px;
}

.fM-module-context-menu {
	list-style: none;
	padding: 5px 5px;
	padding: 4px 0;
	width: 130px;
	position: fixed;
	background: #fefefe;
	-webkit-box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1);
	box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1);
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	-khtml-border-radius: 2px;
	border-radius: 2px;
	border: 1px solid #d2d2d2;
	-index: 100;
	_position: absolute;
	display: none;
	z-index: 9999;
}

.fM-module-context-menu  li {
	padding-left: 17px;
	text-align: left;
	color: #666;
	display: block;
	border-bottom: 1px solid #E7E7E7;
	line-height: 27px;
	background: inherit;
	cursor: pointer;
}
</style>

<script src="${ctx}/public/jquery/dist/jquery.min.js"></script>
<script src="${ctx}/public/jquery-ui/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="${ctx}/static/wangEditor/css/wangEditor.min.css" />

<script src="${ctx}/static/wangEditor/js/wangEditor.min.js"></script>
</head>
<body class="no-skin">
	<div class="layout-main">

		<div id="_main_content" class="layout-main-bd" style="height: 645px;">
			<div id="_main_box" class="inner" style="height: 100%">
				<div id="context-menu" class="fM-module-context-menu" tabindex="0">
					<ul class="menu-node">
						<li data-key="delete">删除</li>
					</ul>
				</div>
				<div id="_note_body" data-label-for-aria="笔记区域" class="note-body"
					style="height: 100%; display: block;">
					<div id="_note_view_list" class="note-list"
						style="display: none height:100%">
						<!-- 文件列表 -->
						<dl id="_note_files">
							<!-- 							<dt>今天</dt> -->
<!-- 							<dd data-file-id="ww" data-list="file" class=""> -->
<!-- 								<div class="note-list-item"> -->
<!-- 									<em>qq</em> -->
<!-- 									<p>2017-05-03 11:07</p> -->
<!-- 								</div> -->
<!-- 							</dd> -->
<!-- 														<dt>昨天</dt> -->
<!-- 							<dd data-file-id="111"> -->
<!-- 								<div class="note-list-item  " tabindex="0"> -->
<!-- 									<em>q q q q</em> -->
<!-- 									<p>2017-05-02 11:00</p> -->
<!-- 								</div> -->
<!-- 							</dd> -->
<!-- 							<dd data-record-id="wy-record-3" data-file-id="" data-list="file" -->
<!-- 								class=""> -->
<!-- 								<div class="note-list-item  " tabindex="0"> -->
<!-- 									<em>q q q</em> -->
<!-- 									<p>2017-05-02 11:00</p> -->
<!-- 								</div> -->
<!-- 							</dd> -->

						</dl>

						<a href="javascript:void(0)" class="note-load-more"
							style="display: none;" id="note_load_more"><i
							class="icon-loading"></i></a>
					</div>
					<div class="note-editor" id="_note_editor">
						<!--编辑器区域-->

						<div>
							<button class="bnt1" onclick="noteEdit(1);return false;">新增</button>
							<button class="bnt" onclick="noteEdit(2);return false;">保存</button>
						</div>
						<input type="hidden" id="noteId" name="noteId" value="">
						<textarea id="noteContent" style="height: 510px;">
						</textarea>
					</div>
				</div>
			</div>
		</div>

	</div>

	<script id="noteTmpl" type="text/x-jsrender">
<dd data-file-id="{{:id}}" >
  		<div class="note-list-item">
   	   <em>{{:noteTitle}}</em>
 		 <p>{{:mtime}}</p>
 		 </div>
	</dd>
</script>
	<script>
			var currentNoteId;
		var editor = new wangEditor($("#noteContent"));
		editor.create();
		$(function() {
			//笔记列表
			noteList();
			//右击事件
			$("#_note_files").delegate('dd','contextmenu',function(e) {
								e.preventDefault();
								e.stopPropagation();
								var elem = $(this), x = e.originalEvent.x
										|| e.originalEvent.layerX || 0, y = e.originalEvent.y
										|| e.originalEvent.layerY || 0, type = elem
										.attr('node-type'), context = $("#context-menu");
								context.show();
								if (x && y) {
									context.css('left', x + 'px').css('top',
											y + 'px');
								}
								 currentNoteId = elem.attr("data-file-id");
							});

			// 目录菜单 mouseover 效果
			$("#context-menu").delegate('ul', 'mouseleave', function(e) {
				e.preventDefault();
				e.stopPropagation();
				$(this).parent().hide();
			});
			
			// 删除
			$("#context-menu").delegate('li', 'click', function(e) {
				e.preventDefault();
				e.stopPropagation();
				var datakey=$(this).attr("data-key");
				if('delete'==datakey){
					$.post("/fileCommon/note/delete",{noteId:currentNoteId}, function(note) {
						noteList();
					});
				}
				$("#context-menu").hide();
				
			});

			//双击目录事件
			$("#_note_files").delegate('dd', 'dblclick', function(e) {
				// 	             e.preventDefault();
				e.stopPropagation();
				var elem = $(this);
				var fileId = elem.attr("data-file-id");
				findById(fileId);
			});
		});

		//
		// 		var noteTmp=$.templates('<dd data-file-id="{{:noteId}}" ><div class="note-list-item "><em>{{:noteTitle}}</em><p>{{:ctime}}</p></div></dd>');

		var IsSave = true;
		//新增 保存
		function noteEdit(type) {
			
			var noteId = $("#noteId").val();
			
			if (type == 1 &&IsSave) {
				var currentTime = TimeObjectUtil.longMsTimeConvertToDateTime(TimeObjectUtil.getCurrentMsTime());
				var noteTitle = '新建笔记';
				var note = {
					id : '',
					mtime : currentTime,
					noteTitle : noteTitle
				};
 				noteRender(note,false);
 				$("#noteId").val('');
 				editor.$txt.html('');
				IsSave = false;
			} else if (type == 2&&!IsSave||(noteId!=null&&noteId!='')) {
				// 获取编辑器区域完整html代码
				var content = editor.$txt.html();
				$.post("/fileCommon/note/save", {
					noteId : noteId,
					content : content
				}, function(result) {
						alert('保存成功。');
						noteList();
						IsSave = true;
					if (result.id) {
						$("#noteId").val(result.id);
					}
				});
			}
		}

		//笔记列表
		function noteList() {
			$.post("/fileCommon/note/list", function(notes) {
				noteRender(notes,true);
			});
		}
		
		//笔记列表
		function findById(id) {
			$.post("/fileCommon/note/id",{noteId:id}, function(note) {
				$("#noteId").val(note.id);
				editor.$txt.html(note.content);
			});
		}

		//渲染笔记列表
		function noteRender(notes,flag) {
			var tmpl = '';
			if (notes.length) {
				$.each(notes, function(index) {
					note = notes[index];
					note.mtime=TimeObjectUtil.longMsTimeConvertToDateTime(note.mtime);
					tmpl += $.templates("#noteTmpl").render(note);
				});
			} else {
				tmpl += $.templates("#noteTmpl").render(notes);
			}
			if(flag){
			$("#_note_files").empty();
			}
			$("#_note_files").prepend(tmpl);
			
			//选中第一个笔记
			$("#_note_files").find("dd:first").dblclick();
		}
	</script>
	<script src="${ctx}/public/jsrender/jsrender.min.js"></script>
</body>

</html>

