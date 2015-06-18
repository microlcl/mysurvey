delete from modules;
delete from functions;
delete from users;
delete from roles;
delete from user_role;
delete from role_function;
delete from category;
delete from function_category;
delete from questions;
delete from papers;
delete from paper_questions;
delete from paper_answers;
delete from groups;
delete from survey;
delete from survey_receivers


insert into modules(module_id, pid, name, description, path) values('M1','','方案管理系统','方案管理系统','');
insert into modules(module_id, pid, name, description, path) values('M1-1','M1','我的用户组','我的用户组','');
insert into modules(module_id, pid, name, description, path) values('M1-2','M1','我发起的调查','我发起的调查','');
insert into modules(module_id, pid, name, description, path) values('M1-3','M1','我参与的调查','我参与的调查','');
insert into modules(module_id, pid, name, description, path) values('M1-7','M1','我的问题','我的问题','');
insert into modules(module_id, pid, name, description, path) values('M1-8','M1','我的问卷','我的问卷','');

insert into modules(module_id, pid, name, description, path) values('M2-1','M1','管理','管理','');

insert into functions(function_id, module_id, name, description, path) values('F0','M1','主界面','查看主界面','/index.jsp');
insert into functions(function_id, module_id, name, description, path) values('F1-1','M1-1','我的群组:列表：','有权限查看列表','/myGroup/list');
insert into functions(function_id, module_id, name, description, path) values('F1-2','M1-1','我的群组:增加','有权限保存','/myGroup/saveGroup');
insert into functions(function_id, module_id, name, description, path) values('F1-3','M1-1','我的群组:修改','有权限修改','/myGroup/toUpdateGroup,/myGroup/updateGroup,/myGroup/importGroup');
insert into functions(function_id, module_id, name, description, path) values('F1-4','M1-1','我的群组:删除','有权限删除','/myGroup/deleteGroup/');

insert into functions(function_id, module_id, name, description, path) values('F2-1','M1-2','我发起的调查:列表','有权限查看列表','/survey/myLaunch');
insert into functions(function_id, module_id, name, description, path) values('F2-2','M1-2','我发起的调查:查看','有权限查看调查','/survey/surveyDetail/');
insert into functions(function_id, module_id, name, description, path) values('F2-3','M1-2','我发起的调查:答案统计','有权限查看答案统计','/survey/statistic/,survey/accessSurvey/');
insert into functions(function_id, module_id, name, description, path) values('F2-4','M1-2','我发起的调查:创建调查','有权限创建调查','/survey/createSurvey/,/survey/surveyAction/');
insert into functions(function_id, module_id, name, description, path) values('F2-5','M1-2','我发起的调查:发送提醒','有权限发送提醒邮件','/survey/sendNoti');
insert into functions(function_id, module_id, name, description, path) values('F2-6','M1-2','我发起的调查:导出记录','有权限导出回答记录','/survey/export');

insert into functions(function_id, module_id, name, description, path) values('F3-1','M1-3','我参与的调查:列表','有权限查看列表','/survey/myParticipation');
insert into functions(function_id, module_id, name, description, path) values('F3-2','M1-3','我参与的调查:查看','有权限查看调查','/survey/accessSurvey/');
insert into functions(function_id, module_id, name, description, path) values('F3-3','M1-3','我参与的调查：修改','有权限修改答案','/survey/saveAction');

insert into functions(function_id, module_id, name, description, path) values('F4-1','M1-4','my profile：view','view my profile','/account/profile');
insert into functions(function_id, module_id, name, description, path) values('F4-2','M1-4','my profile：update','update my profile','/account/update');


insert into functions(function_id, module_id, name, description, path) values('F7-1','M1-7','我的问题：列表','菜单导航','/question/list');
insert into functions(function_id, module_id, name, description, path) values('F7-2','M1-7','我的问题：增加','有权限增加','/question/addQuestion,/question/saveQuestion');
insert into functions(function_id, module_id, name, description, path) values('F7-3','M1-7','我的问题：修改','有权限修改','/question/editQuestion,/question/updateQuestion');
insert into functions(function_id, module_id, name, description, path) values('F7-4','M1-7','我的问题：删除','有权限删除','/question/deleteQuestion');
insert into functions(function_id, module_id, name, description, path) values('F7-5','M1-7','我的问题：查询其他人创建的问题','有权查询其他人创建的问题','');

insert into functions(function_id, module_id, name, description, path) values('F8-1','M1-8','我的问卷：列表','菜单导航','/paper/list');
insert into functions(function_id, module_id, name, description, path) values('F8-2','M1-8','我的问卷：增加','有权限增加','/paper/add/,/paper/save');
insert into functions(function_id, module_id, name, description, path) values('F8-3','M1-8','我的问卷：修改','有权限修改','/paper/edit,/paper/update');
insert into functions(function_id, module_id, name, description, path) values('F8-4','M1-8','我的问卷：删除','有权限删除','/paper/delete');
insert into functions(function_id, module_id, name, description, path) values('F8-5','M1-8','我的问卷：发布','有权限发布调查问卷','/paper/publish');
insert into functions(function_id, module_id, name, description, path) values('F8-6','M1-8','我的问卷：查看','有权限查看','/paper/show');
insert into functions(function_id, module_id, name, description, path) values('F8-7','M1-8','我的问卷：查询其他人创建的paper','有权查询其他人创建的paper','');

insert into functions(function_id, module_id, name, description, path) values('F21','M2-1','管理菜单','能看见管理菜单','');


insert into users(id, name, password, register_date) values('admin','admin','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 01:00:00','D1-1');
insert into users(id, name, password, register_date) values('lichlei@cn.ibm.com','lichlei@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 01:00:00');
insert into users(id, name, password, register_date) values('wangxhdl@cn.ibm.com','wangxhdl@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 01:00:00');
insert into users(id, name, password, register_date) values('gongbf@cn.ibm.com','gongbf@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 02:00:00');
insert into users(id, name, password, register_date) values('zhangfd@cn.ibm.com','zhangfd@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 02:00:00');
insert into users(id, name, password, register_date) values('liush@cn.ibm.com','liush@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 02:00:00');
insert into users(id, name, password, register_date) values('ldlxiao@cn.ibm.com','ldlxiao@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 02:00:00');
insert into users(id, name, password, register_date) values('maoyeye@qq.com','LiChunlei','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 02:00:00');

insert into roles(role_id, name, description) values('R0', '管理员','超级用户');
insert into roles(role_id, name, description) values('R9', '普通用户','普通用户');

insert into user_role(user_id, role_id) values('admin','R0');
insert into user_role(user_id, role_id) values('lichlei@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('wangxhdl@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('gongbf@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('zhangfd@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('liush@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('ldlxiao@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('maoyeye@qq.com','R0');

insert into role_function(role_id, function_id, description) values('R0','F0','');
insert into role_function(role_id, function_id, description) values('R0','F1-1','');
insert into role_function(role_id, function_id, description) values('R0','F1-2','');
insert into role_function(role_id, function_id, description) values('R0','F1-3','');
insert into role_function(role_id, function_id, description) values('R0','F1-4','');
insert into role_function(role_id, function_id, description) values('R0','F2-1','');
insert into role_function(role_id, function_id, description) values('R0','F2-2','');
insert into role_function(role_id, function_id, description) values('R0','F2-3','');
insert into role_function(role_id, function_id, description) values('R0','F2-4','');
insert into role_function(role_id, function_id, description) values('R0','F2-5','');
insert into role_function(role_id, function_id, description) values('R0','F2-6','');
insert into role_function(role_id, function_id, description) values('R0','F3-1','');
insert into role_function(role_id, function_id, description) values('R0','F3-2','');
insert into role_function(role_id, function_id, description) values('R0','F3-3','');
insert into role_function(role_id, function_id, description) values('R0','F4-1','');
insert into role_function(role_id, function_id, description) values('R0','F4-2','');
insert into role_function(role_id, function_id, description) values('R0','F7-1','');
insert into role_function(role_id, function_id, description) values('R0','F7-2','');
insert into role_function(role_id, function_id, description) values('R0','F7-3','');
insert into role_function(role_id, function_id, description) values('R0','F7-4','');
insert into role_function(role_id, function_id, description) values('R0','F7-5','');
insert into role_function(role_id, function_id, description) values('R0','F8-1','');
insert into role_function(role_id, function_id, description) values('R0','F8-2','');
insert into role_function(role_id, function_id, description) values('R0','F8-3','');
insert into role_function(role_id, function_id, description) values('R0','F8-4','');
insert into role_function(role_id, function_id, description) values('R0','F8-5','');
insert into role_function(role_id, function_id, description) values('R0','F8-6','');
insert into role_function(role_id, function_id, description) values('R0','F8-7','');
insert into role_function(role_id, function_id, description) values('R0','F21','');

insert into role_function(role_id, function_id, description) values('R9','F0','');
insert into role_function(role_id, function_id, description) values('R9','F1-1','');
insert into role_function(role_id, function_id, description) values('R9','F1-2','');
insert into role_function(role_id, function_id, description) values('R9','F1-3','');
insert into role_function(role_id, function_id, description) values('R9','F1-4','');
insert into role_function(role_id, function_id, description) values('R9','F2-1','');
insert into role_function(role_id, function_id, description) values('R9','F2-2','');
insert into role_function(role_id, function_id, description) values('R9','F2-3','');
insert into role_function(role_id, function_id, description) values('R9','F2-4','');
insert into role_function(role_id, function_id, description) values('R9','F2-5','');
insert into role_function(role_id, function_id, description) values('R9','F2-6','');
insert into role_function(role_id, function_id, description) values('R9','F3-1','');
insert into role_function(role_id, function_id, description) values('R9','F3-2','');
insert into role_function(role_id, function_id, description) values('R9','F3-3','');
insert into role_function(role_id, function_id, description) values('R9','F4-1','');
insert into role_function(role_id, function_id, description) values('R9','F4-2','');
insert into role_function(role_id, function_id, description) values('R9','F7-1','');
insert into role_function(role_id, function_id, description) values('R9','F7-2','');
insert into role_function(role_id, function_id, description) values('R9','F7-3','');
insert into role_function(role_id, function_id, description) values('R9','F7-4','');
insert into role_function(role_id, function_id, description) values('R9','F8-1','');
insert into role_function(role_id, function_id, description) values('R9','F8-2','');
insert into role_function(role_id, function_id, description) values('R9','F8-3','');
insert into role_function(role_id, function_id, description) values('R9','F8-4','');
insert into role_function(role_id, function_id, description) values('R9','F8-5','');
insert into role_function(role_id, function_id, description) values('R9','F8-6','');



-- category数据：
insert into category(id, pid, name, created_date, trashed, comment) values('1','','category','2012-06-04 02:00:00','F','category root');
-- 系统参数 start
insert into category(id, pid, name, created_date, trashed, comment) values('1-0','1','system setting','2014-12-28 02:00:00','F','system setting');
-- 问卷管理：问卷状态
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1','1-0','Paper Status','2014-12-28 02:00:00','F','paper management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-0','1-0-1','Draft','2014-12-28 02:00:00','F','paper management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-1','1-0-1','Published','2014-12-28 02:00:00','F','paper management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-2','1-0-1','Trashed','2014-12-28 02:00:00','F','paper management');

-- business Type
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2','1-0','Survey Type','2014-12-28 02:00:00','F','system parameters');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-0','1-0-2','Job','2014-12-28 02:00:00','F','system parameters');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-1','1-0-2','Life','2014-12-28 02:00:00','F','system parameters');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-2','1-0-2','Other','2014-12-28 02:00:00','F','system parameters');
-- survey status
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3','1-0','Survey Status','2014-12-28 02:00:00','F','survey management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-0','1-0-3','Draft','2014-12-28 02:00:00','F','survey management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-1','1-0-3','Published','2014-12-28 02:00:00','F','survey management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-2','1-0-3','Completed','2014-12-28 02:00:00','F','survey management');


-- 系统参数 end
insert into function_category(function_id,category_id) values('getBusinessType','1-0-2');
insert into function_category(function_id,category_id) values('paperStatus','1-0-1');
insert into function_category(function_id,category_id) values('surveyStatus','1-0-3');

		
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(1,'你是通过什么途径知道我们的产品的1？','1','网上搜索^朋友分享^无意间了解','1-0-2-0','F','ydq',now());
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(2,'你喜欢的灯具材质是2？','2','木质^金属^水晶^其他','1-0-2-0','F','ydq',now());
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(3,'你对本产品有什么建议3？','3','','1-0-2-0','F','ydq',now());
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(4,'你是通过什么途径知道我们的产品的4？','1','网上搜索^朋友分享^无意间了解','1-0-2-1','F','ydq',now());
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(5,'你喜欢的灯具材质是5？','2','木质^金属^水晶^其他','1-0-2-0','F','lichlei@cn.ibm.com',now());
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(6,'你是通过什么途径知道我们的产品的6？','1','网上搜索^朋友分享^无意间了解','1-0-2-0','F','lichlei@cn.ibm.com',now());
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(7,'你喜欢的灯具材质是7？','2','木质^金属^水晶^其他','1-0-2-0','F','lichlei@cn.ibm.com');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(8,'你是通过什么途径知道我们的产品的8？','1','网上搜索^朋友分享^无意间了解','1-0-2-2','F','lichlei@cn.ibm.com',now());
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp values(9,'你喜欢的灯具材质是9？','2','木质^金属^水晶^其他','1-0-2-0','F','lichlei@cn.ibm.com',now());
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(10,'你喜欢的灯具材质是10？','2','木质^金属^水晶^其他','1-0-2-0','F','admin', '2014-07-04 02:00:00');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(11,'你是通过什么途径知道我们的产品的11？','1','网上搜索^朋友分享^无意间了解','1-0-2-0','F','admin', '2014-08-04 02:00:00');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(12,'你喜欢的灯具材质是12？','2','木质^金属^水晶^其他','1-0-2-0','F','admin', '2014-06-04 02:00:00');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(13,'你是通过什么途径知道我们的产品的13？','1','网上搜索^朋友分享^无意间了解','1-0-2-2','F','admin', '2013-06-04 02:00:00');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id, creat_timestamp) values(14,'你喜欢的灯具材质是14？','2','木质^金属^水晶^其他','1-0-2-0','F','admin', '2012-06-04 02:00:00');

insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (1, '问卷1', 'admin', '1-0-2-0', '2012-06-04 02:00:00', '1-0-1-1');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (2, '问卷2', 'admin', '1-0-2-0', '2013-06-04 02:00:00', '1-0-1-1');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (3, '问卷3', 'admin', '1-0-2-0',  now(), '1-0-1-0');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (4, '问卷4', 'ldlxiao@cn.ibm.com', '1-0-2-2', now(), '1-0-1-2');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (5, '问卷5', 'ldlxiao@cn.ibm.com', '1-0-2-2', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (6, '问卷6', 'ldlxiao@cn.ibm.com', '1-0-2-1', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (7, '问卷7', 'lichlei@cn.ibm.com', '1-0-2-1', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (8, '问卷8', 'lichlei@cn.ibm.com', '1-0-2-0', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (9, '问卷9', 'lichlei@cn.ibm.com', '1-0-2-0', now(), '1-0-1-0');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (10, '问卷10', 'wangxhdl@cn.ibm.com', '1-0-2-2', now(), '1-0-1-2');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (11, '问卷11', 'wangxhdl@cn.ibm.com', '1-0-2-2', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (12, '问卷12', 'wangxhdl@cn.ibm.com', '1-0-2-1', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (13, '问卷13', 'gongbf@cn.ibm.com', '1-0-2-0', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (14, '问卷14', 'gongbf@cn.ibm.com', '1-0-2-0', now(), '1-0-1-0');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (15, '问卷15', 'gongbf@cn.ibm.com', '1-0-2-2', now(), '1-0-1-2');
insert into papers (paper_id, paper_name, user_id, business_type, creat_timestamp, status) values (16, '问卷16', 'zhangfd@cn.ibm.com', '1-0-2-2', now(), '1-0-1-1');

insert into paper_questions (paper_id, question_id, position) values (1, 9, 10);
insert into paper_questions (paper_id, question_id, position) values (1, 8, 20);
insert into paper_questions (paper_id, question_id, position) values (1, 7, 30);
insert into paper_questions (paper_id, question_id, position) values (1, 6, 40);
insert into paper_questions (paper_id, question_id, position) values (1, 5, 50);
insert into paper_questions (paper_id, question_id, position) values (1, 4, 60);
insert into paper_questions (paper_id, question_id, position) values (1, 3, 60);
insert into paper_questions (paper_id, question_id, position) values (2, 1, 10);
insert into paper_questions (paper_id, question_id, position) values (2, 2, 20);
insert into paper_questions (paper_id, question_id, position) values (2, 3, 30);
insert into paper_questions (paper_id, question_id, position) values (2, 4, 40);
insert into paper_questions (paper_id, question_id, position) values (2, 5, 50);
insert into paper_questions (paper_id, question_id, position) values (2, 6, 60);
insert into paper_questions (paper_id, question_id, position) values (3, 9, 10);
insert into paper_questions (paper_id, question_id, position) values (3, 8, 20);
insert into paper_questions (paper_id, question_id, position) values (3, 7, 30);
insert into paper_questions (paper_id, question_id, position) values (3, 6, 40);
insert into paper_questions (paper_id, question_id, position) values (3, 5, 50);
insert into paper_questions (paper_id, question_id, position) values (3, 4, 60);
insert into paper_questions (paper_id, question_id, position) values (4, 1, 10);
insert into paper_questions (paper_id, question_id, position) values (4, 2, 20);
insert into paper_questions (paper_id, question_id, position) values (4, 3, 30);
insert into paper_questions (paper_id, question_id, position) values (4, 4, 40);
insert into paper_questions (paper_id, question_id, position) values (4, 5, 50);
insert into paper_questions (paper_id, question_id, position) values (4, 6, 60);
insert into paper_questions (paper_id, question_id, position) values (5, 1, 10);
insert into paper_questions (paper_id, question_id, position) values (5, 3, 20);
insert into paper_questions (paper_id, question_id, position) values (5, 2, 60);
insert into paper_questions (paper_id, question_id, position) values (6, 1, 10);
insert into paper_questions (paper_id, question_id, position) values (6, 2, 20);
insert into paper_questions (paper_id, question_id, position) values (6, 3, 30);
insert into paper_questions (paper_id, question_id, position) values (6, 4, 40);
insert into paper_questions (paper_id, question_id, position) values (6, 5, 50);
insert into paper_questions (paper_id, question_id, position) values (6, 6, 60);

insert into paper_questions (paper_id, question_id, position) values (7, 3, 30);
insert into paper_questions (paper_id, question_id, position) values (7, 4, 40);
insert into paper_questions (paper_id, question_id, position) values (7, 5, 50);

insert into paper_questions (paper_id, question_id, position) values (8, 2, 20);
insert into paper_questions (paper_id, question_id, position) values (8, 3, 30);
insert into paper_questions (paper_id, question_id, position) values (8, 4, 40);

insert into paper_questions (paper_id, question_id, position) values (9, 9, 10);
insert into paper_questions (paper_id, question_id, position) values (9, 8, 20);
insert into paper_questions (paper_id, question_id, position) values (9, 7, 30);

insert into paper_questions (paper_id, question_id, position) values (10, 6, 40);
insert into paper_questions (paper_id, question_id, position) values (10, 5, 50);
insert into paper_questions (paper_id, question_id, position) values (10, 4, 60);

insert into paper_questions (paper_id, question_id, position) values (11, 1, 10);
insert into paper_questions (paper_id, question_id, position) values (11, 2, 20);
insert into paper_questions (paper_id, question_id, position) values (11, 3, 30);
insert into paper_questions (paper_id, question_id, position) values (11, 4, 40);
insert into paper_questions (paper_id, question_id, position) values (11, 5, 50);
insert into paper_questions (paper_id, question_id, position) values (11, 6, 60);

insert into paper_questions (paper_id, question_id, position) values (12, 1, 10);
insert into paper_questions (paper_id, question_id, position) values (13, 2, 20);
insert into paper_questions (paper_id, question_id, position) values (14, 3, 30);
insert into paper_questions (paper_id, question_id, position) values (15, 4, 40);
insert into paper_questions (paper_id, question_id, position) values (16, 5, 50);


--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,4,'1');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,5,'2');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,6,'3');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,7,'2');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,8,'2');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,9,'2,3');

--insert into paper_answers(business_id, paper_id, question_id, answer) values('C2',6,1,'2');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C2',6,3,'abcde');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('V6',7,3,'abcde');

insert into groups(group_id, group_name, comment, content, edit_date, trashed, user_id) values(1,'群组1','测试群组','张三^zhangsan@111.com|李四^lisi@111.com|王五^wangwu@111.com|',now(),'F','lichlei@cn.ibm.com');
insert into groups(group_id, group_name, comment, content, edit_date, trashed, user_id) values(2,'群组2','测试群组','系统测试邮箱^18661014104@163.com|gongbinfeng^530460414@qq.com|',now(),'F','lichlei@cn.ibm.com');
insert into groups(group_id, group_name, comment, content, edit_date, trashed, user_id) values(3,'群组3','测试群组','jack^jack@111.com|tom^tom@111.com|stan^stan@111.com|^xxx@111.com|',now(),'F','lichlei@cn.ibm.com');
insert into groups(group_id, group_name, comment, content, edit_date, trashed, user_id) values(4,'开发群组','开发群组','lichunlei^lichlei@cn.ibm.com|gongbinfeng^gongbf@cn.ibm.com|zhangfeidi^zhangfd@cn.ibm.com|wangxiaohui^wangxhdl@cn.ibm.com|liusiheng^liush@cn.ibm.com|liuxiao^ldlxiao@cn.ibm.com|',now(),'F','lichlei@cn.ibm.com');

insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(1,'1-0-3-0',null,'lichlei@cn.ibm.com',1,'Testing1','2,3',null,now(),'','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(2,'1-0-3-1',null,'lichlei@cn.ibm.com',1,'Testing2','1,3',null,now() + 123,'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(3,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(4,'1-0-3-0',null,'lichlei@cn.ibm.com',1,'Testing3','1',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(5,'1-0-3-0',null,'lichlei@cn.ibm.com',1,'Testing3','2',null,null,'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(6,'1-0-3-0',null,'lichlei@cn.ibm.com',1,'Testing3','3',null,null,'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(7,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(8,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(9,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now() + 123,'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(10,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now() + 123,'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(11,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(12,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(13,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(14,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(15,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(16,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(17,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(18,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(19,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(20,'1-0-3-2',null,'lichlei@cn.ibm.com',1,'Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');

insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 4, 'lichlei@cn.ibm.com', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 5, 'lichlei@cn.ibm.com', 3);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 6, 'lichlei@cn.ibm.com', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 7, 'lichlei@cn.ibm.com', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 8, 'lichlei@cn.ibm.com', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 9, 'lichlei@cn.ibm.com', '1,2,3');
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 4, 'zhang3', 2);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 5, 'zhang3', 2);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 6, 'zhang3', 3);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 7, 'zhang3', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 8, 'zhang3', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 9, 'zhang3', '1,3');
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 4, '18661014104', 3);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 5, '18661014104', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 6, '18661014104', 2);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 7, '18661014104', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 8, '18661014104', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(2, 9, '18661014104', '1,2');

insert into survey_receivers (survey_id,user_id,nickName,status,update_timestamp)values(14,'123@111.com','','0',null);
insert into survey_receivers (survey_id,user_id,nickName,status,update_timestamp)values(14,'1234@111.com','','1',now());
insert into survey_receivers (survey_id,user_id,nickName,status,update_timestamp)values(14,'1235@111.com','','0',null);
insert into survey_receivers (survey_id,user_id,nickName,status,update_timestamp)values(14,'1236@111.com','','0',null);
