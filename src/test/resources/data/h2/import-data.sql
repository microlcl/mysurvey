delete from category;

delete from function_category;
delete from functions;

delete from papers;
delete from paper_questions;
delete from paper_answers;

delete from questions;
delete from role_function;
delete from roles;
delete from user_role;
delete from users;
delete from groups;



insert into modules(module_id, pid, name, description, path) values('M1','','方案管理系统','方案管理系统','');
insert into modules(module_id, pid, name, description, path) values('M1-7','M1','问题管理','问题管理','');
insert into modules(module_id, pid, name, description, path) values('M1-8','M1','问卷管理','问卷管理','');

insert into functions(function_id, module_id, name, description, path) values('F0','M1','主界面','查看主界面','/index.jsp');

insert into functions(function_id, module_id, name, description, path) values('F6-1','M1-6','问题：列表','菜单导航','/mySurvey/myGroup');

insert into functions(function_id, module_id, name, description, path) values('F7-1','M1-7','问题：列表','菜单导航','/question/list');
insert into functions(function_id, module_id, name, description, path) values('F7-2','M1-7','问题：增加','有权限增加','/question/addQuestion,/question/saveQuestion');
insert into functions(function_id, module_id, name, description, path) values('F7-3','M1-7','问题：修改','有权限修改','/question/editQuestion,/question/updateQuestion');
insert into functions(function_id, module_id, name, description, path) values('F7-4','M1-7','问题：删除','有权限删除','/question/deleteQuestion');

insert into functions(function_id, module_id, name, description, path) values('F8-1','M1-8','调查问卷：列表','菜单导航','/paper/list');
insert into functions(function_id, module_id, name, description, path) values('F8-2','M1-8','调查问卷：增加','有权限增加','/paper/add/,/paper/save');
insert into functions(function_id, module_id, name, description, path) values('F8-3','M1-8','调查问卷：修改','有权限修改','/paper/edit,/paper/update');
insert into functions(function_id, module_id, name, description, path) values('F8-4','M1-8','调查问卷：删除','有权限删除','/paper/delete');
insert into functions(function_id, module_id, name, description, path) values('F8-5','M1-8','调查问卷：发布','有权限发布调查问卷','/paper/publish');
insert into functions(function_id, module_id, name, description, path) values('F8-6','M1-8','调查问卷：查看','有权限查看','/paper/show');

insert into users(id, name, password, email, register_date, department_id) values('lichlei@cn.ibm.com','lichlei@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','lichlei@cn.ibm.com','2012-06-04 01:00:00','D1-1');
insert into users(id, name, password, email, register_date, department_id) values('wangxhdl@cn.ibm.com','wangxhdl@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','wangxhdl@cn.ibm.com','2012-06-04 01:00:00','D1-1');
insert into users(id, name, password, email, register_date, department_id) values('gongbf@cn.ibm.com','gongbf@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','gongbf@cn.ibm.com','2012-06-04 02:00:00','D1-1');
insert into users(id, name, password, email, register_date, department_id) values('zhangfd@cn.ibm.com','zhangfd@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','zhangfd@cn.ibm.com','2012-06-04 02:00:00','D1-1');
insert into users(id, name, password, email, register_date, department_id) values('liush@cn.ibm.com','liush@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','liush@cn.ibm.com','2012-06-04 02:00:00','D1-1');
insert into users(id, name, password, email, register_date, department_id) values('ldlxiao@cn.ibm.com','ldlxiao@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','ldlxiao@cn.ibm.com','2012-06-04 02:00:00','D1-1');
insert into users(id, name, password, email, register_date, department_id) values('maoyeye@qq.com','LiChunlei','a94d5cd0079cfc8db030e1107de1addd1903a01b','maoyeye@qq.com','2012-06-04 02:00:00','D1-1');

insert into roles(role_id, name, description) values('R0', '管理员','超级用户');
insert into roles(role_id, name, description) values('R1', '问题管理员','问题管理员');
insert into roles(role_id, name, description) values('R2', '问卷管理员','问卷管理员');

insert into user_role(user_id, role_id) values('lichlei@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('wangxhdl@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('gongbf@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('zhangfd@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('liush@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('ldlxiao@cn.ibm.com','R0');
insert into user_role(user_id, role_id) values('maoyeye@qq.com','R0');

insert into role_function(role_id, function_id, description) values('R0','F0','');
insert into role_function(role_id, function_id, description) values('R0','F7-1','');


insert into role_function(role_id, function_id, description) values('R0','F6-1','');
insert into role_function(role_id, function_id, description) values('R0','F7-2','');
insert into role_function(role_id, function_id, description) values('R0','F7-3','');
insert into role_function(role_id, function_id, description) values('R0','F7-4','');
insert into role_function(role_id, function_id, description) values('R0','F8-1','');
insert into role_function(role_id, function_id, description) values('R0','F8-2','');
insert into role_function(role_id, function_id, description) values('R0','F8-3','');
insert into role_function(role_id, function_id, description) values('R0','F8-4','');
insert into role_function(role_id, function_id, description) values('R0','F8-5','');
insert into role_function(role_id, function_id, description) values('R0','F8-6','');

insert into role_function(role_id, function_id, description) values('R1','F0','');
insert into role_function(role_id, function_id, description) values('R1','F7-1','');
insert into role_function(role_id, function_id, description) values('R1','F7-2','');
insert into role_function(role_id, function_id, description) values('R1','F7-3','');
insert into role_function(role_id, function_id, description) values('R1','F7-4','');

insert into role_function(role_id, function_id, description) values('R2','F0','');
insert into role_function(role_id, function_id, description) values('R2','F8-1','');
insert into role_function(role_id, function_id, description) values('R2','F8-2','');
insert into role_function(role_id, function_id, description) values('R2','F8-3','');
insert into role_function(role_id, function_id, description) values('R2','F8-4','');
insert into role_function(role_id, function_id, description) values('R2','F8-5','');
insert into role_function(role_id, function_id, description) values('R2','F8-6','');

-- category数据：
insert into category(id, pid, name, created_date, trashed, comment) values('1','','类别','2012-06-04 02:00:00','F','分类根节点');
-- 系统参数 start
insert into category(id, pid, name, created_date, trashed, comment) values('1-0','1','系统参数','2014-12-28 02:00:00','F','系统参数');
-- 问卷管理：问卷状态
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1','1-0','问卷状态','2014-12-28 02:00:00','F','问卷管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-0','1-0-1','草稿','2014-12-28 02:00:00','F','问卷管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-1','1-0-1','发布','2014-12-28 02:00:00','F','问卷管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-2','1-0-1','废弃','2014-12-28 02:00:00','F','问卷管理');

-- business Type
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2','1-0','问卷类别','2014-12-28 02:00:00','F','通用系统参数');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-0','1-0-2','工作调查','2014-12-28 02:00:00','F','通用系统参数');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-1','1-0-2','环境调查','2014-12-28 02:00:00','F','通用系统参数');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-2','1-0-2','生活调查','2014-12-28 02:00:00','F','通用系统参数');

insert into category(id, pid, name, created_date, trashed, comment) values('1-0-12','1-0','表单类别','2012-06-04 02:00:00','F','表单类别');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-12-1','1-0-12','表单1','2012-06-04 02:00:00','F','表单1');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-12-2','1-0-12','表单2','2012-06-04 02:00:00','F','表单2');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-12-3','1-0-12','表单3','2012-06-04 02:00:00','F','表单3');

-- 系统参数 end
insert into function_category(function_id,category_id) values('getBusinessType','1-0-2');
insert into function_category(function_id,category_id) values('paperStatus','1-0-1');
insert into function_category(function_id,category_id) values('getFormType', '1-0-12');

		
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

insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (1, '问卷1', '1-0-2-0', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (2, '问卷2', '1-0-2-0', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (3, '问卷3', '1-0-2-0', now(), '1-0-1-0');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (4, '问卷4', '1-0-2-2', now(), '1-0-1-2');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (5, '问卷5', '1-0-2-2', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (6, '问卷6', '1-0-2-1', now(), '1-0-1-1');


insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (7, '问卷7', '1-0-2-1', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (8, '问卷8', '1-0-2-0', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (9, '问卷9', '1-0-2-0', now(), '1-0-1-0');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (10, '问卷10', '1-0-2-2', now(), '1-0-1-2');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (11, '问卷11', '1-0-2-2', now(), '1-0-1-1');

insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (12, '问卷12', '1-0-2-1', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (13, '问卷13', '1-0-2-0', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (14, '问卷14', '1-0-2-0', now(), '1-0-1-0');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (15, '问卷15', '1-0-2-2', now(), '1-0-1-2');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (16, '问卷16', '1-0-2-2', now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, creat_timestamp, status) values (16, '问卷16', '1-0-2-2', now(), '1-0-1-1');

insert into paper_questions (paper_id, question_id, position) values (1, 9, 10);
insert into paper_questions (paper_id, question_id, position) values (1, 8, 20);
insert into paper_questions (paper_id, question_id, position) values (1, 7, 30);
insert into paper_questions (paper_id, question_id, position) values (1, 6, 40);
insert into paper_questions (paper_id, question_id, position) values (1, 5, 50);
insert into paper_questions (paper_id, question_id, position) values (1, 4, 60);
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

insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(1,'R',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing1','2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(2,'P',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing2','1,3',null,now() + 123,'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(3,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(4,'N',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(5,'D',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','2',null,null,'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(6,'C',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','3',null,null,'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(7,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(8,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(9,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now() + 123,'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(10,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now() + 123,'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(11,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(12,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(13,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(14,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(15,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(16,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(17,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(18,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(19,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description,receivers) values(20,'F',null,'lichlei@cn.ibm.com',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing','stan^stan@111.com^0^0|李四^lisi@111.com^0^0|系统测试邮箱^18661014104@163.com^0^0|王五^wangwu@111.com^0^0|张三^zhangsan@111.com^0^0|jack^jack@111.com^0^0|gongbinfeng^530460414@qq.com^0^0|^xxx@111.com^0^0|tom^tom@111.com^0^0|');

insert into group_users(group_id, user_id) values (1, 'lichlei@cn.ibm.com');
insert into group_users(group_id, user_id) values (2, 'lichlei@cn.ibm.com');

insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 4, 'lichlei@cn.ibm.com', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 5, 'lichlei@cn.ibm.com', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 6, 'lichlei@cn.ibm.com', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 7, 'lichlei@cn.ibm.com', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 8, 'lichlei@cn.ibm.com', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 9, 'lichlei@cn.ibm.com', '1,2,3');
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 4, 'zhang3', 2);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 5, 'zhang3', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 6, 'zhang3', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 7, 'zhang3', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 8, 'zhang3', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 9, 'zhang3', '1,3');
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 4, '18661014104', 2);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 5, '18661014104', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 6, '18661014104', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 7, '18661014104', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 8, '18661014104', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 9, '18661014104', '1,2');

insert into survey_receivers (survey_id,user_id,nickName,status,update_timestamp)values(14,'123@111.com','','0',null);
insert into survey_receivers (survey_id,user_id,nickName,status,update_timestamp)values(14,'1234@111.com','','1',now());
insert into survey_receivers (survey_id,user_id,nickName,status,update_timestamp)values(14,'1235@111.com','','0',null);
insert into survey_receivers (survey_id,user_id,nickName,status,update_timestamp)values(14,'1236@111.com','','0',null);
