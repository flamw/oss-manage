
	// 定义模版
    var   Template = {

           ModuleCrumbs: $.templates('<div class="fM-module-curmbs"> \
                               <div class="crumbs-status"> \
                                   <span class="Loaded"></span> \
                                   <span class="LoadError" style="display:none">加载出错</span> \
                                   <span class="Loading" style="display:none">正在加载中...</span> \
                               </div> \
                               <div class="crumbs"> \
                                   <a class="crumb-item " data-path="/" href="javascript:void(0)">返回上一级 ｜</a> \
                                   <a class="crumb-item " data-path="/" data-bucket="0" href="javascript:void(0)">主页</a> \
                               </div> \
                           </div>'),
           CrumbsItem: $.templates('<a class="crumb-item" data-path="{{:PATH}}" href="javascript:void(0)">&nbsp;&gt;&nbsp;{{:NAME}}</a>'),
           CrumbsItemSpan: $.templates('<span class="crumb-item-span">&nbsp;&gt;&nbsp;{{:NAME}}</span>'),
           ModuleListView: $.templates('<div class="fM-module-list-view"> \
                                <table class="list-view-table"> \
                                   <thead class="list-view-head"> \
                                       <tr class="list"> \
                                       <th class="col1"> \
                                           <span node-type="chkall" class="list-check list-checkall"> \
                                               <span class="fm-icon blank"></span> \
                                           </span> \
                                       </th>\
                                       <th class="col2">大小</th> \
                                       <th class="col3">修改日期</th> \
                                       </tr> \
                                   </thead> \
                                   <tbody class="list-view-content"> \
                                   </tbody>\
                                </table> \
                             <div>'),
           ModuleListViewLi: $.templates('<tr class="list" data-suffix="{{:SUFFIX}}" data-address="{{:address}}" data-key="{{:KEY}}" data-name="{{:NAME}}"> \
                                   <th class="col1"> \
                                       <span class="list-check" node-type="chk"> \
                                           <span class="fm-icon blank"></span> \
                                       </span> \
                                       <span class="list-filename"> \
                                           <span class="list-icon object-icon {{:ICON}}"></span> \
                                           {{:NAME}} \
                                       </span> \
                                       <span class="list-action list-icon"> \
                                           <a data-key="share" class="action oss-icon share" href="javascript:void(0)"></a> \
                                           <a data-key="share" class="action oss-icon download" href="javascript:void(0)"></a> \
                                           <span class="action more-wrapper"> \
                                               <span node-type="btn-more" class="oss-icon more"></span> \
                                               <div node-type="more-list" class="more-list more-list-up" style="display: none;"> \
                                                   <a node-type="btn-item" data-key="move" class="more-item" href="javascript:void(0);">移动到</a> \
                                                   <a node-type="btn-item" data-key="copy" class="more-item" href="javascript:void(0);">复制到</a> \
                                                   <a node-type="btn-rename" class="more-item" href="javascript:void(0);">重命名</a> \
                                                   <a node-type="btn-item" data-key="delete" class="more-item" href="javascript:void(0);">删除</a> \
                                               </div> \
                                           </span> \
                                       </span> \
                                   </th> \
                                   <th class="col2">{{:FILE_SIZE}}</th> \
                                   <th class="col3">{{:FILE_MODIFIED}}</th> \
                              </tr>'),
           ModuleGridView: $.templates('<div class="fM-module-grid-view"> \
                                           <div class="grid-view-content"> \
                                           </div> \
                                       </div>'),
           ModuleGridViewBox_IMG: $.templates('<div class="grid" data-suffix="{{:SUFFIX}}" data-address="{{:address}}" data-key="{{:KEY}}" data-name="{{:NAME}}"> \
                                   <div class="thumb-large" title="{{:NAME}}" style="background:url({{:address}});background-size: 100% 100%;"> \
                                       <div class="grid-check" node-type="chk"> \
                                           <span class="fm-icon blank_b"></span> \
                                       </div> \
                                   </div> \
                                   <span class="grid-name">{{:NAME}}</span> \
                                   <div class="node-edit-name"> \
                                       <input data-type="node-edit-name" class="box" type="text" placeholder="新文件夹名称"> \
                                       <span data-type="node-edit-sure" class="fm-icon fm-icon-sure sure"></span> \
                                       <span data-type="node-edit-sure" class="fm-icon fm-icon-cancel cancel"></span> \
                                   </div> \
                                   </div>'),
           ModuleGridViewBox: $.templates('<div class="grid" data-suffix="{{:SUFFIX}}" data-address="{{:address}}" data-key="{{:KEY}}" data-name="{{:NAME}}"> \
                                   <div class="thumb-large object-large-icon {{:ICON}}" title="{{:NAME}}" > \
                                       <div class="grid-check" node-type="chk"> \
                                           <span class="fm-icon blank_b"></span> \
                                       </div> \
                                   </div> \
                                   <span class="grid-name">{{:NAME}}</span> \
                                   <div class="node-edit-name"> \
                                       <input data-type="node-edit-name" class="box" type="text" placeholder="新文件夹名称"> \
                                       <span data-type="node-edit-sure" class="fm-icon fm-icon-sure sure"></span> \
                                       <span data-type="node-edit-sure" class="fm-icon fm-icon-cancel cancel"></span> \
                                   </div> \
                               </div>'),
       };
	
    // 获取文件的名称或后缀 或者目录的名称
   var fileNameRegexp = new RegExp(/\/?(([^\/]+\/)?([^\/]*\.([^\/]*))*$)/);
    /**
     * 获取文件的扩展名
     *
     * @param name {String} 文件名
     * @return {String} 文件的扩展名
     */
   var getSuffix = function getSuffix(name) {
        var ret = fileNameRegexp.exec(name);
        if (ret.length > 1) {
            if (ret[3] === undefined) {
                return '';
            } else {
                return ret[4];
            }
        }

        return '';
    },
     formatDate = function formatDate(date, fmt) {
     	date=TimeObjectUtil.longMsTimeConvertToDateTime(date);
     	return date;
     },
  // 验证其是否为图片
     isImage = function isImage(suffix) {
         return /jpg|png|jpeg|gif/.test(suffix);
     },
  // 根据文件的节点获取其图标
     getIcon = (function getIcon() {
         //@TODO 支持更多的扩展名
         var iconMap = {
                 mp3: ['icon-mp3', 'large-icon-mp3'],
                 image: ['icon-image'],
                 txt: ['icon-txt', 'large-icon-txt'],
                 folder: ['icon-dir', 'large-icon-dir'],
                 zip: ['icon-zip', 'large-icon-zip']
             },
             // 扩展名规格化
             convertSuffix = function(suffix) {
                 switch (suffix) {
                     case 'jpg':
                     case 'png':
                     case 'jpeg':
                     case 'gif':
                         return 'image';

                     case 'bz2':
                     case 'tar':
                     case 'gz':
                         return 'zip';
                     case 'folder':
                         return 'folder';
                     default:
                         return 'txt';
                 }
             },
             icon;

         /**
          * @param suffix {string} 后缀名,
          * @param flag {boolean} true 为大图标, false 为小图标
          */
         return function(suffix, flag) {
             if (suffix === '')
                 icon = iconMap.text;
             else
                 icon = iconMap[convertSuffix(suffix)];
             if (flag)
                 return icon[1];
             else
                 return icon[0];
         };
     }()),
     // 格式化文件大小格式
     formatFileSize = function formatFileSize(size) {
         var unit = ['Byte', 'KB', 'MB', 'GB', 'TB'],
             i = 0,
             filesize;
         while (size >= 1024) {
             size = size / 1024;
             i++;
         }
         filesize = size + unit[i];
         return size.toFixed(0) + unit[i];
     };
	//渲染
		$(function() {
			var plugin=new Plugin();
			plugin.refreshView();
		});

		var Plugin = function() {
			var plugin = this;
			// 参数合并
			// 主框架
			plugin.element = $('.fManagerWrapper');

			// 对各个模块的缓存
			plugin.module = {
				siderElem : null,
				toolBar : null,
				crumbs : null,
				listView : null,
				gridView : null,
			};
			
			plugin.modules = plugin.module;

			// 默认显示模式
			plugin.viewType = 'list';

			// 初始化列表视图
			plugin.modules.listView = $(".fM-module-list-view");
			plugin.modules.listView.chkallBtn = plugin.modules.listView
					.find('.list-checkall .fm-icon');
			plugin.modules.listViewContent = plugin.modules.listView
					.find('.list-view-content');

			// 初始化grid视图列表
			plugin.modules.gridView = $(".fM-module-grid-view");
			plugin.modules.gridViewContent = plugin.modules.gridView
					.find('.grid-view-content');

			// 初始化选择控件
			plugin.modules.checkAction = {
				elem : $(".fM-module-checkAction"),
				items : []
			};
			//         plugin.modules.toolBar = $(".fM-module-toolbal");

			// 初始化工具栏 ,上传控件, 视图按钮
			(function() {
				plugin.modules.toolBar = $(".fM-module-toolbal");
				// 视图切换
				plugin.modules.toolBar.switchView = (function() {
					var list_view = plugin.modules.toolBar
							.find('.toolbar-list-view .fm-icon'), grid_view = plugin.modules.toolBar
							.find('.toolbar-grid-view .fm-icon');
					return function() {
						list_view.toggleClass('list-selected').toggleClass(
								'list');
						grid_view.toggleClass('grid-selected').toggleClass(
								'grid');
					}
				}());
			}());

			// ----------------
			// 工具栏事件
			//-------------------------------------------------

			plugin.modules.toolBar
			// 切换视图
			.delegate('.tool', 'click', function(e) {
				e.stopPropagation();
				var elem = $(this);
				if (elem.hasClass('toolbar-list-view')) {
					plugin.modules.toolBar.switchView();
					plugin.viewType = 'list';
					plugin.modules.gridView.hide();
					plugin.modules.listView.show();
					// 获取数据
// 					                    plugin.refreshView();
				} else if (elem.hasClass('toolbar-grid-view')) {
					plugin.modules.toolBar.switchView();
					plugin.viewType = 'grid';
					plugin.modules.listView.hide();
					plugin.modules.gridView.show();
					// 获取数据
// 					plugin.refreshView();
				} else if (elem.hasClass('toolbar-new-dir')) {
					// 新建文件夹
					elem.find('.new-dir-box').toggle().find('.box').val('');
				}
			}).delegate('.tool .new-dir-box', 'click', function(e) {
				e.stopPropagation();
			}).delegate('.toolbar-search-view .sure', 'click', function(e) {
                // 文件搜索
           	 var elem = $(this),
                fileName = elem.prev('.box').val();
           	plugin.refreshView('',fileName);
            });;
			
			 // ----------------
	         // gridView 视图事件
	         //-------------------------------------------------
	         plugin.modules.gridViewContent
	            // 选中对象
	            .delegate('.grid-check .fm-icon', 'click', function(e) {
	                 var elem = $(this),
	                     chitems = plugin.modules.checkAction.items,
	                     grid = elem.closest('.grid');
	                 elem.toggleClass('check_b').toggleClass('blank_b');
	                 if (elem.hasClass('check_b')) {
	                     chitems.push({
	                         key: grid.attr('data-key'),
	                         name: grid.attr('data-name'),
	                         address: grid.attr('data-address') || '',
	                     });
	                 } else {
	                     // 撤销
	                     for (var i = 0, len = chitems.length, key = grid.attr('data-key'); i < len; i++) {
	                         if (chitems[i].key === key) {
	                             chitems.splice(i, 1);
	                             break;
	                         }
	                     }
	                 }
	                 plugin.toggleCheckActions();
	             })
	             .delegate('.grid', 'mouseover', function(e) {
	                 var elem = $(this);
	                 if (!elem.hasClass('grid-active'))
	                     elem.addClass('grid-active');
	             })
	             .delegate('.grid', 'mouseout', function(e) {
	                 var elem = $(this),checkBox;
	                 checkBox = elem.find('.grid-check .fm-icon')
	                 if (!checkBox.hasClass('check_b'))
	                     elem.removeClass('grid-active');
	             })
	             .delegate('.grid', 'dblclick', function(e) {
	                 e.stopPropagation();
	                 var elem = $(this),
	                     key = elem.attr('data-key'),
	                     suffix = elem.attr('data-suffix');
	                 // 只有目录可以打开
	             });
			
			//grid视图文件选择
			plugin.modules.gridViewContent.delegate('.grid-check .oss-icon', 'click', function(e) {
	             var elem = $(this),
	                 chitems = plugin.module.checkAction.items,
	                 grid = elem.closest('.grid');
	             elem.toggleClass('check_b').toggleClass('blank_b');
	             if (elem.hasClass('check_b')) {
	                 // 选中
	                 chitems.push({
	                     key: grid.attr('data-key'),
	                     name: grid.attr('data-name'),
	                     address: grid.attr('data-address') || '',
	                 });
	             } else {
	                 // 撤销
	                 for (var i = 0, len = chitems.length, key = grid.attr('data-key'); i < len; i++) {
	                     if (chitems[i].key === key) {
	                         chitems.splice(i, 1);
	                         break;
	                     }
	                 }
	             }
	             plugin.toggleCheckActions();
	         });
			
			
			// 列表视图文件选择
	         plugin.modules.listView.delegate('.list-check', 'click', function(e) {
	             e.stopPropagation();
	             var elem = $(this),
	                 type = elem.attr('node-type'),
	                 chitems = plugin.modules.checkAction.items;
	             if (type === 'chkall') {
	                 // 全部选择
	                 chitems.splice(0, chitems.length);
	                 if (plugin.modules.listView.chkallBtn.hasClass('check')) {
	                     // 撤销所有选中项
	                     plugin.modules.listView.find('.list-check .fm-icon').each(function() {
	                         $(this).removeClass('check')
	                             .addClass('blank')
	                             .closest('.list').removeClass('item_check');
	                     });
	                 } else if (plugin.modules.listView.chkallBtn.hasClass('blank')) {
	                     // 选中所有项
	                     plugin.modules.listView.find('.list-check .fm-icon').each(function(i) {
	                         $(this).removeClass('blank')
	                             .addClass('check')
	                             .closest('.list').addClass('item_check');
	                     });
	                     plugin.modules.listViewContent.find('.list').each(function() {
	                         chitems.push({
	                             key: $(this).attr('data-key'),
	                             name: $(this).attr('data-name')
	                         });
	                     });
	                 }
	             } else if (type === 'chk') {
	                 elem.find('.fm-icon').toggleClass('check').toggleClass('blank');
	                 var list = elem.closest('.list');
	                 if (list.hasClass('item_check')) {
	                     for (var i = 0, len = chitems.length, key = list.attr('data-key'); i < len; i++) {
	                         if (chitems[i].key === key) {
	                             chitems.splice(i, 1);
	                             break;
	                         }
	                     }
	                 } else {
	                     chitems.push({
	                         key: list.attr('data-key'),
	                         name: list.attr('data-name'),
	                         address: list.attr('data-address') || '',
	                     });
	                 }
	                 list.toggleClass('item_check');
	             }
	             plugin.toggleCheckActions();
	         });
			
			
	      // 选中项具体操作
	         plugin.modules.checkAction.elem.delegate('a', 'click', function(e) {
	             var type = $(this).attr('data-key'),
	                 info,
	                 items = plugin.modules.checkAction.items,
	                 item;
	             switch (type) {
	                 case 'delete':
	                     //因为可能删除目录，所有删除的操作交给tree来操作
	                     if (window.confirm('你确定要删除所选项吗？')) {
// 	                         var env = tree.resolveEnv(),
	                         var   keys = [],
	                             key;
	                         for (var i = 0, len = items.length; i < len; i++) {
	                             keys.push(items[i].key);
	                         }
	                         if (!keys.length) {
	                             logger('没有要删除的对象', 'error');
	                             return;
	                         };

	                         key = keys.pop();
	                         plugin.deleteObject(key, function next() {
	                            key = keys.pop();
	                            if(key) {
	                            	plugin.deleteObject(key, next);
	                            } else {
	                                // 全部删除完成刷新视图
	                                plugin.refreshView();
	                            }
	                         });
	                         
	                         
	                     }
	                     break;
	                 case 'download':
	                     // 只下载文件不下载目录
	                     var items = plugin.module.checkAction.items,
	                         item;
	                     console.log('item',item);
	                         for (var i = 0, len = items.length; i < len; i++) {
	                             item = items[i];
	                             if(item.key) {
	                            	 plugin.downloadObject(item.key);
	                             }
	                         }
	                     break;
	                // @TODO
	                 case 'getimage':
	                	
	                     if (plugin.viewType === 'list') {
	                    	 plugin.clearCheckActions();
	                         alert('请在grid模式下使用');
	                     } else {
	                         var items = plugin.module.checkAction.items,
	                             item,
	                             datas = '';
	                         for (var i = 0, len = items.length; i < len; i++) {
	                             datas += '(' + i + ')' + items[i].address + '\n';
	                         }
	                         alert(datas);
	                        //  mkClipBoard(datas);
	                     }

	             }
	         });

		};

		/**
		 * 刷新当前的视图
		 * 刷新方式一， 给定key
		 * 刷新方式二， 当前环境
		 *
		 * @param key {String}
		 */
		Plugin.prototype.refreshView = function(fileType,fileName) {
			var plugin = this;
			if(!fileType){
				fileType=globalFileType;
			}
			var dataGetter=plugin.getObjects(fileType,fileName);
			dataGetter.then(function(response) {
                // 构建目录树
                plugin.refreshListView(response);
                plugin.refreshGridView(response);
            }, function(err) {
            	console.log(err);
            });
			plugin.clearCheckActions();

		}

		// object选中事件
		Plugin.prototype.toggleCheckActions = function toggleCheckActions() {
			var plugin = this, modules = plugin.modules;
			var num = modules.checkAction.items.length;
			if (num) {
				modules.checkAction.elem.show()
				modules.checkAction.elem.find('.text span:first').text(num);
			} else {
				modules.checkAction.elem.hide();
			}
		};

		// 清空选中项
		Plugin.prototype.clearCheckActions = function clearCheckActions() {
			var plugin = this, modules = plugin.modules;
			modules.checkAction.items.splice(0);
			plugin.toggleCheckActions();
		}
		
		
		 /**
	     *
	     * 删除指定的文件
	     */
	     Plugin.prototype.deleteObject = function(id,callback) {
	        var service = this;
	        return $.ajax({
	            url: '/file/public/deleteObject',
	            type: 'post',
	            data: {
	                bucket: '',
	                id: id,
	                userId:userId
	            }
	        }).done(function() {
                if(callback) {
                    callback();
                }
            });
	    }
		 
	     /**
	      * 下载文件
	      */
	      Plugin.prototype.downloadObject = function(key){
// 	         var service = this;
 	         var url='/file/public/download'+'?bucket='+"&ossFileId="+key+"&userId="+userId;
	         window.location.href=url;

	     }
	     
	      /**
		      * 获取文件
		      */
		   Plugin.prototype.getObjects = function(fileType,fileName) {
	          var service = this;
	          return $.ajax({
	              url: '/fileCommon/public/objects',
	              type:'get',
	              data: {
	            	  fileType: fileType,
	            	  fileName: fileName,
	                  userId:userId
	              }
	          });
	      }
	      
	      
		
	     /**
	      * 刷新列表视图
	      * @param data {Object}
	      */
	     Plugin.prototype.refreshListView = function(data) {
	         var plugin = this,
	             listContent = plugin.modules.listViewContent,
	             folder,
	             file,
	             tmpl = '',
	             data;
	        /*  if (!plugin.modules.listView.is(':visible'))
	             plugin.modules.listView.show(); */
	         if (listContent.length) {
	             $.each(data, function(index) {
	                 file = data[index];
	                 suffix = getSuffix(file.Name || file.Key);
	                 tmpl += Template.ModuleListViewLi.render({
	                     FILE_MODIFIED: formatDate(file.LastModified, 'yyyy-MM-dd') || '-',
	                     FILE_SIZE: formatFileSize(file.Size) || '-',
	                     address: file.address || '-',
	                     ICON: getIcon( suffix || 'txt', 0),
	                     NAME: file.Name || file.Key, // oss中的文件key为name
	                     KEY: file.id
	                 });
	             });
	         }
	         listContent.empty().append(tmpl);
	         // 重置选中项
	         plugin.modules.listView.chkallBtn.addClass('blank').removeClass('check');
	         plugin.clearCheckActions();
	     };

	     /**
	      * 刷新Grid视图
	      * @param data {Object}
	      */
	     Plugin.prototype.refreshGridView = function(datas) {
	         var plugin = this,
	             modules = plugin.modules,
	             gridContent = plugin.modules.gridViewContent,
	             tmpl = '',
	             src,
	             suffix, folder, file,
	             files = datas;

	        /*  if (!modules.gridView.is(':visible'))
	             modules.gridView.show(); */

	         if (gridContent.length) {
	             $.each(files, function(index) {
	                 file = files[index];
	                 suffix = getSuffix(file.Name || file.Key);
	                 if (isImage(suffix)) {
	                     tmpl += Template.ModuleGridViewBox_IMG.render({
	                         NAME: file.Name,
	                         address: file.address,
	                         KEY: file.id,
	                         SUFFIX: suffix,
	                         address: file.address
	                     });
	                 } else {
	                     tmpl += Template.ModuleGridViewBox.render({
	                         NAME: file.Name,
	                         address: file.address || '-',
	                         suffix: suffix,
	                         KEY: file.id,
	                         ICON: getIcon(suffix || 'txt', 1),
	                         SUFFIX: suffix,
	                     });
	                 }
	             });
	         }
	         gridContent.empty();
	         gridContent.append(tmpl);
	         plugin.clearCheckActions();

	     };
