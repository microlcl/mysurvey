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

insert into users(id, name, password, email, register_date, department_id) values('admin','admin','a94d5cd0079cfc8db030e1107de1addd1903a01b','myloginname@sina.com','2012-06-04 01:00:00','D1-1');
insert into users(id, name, password, email, register_date, department_id) values('zhang3','user','a94d5cd0079cfc8db030e1107de1addd1903a01b','z2@gmail.com','2012-06-04 02:00:00','D1-1');

insert into roles(role_id, name, description) values('R0', '管理员','超级用户');
insert into roles(role_id, name, description) values('R1', '问题管理员','问题管理员');
insert into roles(role_id, name, description) values('R2', '问卷管理员','问卷管理员');


insert into user_role(user_id, role_id) values('zhang3','R1');
insert into user_role(user_id, role_id) values('admin','R0');


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

		
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id) values(1,'你是通过什么途径知道我们的产品的1？','1','网上搜索^朋友分享^无意间了解','1-0-2-0','F','ydq');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id) values(2,'你喜欢的灯具材质是2？','2','木质^金属^水晶^其他','1-0-2-0','F','ydq');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id) values(3,'你对本产品有什么建议3？','3','','1-0-2-0','F','ydq');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id) values(4,'你是通过什么途径知道我们的产品的4？','1','网上搜索^朋友分享^无意间了解','1-0-2-1','F','ydq');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id) values(5,'你喜欢的灯具材质是5？','2','木质^金属^水晶^其他','1-0-2-0','F','admin');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id) values(6,'你是通过什么途径知道我们的产品的6？','1','网上搜索^朋友分享^无意间了解','1-0-2-0','F','admin');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id) values(7,'你喜欢的灯具材质是7？','2','木质^金属^水晶^其他','1-0-2-0','F','admin');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id) values(8,'你是通过什么途径知道我们的产品的8？','1','网上搜索^朋友分享^无意间了解','1-0-2-2','F','admin');
insert into questions (question_id,question, question_type, question_options, business_type, trashed, user_id) values(9,'你喜欢的灯具材质是9？','2','木质^金属^水晶^其他','1-0-2-0','F','admin');

insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (1, '问卷1', '1-0-2-0', '1-0-12-3',now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (2, '问卷2', '1-0-2-0', '1-0-12-3',now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (3, '问卷3', '1-0-2-0', '1-0-12-3',now(), '1-0-1-0');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (4, '问卷4', '1-0-2-2', '1-0-12-3',now(), '1-0-1-2');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (5, '问卷5', '1-0-2-2', '1-0-12-3',now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (6, '问卷6', '1-0-2-1', '1-0-12-3',now(), '1-0-1-1');


insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (7, '问卷7', '1-0-2-1', '1-0-12-2',now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (8, '问卷8', '1-0-2-0', '1-0-12-2',now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (9, '问卷9', '1-0-2-0', '1-0-12-2',now(), '1-0-1-0');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (10, '问卷10', '1-0-2-2', '1-0-12-2',now(), '1-0-1-2');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (11, '问卷11', '1-0-2-2', '1-0-12-2',now(), '1-0-1-1');

insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (12, '问卷12', '1-0-2-1', '1-0-12-1',now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (13, '问卷13', '1-0-2-0', '1-0-12-1',now(), '1-0-1-1');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (14, '问卷14', '1-0-2-0', '1-0-12-1',now(), '1-0-1-0');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (15, '问卷15', '1-0-2-2', '1-0-12-1',now(), '1-0-1-2');
insert into papers (paper_id, paper_name, business_type, form_type, creat_timestamp, status) values (16, '问卷16', '1-0-2-2', '1-0-12-1',now(), '1-0-1-1');

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
insert into paper_questions (paper_id, question_id, position) values (17, 6, 60);


--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,4,'1');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,5,'2');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,6,'3');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,7,'2');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,8,'2');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C1',1,9,'2,3');

--insert into paper_answers(business_id, paper_id, question_id, answer) values('C2',6,1,'2');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('C2',6,3,'abcde');
--insert into paper_answers(business_id, paper_id, question_id, answer) values('V6',7,3,'abcde');

insert into groups(group_id, group_name, comment, content, edit_date, trashed, user_id) values(1,'群组1','测试群组','张三^zhangsan@cn.ibm.com|李四^lisi@cn.ibm.com|王五^wangwu@cn.ibm.com',now(),'F','admin');
insert into groups(group_id, group_name, comment, content, edit_date, trashed, user_id) values(2,'群组2','测试群组','',now(),'F','zhang3');
insert into groups(group_id, group_name, comment, content, edit_date, trashed, user_id) values(3,'群组3','测试群组','jack^jack@cn.ibm.com|tom^tom@cn.ibm.com|stan^stan@cn.ibm.com|^xxx@cn.ibm.com',now(),'F','admin');

insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(1,'R',null,'admin',1,'ibm.com','Testing1','2,3',null,now(),'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(2,'P',null,'admin',1,'ibm.com','Testing2','1,3',null,now() + 123,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(3,'F',null,'admin',1,'ibm.com','Testing3','1,2',null,now(),'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(4,'N',null,'admin',1,'ibm.com','Testing3','1',null,now(),'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(5,'D',null,'admin',1,'ibm.com','Testing3','2',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(6,'C',null,'admin',1,'ibm.com','Testing3','3',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(7,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(8,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,now(),'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(9,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,now() + 123,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(10,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,now() + 123,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(11,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(12,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(13,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(14,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(15,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(16,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(17,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(18,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(19,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,null,'T','just for testing');
insert into survey(survey_id, status, update_timestamp, user_id, paper_id, paper_url, subject, groups_id, sent_timestamp, deadline_timestamp, is_anonymous, description) values(20,'F',null,'admin',1,'ibm.com','Testing3','1,2,3',null,null,'T','just for testing');

insert into group_users(group_id, user_id) values (1, 'admin');
insert into group_users(group_id, user_id) values (2, 'admin');

insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 1, 'admin', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 2, 'admin', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 3, 'admin', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 4, 'admin', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 5, 'admin', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 6, 'admin', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 7, 'admin', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 8, 'admin', 1);
insert into paper_answers(survey_id, question_id, answer_user_id, answer) values(1, 9, 'admin', '1,2,3');
