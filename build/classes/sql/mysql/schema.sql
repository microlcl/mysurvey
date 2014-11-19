drop table if exists attachments;
drop table if exists business_type_character;
drop table if exists case_customers;
drop table if exists case_subscribers;
drop table if exists case_task;
drop table if exists cases;
drop table if exists category;
drop table if exists comments;
drop table if exists customer;
drop table if exists departments;
drop table if exists download_product_history;
drop table if exists download_resource_history;
drop table if exists function_category;
drop table if exists functions;
drop table if exists holders;
drop table if exists media_category;
drop table if exists medias;
drop table if exists module_category;
drop table if exists modules;
drop table if exists papers;
drop table if exists paper_questions;
drop table if exists paper_answers;
drop table if exists procedures;
drop table if exists product_attribute;
drop table if exists product_category;
drop table if exists products;

drop table if exists question_type;
drop table if exists questions;
drop table if exists role_function;
drop table if exists roles;
drop table if exists scheme_category;
drop table if exists scheme_product;
drop table if exists scheme_resource;
drop table if exists schemes;
drop table if exists space_attribute;
drop table if exists spaces;
drop table if exists task;
drop table if exists task_attachments;
drop table if exists task_comments;
drop table if exists task_status_history;
drop table if exists task_subscribers;
drop table if exists user_role;
drop table if exists users;
drop table if exists visit_activities;

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

CREATE TABLE `function_category` (
  `function_id` varchar(64) NOT NULL DEFAULT '',
  `category_id` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`function_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `departments` (
  `department_id` varchar(64) NOT NULL,
   `name` varchar(64) NOT NULL,
  `pid` varchar(64),
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_id` (`department_id`)
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

CREATE TABLE `modules` (
  `module_id` varchar(64) NOT NULL DEFAULT '',
  `pid` varchar(64) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`module_id`),
  UNIQUE KEY `moduleId` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `role_function` (
  `role_id` varchar(64) NOT NULL,
  `function_id` varchar(64) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`role_id`,`function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `roles` (
  `role_id` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_role` (
  `user_id` varchar(64) NOT NULL,
  `role_id` varchar(64) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `password` varchar(255) NOT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `department_id` varchar(64) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `phone_num` varchar(20) DEFAULT NULL,
  `address` varchar(64) DEFAULT NULL,
  `hometown` varchar(64) DEFAULT NULL,
  `birthday` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `register_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` varchar(20) DEFAULT NULL,
  `comment` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `medias` (
  `media_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `media_type` varchar(10) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL,
  `status` varchar(64) DEFAULT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `upload_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` varchar(128) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `author` varchar(32) DEFAULT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modify_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `media_category` (
  `media_id` bigint(20) NOT NULL DEFAULT '0',
  `category_id` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`media_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `products` (
  `product_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `status` varchar(64) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `default_picture_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `is_outsourcing` varchar(1) DEFAULT NULL, -- 是否需要外购， T -- Ture, F - False
  `create_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modify_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',  
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `product_category` (
  `product_id` bigint(11) NOT NULL DEFAULT '0',
  `category_id` varchar(64) NOT NULL DEFAULT '',
  `picture_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,2), -- 不同分类的相同产品，有可能有不同的价格
  PRIMARY KEY (`product_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table product_attribute (
	product_id bigint(11) NOT NULL,
	category_id varchar(64) NOT NULL,
	primary key (product_id,category_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `module_category` (
  `module_id` varchar(64) NOT NULL DEFAULT '',
  `category_id` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`module_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `holders` (
  `holder_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `holder_name` varchar(32) DEFAULT NULL,
  `address` varchar(64) DEFAULT NULL,
  `level` int(1) DEFAULT NULL,
  `contact` varchar(24) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modify_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`holder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `spaces` (
  `space_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `holder_id` bigint(11),
  `space_name` varchar(32) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `hall_height` int(11) DEFAULT NULL,
  `stage_length` int(11) DEFAULT NULL,
  `stage_width` int(11) DEFAULT NULL,
  `stage_height` int(11) DEFAULT NULL,
  `attributes` varchar(256) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modify_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',  
  PRIMARY KEY (`space_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table space_attribute (
	space_id bigint(11) NOT NULL,
	attribute_id varchar(64) NOT NULL,
	primary key (space_id,attribute_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `questions` (
	`question_id` bigint(11) NOT NULL AUTO_INCREMENT,
	`user_id` varchar(64), -- 创建者的id
	`question` varchar(256) NOT NULL,
	`question_type` varchar(64) NOT NULL, -- 问题种类：单选，多选，开放式问题等 ,不用在category table里面配置
	`question_options` varchar(512), -- 问题答案选项，用特殊字符^分隔， 如果是开放式问题， 此字段为空
	`business_type` varchar(64), -- 庆典种类：婚庆，生日，公司年会,年终员工调查等，可以在category table配置
	`trashed` varchar(1),
	 PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `paper_questions` (
	`paper_id` bigint(11) NOT NULL,
	`question_id` bigint(11) NOT NULL,
	`position` int(3) not null, -- 问题在调查问卷中的位置
	PRIMARY KEY (`paper_id`, `question_id`)	
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `question_type` (
	`question_type` varchar(1) NOT NULL,
	`question_name` varchar(16) NOT NULL,
	PRIMARY KEY(`question_type`, `question_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `paper_answers` (
	`business_id` varchar(64), -- 由business_code与具体业务表的sequence构成
	`paper_id` bigint(11) NOT NULL,
	`question_id` bigint(11) NOT NULL,
	`answer` varchar(256), -- 多选项的答案应该是用逗号隔开的所选答案的index
	PRIMARY KEY (`business_id`,`paper_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `papers` (
	`paper_id` bigint(11) NOT NULL AUTO_INCREMENT,
	`paper_name` varchar(32) NOT NULL,
	`creat_timestamp` timestamp,
	`status` varchar(64) NOT NULL, -- 调查问卷的状态： draft, publish, trashed,只有publish状态的才能使用。此status在category的系统参数节点下配置，此处保存的是category id.
	`business_type` varchar(64) NOT NULL, -- 庆典种类：婚庆，生日，公司年会,年终员工调查等，可以在category table配置
	`default_paper` varchar(1), -- 是否是某类型问卷的默认paper: T = Ture, F = False 
	`form_type` varchar(64), -- 单据类型：回访表单，需求表单，等
	PRIMARY KEY (`paper_id`)	
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `cases` (
	`case_id` bigint(11) NOT NULL AUTO_INCREMENT,
	`case_title` varchar(32), -- case的title，比如： 张三的婚庆，李四公司的年会庆典等
	`created_time` timestamp, -- case创建时间戳
	`assigned_department_id` varchar(64), -- assigned 给哪个部门
	`case_owner` varchar(64), -- 这个case的跟单人
	`business_type` varchar(64),   -- 庆典种类：婚庆，生日，公司年会等，可以在category table配置
	`event_time` timestamp,    -- 庆典时间
	`guest_num` int,     -- 客人人数
	`space_id` bigint(11),    -- 庆典地点,关联space table
	`space_tip` varchar(64), -- 庆典地点信息，由前台文字输入。后续跟单者可以根据这个信息完成space_id字段的填写。
	`description` varchar(1024),
	`paper_id` bigint(11),
	`status` varchar(64), -- case的状态（new, in progress, finished, trashed）,配置在category table的系统参数节点下
	`business_code` varchar(6),-- 默认为C, 与case_id 联合组成business_id,与paper_answers table相关联
	 PRIMARY KEY (case_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table case_subscribers (
	case_id bigint(11) not null,
	user_id varchar(64) not null,
	primary key (case_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- case与customer的映射表，存储某一个case中的主角及相关人员
create table case_customers (
	case_id bigint(11) not null,
	character_id varchar(64) not null,   -- 角色id(角色：新娘，新郎，宝宝...)， 保存在category表
	customer_id bigint(11),
	description varchar(256),
	primary key (case_id,character_id,customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table business_type_character (
	business_type varchar(64) not null, -- value为配置在category table里面的category_id
	character_id varchar(64) not null, -- value为配置在category table里面的category_id
	primary key (business_type, character_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 所有外部人员信息（不一定只有case的主角才记录在此表）。积累下来将是潜在机会，所以单独建表
create table customer (
	customer_id bigint(11) NOT NULL AUTO_INCREMENT,
	customer_name varchar(32), -- 遇到不愿意提供姓名的客户，可以只存储姓
	customer_phone varchar(20),
	customer_sex varchar(2),
	job varchar(32), -- 工作
	weixin varchar(16),
	weibo varchar(16),
	qq varchar(16),
	birthday date,
	favorite varchar(128), -- 爱好
	description varchar(256), -- 备注
	primary key (customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `visit_activities` (
	`visit_id` bigint(11) NOT NULL AUTO_INCREMENT,
	`customer_id` bigint(11),
	`visit_type` varchar(64), -- 访问类别： 到访，回访，在category table配置
	`visit_stime` timestamp,  -- 默认是系统时间，可以修改
	`visitor_num` int,	-- 到访，回访人数
	`assigned_department_id` varchar(64), -- assigned 给哪个部门
	`recipient` varchar(64),  -- 接待者（前台接待）
	`operator` varchar(64), -- 经办人（跟单者）
	`business_type` varchar(64), -- 庆典种类：婚庆，生日，公司年会等，可以在category table配置
	`case_id` bigint(11),   -- 这次到访是为了哪个case
	`is_visited` varchar(1), -- 是否初次到访： Ture/False
	`comment` varchar(256), -- 备注
	`paper_id` bigint(11), -- 回访单id
	PRIMARY KEY (`visit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table task (
	task_id bigint(11) NOT NULL AUTO_INCREMENT,
	parent_id bigint(11), -- 父task,为空就是没有父task，就是US
	summary varchar(128) not null, -- 类似于RTC中的summary，用作title
	description varchar(1024), -- 描述
	task_type varchar(64),  -- US的type，可在category table配置
	status varchar(64), -- US的状态： new， in progress, completed etc.在category table配置
	department_id varchar(64),-- task所属的部门id
	owner varchar(64),	
	progress int, -- 百分比 * 100后的value，eg: value为36，表示进度为36%.此value应根据:子task的花费的总时间/子task的总时间 *100后四舍五入自动得到
	priority varchar(64), -- 优先级，在category的系统参数节点配置
	due_date timestamp, -- 计划完成时间
	time_remaining int, -- 剩下多少小时
	created_timestamp timestamp, -- 创建时间
	created_by varchar(64), -- 创建人
	primary key (task_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table task_subscribers (
	task_id bigint(11) not null,
	user_id varchar(64) not null,
	primary key (task_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 记录task下面的comments
create table task_comments (
	comment_id bigint(11) not null,
	task_id bigint(11) not null,
	primary key (comment_id,task_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table comments (
	comment_id bigint(11) NOT NULL AUTO_INCREMENT,
	user_id varchar(64) not null, -- 加comment的人
	comment varchar(1024) not null,
	created_timestamp timestamp,
	primary key (comment_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table task_attachments (
	attachment_id bigint(11) not null,
	task_id bigint(11) not null,
	primary key (attachment_id,task_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table attachments (
	attachment_id  bigint(11) NOT NULL AUTO_INCREMENT,
	user_id varchar(64) not null, -- 加comment的人
	uploaded_timestamp timestamp,	
	path varchar(128) not null, -- 文件路径 + 文件名
	file_size int, -- 文件大小,单位：M
	primary key (attachment_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table task_status_history (
	history_id bigint(11) NOT NULL AUTO_INCREMENT,
	task_id bigint(11) not null,
	status varchar(64) not null, -- status的category id
	modified_timestamp timestamp, -- 修改时间
	editor varchar(64) not null, -- 修改人
	primary key (history_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table case_task (
	case_id bigint(11) not null,
	task_id bigint(11) not null,
	primary key (case_id, task_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table procedures (
	procedure_id bigint(11) NOT NULL AUTO_INCREMENT,
	procedure_name varchar(32) not null,
	position int not null, -- 环节的先后顺序	
	business_type varchar(64),   -- 庆典种类：婚庆，生日，公司年会等，可以在category table配置
	primary key (procedure_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table schemes (
	scheme_id bigint(11) NOT NULL AUTO_INCREMENT,
	case_id bigint(11),
	scheme_name varchar(32) not null,
	created_by varchar(64), -- 由谁创建
	modified_timestamp timestamp, -- 修改时间
	status varchar(64), -- 方案的状态（new, in progress, finished, trashed）,配置在category table的系统参数节点下
	comment varchar(128),
	scheme_path varchar(64), -- 方案（PPT）上传的路径	
	inherit_scheme_id bigint(11), -- 可为空，由哪个scheme继承而来（方案copy功能）
	primary key (scheme_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table scheme_category (
	scheme_id bigint(11) not null,
	scheme_type varchar(64) not null, -- 方案种类(浪漫，搞笑等)，在category table配置
	primary key (scheme_id,scheme_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table scheme_resource (
	scheme_id bigint not null,
	media_id bigint, -- 图片id
	media_type varchar(10),    -- 音频，视频，图片
	trashed varchar(1) not null,    -- T：ture， F：false
	user_id varchar(64) not null,    -- 谁引入这个方案
	refer_datetime timestamp not null,  -- 方案引用此资源的时间
	primary key (scheme_id,media_id)	
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table scheme_product (
	scheme_id bigint not null,
	product_id bigint, 
	product_count int, -- 需要的product的数量
	category_id varchar(64), -- product 分类id
	trashed varchar(1) not null,    -- T：ture， F：false
	user_id varchar(64) not null,    -- 谁引入这个方案
	refer_datetime timestamp not null,  -- 方案引用此资源的时间
	discount int,-- 0表示赠送，95表示95折， 100表示没有折扣
	price decimal(10,2), -- 产品价格存根，这个价格是做scheme的时候product的价格，如果product的价格有变化，需要提示用户，让用户决定是否需要采用产品的新价格。
	attribute_category_id varchar(64), -- 用户自定义的attribute，以便用户对产生的报表进行干预
	primary key (scheme_id,product_id,category_id)	
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table download_resource_history (
	download_resource_id bigint NOT NULL AUTO_INCREMENT,
	user_id varchar(64) not null,    -- 下载人
	case_id bigint not null,	
	scheme_id bigint not null,
	media_id bigint not null, -- 媒体id
	download_datetime timestamp not null,  -- 下载发生的时间
	primary key (download_resource_id)	
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table download_product_history (
	download_product_id  bigint NOT NULL AUTO_INCREMENT,
	user_id varchar(64) not null,    -- 下载人
	case_id bigint not null,	
	scheme_id bigint not null,
	product_id bigint not null, 
	category_id varchar(64) not null, -- product 分类id
	download_datetime timestamp not null,  -- 下载发生的时间
	primary key (download_product_id)	
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
