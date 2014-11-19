delete from attachments;
delete from business_type_character;
delete from case_customers;
delete from case_subscribers;
delete from case_task;
delete from cases;
delete from category;
delete from comments;
delete from customer;
delete from departments;
delete from download_product_history;
delete from download_resource_history;
delete from function_category;
delete from functions;
delete from holders;
delete from media_category;
delete from medias;
delete from module_category;
delete from modules;
delete from papers;
delete from paper_questions;
delete from paper_answers;
delete from procedures;
delete from product_attribute;
delete from product_category;
delete from products;

delete from question_type;
delete from questions;
delete from role_function;
delete from roles;
delete from scheme_category;
delete from scheme_product;
delete from scheme_resource;
delete from schemes;
delete from space_attribute;
delete from spaces;
delete from task;
delete from task_attachments;
delete from task_comments;
delete from task_status_history;
delete from task_subscribers;
delete from user_role;
delete from users;
delete from visit_activities;




insert into modules(module_id, pid, name, description, path) values('M1','','方案管理系统','方案管理系统','');
insert into modules(module_id, pid, name, description, path) values('M1-1','M1','类别管理','类别管理','');
insert into modules(module_id, pid, name, description, path) values('M1-2','M1','人员管理','人员管理','');
insert into modules(module_id, pid, name, description, path) values('M1-3','M1','角色管理','角色管理','');
insert into modules(module_id, pid, name, description, path) values('M1-4','M1','多媒体资源管理','多媒体资源管理','');
insert into modules(module_id, pid, name, description, path) values('M1-5','M1','产品管理','产品管理','');
insert into modules(module_id, pid, name, description, path) values('M1-6','M1','场地管理','场地管理','');
insert into modules(module_id, pid, name, description, path) values('M1-7','M1','问题管理','问题管理','');
insert into modules(module_id, pid, name, description, path) values('M1-8','M1','问卷管理','问卷管理','');
insert into modules(module_id, pid, name, description, path) values('M1-9','M1','协同作业','协同作业','');

insert into modules(module_id, pid, name, description, path) values('M1-10','M1','需求管理','需求管理','');
insert into modules(module_id, pid, name, description, path) values('M1-11','M1','进店管理','进店管理','');
insert into modules(module_id, pid, name, description, path) values('M1-12','M1','方案管理','方案管理','');


insert into functions(function_id, module_id, name, description, path) values('F0','M1','主界面','查看主界面','/index.jsp');
insert into functions(function_id, module_id, name, description, path) values('F1-1','M1-1','类别：查看','有权限查看','/category/list');
insert into functions(function_id, module_id, name, description, path) values('F1-2','M1-1','类别：增加','有权限增加','/category/api/save,/category/api/subId');
insert into functions(function_id, module_id, name, description, path) values('F1-3','M1-1','类别：修改','有权限修改','/category/api/save');
insert into functions(function_id, module_id, name, description, path) values('F1-4','M1-1','类别：删除','有权限删除','/category/api/delete');


insert into functions(function_id, module_id, name, description, path) values('F2-1','M1-2','人员：列表','菜单导航','/account/list');
insert into functions(function_id, module_id, name, description, path) values('F2-2','M1-2','人员：查询','有权限查询','/account/list');
insert into functions(function_id, module_id, name, description, path) values('F2-3','M1-2','人员：查看详细','有权限查看','/account/show/userInfo');
insert into functions(function_id, module_id, name, description, path) values('F2-4','M1-2','人员：增加','有权限增加','account/add');
insert into functions(function_id, module_id, name, description, path) values('F2-5','M1-2','人员：修改他人信息','有权限修改','/account/show,/account/update');
insert into functions(function_id, module_id, name, description, path) values('F2-6','M1-2','人员：修改自己的信息','有权限修改','/account/edit/profile,/account/save/profile');

insert into functions(function_id, module_id, name, description, path) values('F3-1','M1-3','角色：列表','菜单导航','/role/list');
insert into functions(function_id, module_id, name, description, path) values('F3-2','M1-3','角色：查询','有权限查询','/role/list');
insert into functions(function_id, module_id, name, description, path) values('F3-3','M1-3','角色：创建','有权限创建角色','/role/add,/role/doAdd');
insert into functions(function_id, module_id, name, description, path) values('F3-4','M1-3','角色：修改','有权限修改角色','/role/update,/role/save');
insert into functions(function_id, module_id, name, description, path) values('F3-5','M1-3','角色：删除','有权限删除角色','/role/delete');

insert into functions(function_id, module_id, name, description, path) values('F4-1','M1-4','多媒体：列表','菜单导航','/media/list');
insert into functions(function_id, module_id, name, description, path) values('F4-2','M1-4','多媒体：增加','有权限增加','/media/upload,/media/add,/media/save');
insert into functions(function_id, module_id, name, description, path) values('F4-3','M1-4','多媒体：修改','有权限修改','/media/edit,/media/update');
insert into functions(function_id, module_id, name, description, path) values('F4-4','M1-4','多媒体：删除','有权限删除','/media/delete');
insert into functions(function_id, module_id, name, description, path) values('F4-5','M1-4','多媒体：查询','有权限查询','/media/list,/media/mostPopularResource,/media/mostPopular');

insert into functions(function_id, module_id, name, description, path) values('F5-1','M1-5','产品：列表','菜单导航','/product/list');
insert into functions(function_id, module_id, name, description, path) values('F5-2','M1-5','产品：增加','有权限增加','/product/add,/product/doAdd');
insert into functions(function_id, module_id, name, description, path) values('F5-3','M1-5','产品：修改','有权限修改','/product/update,/product/updateProduct');
insert into functions(function_id, module_id, name, description, path) values('F5-4','M1-5','产品：删除','有权限删除','/product/delete');
insert into functions(function_id, module_id, name, description, path) values('F5-5','M1-5','产品：查看','有权限查看','/product/view');
insert into functions(function_id, module_id, name, description, path) values('F5-6','M1-5','产品：统计','查看报表','/product/topUsed,product/top10Used');

insert into functions(function_id, module_id, name, description, path) values('F6-1','M1-6','场地：列表','菜单导航','/holder/list');
insert into functions(function_id, module_id, name, description, path) values('F6-2','M1-6','场地：增加','有权限增加','/holder/add,/holder/save');
insert into functions(function_id, module_id, name, description, path) values('F6-3','M1-6','场地：修改','有权限修改','/holder/update,/holder/updateHolder,/holder/doUpdate');
insert into functions(function_id, module_id, name, description, path) values('F6-5','M1-6','场地：查看','有权限查看','/holder/show/holderInfo');
insert into functions(function_id, module_id, name, description, path) values('F6-4','M1-6','场地：报表','查看报表','/holder/topUsed,/holder/top10Used');

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

insert into functions(function_id, module_id, name, description, path) values('F9-1','M1-9','任务：列表','菜单导航','/task/list');
insert into functions(function_id, module_id, name, description, path) values('F9-2','M1-9','任务：增加','有权限增加','/task/add,/task/save,/task/upload,/task/download');
insert into functions(function_id, module_id, name, description, path) values('F9-3','M1-9','任务：修改任务','有权限修改任务描述','/task/update,/task/doUpdate,/task/deleteAttachment,/task/save,/task/upload,/task/download');

insert into functions(function_id, module_id, name, description, path) values('F10-1','M1-10','需求：列表','菜单导航','/case/list');
insert into functions(function_id, module_id, name, description, path) values('F10-2','M1-10','需求：增加','有权限增加','/case/add,/case/save');
insert into functions(function_id, module_id, name, description, path) values('F10-3','M1-10','需求：修改','有权限修改','/case/detail,/case/save');
insert into functions(function_id, module_id, name, description, path) values('F10-4','M1-10','需求：增加到访记录','有权限修改到访记录','/visit/update,/visit/save,/holder/show/holderInfo/');
insert into functions(function_id, module_id, name, description, path) values('F10-5','M1-10','需求：增加修改回访记录','增加修改回访记录','/visit/update,/visit/save,/holder/show/holderInfo/,/visit/returnVisit,/visit/showReVisit/');

insert into functions(function_id, module_id, name, description, path) values('F11-1','M1-11','进店：列表','菜单导航','/visit/list');
insert into functions(function_id, module_id, name, description, path) values('F11-2','M1-11','进店：增加初次到访','有权限增加初次到访','/visit/add,/visit/save,/holder/show/holderInfo');
insert into functions(function_id, module_id, name, description, path) values('F11-3','M1-11','进店：增加非初次到访','有权限增加非初次到访','/visit/add?isVisited=T,/visit/save,/holder/show/holderInfo/');
insert into functions(function_id, module_id, name, description, path) values('F11-4','M1-11','进店：查看','有权限查看进度信息','/visit/show');
insert into functions(function_id, module_id, name, description, path) values('F11-5','M1-11','进店：修改到访记录','有权限修改到访记录','/visit/update,/visit/save,/holder/show/holderInfo/');
insert into functions(function_id, module_id, name, description, path) values('F11-6','M1-11','进店：报表','查看进店报表','/visit/topVisited,/visit/count,/visit/count2,/visit/count3');

insert into functions(function_id, module_id, name, description, path) values('F12-1','M1-12','方案：列表','菜单导航','/scheme/list');
insert into functions(function_id, module_id, name, description, path) values('F12-2','M1-12','方案：新增','有权限增加方案','/scheme/addScheme,/scheme/save,/scheme/addTemplateScheme/');
insert into functions(function_id, module_id, name, description, path) values('F12-3','M1-12','方案：修改','有权限修改方案','/scheme/update,/scheme/save,/scheme/addProduct,/scheme/saveProduct,/scheme/recoverSchemeProd,/scheme/deleteSchemeProd,/scheme/deleteSchemeMedia,/scheme/recoverSchemeMedia,/scheme/checkProduct,/scheme/checkPicture,/scheme/editProduct,/scheme/addPicture,/scheme/addAudio,/scheme/downloadResource,/scheme/exportBudgetExcel,/scheme/exportProdExcel');
insert into functions(function_id, module_id, name, description, path) values('F12-4','M1-12','方案：删除','有权限删除方案','/scheme/delete');

insert into users(id, name, password, email, register_date, department_id) values('admin','admin','a94d5cd0079cfc8db030e1107de1addd1903a01b','myloginname@sina.com','2012-06-04 01:00:00','D1-1');

insert into departments(department_id, name, pid, description) values('D1','EastTeam','','EastTeam公司');
insert into departments(department_id, name, pid, description) values('D1-1','研发部','D1','EastTeam公司');
insert into departments(department_id, name, pid, description) values('D1-2','销售部','D1','EastTeam公司');
insert into departments(department_id, name, pid, description) values('D1-2-1','渠道销售部','D1-2','EastTeam公司');
insert into departments(department_id, name, pid, description) values('D1-3','客服部','D1','EastTeam公司');

insert into roles(role_id, name, description) values('R0', '管理员','超级用户');

insert into user_role(user_id, role_id) values('admin','R0');


insert into role_function(role_id, function_id, description) values('R0','F0','');
insert into role_function(role_id, function_id, description) values('R0','F1-1','');
insert into role_function(role_id, function_id, description) values('R0','F1-2','');
insert into role_function(role_id, function_id, description) values('R0','F1-3','');
insert into role_function(role_id, function_id, description) values('R0','F1-4','');
insert into role_function(role_id, function_id, description) values('R0','F1-5','');
insert into role_function(role_id, function_id, description) values('R0','F1-6','');
insert into role_function(role_id, function_id, description) values('R0','F1-7','');
insert into role_function(role_id, function_id, description) values('R0','F1-8','');
insert into role_function(role_id, function_id, description) values('R0','F2-1','');
insert into role_function(role_id, function_id, description) values('R0','F2-2','');
insert into role_function(role_id, function_id, description) values('R0','F2-3','');
insert into role_function(role_id, function_id, description) values('R0','F2-4','');
insert into role_function(role_id, function_id, description) values('R0','F2-5','');
insert into role_function(role_id, function_id, description) values('R0','F2-6','');
insert into role_function(role_id, function_id, description) values('R0','F3-1','');
insert into role_function(role_id, function_id, description) values('R0','F3-2','');
insert into role_function(role_id, function_id, description) values('R0','F3-3','');
insert into role_function(role_id, function_id, description) values('R0','F3-4','');
insert into role_function(role_id, function_id, description) values('R0','F3-5','');
insert into role_function(role_id, function_id, description) values('R0','F3-6','');
insert into role_function(role_id, function_id, description) values('R0','F4-1','');
insert into role_function(role_id, function_id, description) values('R0','F4-2','');
insert into role_function(role_id, function_id, description) values('R0','F4-3','');
insert into role_function(role_id, function_id, description) values('R0','F4-4','');
insert into role_function(role_id, function_id, description) values('R0','F4-5','');
insert into role_function(role_id, function_id, description) values('R0','F4-6','');
insert into role_function(role_id, function_id, description) values('R0','F5-1','');
insert into role_function(role_id, function_id, description) values('R0','F5-2','');
insert into role_function(role_id, function_id, description) values('R0','F5-3','');
insert into role_function(role_id, function_id, description) values('R0','F5-4','');
insert into role_function(role_id, function_id, description) values('R0','F5-5','');
insert into role_function(role_id, function_id, description) values('R0','F5-6','');
insert into role_function(role_id, function_id, description) values('R0','F6-1','');
insert into role_function(role_id, function_id, description) values('R0','F6-2','');
insert into role_function(role_id, function_id, description) values('R0','F6-3','');
insert into role_function(role_id, function_id, description) values('R0','F6-5','');
insert into role_function(role_id, function_id, description) values('R0','F6-4','');

insert into role_function(role_id, function_id, description) values('R0','F7-1','');
insert into role_function(role_id, function_id, description) values('R0','F7-2','');
insert into role_function(role_id, function_id, description) values('R0','F7-3','');
insert into role_function(role_id, function_id, description) values('R0','F7-4','');

insert into role_function(role_id, function_id, description) values('R0','F8-1','');
insert into role_function(role_id, function_id, description) values('R0','F8-2','');
insert into role_function(role_id, function_id, description) values('R0','F8-3','');
insert into role_function(role_id, function_id, description) values('R0','F8-4','');
insert into role_function(role_id, function_id, description) values('R0','F8-5','');
insert into role_function(role_id, function_id, description) values('R0','F8-6','');

insert into role_function(role_id, function_id, description) values('R0','F9-1','');
insert into role_function(role_id, function_id, description) values('R0','F9-2','');
insert into role_function(role_id, function_id, description) values('R0','F9-3','');

insert into role_function(role_id, function_id, description) values('R0','F10-1','');
insert into role_function(role_id, function_id, description) values('R0','F10-2','');
insert into role_function(role_id, function_id, description) values('R0','F10-3','');
insert into role_function(role_id, function_id, description) values('R0','F10-4','');
insert into role_function(role_id, function_id, description) values('R0','F10-5','');

insert into role_function(role_id, function_id, description) values('R0','F11-1','');
insert into role_function(role_id, function_id, description) values('R0','F11-2','');
insert into role_function(role_id, function_id, description) values('R0','F11-3','');
insert into role_function(role_id, function_id, description) values('R0','F11-4','');
insert into role_function(role_id, function_id, description) values('R0','F11-5','');
insert into role_function(role_id, function_id, description) values('R0','F11-6','');

insert into role_function(role_id, function_id, description) values('R0','F12-1','');
insert into role_function(role_id, function_id, description) values('R0','F12-2','');
insert into role_function(role_id, function_id, description) values('R0','F12-3','');
insert into role_function(role_id, function_id, description) values('R0','F12-4','');

-- category数据：
insert into category(id, pid, name, created_date, trashed, comment) values('1','','类别','2012-06-04 02:00:00','F','分类根节点');
-- 系统参数 start
insert into category(id, pid, name, created_date, trashed, comment) values('1-0','1','系统参数','2014-12-28 02:00:00','F','系统参数');
-- 会场管理模块：场地特色
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0','1-0','场地特色','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-0','1-0-0','观景房','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-1','1-0-0','千人会场','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-2','1-0-0','欧式风格','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-3','1-0-0','中式风格','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-4','1-0-0','优美怡人','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-5','1-0-0','高层会场','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-6','1-0-0','无柱会场','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-7','1-0-0','自然采光','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-8','1-0-0','草坪','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-9','1-0-0','婚礼场地','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-10','1-0-0','户外广场','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-11','1-0-0','山庄','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-12','1-0-0','核心商圈','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-13','1-0-0','景区周边','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-14','1-0-0','市中心','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-15','1-0-0','免费WIFI','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-16','1-0-0','高尔夫球场','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-17','1-0-0','温泉','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-18','1-0-0','特色酒吧','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-19','1-0-0','游泳池','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-20','1-0-0','特色餐饮','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-21','1-0-0','民族风格','2014-12-28 02:00:00','F','会场管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-0-22','1-0-0','皇家风范','2014-12-28 02:00:00','F','会场管理');

-- 问卷管理：问卷状态
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1','1-0','问卷状态','2014-12-28 02:00:00','F','问卷管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-0','1-0-1','草稿','2014-12-28 02:00:00','F','问卷管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-1','1-0-1','发布','2014-12-28 02:00:00','F','问卷管理');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-1-2','1-0-1','废弃','2014-12-28 02:00:00','F','问卷管理');

-- 庆典类别(策划类别)
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2','1-0','策划类别','2014-12-28 02:00:00','F','通用系统参数');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-0','1-0-2','婚庆','2014-12-28 02:00:00','F','通用系统参数');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-1','1-0-2','生日','2014-12-28 02:00:00','F','通用系统参数');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-2-2','1-0-2','公司年会','2014-12-28 02:00:00','F','通用系统参数');

-- 客户身份
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3','1-0','身份','2012-06-04 02:00:00','F','某一个case的stakeholder的身份');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-1','1-0-3','新娘','2012-06-04 02:00:00','F','新娘');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-2','1-0-3','新郎','2012-06-04 02:00:00','F','新郎');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-3','1-0-3','寿星','2012-06-04 02:00:00','F','宝宝');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-4','1-0-3','亲戚','2012-06-04 02:00:00','F','亲戚');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-5','1-0-3','朋友','2012-06-04 02:00:00','F','朋友');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-6','1-0-3','同事','2012-06-04 02:00:00','F','同事');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-7','1-0-3','领导','2012-06-04 02:00:00','F','领导');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-8','1-0-3','同学','2012-06-04 02:00:00','F','领导');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-3-9','1-0-3','联系人','2012-06-04 02:00:00','F','联系人');

-- 访问类别
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-4','1-0','到访类别','2014-01-10 00:00:00','F','到访类别');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-4-0','1-0-4','到访','2014-01-10 00:00:00','F','到访类别');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-4-1','1-0-4','回访','2014-01-10 00:00:00','F','到访类别');

-- task 优先级
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-5','1-0','作业优先级','2012-06-04 02:00:00','F','作业优先级');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-5-1','1-0-5','低优先级','2012-06-04 02:00:00','F','作业优先级低');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-5-2','1-0-5','中优先级','2012-06-04 02:00:00','F','作业优先级中');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-5-3','1-0-5','高优先级','2012-06-04 02:00:00','F','作业优先高');

-- task 类别
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-6','1-0','作业类型','2012-06-04 02:00:00','F','作业类型');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-6-1','1-0-6','设计','2012-06-04 02:00:00','F','设计');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-6-2','1-0-6','工程','2012-06-04 02:00:00','F','工程');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-6-3','1-0-6','会议','2012-06-04 02:00:00','F','会议');

-- task 状态
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-7','1-0','作业状态','2012-06-04 02:00:00','F','作业状态');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-7-1','1-0-7','新建','2012-06-04 02:00:00','F','新建作业');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-7-2','1-0-7','进行中','2012-06-04 02:00:00','F','作业进行中');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-7-3','1-0-7','完成','2012-06-04 02:00:00','F','作业已完成');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-7-4','1-0-7','废弃','2012-06-04 02:00:00','F','作业被废弃');

-- Case 状态
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-8','1-0','需求状态','2012-06-04 02:00:00','F','需求状态');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-8-1','1-0-8','新建','2012-06-04 02:00:00','F','新建');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-8-2','1-0-8','进行中','2012-06-04 02:00:00','F','进行中');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-8-3','1-0-8','完成','2012-06-04 02:00:00','F','已完成');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-8-4','1-0-8','废弃','2012-06-04 02:00:00','F','被废弃');

-- 方案 状态
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-9','1-0','方案状态','2012-06-04 02:00:00','F','方案状态');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-9-1','1-0-9','新建','2012-06-04 02:00:00','F','新建');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-9-2','1-0-9','进行中','2012-06-04 02:00:00','F','进行中');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-9-3','1-0-9','完成','2012-06-04 02:00:00','F','已完成');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-9-4','1-0-9','废弃','2012-06-04 02:00:00','F','被废弃');

-- 预算类别
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10','1-0','预算分类','2012-06-04 02:00:00','F','预算分类');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-1','1-0-10','人员服务','2012-06-04 02:00:00','F','人员服务');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-2','1-0-10','视频梦工场','2012-06-04 02:00:00','F','视频梦工场');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-3','1-0-10','酒店大门布置','2012-06-04 02:00:00','F','酒店大门布置');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-4','1-0-10','迎宾区布置','2012-06-04 02:00:00','F','迎宾区布置');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-5','1-0-10','主厅-仪式区布置','2012-06-04 02:00:00','F','主厅-仪式区布置');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-6','1-0-10','主厅-嘉宾区布置','2012-06-04 02:00:00','F','主厅-嘉宾区布置');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-7','1-0-10','副厅-仪式区布置','2012-06-04 02:00:00','F','副厅-仪式区布置');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-8','1-0-10','副厅-嘉宾区布置','2012-06-04 02:00:00','F','副厅-嘉宾区布置');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-9','1-0-10','舞美灯光','2012-06-04 02:00:00','F','舞美灯光');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-10','1-0-10','婚礼道具','2012-06-04 02:00:00','F','婚礼道具');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-10-11','1-0-10','喜品定制','2012-06-04 02:00:00','F','喜品定制');

insert into category(id, pid, name, created_date, trashed, comment) values('1-0-11','1-0','其他','2012-06-04 02:00:00','F','产品其他分类');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-11-1','1-0-11','其他','2012-06-04 02:00:00','F','产品其他分类');

insert into category(id, pid, name, created_date, trashed, comment) values('1-0-12','1-0','表单类别','2012-06-04 02:00:00','F','表单类别');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-12-1','1-0-12','到访单','2012-06-04 02:00:00','F','到访单');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-12-2','1-0-12','回访单','2012-06-04 02:00:00','F','回访单');
insert into category(id, pid, name, created_date, trashed, comment) values('1-0-12-3','1-0-12','需求单','2012-06-04 02:00:00','F','需求单');

-- 系统参数 end
insert into category(id, pid, name, created_date, trashed, comment) values('1-1','1','风格','2012-06-04 02:00:00','F','婚庆根节点');
insert into category(id, pid, name, created_date, trashed, comment) values('1-1-1','1-1','搞笑','2012-06-04 02:00:00','F','搞笑的媒体资源');
insert into category(id, pid, name, created_date, trashed, comment) values('1-1-2','1-1','浪漫','2012-06-04 02:00:00','F','温馨的媒体资源');
insert into category(id, pid, name, created_date, trashed, comment) values('1-2','1','档次','2012-06-04 02:00:00','F','生日根节点');
insert into category(id, pid, name, created_date, trashed, comment) values('1-2-1','1-2','经济','2012-06-04 02:00:00','F','搞笑的媒体资源');
insert into category(id, pid, name, created_date, trashed, comment) values('1-2-2','1-2','奢华','2012-06-04 02:00:00','F','温馨的媒体资源');
insert into category(id, pid, name, created_date, trashed, comment) values('1-3','1','图片','2012-06-04 02:00:00','F','图片根节点');
insert into category(id, pid, name, created_date, trashed, comment) values('1-3-1','1-3','桌花','2012-06-04 02:00:00','F','桌花');
insert into category(id, pid, name, created_date, trashed, comment) values('1-3-2','1-3','舞台','2012-06-04 02:00:00','F','舞台');
insert into category(id, pid, name, created_date, trashed, comment) values('1-5','1','颜色','2012-06-04 02:00:00','F','产品颜色');
insert into category(id, pid, name, created_date, trashed, comment) values('1-5-1','1-5','白色','2012-06-04 02:00:00','F','白色');
insert into category(id, pid, name, created_date, trashed, comment) values('1-5-2','1-5','黑色','2012-06-04 02:00:00','F','黑色');
insert into category(id, pid, name, created_date, trashed, comment) values('1-6','1','尺寸','2012-06-04 02:00:00','F','产品尺寸');
insert into category(id, pid, name, created_date, trashed, comment) values('1-6-1','1-6','40','2012-06-04 02:00:00','F','40');
insert into category(id, pid, name, created_date, trashed, comment) values('1-6-2','1-6','42','2012-06-04 02:00:00','F','42');
insert into category(id, pid, name, created_date, trashed, comment) values('1-6-3','1-6','4','2012-06-04 02:00:00','F','45');

insert into function_category(function_id,category_id) values('getStyles','1-1');
insert into function_category(function_id,category_id) values('getStyles','1-2');
insert into function_category(function_id,category_id) values('getProductCategories','1-0-11-1');
insert into function_category(function_id,category_id) values('getProductCategories','1-5');
insert into function_category(function_id,category_id) values('getProductCategories','1-6');
insert into function_category(function_id,category_id) values('getBusinessType','1-0-2');
insert into function_category(function_id,category_id) values('getCaseStatus', '1-0-8');
insert into function_category(function_id,category_id) values('paperStatus','1-0-1');
insert into function_category(function_id,category_id) values('getSpaceAttributes','1-0-0');
insert into function_category(function_id,category_id) values('getTaskStatus','1-0-7');
insert into function_category(function_id,category_id) values('getTaskType','1-0-6');
insert into function_category(function_id,category_id) values('getTaskPriority','1-0-5');
insert into function_category(function_id,category_id) values('getCharacterType', '1-0-3');
insert into function_category(function_id,category_id) values('getSchemeStauts', '1-0-9');
insert into function_category(function_id,category_id) values('getProductAttribute', '1-0-10');
insert into function_category(function_id,category_id) values('getFormType', '1-0-12');

-- 不同类型case默认的主角
-- 婚庆：新娘， 新郎	,联系人
insert into business_type_character(business_type, character_id) values('1-0-2-0','1-0-3-1');
insert into business_type_character(business_type, character_id) values('1-0-2-0','1-0-3-2');
insert into business_type_character(business_type, character_id) values('1-0-2-0','1-0-3-9');
-- 生日宴：寿星，联系人
insert into business_type_character(business_type, character_id) values('1-0-2-1','1-0-3-3');
insert into business_type_character(business_type, character_id) values('1-0-2-1','1-0-3-9');
-- 公司年会：联系人
insert into business_type_character(business_type, character_id) values('1-0-2-2','1-0-3-9');

