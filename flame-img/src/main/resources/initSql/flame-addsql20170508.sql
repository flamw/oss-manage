
drop table  t_menu;

CREATE TABLE `t_menu` (
  `menu_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(32) NOT NULL COMMENT '菜单名称',
  `pid` int(11) DEFAULT NULL COMMENT '父id',
  `url` varchar(100) DEFAULT NULL COMMENT '菜单url',
  `menu_icon` varchar(100) DEFAULT NULL COMMENT '菜单图片',
  `sort` int(11) DEFAULT NULL COMMENT '排序号',
  `ctime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='菜单表'；

insert into `t_menu` ( `pid`, `sort`, `ctime`, `menu_icon`, `menu_name`, `mtime`, `menu_id`, `url`) values ( null, '1', '2017-03-31 15:36:22', 'fa-users', '用户管理', '2017-03-31 15:36:22', '1', '/user/');
insert into `t_menu` ( `pid`, `sort`, `ctime`, `menu_icon`, `menu_name`, `mtime`, `menu_id`, `url`) values ( null, '2', '2017-03-31 15:36:45', 'fa-cogs', '日志管理', '2017-03-31 15:36:45', '2', '/sysLog/');
insert into `t_menu` ( `pid`, `sort`, `ctime`, `menu_icon`, `menu_name`, `mtime`, `menu_id`, `url`) values ( null, '3', '2017-03-31 15:37:41', 'fa-briefcase', '文件管理', '2017-03-31 15:37:41', '3', '/file/manage');
insert into `t_menu` ( `pid`, `sort`, `ctime`, `menu_icon`, `menu_name`, `mtime`, `menu_id`, `url`) values ( null, '4', '2017-04-21 21:51:43', 'fa-cloud', '共享文件', '2017-04-21 21:51:43', '4', '/shareFile/');
insert into `t_menu` ( `pid`, `sort`, `ctime`, `menu_icon`, `menu_name`, `mtime`, `menu_id`, `url`) values ( null, '5', '2017-05-08 21:30:59', 'fa-book', '文档', '2017-05-08 21:30:59', '5', '/fileCommon/?fileType=DOCUMENT');
insert into `t_menu` ( `pid`, `sort`, `ctime`, `menu_icon`, `menu_name`, `mtime`, `menu_id`, `url`) values ( null, '6', '2017-05-08 21:31:29', 'fa-headphones', '音乐', '2017-05-08 21:31:29', '6', '/fileCommon/?fileType=MUSIC');
insert into `t_menu` ( `pid`, `sort`, `ctime`, `menu_icon`, `menu_name`, `mtime`, `menu_id`, `url`) values ( null, '7', '2017-05-08 21:31:55', 'fa-film', '视频', '2017-05-08 21:31:55', '7', '/fileCommon/?fileType=VIDEO');
insert into `t_menu` ( `pid`, `sort`, `ctime`, `menu_icon`, `menu_name`, `mtime`, `menu_id`, `url`) values ( null, '8', '2017-05-08 21:32:17', 'fa-camera', '图片', '2017-05-08 21:32:17', '8', '/fileCommon/?fileType=PICTURE');
insert into `t_menu` ( `pid`, `sort`, `ctime`, `menu_icon`, `menu_name`, `mtime`, `menu_id`, `url`) values ( null, '9', '2017-05-08 21:32:31', 'fa-pencil-square-o', '笔记本', '2017-05-08 21:32:31', '9', '/fileCommon/note');

delete from t_role_menu;

insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '1', '1');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '1', '2');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '1', '3');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '1', '4');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '1', '5');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '1', '6');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '1', '7');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '1', '8');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '1', '9');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '2', '3');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '2', '4');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '2', '5');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '2', '6');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '2', '7');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '2', '8');
insert into `t_role_menu` ( `role_id`, `menu_id`) values ( '2', '9');


CREATE TABLE `t_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` text COMMENT '评论内容',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(100) DEFAULT NULL COMMENT '用户名',
  `file_id` int(11) DEFAULT NULL COMMENT '所属文件id',
  `ctime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='评论信息表';


CREATE TABLE `t_note` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `note_title` varchar(100) DEFAULT NULL COMMENT '笔记标题',
  `content` text COMMENT '笔记内容',
  `user_id` int(11) DEFAULT NULL COMMENT '所属用户',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `mtime` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='记事本';



CREATE TABLE `t_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL COMMENT '消息标题',
  `content` varchar(2000) DEFAULT NULL COMMENT '消息内容',
  `user_id` int(11) DEFAULT NULL COMMENT '发布者',
  `user_name` varchar(150) DEFAULT NULL COMMENT '发布者名称',
  `publish_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='消息通知信息表';



CREATE TABLE `t_user_message` (
  `user_id` int(11) DEFAULT NULL,
  `message_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息用户关联表';