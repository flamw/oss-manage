/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50716
 Source Host           : localhost
 Source Database       : flame

 Target Server Type    : MySQL
 Target Server Version : 50716
 File Encoding         : utf-8

 Date: 04/09/2017 17:55:56 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `t_file`
-- ----------------------------
DROP TABLE IF EXISTS `t_file`;
CREATE TABLE `t_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `domain` varchar(52) DEFAULT NULL COMMENT '文件所在域',
  `bucket` varchar(32) DEFAULT NULL COMMENT '文件所属bucket',
  `file_name` varchar(102) DEFAULT NULL COMMENT '文件名称',
  `is_file` int(1) DEFAULT '0' COMMENT '是否为文件 0:是，1:文件夹',
  `file_type` varchar(102) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL COMMENT '文件大小 ，单位：byte',
  `relative_path` varchar(150) DEFAULT NULL COMMENT '文件相对路径',
  `absolute_path` varchar(200) DEFAULT NULL COMMENT '文件绝对路径',
  `address` varchar(200) DEFAULT NULL COMMENT '访问地址',
  `addition` varchar(500) DEFAULT NULL COMMENT '冗余字段',
  `atime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `mtime` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='文件信息';

-- ----------------------------
--  Records of `t_file`
-- ----------------------------
BEGIN;
INSERT INTO `t_file` VALUES ('52', null, 'flame-img', 'abc', '1', null, null, '/abc', null, null, '', '2017-04-08 11:04:24', '2017-04-08 11:04:24'), ('54', null, 'flame-img', 'dd', '1', null, null, '/abc/dd', null, null, '', '2017-04-08 11:05:36', '2017-04-08 11:05:36');
COMMIT;

-- ----------------------------
--  Table structure for `t_folder`
-- ----------------------------
DROP TABLE IF EXISTS `t_folder`;
CREATE TABLE `t_folder` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `bucket` varchar(100) DEFAULT NULL COMMENT 'bucket',
  `folder_name` varchar(50) NOT NULL COMMENT '文件夹名称',
  `pid` int(11) DEFAULT NULL COMMENT '父id',
  `permission` int(1) DEFAULT '0' COMMENT '权限 0:私有，只能文件所属用户可见，1:公有，所有用户可见',
  `user_id` int(11) NOT NULL COMMENT '所属用户id',
  `ctime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='文件夹信息表';

-- ----------------------------
--  Table structure for `t_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
  `menu_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(32) NOT NULL COMMENT '菜单名称',
  `pid` int(11) DEFAULT NULL COMMENT '父id',
  `url` varchar(100) DEFAULT NULL COMMENT '菜单url',
  `ctime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
--  Records of `t_menu`
-- ----------------------------
BEGIN;
INSERT INTO `t_menu` VALUES ('1', '用户管理', null, '/user/', '2017-03-31 15:36:22', '2017-03-31 15:36:22'), ('2', '日志管理', null, '/sysLog/', '2017-03-31 15:36:45', '2017-03-31 15:36:45'), ('3', '文件管理', null, '/file/manage', '2017-03-31 15:37:41', '2017-03-31 15:37:41');
COMMIT;

-- ----------------------------
--  Table structure for `t_oss_file`
-- ----------------------------
DROP TABLE IF EXISTS `t_oss_file`;
CREATE TABLE `t_oss_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `bucket` varchar(32) DEFAULT NULL COMMENT '文件所属bucket',
  `file_name` varchar(102) DEFAULT NULL COMMENT '文件名称',
  `file_type` varchar(102) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL COMMENT '文件大小 ，单位：byte',
  `oss_key` varchar(50) DEFAULT NULL COMMENT '上传阿里云key',
  `url` varchar(200) DEFAULT NULL COMMENT '访问地址',
  `folder_id` int(11) NOT NULL COMMENT '所属文件夹',
  `atime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `mtime` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='阿里云文件信息表';

-- ----------------------------
--  Table structure for `t_question`
-- ----------------------------
DROP TABLE IF EXISTS `t_question`;
CREATE TABLE `t_question` (
  `question_id` int(11) NOT NULL COMMENT '问题id',
  `question_type` int(1) DEFAULT NULL COMMENT '问题类型',
  `question_desc` varchar(100) DEFAULT NULL COMMENT '问题描述',
  `ctime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='密码找回问题表';

-- ----------------------------
--  Records of `t_question`
-- ----------------------------
BEGIN;
INSERT INTO `t_question` VALUES ('1', '1', '我外公的名字？', '2017-03-29 23:48:52'), ('2', '1', '我小学语文老师的名字？', '2017-03-29 23:49:14'), ('3', '2', '我比较喜欢的球类运动是？', '2017-03-29 23:49:46'), ('4', '2', '我最喜欢的食物是？', '2017-03-29 23:51:21'), ('5', '3', '我的宠物名字是？', '2017-03-29 23:51:55'), ('6', '3', '我的爱好是？', '2017-03-29 23:54:52');
COMMIT;

-- ----------------------------
--  Table structure for `t_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id，唯一标识',
  `role_name` varchar(32) DEFAULT NULL COMMENT '角色名称',
  `ctime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
--  Records of `t_role`
-- ----------------------------
BEGIN;
INSERT INTO `t_role` VALUES ('1', '管理员', '2017-03-29 15:17:59', '2017-03-29 15:17:59'), ('2', '普通用户', '2017-03-29 22:41:55', '2017-03-29 22:41:55');
COMMIT;

-- ----------------------------
--  Table structure for `t_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu` (
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单关系表';

-- ----------------------------
--  Records of `t_role_menu`
-- ----------------------------
BEGIN;
INSERT INTO `t_role_menu` VALUES ('1', '1'), ('1', '2'), ('1', '3'), ('2', '3');
COMMIT;

-- ----------------------------
--  Table structure for `t_sys_log`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_log`;
CREATE TABLE `t_sys_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `operation_type` varchar(50) DEFAULT NULL COMMENT '操作类型',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `ctime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
--  Records of `t_sys_log`
-- ----------------------------
BEGIN;
INSERT INTO `t_sys_log` VALUES ('1', '11', '1', 'sdd', null, '2017-04-09 16:25:42'), ('2', '28', 'dashen', '平台登陆', null, '2017-04-09 17:15:14'), ('3', '28', 'dashen', '文件上传', '上传文件名称：67D344239D287A66B6C53ABD9AAD7D5F.jpg', '2017-04-09 17:15:40'), ('4', '28', 'dashen', '文件上传', '上传文件名称：0228.numbers', '2017-04-09 17:17:51'), ('5', '28', 'dashen', '平台登陆', null, '2017-04-09 17:27:40'), ('6', '28', 'dashen', '新增文件夹', null, '2017-04-09 17:27:56'), ('7', '28', 'dashen', '新增文件夹', null, '2017-04-09 17:28:02'), ('8', '28', 'dashen', '文件上传', '136.pic_hd.jpg', '2017-04-09 17:30:13'), ('9', '28', 'dashen', '文件上传', '没有映射关系的专营店.xls', '2017-04-09 17:31:10'), ('10', '28', 'dashen', '文件上传', '0228.numbers', '2017-04-09 17:31:10'), ('11', '28', 'dashen', '文件/文件夹 删除', '', '2017-04-09 17:31:55'), ('12', '28', 'dashen', '文件/文件夹 删除', '', '2017-04-09 17:31:56'), ('13', null, null, '用户注销', null, '2017-04-09 17:32:22'), ('14', '36', 'dashen123', '平台登陆', null, '2017-04-09 17:32:28'), ('15', '36', 'dashen123', '文件上传', 'nohup.out', '2017-04-09 17:32:48'), ('16', '36', 'dashen123', '文件/文件夹 删除', '', '2017-04-09 17:33:04'), ('17', null, null, '用户注销', null, '2017-04-09 17:40:02'), ('18', '37', 'test', '用户注册', null, '2017-04-09 17:40:26'), ('19', '37', 'test', '平台登陆', null, '2017-04-09 17:40:34'), ('20', '37', 'test', '新增文件夹', 'aa', '2017-04-09 17:41:03'), ('21', '37', 'test', '文件上传', '25.pic.jpg', '2017-04-09 17:41:15'), ('22', '37', 'test', '文件下载', '25.pic.jpg', '2017-04-09 17:41:23'), ('23', '37', 'test', '文件/文件夹 删除', '', '2017-04-09 17:41:54'), ('24', null, null, '用户注销', null, '2017-04-09 17:45:14'), ('25', '37', 'test', '平台登陆', null, '2017-04-09 17:46:37'), ('26', null, null, '用户注销', null, '2017-04-09 17:46:52'), ('27', '37', 'test', '平台登陆', null, '2017-04-09 17:47:42'), ('28', '37', 'test', '文件/文件夹 删除', '', '2017-04-09 17:48:54'), ('29', '37', 'test', '文件/文件夹 删除', '', '2017-04-09 17:48:55'), ('30', '37', 'test', '文件/文件夹 删除', '', '2017-04-09 17:48:55'), ('31', '37', 'test', '文件/文件夹 删除', '', '2017-04-09 17:48:55'), ('32', null, null, '用户注销', null, '2017-04-09 17:49:12'), ('33', '28', 'dashen', '平台登陆', null, '2017-04-09 17:49:17'), ('34', '28', 'dashen', '用户删除', null, '2017-04-09 17:49:46'), ('35', null, null, '用户注销', null, '2017-04-09 17:50:16'), ('36', '38', 'admin', '用户注册', null, '2017-04-09 17:50:33'), ('37', '38', 'admin', '平台登陆', null, '2017-04-09 17:50:41'), ('38', null, null, '用户注销', null, '2017-04-09 17:51:07'), ('39', '38', 'admin', '平台登陆', null, '2017-04-09 17:51:15'), ('40', '38', 'admin', '文件/文件夹 删除', '', '2017-04-09 17:51:26'), ('41', '38', 'admin', '文件/文件夹 删除', '', '2017-04-09 17:51:34'), ('42', '38', 'admin', '文件/文件夹 删除', '', '2017-04-09 17:51:40'), ('43', '38', 'admin', '文件/文件夹 删除', '', '2017-04-09 17:51:42'), ('44', '38', 'admin', '用户注销', null, '2017-04-09 17:53:22'), ('45', '38', 'admin', '平台登陆', null, '2017-04-09 17:53:26');
COMMIT;

-- ----------------------------
--  Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id，唯一标识',
  `user_name` varchar(32) NOT NULL COMMENT '用户名称',
  `password` varchar(32) NOT NULL COMMENT '密码，md5加密',
  `role_id` int(11) DEFAULT NULL COMMENT '角色id',
  `status` int(1) DEFAULT '0' COMMENT '状态 0:正常，1:已删除',
  `ctime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
--  Records of `t_user`
-- ----------------------------
BEGIN;
INSERT INTO `t_user` VALUES ('28', 'dashen', 'e99a18c428cb38d5f260853678922e03', '1', '0', '2017-04-01 23:30:58', '2017-04-02 14:19:57'), ('30', 'amw', 'd41d8cd98f00b204e9800998ecf8427e', '2', '0', '2017-04-01 23:42:37', '2017-04-01 23:42:37'), ('31', 'amsd', 'd41d8cd98f00b204e9800998ecf8427e', '1', '0', '2017-04-01 23:44:37', '2017-04-01 23:44:37'), ('32', '123', '4297f44b13955235245b2497399d7a93', '2', '1', '2017-04-01 23:46:53', '2017-04-01 23:46:53'), ('33', 'da', '4297f44b13955235245b2497399d7a93', '2', '0', '2017-04-02 00:38:07', '2017-04-02 00:38:07'), ('34', 'gg', '91901b18f5bd120309664b97d9792b71', '2', '0', '2017-04-02 00:42:52', '2017-04-02 00:42:52'), ('35', 'abc', '4297f44b13955235245b2497399d7a93', '2', '0', '2017-04-02 12:46:29', '2017-04-02 12:46:29'), ('36', 'dashen123', 'e99a18c428cb38d5f260853678922e03', '2', '0', '2017-04-09 02:05:59', '2017-04-09 02:05:59'), ('37', 'test', 'd9f6e636e369552839e7bb8057aeb8da', '2', '1', '2017-04-09 17:40:26', '2017-04-09 17:46:27'), ('38', 'admin', '0192023a7bbd73250516f069df18b500', '1', '0', '2017-04-09 17:50:33', '2017-04-09 17:50:33');
COMMIT;

-- ----------------------------
--  Table structure for `t_user_file`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_file`;
CREATE TABLE `t_user_file` (
  `user_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  `permission` int(1) DEFAULT '0' COMMENT '权限 0:私有，只能文件所属用户可见，1:公有，所有用户可见',
  UNIQUE KEY `primary_index` (`user_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与文件关系表';

-- ----------------------------
--  Records of `t_user_file`
-- ----------------------------
BEGIN;
INSERT INTO `t_user_file` VALUES ('28', '52', '0'), ('28', '54', '0');
COMMIT;

-- ----------------------------
--  Table structure for `t_user_question`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_question`;
CREATE TABLE `t_user_question` (
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `question_id` int(11) DEFAULT NULL COMMENT '问题id',
  `answer` varchar(100) DEFAULT NULL COMMENT '用户答案',
  UNIQUE KEY `primary_index` (`user_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_user_question`
-- ----------------------------
BEGIN;
INSERT INTO `t_user_question` VALUES ('28', '1', 'a'), ('28', '3', 'b'), ('28', '5', 'c'), ('29', '1', 'a'), ('29', '3', 'b'), ('29', '5', 'c'), ('30', '1', '1'), ('30', '3', '2'), ('30', '5', '3'), ('31', '1', '123123'), ('31', '3', '123123'), ('31', '5', '123'), ('32', '1', '123'), ('32', '3', '123'), ('32', '5', '123'), ('33', '1', '1'), ('33', '3', '2'), ('33', '5', '3'), ('34', '1', '1'), ('34', '3', '23'), ('34', '5', '3'), ('35', '1', '123'), ('35', '3', '123'), ('35', '5', '123'), ('36', '1', 'a'), ('36', '3', 'b'), ('36', '5', 'c'), ('37', '1', 'a'), ('37', '3', 'd'), ('37', '5', 'b'), ('38', '1', 'a'), ('38', '3', 'b'), ('38', '5', 'c');
COMMIT;

-- ----------------------------
--  Table structure for `t_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色关系表';

-- ----------------------------
--  Records of `t_user_role`
-- ----------------------------
BEGIN;
INSERT INTO `t_user_role` VALUES ('1', '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
