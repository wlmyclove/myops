CREATE DATABASE `ops`  DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin ;

use ops;

--  用户表
create table t_users (
  	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(30) NOT NULL COMMENT 'unique index(UI_CIRC_USER__USER_NAME)' COLLATE 'utf8_bin',
	`password` VARCHAR(128) NOT NULL COMMENT '口令' COLLATE 'utf8_bin',
	`realname` VARCHAR(50) NOT NULL COMMENT '真实名' COLLATE 'utf8_bin',
	`gender` INT(1) NULL DEFAULT NULL COMMENT 'M--男；M--女' COLLATE 'utf8_bin',
	`usertype` INT(1) NULL DEFAULT NULL,
	`status` INT(1) NOT NULL DEFAULT 1 COMMENT '1--有效；2--无效' COLLATE 'utf8_bin',
	`telephone` VARCHAR(50) NULL DEFAULT NULL COMMENT '联系电话' COLLATE 'utf8_bin',
	`email` VARCHAR(50) NULL DEFAULT NULL COMMENT 'email' COLLATE 'utf8_bin',
	`change_time` DATETIME NULL DEFAULT NULL COMMENT '上次密码修改时间',
	primary key (id)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

ALTER TABLE t_users ADD CONSTRAINT u_t_user_name UNIQUE(username);

insert into t_users (username,password,realname,gender,usertype,status) values ('wanglei',md5(123456),'billy','1','1','1');
insert into t_users (username,password,realname,gender,usertype,status) values ('zhangyue',md5(123456),'张玥','1','2','0');
insert into t_users (username,password,realname,gender,usertype,status) values ('xiangshijian',md5(123456),'向诗健','1','2','1');
commit;


-- 角色表
create table t_role(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(20) NOT NULL,
	`description` varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
AUTO_INCREMENT=1;

ALTER TABLE t_role ADD CONSTRAINT u_t_role_name UNIQUE(name);

-- 给用户表添加 用户类型外键
ALTER TABLE t_users ADD CONSTRAINT fk_troleid_tusertype FOREIGN KEY (usertype) REFERENCES t_role (id);




insert into t_role (name,description) values ('管理员','最高权限');
insert into t_role (name,description) values ('应用运维','应用运维配置信息管理');

commit;





-- 权限表
create table t_permission(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(20) NOT NULL,
	`value` varchar(40),
	`type` varchar(2),
	`paraent_id` int(11),  -- 按钮才有的配置，按钮ID
	`list_order` int(3),
	`description` varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
AUTO_INCREMENT=1;




--- type 1菜单，2按钮
insert into t_permission (name ,value,type,paraent_id,list_order,description) values
('首页','main','1','0','1','首页');
insert into t_permission (name ,value,type,paraent_id,list_order,description) values
('配置清单','operation','1','0','2','配置清单');
insert into t_permission (name ,value,type,paraent_id,list_order,description) values
('网络设备','network','1','0','3','网络设备');
insert into t_permission (name ,value,type,paraent_id,list_order,description) values
('设置','config','1','0','4','设置菜单');
insert into t_permission (name ,value,type,paraent_id,list_order,description) values
('变更日志','changelog','1','0','5','变更日志');
insert into t_permission (name ,value,type,paraent_id,list_order,description) values
('退出','exit','1','0','6','退出');
insert into t_permission (name ,value,type,paraent_id,list_order,description) values
('配置变更','1','2','0','0','是否有删除编辑按钮权限');


commit;




-- 用户与角色对照表
create table t_user_role(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`user_id` int(11) NOT NULL,
	`role_id` int(11) NOT NULL,
	PRIMARY KEY (`id`),
	KEY `fk_user_role_t_role_1` (`role_id`),
	KEY `fk_user_role_t_user_1` (`user_id`),
	CONSTRAINT `fk_user_role_t_role_1` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fk_user_role_t_user_1` FOREIGN KEY (`user_id`) REFERENCES `t_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
COLLATE='utf8_bin'
ENGINE=InnoDB
AUTO_INCREMENT=1;


insert into t_user_role (user_id,role_id) values ('1','1');

insert into t_user_role (user_id,role_id) values ('2','2');
insert into t_user_role (user_id,role_id) values ('3','2');
commit;

-- 角色与权限对照表
create table t_role_permission(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`role_id` int(11) NOT NULL,
	`permission_id` int(11) NOT NULL,
	PRIMARY KEY (`id`),
	KEY `fk_role_permission_t_permission_1` (`permission_id`),
	KEY `fk_role_permission_t_role_1` (`role_id`),
	CONSTRAINT `fk_role_permission_t_permission_1` FOREIGN KEY (`permission_id`) REFERENCES `t_permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fk_role_permission_t_role_1` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
COLLATE='utf8_bin'
ENGINE=InnoDB
AUTO_INCREMENT=1;

insert into t_role_permission (role_id,permission_id) values (1,1);
insert into t_role_permission (role_id,permission_id) values (1,2);
insert into t_role_permission (role_id,permission_id) values (1,3);
insert into t_role_permission (role_id,permission_id) values (1,4);
insert into t_role_permission (role_id,permission_id) values (1,5);
insert into t_role_permission (role_id,permission_id) values (1,6);
insert into t_role_permission (role_id,permission_id) values (1,7);

insert into t_role_permission (role_id,permission_id) values (2,1);
insert into t_role_permission (role_id,permission_id) values (2,2);
insert into t_role_permission (role_id,permission_id) values (2,3);
insert into t_role_permission (role_id,permission_id) values (2,6);







commit;


-- 代码表
create table t_code(
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`code` varchar(10) comment '代码',
	`name` varchar(30) comment '代码名称',
	primary key (id)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
AUTO_INCREMENT=1;

ALTER TABLE t_code ADD CONSTRAINT u_t_code_code UNIQUE(code);

insert into t_code (code,name) values ('A001','生产');
insert into t_code (code,name) values ('A002','联调');
insert into t_code (code,name) values ('A003','开发');
insert into t_code (code,name) values ('A004','其它');
insert into t_code (code,name) values ('0','错误');
insert into t_code (code,name) values ('1','正常');
commit;


-- 公司信息
create table t_company(
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`company_name` VARCHAR(30) NOT NULL COMMENT 'unique index(UI_tsi_systemname)' COMMENT '公司名称',
	`person_name`  VARCHAR(30) comment '甲方联系人',
	`person_tel` VARCHAR(30) comment '联系电话',
	`description` varchar(255) DEFAULT NULL COMMENT '备注',
	primary key (id)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
AUTO_INCREMENT=1;

ALTER TABLE t_company ADD CONSTRAINT u_t_company_company_name UNIQUE(company_name);



insert into t_company (company_name,person_name,person_tel,description) values ('公会','包包','13311331133','上海保险同业公会');
insert into t_company (company_name,person_name,person_tel,description) values ('银保信','吕老','1141141144','银保信科技有限公司');
commit;



-- 系统信息表
create table t_system_info(
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`company_id` int(11) NOT NULL COMMENT '公司id外键 FK t_company id',
	`system_name` VARCHAR(30) NOT NULL COMMENT '系统名称',
	`system_type` VARCHAR(10) NOT NULL COMMENT '系统类型 1-生产  2-联调 3-开发  4-其它',
	`description` varchar(255) DEFAULT NULL COMMENT '备注',
	primary key (id),
	KEY `fk_system_company_id` (`company_id`),
	CONSTRAINT `fk_system_company_id` FOREIGN KEY (`company_id`) REFERENCES `t_company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
COLLATE='utf8_bin'
ENGINE=InnoDB
AUTO_INCREMENT=1;
ALTER TABLE t_system_info ADD CONSTRAINT u_t_systeminfo_system_name UNIQUE(system_name,system_type);


insert into t_system_info ( company_id,system_name,system_type) values ('1','上海快处易赔系统','A001');
insert into t_system_info ( company_id,system_name,system_type) values ('1','上海快处易赔系统-联调','A002');
insert into t_system_info ( company_id,system_name,system_type) values ('1','上海快处易赔系统-开发','A003');

insert into t_system_info ( company_id,system_name,system_type) values ('2','上海车险系统','A001');
insert into t_system_info ( company_id,system_name,system_type) values ('2','上海车险系统-开发','A003');
insert into t_system_info ( company_id,system_name,system_type) values ('2','上海车险系统-其它','A004');
commit;





-- 主机信息表
create table t_host_info;

-- 数据库信息表
create table t_database_info;

-- 中间件信息表
create table t_middleware_info;

-- 主机用户信息表
create table t_host_user_info;

-- 数据库用户信息表
create table t_db_user_info;

-- 中间件用户信息表
create table t_middle_user_info;

-- 主机定时任务表
create table t_host_job_info;

-- 数据库定时任务表
create table t_db_job_info;

-- 中间件定时任务表
create table t_middle_job_info;


-- 主机外部关联表
create table t_host_job_info;

-- 数据库外部关联表
create table t_db_job_info;

-- 中间件外部关联表
create table t_middle_job_info;






-- 查询用户角色

select a.real_name,c.description from t_users a ,t_user_role b ,t_role c  where a.id = b.user_id
and b.role_id = c.id;

--查看用户菜单
select a.id,d.name,d.value,d.list_order from t_users a ,t_user_role b ,t_role_permission c,t_permission d 
where a.id = b.user_id  and b.role_id = c.role_id  and c.permission_id = d.id and a.id = 2 and d.type = 1;


--根据用户ID 获取菜单








