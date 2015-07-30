set character_set_database = utf8;
set character_set_server = utf8;

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
delete from survey_receivers;


insert into modules(module_id, pid, name, description, path) values('M1','','surveysystem','surveysystem','');
insert into modules(module_id, pid, name, description, path) values('M1-1','M1','my gourp','my group','');
insert into modules(module_id, pid, name, description, path) values('M1-2','M1','my lunch','my lunch','');
insert into modules(module_id, pid, name, description, path) values('M1-3','M1','participate','paticipate','');
insert into modules(module_id, pid, name, description, path) values('M1-7','M1','my question','my question','');
insert into modules(module_id, pid, name, description, path) values('M1-8','M1','my paper','my paper','');

insert into modules(module_id, pid, name, description, path) values('M2-1','M1','admin','admin','');

insert into functions(function_id, module_id, name, description, path) values('F0','M1','main UI','view main UI','/index.jsp');
insert into functions(function_id, module_id, name, description, path) values('F1-1','M1-1','my group:list','','/myGroup/list');
insert into functions(function_id, module_id, name, description, path) values('F1-2','M1-1','my group:add','','/myGroup/saveGroup');
insert into functions(function_id, module_id, name, description, path) values('F1-3','M1-1','my group:modify','','/myGroup/toUpdateGroup,/myGroup/updateGroup,/myGroup/importGroup');
insert into functions(function_id, module_id, name, description, path) values('F1-4','M1-1','my group:delete','','/myGroup/deleteGroup/');

insert into functions(function_id, module_id, name, description, path) values('F2-1','M1-2','my launch:list','','/survey/myLaunch');
insert into functions(function_id, module_id, name, description, path) values('F2-2','M1-2','my launch:view','','/survey/surveyDetail/');
insert into functions(function_id, module_id, name, description, path) values('F2-3','M1-2','my launch:statistics','','/survey/statistic/,survey/accessSurvey/');
insert into functions(function_id, module_id, name, description, path) values('F2-4','M1-2','my launch:create survey','','/survey/createSurvey/,/survey/surveyAction/');
insert into functions(function_id, module_id, name, description, path) values('F2-5','M1-2','my launch:send a reminder','','/survey/sendNoti');
insert into functions(function_id, module_id, name, description, path) values('F2-6','M1-2','my launch:','export','/survey/export');

insert into functions(function_id, module_id, name, description, path) values('F3-1','M1-3','my participate:list','','/survey/myParticipation');
insert into functions(function_id, module_id, name, description, path) values('F3-2','M1-3','my participate:view','','/survey/accessSurvey/');
insert into functions(function_id, module_id, name, description, path) values('F3-3','M1-3','my participate：modify','','/survey/saveAction');

insert into functions(function_id, module_id, name, description, path) values('F4-1','M1-4','my profile：view','view my profile','/account/profile');
insert into functions(function_id, module_id, name, description, path) values('F4-2','M1-4','my profile：update','update my profile','/account/update');


insert into functions(function_id, module_id, name, description, path) values('F7-1','M1-7','my question：list','','/question/list');
insert into functions(function_id, module_id, name, description, path) values('F7-2','M1-7','my question：add','','/question/addQuestion,/question/saveQuestion');
insert into functions(function_id, module_id, name, description, path) values('F7-3','M1-7','my question：modify','','/question/editQuestion,/question/updateQuestion');
insert into functions(function_id, module_id, name, description, path) values('F7-4','M1-7','my question：delete','','/question/deleteQuestion');
insert into functions(function_id, module_id, name, description, path) values('F7-5','M1-7','my question：query to requestioins owned by others','','');

insert into functions(function_id, module_id, name, description, path) values('F8-1','M1-8','my paper：list','','/paper/list');
insert into functions(function_id, module_id, name, description, path) values('F8-2','M1-8','my paper：add','','/paper/add/,/paper/save');
insert into functions(function_id, module_id, name, description, path) values('F8-3','M1-8','my paper：modify','','/paper/edit,/paper/update');
insert into functions(function_id, module_id, name, description, path) values('F8-4','M1-8','my paper：delete','','/paper/delete');
insert into functions(function_id, module_id, name, description, path) values('F8-5','M1-8','my paper：publish','','/paper/publish');
insert into functions(function_id, module_id, name, description, path) values('F8-6','M1-8','my paper：view','','/paper/show');
insert into functions(function_id, module_id, name, description, path) values('F8-7','M1-8','my paper：query to papers owned by others','query to papers owned by others','');

insert into functions(function_id, module_id, name, description, path) values('F21','M2-1','admin menu','view admin menu','');


insert into users(id, name, password, register_date) values('lichlei@cn.ibm.com','lichlei@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 01:00:00');
insert into users(id, name, password, register_date) values('wangxhdl@cn.ibm.com','wangxhdl@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 01:00:00');
insert into users(id, name, password, register_date) values('gongbf@cn.ibm.com','gongbf@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 02:00:00');
insert into users(id, name, password, register_date) values('zhangfd@cn.ibm.com','zhangfd@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 02:00:00');
insert into users(id, name, password, register_date) values('liush@cn.ibm.com','liush@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 02:00:00');
insert into users(id, name, password, register_date) values('ldlxiao@cn.ibm.com','ldlxiao@cn.ibm.com','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 02:00:00');
insert into users(id, name, password, register_date) values('maoyeye@qq.com','LiChunlei','a94d5cd0079cfc8db030e1107de1addd1903a01b','2012-06-04 02:00:00');

insert into roles(role_id, name, description) values('R0', 'admin','super user');
insert into roles(role_id, name, description) values('R9', 'user','user');

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



insert into category(id, pid, name, created_date, trashed, comment) values('1','','category','2012-06-04 02:00:00','F','category root');

insert into category(id, pid, name, created_date, trashed, comment) values('1-0','1','system setting','2014-12-28 02:00:00','F','system setting');

insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1','1-0','Paper Status','2014-12-28 02:00:00','F','paper management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-0','1-0-1','Draft','2014-12-28 02:00:00','F','paper management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-1','1-0-1','Published','2014-12-28 02:00:00','F','paper management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-2','1-0-1','Trashed','2014-12-28 02:00:00','F','paper management');

insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2','1-0','Survey Type','2014-12-28 02:00:00','F','system parameters');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-0','1-0-2','Job','2014-12-28 02:00:00','F','system parameters');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-1','1-0-2','Life','2014-12-28 02:00:00','F','system parameters');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-2','1-0-2','Other','2014-12-28 02:00:00','F','system parameters');

insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3','1-0','Survey Status','2014-12-28 02:00:00','F','survey management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-0','1-0-3','Draft','2014-12-28 02:00:00','F','survey management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-1','1-0-3','Published','2014-12-28 02:00:00','F','survey management');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-2','1-0-3','Completed','2014-12-28 02:00:00','F','survey management');


insert into function_category(function_id,category_id) values('getBusinessType','1-0-2');
insert into function_category(function_id,category_id) values('paperStatus','1-0-1');
insert into function_category(function_id,category_id) values('surveyStatus','1-0-3');

