<%@ page language="java" pageEncoding="UTF-8"%>
<div class="sidebar responsive ace-save-state" id="sidebar">
                <!-- sidebar goes here -->
                <ul class="nav nav-list">
<!--                     <li> -->
<!--                         <a href="home.html"> -->
<!--                             <span class="menu-text"> -->
<!--                                 首页 -->
<!--                             </span> -->
<!--                         </a> -->
<!--                     </li> -->
                    <c:forEach var="item" items="${menus}">
					  <li > 
                                <a href="${item.url}" >
                                    <i class="menu-icon fa fa-caret-right"></i>
                                    <span class="menu-text">
                                        ${item.menu_name}
                                    </span>
                                </a>
                     </li>
					  </c:forEach>
                    
<!--                     <li class="active open"> -->
<!--                         <a class="dropdown-toggle" href="#"> -->
<!--                             <span class="menu-text"> -->
<!--                                 商品管理 -->
<!--                             </span> -->
<!--                             <b class="arrow fa fa-angle-down"></b> -->
<!--                         </a> -->
<!--                         <b class="arrow"></b> -->
<!--                         <ul class="submenu"> -->
<!--                             <li class="active"> -->
<!--                                 <a href="http://localhost:8080/page/a"> -->
<!--                                     <i class="menu-icon fa fa-caret-right"></i> -->
<!--                                     <span class="menu-text"> -->
<!--                                         商品管理 - 1 -->
<!--                                     </span> -->
<!--                                 </a> -->
<!--                             </li> -->
<!--                             <li> -->
<!--                                 <a href="http://localhost:8080/page/b"> -->
<!--                                     <i class="menu-icon fa fa-caret-right"></i> -->
<!--                                     <span class="menu-text"> -->
<!--                                         商品管理 - 2 -->
<!--                                     </span> -->
<!--                                 </a> -->
<!--                             </li> -->
<!--                         </ul> -->
<!--                     </li> -->
<!--                     <li> -->
<!--                         <a href="#"> -->
<!--                             <span class="menu-text"> -->
<!--                                 订单管理 -->
<!--                             </span> -->
<!--                         </a> -->
<!--                     </li> -->
<!--                     <li> -->
<!--                         <a href="#"> -->
<!--                             <span class="menu-text"> -->
<!--                                 线索池管理 -->
<!--                             </span> -->
<!--                         </a> -->
<!--                     </li> -->
<!--                     <li> -->
<!--                         <a href="#"> -->
<!--                             <span class="menu-text"> -->
<!--                                 公共数据 -->
<!--                             </span> -->
<!--                         </a> -->
<!--                     </li> -->
<!--                     <li> -->
<!--                         <a href="#"> -->
<!--                             <span class="menu-text"> -->
<!--                                 资讯内容 -->
<!--                             </span> -->
<!--                         </a> -->
<!--                     </li> -->
<!--                     <li> -->
<!--                         <a href="#"> -->
<!--                             <span class="menu-text"> -->
<!--                                 活动管理 -->
<!--                             </span> -->
<!--                         </a> -->
<!--                     </li> -->
<!--                     <li> -->
<!--                         <a href="#"> -->
<!--                             <span class="menu-text"> -->
<!--                                 经销商管理 -->
<!--                             </span> -->
<!--                         </a> -->
<!--                     </li> -->
<!--                     <li> -->
<!--                         <a href="#"> -->
<!--                             <span class="menu-text"> -->
<!--                                 报表中心 -->
<!--                             </span> -->
<!--                         </a> -->
<!--                     </li> -->
<!--                     <li> -->
<!--                         <a href="#"> -->
<!--                             <span class="menu-text"> -->
<!--                                 系统设置 -->
<!--                             </span> -->
<!--                         </a> -->
<!--                     </li> -->
                </ul>
                
            </div>
            
