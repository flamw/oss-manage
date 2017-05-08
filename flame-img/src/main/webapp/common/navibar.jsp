<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %> 
<div id="navbar-container" class="navbar-container">
                <!-- toggle buttons are here or inside brand container -->
                <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
                    <span class="sr-only">Toggle sidebar</span>

                    <span class="icon-bar"></span>

                    <span class="icon-bar"></span>

                    <span class="icon-bar"></span>
                </button>
                <a href="${ctx}/system/workbench/welcome" class="pull-left">
<%--                     <img style="margin: 4px;padding: 0;width: 75px;height: 36px;" src="${ctx}/static/images/chx/df_logo.png" alt="logo" /> --%>
                </a>
                <div class="navbar-header pull-left">
                    <!-- brand text here -->
                    <a href="#" class="navbar-brand">
                        <small>
                            <i class="ace-icon fa fa-leaf"></i>
                            OSS文件管理平台
                            
                        </small>
                    </a>
                </div><!-- /.navbar-header -->
                <div class="navbar-header pull-center">
                    <!-- brand text here -->
                    <a href="#" class="navbar-brand">
                        <small>
<!--                             <i class="ace-icon fa fa-leaf"></i> -->
                           <fmt:formatDate value="${today}" type="date" dateStyle="full"/>	
                            
                        </small>
                    </a>
                </div><!-- /.navbar-header -->
                <nav class="navbar-menu pull-left">
								    <!-- #section:basics/navbar.nav -->
								    <ul class="nav ace-nav">
								        <li>
								            <div class="navbar_divider"></div>
								        </li>
								        <c:forEach  items="${topMenu}" var="topMenu">
								        	<li class="transparent navbar_tab">
								        	<c:choose>
								        		<c:when test='${fn:contains(topMenu.pageLink,"?")}'>
								        			<a href="${topMenu.pageLink}&token=<shiro:principal property="token"/>" class="navbar_tab_active">
								           	    		${topMenu.functionName}
								            		</a>
								        		</c:when>
								        		<c:otherwise>
								        			<a href="${topMenu.pageLink}?token=<shiro:principal property="token"/>" class="navbar_tab_active">
								               		${topMenu.functionName}
								               		</a>
								        		</c:otherwise>
								        	</c:choose>
								           
								        </li>
								        </c:forEach>
								        <!-- <li class="transparent navbar_tab">
								            <a href="home.html" class="navbar_tab_active">
								                E4S后台管理
								            </a>
								        </li>
								        <li class="transparent navbar_tab">
								            <a href="product1.html">
								                车巴巴内容管理
								            </a>
								        </li>
								        <li class="transparent navbar_tab">
								            <a href="product2.html">
								                微信内容管理
								            </a>
								        </li> -->
								    </ul>
								</nav>
                <div class="navbar-buttons navbar-header pull-right ">
                
                    <ul class="nav ace-nav">
                        <!-- user buttons such as messages, notifications and user menu -->
                        <li class="transparent">
                        
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <i class="ace-icon fa fa-envelope icon-animated-vertical"></i>
                                <span class="badge badge-light">5</span>
                            </a>

                            <ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
                                <li class="dropdown-header">
                                    <i class="ace-icon fa fa-envelope-o"></i>
                                    5 条消息
                                </li>

                                <li class="dropdown-content">
                                    <ul id="messageContent" class="dropdown-menu dropdown-navbar">
                                        <li>
                                            <a href="#" class="clearfix">
                                                <img src="${ctx}/static/avatars/avatar2.png" class="msg-photo" alt="Alex's Avatar" />
                                                <span class="msg-body">
                                                    <span class="msg-title">
                                                        <span class="blue">李四:</span>
                                                        今天天气真好 ...
                                                    </span>

                                                    <span class="msg-time">
                                                        <i class="ace-icon fa fa-clock-o"></i>
                                                        <span>1分钟前</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>

<!--                                         <li> -->
<!--                                             <a href="#" class="clearfix"> -->
<%--                                                 <img src="${ctx}/static/avatars/avatar2.png" class="msg-photo" alt="Susan's Avatar" /> --%>
<!--                                                 <span class="msg-body"> -->
<!--                                                     <span class="msg-title"> -->
<!--                                                         <span class="blue">小明:</span> -->
<!--                                                         天气不错 ... -->
<!--                                                     </span> -->

<!--                                                     <span class="msg-time"> -->
<!--                                                         <i class="ace-icon fa fa-clock-o"></i> -->
<!--                                                         <span>20分钟前</span> -->
<!--                                                     </span> -->
<!--                                                 </span> -->
<!--                                             </a> -->
<!--                                         </li> -->

<!--                                         <li> -->
<!--                                             <a href="#" class="clearfix"> -->
<%--                                                 <img src="${ctx}/static/avatars/avatar2.png" class="msg-photo" alt="Bob's Avatar" /> --%>
<!--                                                 <span class="msg-body"> -->
<!--                                                     <span class="msg-title"> -->
<!--                                                         <span class="blue">小红:</span> -->
<!--                                                         今天天气真好 ... -->
<!--                                                     </span> -->

<!--                                                     <span class="msg-time"> -->
<!--                                                         <i class="ace-icon fa fa-clock-o"></i> -->
<!--                                                         <span>下午 3:15</span> -->
<!--                                                     </span> -->
<!--                                                 </span> -->
<!--                                             </a> -->
<!--                                         </li> -->

<!--                                         <li> -->
<!--                                             <a href="#" class="clearfix"> -->
<%--                                                 <img src="${ctx}/static/avatars/avatar2.png" class="msg-photo" alt="Kate's Avatar" /> --%>
<!--                                                 <span class="msg-body"> -->
<!--                                                     <span class="msg-title"> -->
<!--                                                         <span class="blue">小张:</span> -->
<!--                                                         今天天气真好 ... -->
<!--                                                     </span> -->

<!--                                                     <span class="msg-time"> -->
<!--                                                         <i class="ace-icon fa fa-clock-o"></i> -->
<!--                                                         <span>下午 1:33</span> -->
<!--                                                     </span> -->
<!--                                                 </span> -->
<!--                                             </a> -->
<!--                                         </li> -->

<!--                                         <li> -->
<!--                                             <a href="#" class="clearfix"> -->
<%--                                                 <img src="${ctx}/static/avatars/avatar2.png" class="msg-photo" alt="Fred's Avatar" /> --%>
<!--                                                 <span class="msg-body"> -->
<!--                                                     <span class="msg-title"> -->
<!--                                                         <span class="blue">老李:</span> -->
<!--                                                         今天天气真好  ... -->
<!--                                                     </span> -->

<!--                                                     <span class="msg-time"> -->
<!--                                                         <i class="ace-icon fa fa-clock-o"></i> -->
<!--                                                         <span>早上 10:09</span> -->
<!--                                                     </span> -->
<!--                                                 </span> -->
<!--                                             </a> -->
<!--                                         </li> -->
                                    </ul>
                                </li>

                                <li class="dropdown-footer">
                                    <a href="#" onclick="lookmore();">
                                        查看所有信息
                                        <i class="ace-icon fa fa-arrow-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="transparent">
                            <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                <img class="nav-user-photo" src="${ctx}/static/avatars/avatar2.png" alt="user" />
                                <span class="user-info">
                                    <small>欢迎</small> ${user.userName }
                                </span>
                                <i class="ace-icon fa fa-caret-down"></i>
                            </a>
                            <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret">
                                <li><a href="#"><i class="ace-icon fa fa-cog"></i> 设置</a></li>
                                <li class="divider"></li>
                                <li><a href="${ctx}/login/logout"><i class="ace-icon fa fa-power-off"></i> 退出</a></li>
                            </ul>
                        </li>

                    </ul>
                </div><!-- /.navbar-buttons -->
                <nav class="navbar-menu pull-left">
                    <!-- optional menu & form inside navbar -->
                </nav><!-- /.navbar-menu -->
            </div><!-- /.navbar-container -->
            
<!--       ---------------消息通知----------------       -->
<!--             <div class="page-content"> -->
<!-- 			<div class="hr"></div> -->
<!-- 		  </div> -->
		<!-- /.col -->

		<div id="messageGird" class="hide" style="display: none;">
			<!-- PAGE CONTENT BEGINS -->
			<c:if test="${user.roleId ==1 }">
						<button type="button" class="btn btn-sm btn-primary"
							onclick="messageEdit();">
							<i class="ace-icon glyphicon glyphicon-plus"></i> 发布消息
						</button>
		   </c:if>				
			<!-- <button id="id-btn-addattr" type="button" class="btn btn-sm btn-primary" >
						<i class="ace-icon glyphicon glyphicon-edit"></i> 编辑
					</button>

					<button type="button" class="btn btn-sm btn-primary"
						onclick="del()">
						<i class="ace-icon glyphicon glyphicon-minus"></i> 删除
					</button> -->
			<table id="message-grid-table"></table>

			<div id="message-grid-pager"></div>

			<!-- PAGE CONTENT ENDS -->
		</div>
		
	
	<div>
	
	
<!-- 	add -->
	<form id="messageAddForm" class="form-horizontal" style="display: none;" method="post" action="${ctx}/message/save">
				<input type="hidden" name="id" id="id" value="">
				<input type="hidden" name="userIds" id="userIds" value="">
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">消息标题:</label>
					<div class="clearfix  col-sm-6">
						<input type="text" name="title" id="title" size="44"
							value="" placeholder="请输入消息标题" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">消息内容:</label>
					<div class="clearfix  col-sm-6">
					<textarea rows="5" cols="5" placeholder="请输入消息内容" id="content" name="content" style="width:100%;">
					
					</textarea>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label  col-sm-3 no-padding-right"
						for="roleName">选择用户:</label>
		<div class="clearfix  col-sm-6">
<!-- 		<input type="checkbox" checked onclick="$('#cc').combotree({cascadeCheck:$(this).is(':checked')})"> -->
	<select id="cc" class="easyui-combotree" data-options="url:'${ctx}/static/combotree/tree_data1.json',method:'get'" multiple style="width:330px;heigth:55px;"></select>

					</div>
				</div>

			</form>
	</div>
		
		
<script id="messageTmpl" type="text/x-jsrender">
  										<li>
                                            <a href="#" class="clearfix">
                                                <img src="${ctx}/static/avatars/avatar2.png" class="msg-photo" alt="Alex's Avatar" />
                                                <span class="msg-body">
                                                    <span class="msg-title">
                                                        <span class="blue">{{:userName}}</span>
                                                       {{:title}}
                                                    </span>

                                                    <span class="msg-time">
                                                        <i class="ace-icon fa fa-clock-o"></i>
                                                        <span>{{:publishTime}}</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>
</script>		
		
<script type="text/javascript">

var isAdmin=false;
 <c:if test="${user.roleId ==1 }">
 isAdmin=true;
 </c:if>

// 		消息编辑
		function messageEdit(id,title,content){
// 	       $('#cc').reload('${cxt}/message/userCheckList?messageId='+id);
           
           if(typeof(id) == "undefined"){
        	   id=0;
           }
           if(typeof(title) == "undefined"){
        	   title='';
           }
           if(typeof(content) == "undefined"){
        	   content='';
           }
           
           $("#id").val(id);
	       $("#title").val(title);
	       $("#content").val(content);
	       
	       $('#cc').combotree({
	    	    url: '${cxt}/message/userCheckList?messageId='+id,
	    	    required: true
	    	});
	       
			$("#messageAddForm").removeClass('hide').dialog(
					{
						modal : true,
						 closable: false,
						 closeOnEscape:false, 
						 open:function(event,ui){$(".ui-dialog-titlebar-close").hide();} ,
						title : '消息编辑',
						// 		title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='ace-icon fa fa-check'></i>确认删除</h4></div>",
						// 		title_html: true,
						width : '700',
						height : 'auto',
						buttons : [{
							text : "发布",
							"class" : "btn btn-primary btn-minier",
							click : function() {
								
								$("#userIds").val($("#cc").combotree("getValues"));
								var param=$("#messageAddForm").serialize();
								$.post("${ctx}/message/save",param,function(response) {
									  if(response=='0'){
									  	 jQuery("#message-grid-table").trigger("reloadGrid"); 
										  alert('发布成功。');
								     	 $("#messageAddForm").dialog("close");
									  }else{
										  alert('发布失败。');
									  }
								 });
							}
						},
								{
									text : "返回",
									"class" : "btn btn-white btn-default btn-round",
									click : function() {
										$(this).dialog("close");
									}
								} ]
					});
}

//delete

function deleteMessage(id){
	
	if(confirm("确定要删除吗？")){
		$.post("${cxt}/message/delete",{messageId:id},function(response) {
			  if(response=='0'){
				  alert('删除成功。');
			   jQuery("#message-grid-table").trigger("reloadGrid"); 
			  }else{
				  alert('删除失败。');
			  }
		 });
	}
}
		
	//消息查看更多
function lookmore(){
			$("#messageGird").removeClass('hide').dialog(
					{
						modal : true,
						 closable: false,
						 closeOnEscape:false, 
						 open:function(event,ui){$(".ui-dialog-titlebar-close").hide();} ,
						title : '消息通知列表',
						// 		title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='ace-icon fa fa-check'></i>确认删除</h4></div>",
						// 		title_html: true,
						width : 'auto',
						height : 'auto',
						buttons : [
								{
									text : "返回",
									"class" : "btn btn-white btn-default btn-round",
									click : function() {

										$(this).dialog("close");
									}
								} ]
					});
		}
		
		//消息列表
		jQuery(function($) {
			
			//显示前5条
			
			$.post("${ctx}/message/list",{page:1,pageSize:5},function(response) {
				var datas=response.results.datas;
				var tmplHtml='';
				$.each(datas, function(index) {
					data = datas[index];
					data.publishTime=TimeObjectUtil.longMsTimeConvertToDateTime(data.publishTime);
					tmplHtml += $.templates("#messageTmpl").render(data);
				});
				$("#messageContent").empty();
				$("#messageContent").prepend(tmplHtml);
			});
			
			
			var grid_selector = "#message-grid-table";
			var pager_selector = "#message-grid-pager";
			var parent_column = $(grid_selector).closest('[class*="col-"]');
			//对话框标题
				$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
					_title: function(title) {
						var $title = this.options.title || '&nbsp;'
						if( ("title_html" in this.options) && this.options.title_html == true )
							title.html($title);
						else title.text($title);
					}
				}));
			//resize to fit page size
			$(window).on('resize.jqGrid', function () {
			    $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
			})
						
			jQuery(grid_selector).jqGrid({
					//direction: "rtl",
					ajaxGridOptions: { contentType: 'application/json; charset=UTF-8' },
					url:'${cxt}/message/list',
					datatype : "json",
					height : 370,
					colNames : [ 'messageId', '消息标题', '消息内容','发布者','发布时间', '操作' ],
					colModel : [
						{
							name : 'id',
							index : 'id',
							key : true,
							width : 160,
							hidden:true,
							sortable : false,
							editable : true,
							align : 'center'
						},
					    {
						name : 'title',
						index : 'title',
						width : 160,
						sortable : false,
						editable : true,
						align : 'center'
					}
					, {
						name : 'content',
						index : 'content',
						width : 500,
						sortable : false,
						editable : true,
						align : 'center'
					}
					, {
						name : 'userName',
						index : 'userName',
						width : 150,
						sortable : false,
						editable : true,
						align : 'center'
					}
					, {
						name : 'publishTime',
						index : 'publishTime',
						width : 150,
						sortable : false,
						editable : true,
						formatter:formatDateHHMMSS,
						align : 'center'
					}
					, {
						name : 'oper',
						index : 'oper',
						width : 160,
						fixed : true,
						sortable : false,
						align : 'center'
					} ],
	
					viewrecords : true,
					rowNum : 10,
					rownumbers:true,
					//rowList:[10,20,30],
					pager : pager_selector,
					onPaging : function(first, last, prev, next) {
						
					},
					altRows : true,
					//toppager: true,
					
					//multiselect : true,
					//multikey: "ctrlKey",
					//multiboxonly : true,
	
					loadComplete : function() {
						var table = this;
						setTimeout(function() {
							updatePagerIcons(table);
							enableTooltips(table);
						}, 0);
					},
	
					gridComplete : function() {
						var ids = jQuery("#message-grid-table").jqGrid('getDataIDs');
						if(!isAdmin)return;
						for (var i = 0; i < ids.length; i++) {
							var id = ids[i];
							var rowData = $("#message-grid-table").getRowData(id);
							var editBtn = "<a href='#' style='color:#f60' onclick='messageEdit(\""+ id+ "\",\""+ rowData.title+ "\",\""+ rowData.content+ "\")' >编辑</a>&nbsp;&nbsp;";
								editBtn  += "<a href='#' style='color:#f60' onclick='deleteMessage(\""+ id + "\")' >删除</a>";
							
							if(rowData.userType == 1){
								editBtn = "";
							}
							jQuery("#message-grid-table").jqGrid('setRowData', ids[i], {oper : editBtn});
						}
	
					},
	
					// 读取返回的数据格式
					jsonReader : {
						repeatitems : true,
						root : "results.datas", // 返回的具体的数据的数组
						row : "results.size", // 返回的行数
						//page:"pageCurrNum", // 当前的页数
						total : "results.pages", // 返回的总页数 
						records : "results.total", // 返回的总记录条数 
						repeatitems : true,
					    // id: "tsortMark"
					},
	
					editurl : "/dummy.html",
					caption : ""
	
			});
		
			$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

			//replace icons with FontAwesome icons like above
			function updatePagerIcons(table) {
				var replacement = {
					'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
					'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
					'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
					'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
				};
				$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(
						function() {
							var icon = $(this);
							var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
							if ($class in replacement)icon.attr('class', 'ui-icon '
										+ replacement[$class]);
						})
			}

			function enableTooltips(table) {
				$('.navtable .ui-pg-button').tooltip({
					container : 'body'
				});
				$(table).find('.ui-pg-div').tooltip({
					container : 'body'
				});
			}

			
			//var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

			$(document).one('ajaxloadstart.page', function(e) {
				$.jgrid.gridDestroy(grid_selector);
				$('.ui-jqdialog').remove();
			});
		});
</script>
