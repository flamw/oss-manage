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
                            图片管理平台
                            
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
                                    <ul class="dropdown-menu dropdown-navbar">
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

                                        <li>
                                            <a href="#" class="clearfix">
                                                <img src="${ctx}/static/avatars/avatar2.png" class="msg-photo" alt="Susan's Avatar" />
                                                <span class="msg-body">
                                                    <span class="msg-title">
                                                        <span class="blue">小明:</span>
                                                        天气不错 ...
                                                    </span>

                                                    <span class="msg-time">
                                                        <i class="ace-icon fa fa-clock-o"></i>
                                                        <span>20分钟前</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>

                                        <li>
                                            <a href="#" class="clearfix">
                                                <img src="${ctx}/static/avatars/avatar2.png" class="msg-photo" alt="Bob's Avatar" />
                                                <span class="msg-body">
                                                    <span class="msg-title">
                                                        <span class="blue">小红:</span>
                                                        今天天气真好 ...
                                                    </span>

                                                    <span class="msg-time">
                                                        <i class="ace-icon fa fa-clock-o"></i>
                                                        <span>下午 3:15</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>

                                        <li>
                                            <a href="#" class="clearfix">
                                                <img src="${ctx}/static/avatars/avatar2.png" class="msg-photo" alt="Kate's Avatar" />
                                                <span class="msg-body">
                                                    <span class="msg-title">
                                                        <span class="blue">小张:</span>
                                                        今天天气真好 ...
                                                    </span>

                                                    <span class="msg-time">
                                                        <i class="ace-icon fa fa-clock-o"></i>
                                                        <span>下午 1:33</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>

                                        <li>
                                            <a href="#" class="clearfix">
                                                <img src="${ctx}/static/avatars/avatar2.png" class="msg-photo" alt="Fred's Avatar" />
                                                <span class="msg-body">
                                                    <span class="msg-title">
                                                        <span class="blue">老李:</span>
                                                        今天天气真好  ...
                                                    </span>

                                                    <span class="msg-time">
                                                        <i class="ace-icon fa fa-clock-o"></i>
                                                        <span>早上 10:09</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="dropdown-footer">
                                    <a href="#">
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
