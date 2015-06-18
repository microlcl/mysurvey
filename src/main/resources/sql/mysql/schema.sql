drop table if exists category;
drop table if exists function_category;
drop table if exists functions;
drop table if exists modules;
drop table if exists papers;
drop table if exists paper_questions;
drop table if exists paper_answers;
drop table if exists question_type;
drop table if exists questions;
drop table if exists role_function;
drop table if exists roles;

drop table if exists user_role;
drop table if exists users;
drop table if exists groups;
drop table if exists survey;

CREATE TABLE `survey` (
  `survey_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` varchar(64) DEFAULT NULL,  --调查状态： N - 新建, D - 草稿, R - 可发布, P - 已发布, F - 已完成, C - 作废 
  `update_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  --更新时间
  `user_id` varchar(64) NOT NULL, -- 调查发起人
  `paper_id` bigint(20) NOT NULL,  -- 一次调查只包含一个paper

  `subject` varchar(128) DEFAULT NULL,  -- 调查问卷的主题
  `groups_id` varchar(32) NOT NULL, -- 如果有多个group，用逗号隔开
  `sent_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00', -- 调查发送时间
  `deadline_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00', -- 本次调查的最后期限
  `is_anonymous` varchar(1) DEFAULT NULL,  -- 是否是匿名调查: T - True, F - False
  `description` varchar(1280) DEFAULT NULL, -- 描述性文字，作为group的user收到的邮件内容
  `receivers` text DEFAULT NULL,  -- 调查对象名单，包括其完成状态，单个结构为  昵称^ID^0/1(是否作答)^作答时间
  PRIMARY KEY (`survey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- survey和参与调查者(receiver)的一对多映射表， survey表中的receivers字段作废
CREATE TABLE `survey_receivers` (
  `survey_id` bigint(20) NOT NULL,
  `user_id` varchar(64) NOT NULL DEFAULT '',  -- 被调查者user id(intranet id)
  `status` varchar(1) DEFAULT NULL,  -- 标识此人是否完成了此次调查 0： 未完成， 1： 已完成
  `update_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- 被调查者答题或修改时间
  `nickname` varchar(64) DEFAULT NULL, -- 群组中的昵称
  PRIMARY KEY (`survey_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `users` (
  `id` varchar(64) NOT NULL,
  `name` varchar(32),
  `password` varchar(255) NOT NULL,
   `register_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   `comment` varchar(128) DEFAULT NULL,
   `resetToken` varchar(255),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `category` (
  `id` varchar(64) NOT NULL,
  `pid` varchar(64) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `trashed` varchar(1) NOT NULL,
  `comment` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `modules` (
  `module_id` varchar(64) NOT NULL,
  `pid` varchar(64) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`module_id`),
  UNIQUE KEY `module_id` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `functions` (
  `function_id` varchar(64) NOT NULL,
  `module_id` varchar(64) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  `path` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`function_id`),
  UNIQUE KEY `function_id` (`function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `roles` (
  `role_id` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `role_function` (
  `role_id` varchar(64) NOT NULL,
  `function_id` varchar(64) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`role_id`,`function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `user_role` (
  `user_id` varchar(64) NOT NULL,
  `role_id` varchar(64) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `function_category` (
  `function_id` varchar(64) NOT NULL DEFAULT '',
  `category_id` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`function_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `papers` (
  `paper_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `paper_name` varchar(32) NOT NULL,
  `creat_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(64) DEFAULT NULL, -- 创建者的id
  `status` varchar(64) NOT NULL, -- 调查问卷的状态： draft, publish, trashed,只有publish状态的才能使用。此status在category的系统参数节点下配置，此处保存的是category id.
  `default_paper` varchar(1) DEFAULT NULL, -- 是否是某类型问卷的默认paper: T = Ture, F = False 
  `business_type` varchar(64) NOT NULL, -- 问卷业务类型，可以在category table配置
  PRIMARY KEY (`paper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;


-- 调查表
CREATE TABLE `questions` (
  `question_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `question` varchar(256) NOT NULL,
  `user_id` varchar(64) DEFAULT NULL,  -- 创建者的id
  `question_type` varchar(64) NOT NULL, -- 问题种类：单选，多选，开放式问题等 ,不用在category table里面配置
  `question_options` varchar(512) DEFAULT NULL, -- 问题答案选项，用特殊字符^分隔， 如果是开放式问题， 此字段为空
  `business_type` varchar(64) DEFAULT NULL, -- 问题类别，可以在category table配置
  `creat_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `trashed` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


CREATE TABLE `paper_questions` (
  `paper_id` bigint(20) NOT NULL,
  `question_id` bigint(20) NOT NULL,
  `position` int(11) NOT NULL, -- 问题在调查问卷中的位置
  PRIMARY KEY (`paper_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 系统表，存储问题类别：单选，多选，开放式问题
CREATE TABLE `question_type` (
  `question_type` varchar(1) NOT NULL,
  `question_name` varchar(16) NOT NULL,
  PRIMARY KEY (`question_type`,`question_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `paper_answers` (
  `survey_id` bigint(20) NOT NULL, -- 与survery table关联，表明是哪一次调查
  `question_id` bigint(20) NOT NULL,
  `answer` varchar(256) DEFAULT NULL, -- 多选项的答案应该是用逗号隔开的所选答案的index
  `answer_user_id` varchar(64) NOT NULL,  -- 答题者
  PRIMARY KEY (`survey_id`,`question_id`,`answer_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 用户组，给特定人群发调查问卷用的，类似于邮件组
CREATE TABLE `groups` (
  `group_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(32) NOT NULL,
  `comment` varchar(128) DEFAULT NULL, -- 用户组的标注
  `content` text DEFAULT NULL,
  `edit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(64) DEFAULT NULL, -- 创建者，这个group是由谁创建的，就归谁用
  `trashed` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


-- 用户组与user的映射表，一对多
CREATE TABLE `group_users` (
  `group_id` bigint(20) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `nickname` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


	