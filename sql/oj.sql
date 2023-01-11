/*
SQLyog Ultimate v12.14 (64 bit)
MySQL - 8.0.29 : Database - oj
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`oj` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `oj`;

/*Table structure for table `admin_sys_notice` */

DROP TABLE IF EXISTS `admin_sys_notice`;

CREATE TABLE `admin_sys_notice` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) DEFAULT NULL COMMENT '标题',
  `content` LONGTEXT COMMENT '内容',
  `type` VARCHAR(255) DEFAULT NULL COMMENT '发给哪些用户类型',
  `state` TINYINT(1) DEFAULT '0' COMMENT '是否已拉取给用户',
  `recipient_id` VARCHAR(32) DEFAULT NULL COMMENT '接受通知的用户id',
  `admin_id` VARCHAR(32) DEFAULT NULL COMMENT '发送通知的管理员id',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `admin_sys_notice` */

/*Table structure for table `announcement` */

DROP TABLE IF EXISTS `announcement`;

CREATE TABLE `announcement` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL COMMENT '公告标题',
  `content` LONGTEXT COMMENT '公告正文',
  `uid` VARCHAR(255) DEFAULT NULL COMMENT '发布公告用户',
  `status` INT DEFAULT '0' COMMENT '0可见，1不可见',
  `gid` BIGINT UNSIGNED DEFAULT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `announcement` */

/*Table structure for table `auth` */

DROP TABLE IF EXISTS `auth`;

CREATE TABLE `auth` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) DEFAULT NULL COMMENT '权限名称',
  `permission` VARCHAR(100) DEFAULT NULL COMMENT '权限字符串',
  `status` TINYINT NOT NULL DEFAULT '0' COMMENT '0可用，1不可用',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `auth` */

/*Table structure for table `classes` */

DROP TABLE IF EXISTS `classes`;

CREATE TABLE `classes` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '班级id',
  `classes_college` VARCHAR(25) DEFAULT NULL COMMENT '学院',
  `classes_major` VARCHAR(25) DEFAULT NULL COMMENT '专业',
  `classes_name` VARCHAR(25) DEFAULT NULL COMMENT '班级',
  `owner` VARCHAR(255) NOT NULL COMMENT '班级管理教师用户名',
  `uid` VARCHAR(32) NOT NULL COMMENT '班级管理教师用户id',
  `code` VARCHAR(6) DEFAULT NULL COMMENT '邀请码',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb3;

/*Data for the table `classes` */

/*Table structure for table `classes_member` */

DROP TABLE IF EXISTS `classes_member`;

CREATE TABLE `classes_member` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` BIGINT UNSIGNED NOT NULL COMMENT '班级id',
  `uid` VARCHAR(32) NOT NULL COMMENT '用户id',
  `auth` INT DEFAULT '1' COMMENT '1普通学生，2班级任课老师',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cid` (`cid`,`uid`)
) ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb3;

/*Data for the table `classes_member` */

/*Table structure for table `contest` */

DROP TABLE IF EXISTS `contest`;

CREATE TABLE `contest` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(32) NOT NULL COMMENT '比赛创建者id',
  `author` VARCHAR(255) DEFAULT NULL COMMENT '比赛创建者的用户名',
  `title` VARCHAR(255) DEFAULT NULL COMMENT '比赛标题',
  `type` INT NOT NULL DEFAULT '0' COMMENT '0为acm赛制，1为比分赛制',
  `description` LONGTEXT COMMENT '比赛说明',
  `source` INT DEFAULT '0' COMMENT '比赛来源，原创为0，克隆赛为比赛id',
  `auth` INT NOT NULL COMMENT '0为公开赛，1为私有赛（访问有密码），2为保护赛（提交有密码）',
  `pwd` VARCHAR(255) DEFAULT NULL COMMENT '比赛密码',
  `start_time` DATETIME DEFAULT NULL COMMENT '开始时间',
  `end_time` DATETIME DEFAULT NULL COMMENT '结束时间',
  `duration` BIGINT DEFAULT NULL COMMENT '比赛时长(s)',
  `seal_rank` TINYINT(1) DEFAULT '0' COMMENT '是否开启封榜',
  `seal_rank_time` DATETIME DEFAULT NULL COMMENT '封榜起始时间，一直到比赛结束，不刷新榜单',
  `auto_real_rank` TINYINT(1) DEFAULT '1' COMMENT '比赛结束是否自动解除封榜,自动转换成真实榜单',
  `status` INT DEFAULT NULL COMMENT '-1为未开始，0为进行中，1为已结束',
  `visible` TINYINT(1) DEFAULT '1' COMMENT '是否可见',
  `open_print` TINYINT(1) DEFAULT '0' COMMENT '是否打开打印功能',
  `open_account_limit` TINYINT(1) DEFAULT '0' COMMENT '是否开启账号限制',
  `account_limit_rule` MEDIUMTEXT COMMENT '账号限制规则',
  `rank_show_name` VARCHAR(20) DEFAULT 'username' COMMENT '排行榜显示（username、nickname、realname）',
  `open_rank` TINYINT(1) DEFAULT '0' COMMENT '是否开放比赛榜单',
  `star_account` MEDIUMTEXT COMMENT '打星用户列表',
  `oi_rank_score_type` VARCHAR(255) DEFAULT 'Recent' COMMENT 'oi排行榜得分方式，Recent、Highest',
  `is_group` TINYINT(1) DEFAULT '0',
  `gid` BIGINT UNSIGNED DEFAULT NULL,
  `award_type` INT DEFAULT '0' COMMENT '奖项类型：0(不设置),1(设置占比),2(设置人数)',
  `award_config` TEXT COMMENT '奖项配置 json',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`uid`)
) ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb3;

/*Data for the table `contest` */

/*Table structure for table `contest_announcement` */

DROP TABLE IF EXISTS `contest_announcement`;

CREATE TABLE `contest_announcement` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aid` BIGINT UNSIGNED NOT NULL COMMENT '公告id',
  `cid` BIGINT UNSIGNED NOT NULL COMMENT '比赛id',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `contest_announcement` */

/*Table structure for table `contest_explanation` */

DROP TABLE IF EXISTS `contest_explanation`;

CREATE TABLE `contest_explanation` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` BIGINT UNSIGNED NOT NULL,
  `uid` VARCHAR(32) NOT NULL COMMENT '发布者（必须为比赛创建者或者超级管理员才能）',
  `content` LONGTEXT COMMENT '内容(支持markdown)',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `contest_explanation` */

/*Table structure for table `contest_print` */

DROP TABLE IF EXISTS `contest_print`;

CREATE TABLE `contest_print` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) DEFAULT NULL,
  `realname` VARCHAR(100) DEFAULT NULL,
  `cid` BIGINT UNSIGNED DEFAULT NULL,
  `content` LONGTEXT NOT NULL,
  `status` INT DEFAULT '0',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `contest_print` */

/*Table structure for table `contest_problem` */

DROP TABLE IF EXISTS `contest_problem`;

CREATE TABLE `contest_problem` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `display_id` VARCHAR(255) NOT NULL COMMENT '该题目在比赛中的顺序id',
  `cid` BIGINT UNSIGNED NOT NULL COMMENT '比赛id',
  `pid` BIGINT UNSIGNED NOT NULL COMMENT '题目id',
  `display_title` VARCHAR(255) NOT NULL COMMENT '该题目在比赛中的标题，默认为原名字',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`cid`,`pid`),
  UNIQUE KEY `display_id` (`display_id`,`cid`,`pid`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `contest_problem` */

/*Table structure for table `contest_record` */

DROP TABLE IF EXISTS `contest_record`;

CREATE TABLE `contest_record` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cid` BIGINT UNSIGNED DEFAULT NULL COMMENT '比赛id',
  `uid` VARCHAR(255) NOT NULL COMMENT '用户id',
  `pid` BIGINT UNSIGNED DEFAULT NULL COMMENT '题目id',
  `cpid` BIGINT UNSIGNED DEFAULT NULL COMMENT '比赛中的题目的id',
  `username` VARCHAR(255) DEFAULT NULL COMMENT '用户名',
  `realname` VARCHAR(255) DEFAULT NULL COMMENT '真实姓名',
  `display_id` VARCHAR(255) DEFAULT NULL COMMENT '比赛中展示的id',
  `submit_id` BIGINT UNSIGNED NOT NULL COMMENT '提交id，用于可重判',
  `status` INT DEFAULT NULL COMMENT '提交结果，0表示未AC通过不罚时，1表示AC通过，-1为未AC通过算罚时',
  `submit_time` DATETIME NOT NULL COMMENT '具体提交时间',
  `time` BIGINT UNSIGNED DEFAULT NULL COMMENT '提交时间，为提交时间减去比赛时间',
  `score` INT DEFAULT NULL COMMENT 'OI比赛的得分',
  `use_time` INT DEFAULT NULL COMMENT '运行耗时',
  `checked` TINYINT(1) DEFAULT '0' COMMENT 'AC是否已校验',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`submit_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `contest_record` */

/*Table structure for table `contest_score` */

DROP TABLE IF EXISTS `contest_score`;

CREATE TABLE `contest_score` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` BIGINT UNSIGNED NOT NULL,
  `last` INT DEFAULT NULL COMMENT '比赛前的score得分',
  `change` INT DEFAULT NULL COMMENT 'Score比分变化',
  `now` INT DEFAULT NULL COMMENT '现在的score',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`cid`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `contest_score` */

/*Table structure for table `file` */

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` VARCHAR(32) DEFAULT NULL COMMENT '用户id',
  `name` VARCHAR(255) NOT NULL COMMENT '文件名',
  `suffix` VARCHAR(255) NOT NULL COMMENT '文件后缀格式',
  `folder_path` VARCHAR(255) NOT NULL COMMENT '文件所在文件夹的路径',
  `file_path` VARCHAR(255) DEFAULT NULL COMMENT '文件绝对路径',
  `type` VARCHAR(255) DEFAULT NULL COMMENT '文件所属类型，例如avatar',
  `delete` TINYINT(1) DEFAULT '0' COMMENT '是否删除',
  `gid` BIGINT UNSIGNED DEFAULT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `file` */

/*Table structure for table `group` */

DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像地址',
  `name` VARCHAR(25) DEFAULT NULL COMMENT '团队名称',
  `short_name` VARCHAR(10) DEFAULT NULL COMMENT '团队简称，创建题目时题号自动添加的前缀',
  `brief` VARCHAR(50) DEFAULT NULL COMMENT '团队简介',
  `description` LONGTEXT COMMENT '团队介绍',
  `owner` VARCHAR(255) NOT NULL COMMENT '团队拥有者用户名',
  `uid` VARCHAR(32) NOT NULL COMMENT '团队拥有者用户id',
  `auth` INT NOT NULL COMMENT '0为Public，1为Protected，2为Private',
  `visible` TINYINT(1) DEFAULT '1' COMMENT '是否可见',
  `status` TINYINT(1) DEFAULT '0' COMMENT '是否封禁',
  `code` VARCHAR(6) DEFAULT NULL COMMENT '邀请码',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb3;

/*Data for the table `group` */

/*Table structure for table `group_member` */

DROP TABLE IF EXISTS `group_member`;

CREATE TABLE `group_member` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `gid` BIGINT UNSIGNED NOT NULL COMMENT '团队id',
  `uid` VARCHAR(32) NOT NULL COMMENT '用户id',
  `auth` INT DEFAULT '1' COMMENT '1未审批，2拒绝，3普通成员，4团队管理员，5团队拥有者',
  `reason` VARCHAR(100) DEFAULT NULL COMMENT '申请理由',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gid` (`gid`,`uid`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `group_member` */

/*Table structure for table `language` */

DROP TABLE IF EXISTS `language`;

CREATE TABLE `language` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content_type` VARCHAR(255) DEFAULT NULL COMMENT '语言类型',
  `description` VARCHAR(255) DEFAULT NULL COMMENT '语言描述',
  `name` VARCHAR(255) DEFAULT NULL COMMENT '语言名字',
  `compile_command` MEDIUMTEXT COMMENT '编译指令',
  `template` LONGTEXT COMMENT '模板',
  `code_template` LONGTEXT COMMENT '语言默认代码模板',
  `is_spj` TINYINT(1) DEFAULT '0' COMMENT '是否可作为特殊判题的一种语言',
  `oj` VARCHAR(255) DEFAULT NULL COMMENT '该语言属于哪个oj，自身oj用ME',
  `seq` INT DEFAULT '0' COMMENT '语言排序',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb3;

/*Data for the table `language` */

INSERT  INTO `language`(`id`,`content_type`,`description`,`name`,`compile_command`,`template`,`code_template`,`is_spj`,`oj`,`seq`,`create_time`,`update_time`) VALUES 
(1,'text/x-csrc','GCC 9.4.0','C','/usr/bin/gcc -DONLINE_JUDGE -w -fmax-errors=3 -std=c11 {src_path} -lm -o {exe_path}','#include <stdio.h>\r\nint main() {\r\n    int a,b;\r\n    scanf(\"%d %d\",&a,&b);\r\n    printf(\"%d\",a+b);\r\n    return 0;\r\n}','//PREPEND BEGIN\r\n#include <stdio.h>\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  printf(\"%d\", add(1, 2));\r\n  return 0;\r\n}\r\n//APPEND END',1,'ME',0,'2020-12-12 23:11:44','2021-06-14 21:40:28'),
(2,'text/x-csrc','GCC 9.4.0','C With O2','/usr/bin/gcc -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c11 {src_path} -lm -o {exe_path}','#include <stdio.h>\r\nint main() {\r\n    int a,b;\r\n    scanf(\"%d %d\",&a,&b);\r\n    printf(\"%d\",a+b);\r\n    return 0;\r\n}','//PREPEND BEGIN\r\n#include <stdio.h>\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  printf(\"%d\", add(1, 2));\r\n  return 0;\r\n}\r\n//APPEND END',0,'ME',0,'2021-06-14 21:05:57','2021-06-14 21:20:08'),
(3,'text/x-c++src','G++ 9.4.0','C++','/usr/bin/g++ -DONLINE_JUDGE -w -fmax-errors=3 -std=c++14 {src_path} -lm -o {exe_path}','#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}','//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END',1,'ME',0,'2020-12-12 23:12:44','2021-06-14 21:40:36'),
(4,'text/x-c++src','G++ 9.4.0','C++ With O2','/usr/bin/g++ -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c++14 {src_path} -lm -o {exe_path}','#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}','//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END',0,'ME',0,'2021-06-14 21:09:35','2021-06-14 21:20:19'),
(5,'text/x-c++src','G++ 9.4.0','C++ 17','/usr/bin/g++ -DONLINE_JUDGE -w -fmax-errors=3 -std=c++17 {src_path} -lm -o {exe_path}','#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}','//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END',0,'ME',0,'2020-12-12 23:12:44','2021-06-14 21:40:36'),
(6,'text/x-c++src','G++ 9.4.0','C++ 17 With O2','/usr/bin/g++ -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c++17 {src_path} -lm -o {exe_path}','#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}','//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END',0,'ME',0,'2021-06-14 21:09:35','2021-06-14 21:20:19'),
(7,'text/x-c++src','G++ 9.4.0','C++ 20','/usr/bin/g++ -DONLINE_JUDGE -w -fmax-errors=3 -std=c++20 {src_path} -lm -o {exe_path}','#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}','//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END',0,'ME',0,'2020-12-12 23:12:44','2021-06-14 21:40:36'),
(8,'text/x-c++src','G++ 9.4.0','C++ 20 With O2','/usr/bin/g++ -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c++20 {src_path} -lm -o {exe_path}','#include<iostream>\r\nusing namespace std;\r\nint main()\r\n{\r\n    int a,b;\r\n    cin >> a >> b;\r\n    cout << a + b;\r\n    return 0;\r\n}','//PREPEND BEGIN\r\n#include <iostream>\r\nusing namespace std;\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\nint add(int a, int b) {\r\n  // Please fill this blank\r\n  return ___________;\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nint main() {\r\n  cout << add(1, 2);\r\n  return 0;\r\n}\r\n//APPEND END',0,'ME',0,'2021-06-14 21:09:35','2021-06-14 21:20:19'),
(9,'text/x-java','OpenJDK 1.8','Java','/usr/bin/javac {src_path} -d {exe_dir} -encoding UTF8','import java.util.Scanner;\r\npublic class Main{\r\n    public static void main(String[] args){\r\n        Scanner in=new Scanner(System.in);\r\n        int a=in.nextInt();\r\n        int b=in.nextInt();\r\n        System.out.println((a+b));\r\n    }\r\n}','//PREPEND BEGIN\r\nimport java.util.Scanner;\r\n//PREPEND END\r\n\r\npublic class Main{\r\n    //TEMPLATE BEGIN\r\n    public static Integer add(int a,int b){\r\n        return _______;\r\n    }\r\n    //TEMPLATE END\r\n\r\n    //APPEND BEGIN\r\n    public static void main(String[] args){\r\n        System.out.println(add(a,b));\r\n    }\r\n    //APPEND END\r\n}\r\n',0,'ME',0,'2020-12-12 23:12:51','2021-06-14 21:19:52'),
(10,'text/x-python','Python 3.7.5','Python3','/usr/bin/python3 -m py_compile {src_path}','a, b = map(int, input().split())\r\nprint(a + b)','//PREPEND BEGIN\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\ndef add(a, b):\r\n    return a + b\r\n//TEMPLATE END\r\n\r\n\r\nif __name__ == \'__main__\':  \r\n    //APPEND BEGIN\r\n    a, b = 1, 1\r\n    print(add(a, b))\r\n    //APPEND END',0,'ME',0,'2020-12-12 23:14:23','2021-06-14 21:19:50'),
(11,'text/x-python','Python 2.7.17','Python2','/usr/bin/python -m py_compile {src_path}','a, b = map(int, raw_input().split())\r\nprint a+b','//PREPEND BEGIN\r\n//PREPEND END\r\n\r\n//TEMPLATE BEGIN\r\ndef add(a, b):\r\n    return a + b\r\n//TEMPLATE END\r\n\r\n\r\nif __name__ == \'__main__\':  \r\n    //APPEND BEGIN\r\n    a, b = 1, 1\r\n    print add(a, b)\r\n    //APPEND END',0,'ME',0,'2021-01-26 11:11:44','2021-06-14 21:19:45'),
(12,'text/x-go','Golang 1.19','Golang','/usr/bin/go build -o {exe_path} {src_path}','package main\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n    var x int\r\n    var y int\r\n    fmt.Scanln(&x,&y)\r\n    fmt.Printf(\"%d\",x+y)  \r\n}\r\n','\r\npackage main\r\n\r\n//PREPEND BEGIN\r\nimport \"fmt\"\r\n//PREPEND END\r\n\r\n\r\n//TEMPLATE BEGIN\r\nfunc add(a,b int)int{\r\n    return ______\r\n}\r\n//TEMPLATE END\r\n\r\n//APPEND BEGIN\r\nfunc main(){\r\n    var x int\r\n    var y int\r\n    fmt.Printf(\"%d\",add(x,y))  \r\n}\r\n//APPEND END\r\n',0,'ME',0,'2021-03-28 23:15:54','2021-06-14 21:20:26'),
(13,'text/x-csharp','C# Mono 4.6.2','C#','/usr/bin/mcs -optimize+ -out:{exe_path} {src_path}','using System;\r\nusing System.Linq;\r\n\r\nclass Program {\r\n    public static void Main(string[] args) {\r\n        Console.WriteLine(Console.ReadLine().Split().Select(int.Parse).Sum());\r\n    }\r\n}','//PREPEND BEGIN\r\nusing System;\r\nusing System.Collections.Generic;\r\nusing System.Text;\r\n//PREPEND END\r\n\r\nclass Solution\r\n{\r\n    //TEMPLATE BEGIN\r\n    static int add(int a,int b){\r\n        return _______;\r\n    }\r\n    //TEMPLATE END\r\n\r\n    //APPEND BEGIN\r\n    static void Main(string[] args)\r\n    {\r\n        int a ;\r\n        int b ;\r\n        Console.WriteLine(add(a,b));\r\n    }\r\n    //APPEND END\r\n}',0,'ME',0,'2021-04-13 16:10:03','2021-06-14 21:20:36'),
(14,'text/x-php','PHP 7.3.33','PHP','/usr/bin/php {src_path}','<?=array_sum(fscanf(STDIN, \"%d %d\"));',NULL,0,'ME',0,'2022-02-25 20:55:30','2022-09-20 21:43:01'),
(15,'text/x-python','PyPy 2.7.18 (7.3.8)','PyPy2','/usr/bin/pypy -m py_compile {src_path}','print sum(int(x) for x in raw_input().split(\' \'))','//PREPEND BEGIN\n//PREPEND END\n\n//TEMPLATE BEGIN\ndef add(a, b):\n    return a + b\n//TEMPLATE END\n\n\nif __name__ == \'__main__\':  \n    //APPEND BEGIN\n    a, b = 1, 1\n    print add(a, b)\n    //APPEND END',0,'ME',0,'2022-02-25 20:55:30','2022-09-20 21:43:03'),
(16,'text/x-python','PyPy 3.8.12 (7.3.8)','PyPy3','/usr/bin/pypy3 -m py_compile {src_path}','print(sum(int(x) for x in input().split(\' \')))','//PREPEND BEGIN\n//PREPEND END\n\n//TEMPLATE BEGIN\ndef add(a, b):\n    return a + b\n//TEMPLATE END\n\n\nif __name__ == \'__main__\':  \n    //APPEND BEGIN\n    a, b = 1, 1\n    print(add(a, b))\n    //APPEND END',0,'ME',0,'2022-02-25 20:55:30','2022-09-20 21:43:06'),
(17,'text/javascript','Node.js 14.19.0','JavaScript Node','/usr/bin/node {src_path}','var readline = require(\'readline\');\nconst rl = readline.createInterface({\n        input: process.stdin,\n        output: process.stdout\n});\nrl.on(\'line\', function(line){\n   var tokens = line.split(\' \');\n    console.log(parseInt(tokens[0]) + parseInt(tokens[1]));\n});',NULL,0,'ME',0,'2022-02-25 20:55:30','2022-09-20 21:43:09'),
(18,'text/javascript','JavaScript V8 8.4.109','JavaScript V8','/usr/bin/jsv8/d8 {src_path}','const [a, b] = readline().split(\' \').map(n => parseInt(n, 10));\nprint((a + b).toString());',NULL,0,'ME',0,'2022-02-25 20:55:30','2022-09-20 21:43:14'),
(19,'text/x-csrc','GCC','GCC',NULL,NULL,NULL,0,'HDU',0,'2021-02-18 21:32:34','2022-09-20 21:44:32'),
(20,'text/x-c++src','G++','G++',NULL,NULL,NULL,0,'HDU',0,'2021-02-18 21:32:58','2022-09-20 21:44:34'),
(21,'text/x-c++src','C++','C++',NULL,NULL,NULL,0,'HDU',0,'2021-02-18 21:33:11','2022-09-20 21:44:36'),
(22,'text/x-csrc','C','C',NULL,NULL,NULL,0,'HDU',0,'2021-02-18 21:33:41','2022-09-20 21:44:38'),
(23,'text/x-pascal','Pascal','Pascal',NULL,NULL,NULL,0,'HDU',0,'2021-02-18 21:34:33','2022-09-20 21:44:41'),
(24,'text/x-java','Java','Java',NULL,NULL,NULL,0,'HDU',0,'2022-09-20 21:25:00','2022-09-20 21:44:46'),
(25,'text/x-csharp','C#','C#',NULL,NULL,NULL,0,'HDU',0,'2022-09-20 21:25:00','2022-09-20 21:45:32'),
(26,'text/x-csrc','GNU GCC C11 5.1.0','GNU GCC C11 5.1.0',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(27,'text/x-c++src','Clang++17 Diagnostics','Clang++17 Diagnostics',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(28,'text/x-c++src','GNU G++14 6.4.0','GNU G++14 6.4.0',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(29,'text/x-c++src','GNU G++17 7.3.0','GNU G++17 7.3.0',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(30,'text/x-c++src','GNU G++20 11.2.0 (64 bit, winlibs)','GNU G++20 11.2.0 (64 bit, winlibs)',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(31,'text/x-c++src','Microsoft Visual C++ 2017','Microsoft Visual C++ 2017',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(32,'text/x-csharp','C# Mono 6.8','C# Mono 6.8',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(33,'text/x-d','D DMD32 v2.091.0','D DMD32 v2.091.0',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(34,'text/x-go','Go 1.15.6','Go 1.15.6',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(35,'text/x-haskell','Haskell GHC 8.10.1','Haskell GHC 8.10.1',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(36,'text/x-java','Java 1.8.0_241','Java 1.8.0_241',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(37,'text/x-java','Kotlin 1.4.0','Kotlin 1.4.0',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(38,'text/x-ocaml','OCaml 4.02.1','OCaml 4.02.1',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(39,'text/x-pascal','Delphi 7','Delphi 7',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(40,'text/x-pascal','Free Pascal 3.0.2','Free Pascal 3.0.2',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(41,'text/x-pascal','PascalABC.NET 3.4.2','PascalABC.NET 3.4.2',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(42,'text/x-perl','Perl 5.20.1','Perl 5.20.1',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(43,'text/x-php','PHP 7.2.13','PHP 7.2.13',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(44,'text/x-python','Python 2.7.18','Python 2.7.18',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(45,'text/x-python','Python 3.9.1','Python 3.9.1',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(46,'text/x-python','PyPy 2.7 (7.3.0)','PyPy 2.7 (7.3.0)',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(47,'text/x-python','PyPy 3.7 (7.3.0)','PyPy 3.7 (7.3.0)',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(48,'text/x-ruby','Ruby 3.0.0','Ruby 3.0.0',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(49,'text/x-rustsrc','Rust 1.49.0','Rust 1.49.0',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(50,'text/x-scala','Scala 2.12.8','Scala 2.12.8',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(51,'text/javascript','JavaScript V8 4.8.0','JavaScript V8 4.8.0',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(52,'text/javascript','Node.js 12.6.3','Node.js 12.6.3',NULL,NULL,NULL,0,'CF',0,'2021-03-03 19:46:24','2022-09-20 21:46:04'),
(53,'text/x-csharp','C# 8, .NET Core 3.1','C# 8, .NET Core 3.1',NULL,NULL,NULL,0,'CF',0,'2021-03-25 21:17:39','2022-09-20 21:46:04'),
(54,'text/x-java','Java 11.0.6','Java 11.0.6',NULL,NULL,NULL,0,'CF',0,'2021-03-25 21:20:03','2022-09-20 21:46:04'),
(55,'text/x-c++src','G++','G++',NULL,NULL,NULL,0,'POJ',0,'2021-06-24 22:50:50','2022-09-20 21:46:04'),
(56,'text/x-csrc','GCC','GCC',NULL,NULL,NULL,0,'POJ',0,'2021-06-24 22:51:04','2022-09-20 21:46:04'),
(57,'text/x-java','Java','Java',NULL,NULL,NULL,0,'POJ',0,'2021-06-24 22:51:29','2022-09-20 21:46:04'),
(58,'text/x-pascal','Pascal','Pascal',NULL,NULL,NULL,0,'POJ',0,'2021-06-24 22:51:50','2022-09-20 21:46:04'),
(59,'text/x-c++src','C++','C++',NULL,NULL,NULL,0,'POJ',0,'2021-06-24 22:52:15','2022-09-20 21:46:04'),
(60,'text/x-csrc','C','C',NULL,NULL,NULL,0,'POJ',0,'2021-06-24 22:52:38','2022-09-20 21:46:04'),
(61,'text/x-fortran','Fortran','Fortran',NULL,NULL,NULL,0,'POJ',0,'2021-06-24 22:55:15','2022-09-20 21:46:04');

/*Table structure for table `problem` */

DROP TABLE IF EXISTS `problem`;

CREATE TABLE `problem` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `problem_id` VARCHAR(255) NOT NULL COMMENT '问题的自定义ID 例如（HOJ-1000）',
  `title` VARCHAR(255) NOT NULL COMMENT '题目',
  `author` VARCHAR(255) DEFAULT '未知' COMMENT '作者',
  `type` INT NOT NULL DEFAULT '0' COMMENT '0为ACM,1为OI',
  `time_limit` INT DEFAULT '1000' COMMENT '时间限制,单位ms',
  `memory_limit` INT DEFAULT '65535' COMMENT '内存限制,单位mb',
  `stack_limit` INT DEFAULT '128' COMMENT '栈限制,单位mb',
  `description` LONGTEXT COMMENT '题目描述',
  `input_description` LONGTEXT COMMENT '输入描述',
  `output_description` LONGTEXT COMMENT '输出描述',
  `examples` LONGTEXT COMMENT '题面样例',
  `is_remote` TINYINT(1) DEFAULT '0' COMMENT '是否为vj判题',
  `source` TEXT COMMENT '题目来源',
  `difficulty` INT DEFAULT '0' COMMENT '题目难度,0简单，1中等，2困难',
  `hint` LONGTEXT COMMENT '备注,提醒',
  `auth` INT DEFAULT '1' COMMENT '默认为1公开，2为私有，3为比赛题目',
  `io_score` INT DEFAULT '100' COMMENT '当该题目为io题目时的分数',
  `code_share` TINYINT(1) DEFAULT '1' COMMENT '该题目对应的相关提交代码，用户是否可用分享',
  `judge_mode` VARCHAR(255) DEFAULT 'default' COMMENT '题目评测模式,default、spj、interactive',
  `judge_case_mode` VARCHAR(255) DEFAULT 'default' COMMENT '题目样例评测模式,default,subtask_lowest,subtask_average',
  `user_extra_file` MEDIUMTEXT COMMENT '题目评测时用户程序的额外文件 json key:name value:content',
  `judge_extra_file` MEDIUMTEXT COMMENT '题目评测时交互或特殊程序的额外文件 json key:name value:content',
  `spj_code` LONGTEXT COMMENT '特判程序或交互程序代码',
  `spj_language` VARCHAR(255) DEFAULT NULL COMMENT '特判程序或交互程序代码的语言',
  `is_remove_end_blank` TINYINT(1) DEFAULT '1' COMMENT '是否默认去除用户代码的文末空格',
  `open_case_result` TINYINT(1) DEFAULT '1' COMMENT '是否默认开启该题目的测试样例结果查看',
  `is_upload_case` TINYINT(1) DEFAULT '1' COMMENT '题目测试数据是否是上传文件的',
  `case_version` VARCHAR(40) DEFAULT '0' COMMENT '题目测试数据的版本号',
  `modified_user` VARCHAR(255) DEFAULT NULL COMMENT '修改题目的管理员用户名',
  `is_group` TINYINT(1) DEFAULT '0',
  `gid` BIGINT UNSIGNED DEFAULT NULL,
  `apply_public_progress` INT DEFAULT NULL COMMENT '申请公开的进度：null为未申请，1为申请中，2为申请通过，3为申请拒绝',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb3;

/*Data for the table `problem` */

/*Table structure for table `problem_case` */

DROP TABLE IF EXISTS `problem_case`;

CREATE TABLE `problem_case` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `pid` BIGINT UNSIGNED NOT NULL COMMENT '题目id',
  `input` LONGTEXT COMMENT '测试样例的输入',
  `output` LONGTEXT COMMENT '测试样例的输出',
  `score` INT DEFAULT NULL COMMENT '该测试样例的IO得分',
  `status` INT DEFAULT '0' COMMENT '0可用，1不可用',
  `group_num` INT DEFAULT '1' COMMENT 'subtask分组的编号',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `problem_case` */

/*Table structure for table `problem_language` */

DROP TABLE IF EXISTS `problem_language`;

CREATE TABLE `problem_language` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` BIGINT UNSIGNED NOT NULL,
  `lid` BIGINT UNSIGNED NOT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `problem_language` */

/*Table structure for table `problem_tag` */

DROP TABLE IF EXISTS `problem_tag`;

CREATE TABLE `problem_tag` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` BIGINT UNSIGNED NOT NULL,
  `tid` BIGINT UNSIGNED NOT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `problem_tag` */

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` BIGINT(20) UNSIGNED ZEROFILL NOT NULL,
  `role` VARCHAR(50) NOT NULL COMMENT '角色',
  `description` VARCHAR(100) DEFAULT NULL COMMENT '描述',
  `status` TINYINT NOT NULL DEFAULT '0' COMMENT '默认0可用，1不可用',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `role` */

/*Table structure for table `role_auth` */

DROP TABLE IF EXISTS `role_auth`;

CREATE TABLE `role_auth` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `auth_id` BIGINT UNSIGNED NOT NULL,
  `role_id` BIGINT UNSIGNED NOT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `role_auth` */

/*Table structure for table `session` */

DROP TABLE IF EXISTS `session`;

CREATE TABLE `session` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(255) NOT NULL,
  `user_agent` VARCHAR(512) DEFAULT NULL,
  `ip` VARCHAR(255) DEFAULT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `session` */

/*Table structure for table `tag` */

DROP TABLE IF EXISTS `tag`;

CREATE TABLE `tag` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL COMMENT '标签名字',
  `color` VARCHAR(10) DEFAULT NULL COMMENT '标签颜色',
  `gid` BIGINT UNSIGNED DEFAULT NULL,
  `tcid` BIGINT UNSIGNED DEFAULT NULL COMMENT '标签分类id',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`gid`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `tag` */

/*Table structure for table `tag_classification` */

DROP TABLE IF EXISTS `tag_classification`;

CREATE TABLE `tag_classification` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签分类名称',
  `create_time` DATETIME DEFAULT NULL,
  `update_time` DATETIME DEFAULT NULL,
  `rank` INT(10) UNSIGNED ZEROFILL DEFAULT NULL COMMENT '标签分类优先级 越小越高',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `tag_classification` */

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `id` VARCHAR(32) NOT NULL,
  `username` VARCHAR(100) NOT NULL COMMENT '用户名',
  `password` VARCHAR(100) NOT NULL COMMENT '密码',
  `nickname` VARCHAR(100) DEFAULT NULL COMMENT '昵称',
  `college` VARCHAR(100) DEFAULT NULL COMMENT '学院',
  `major` VARCHAR(100) DEFAULT NULL COMMENT '专业',
  `stuclass` VARCHAR(100) DEFAULT NULL COMMENT '班级',
  `number` VARCHAR(20) DEFAULT NULL COMMENT '学号',
  `realname` VARCHAR(100) DEFAULT NULL COMMENT '真实姓名',
  `gender` VARCHAR(20) NOT NULL DEFAULT 'secrecy' COMMENT '性别',
  `cf_username` VARCHAR(255) DEFAULT NULL COMMENT 'cf的username',
  `email` VARCHAR(320) DEFAULT NULL COMMENT '邮箱',
  `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像地址',
  `signature` MEDIUMTEXT COMMENT '个性签名',
  `deleted` INT NOT NULL DEFAULT '0' COMMENT '0未删除，1删除',
  `status` INT NOT NULL DEFAULT '0' COMMENT '0可用，1不可用',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `number` (`number`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `user_info` */

/*Table structure for table `user_role` */

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(32) NOT NULL,
  `role_id` BIGINT UNSIGNED NOT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `user_role` */

/*Table structure for table `user_sys_notice` */

DROP TABLE IF EXISTS `user_sys_notice`;

CREATE TABLE `user_sys_notice` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sys_notice_id` BIGINT UNSIGNED DEFAULT NULL COMMENT '系统通知的id',
  `recipient_id` VARCHAR(32) DEFAULT NULL COMMENT '接受通知的用户id',
  `type` VARCHAR(255) DEFAULT NULL COMMENT '消息类型，系统通知sys、我的信息mine',
  `state` TINYINT(1) DEFAULT '0' COMMENT '是否已读',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '读取时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb3;

/*Data for the table `user_sys_notice` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
