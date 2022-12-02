CREATE DATABASE `token_atm` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

-- menu
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint COMMENT 'parent menu ID，first menu 0',
  `name` varchar(50) COMMENT 'menu name',
  `url` varchar(200) COMMENT 'menu id ',
  `perms` varchar(500) COMMENT 'Authorization(user:list,user:create)',
  `type` int COMMENT 'type   0：contents   1：menu   2：button',
  `icon` varchar(50) COMMENT 'menu icon',
  `order_num` int COMMENT 'sort',
  PRIMARY KEY (`menu_id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='menu management';

-- system user
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT 'user name',
  `password` varchar(100) COMMENT 'password',
  `salt` varchar(20) COMMENT 'salt',
  `email` varchar(100) COMMENT 'mail',
  `mobile` varchar(100) COMMENT 'phone',
  `status` tinyint COMMENT 'status  0：disabled   1：enable',
  `create_user_id` bigint(20) COMMENT 'creator id',
  `create_time` datetime COMMENT 'created time',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX (`username`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='sys user';

-- system user token
CREATE TABLE `sys_user_token` (
  `user_id` bigint(20) NOT NULL,
  `token` varchar(100) NOT NULL COMMENT 'token',
  `expire_time` datetime DEFAULT NULL COMMENT 'expired time',
  `update_time` datetime DEFAULT NULL COMMENT 'updated time',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='sys user Token';

-- system verification code
CREATE TABLE `sys_captcha` (
  `uuid` char(36) NOT NULL COMMENT 'uuid',
  `code` varchar(6) NOT NULL COMMENT 'CAPTCHA code',
  `expire_time` datetime DEFAULT NULL COMMENT 'expired time',
  PRIMARY KEY (`uuid`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='sys CAPTCHA code';

-- role
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) COMMENT 'role name',
  `remark` varchar(100) COMMENT 'remark',
  `create_user_id` bigint(20) COMMENT 'creator ID',
  `create_time` datetime COMMENT 'create time',
  PRIMARY KEY (`role_id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='role';

-- relationship between users and roles
CREATE TABLE `sys_user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint COMMENT 'user ID',
  `role_id` bigint COMMENT 'role ID',
  PRIMARY KEY (`id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='relationship between user and role';

-- elationship between users and menu
CREATE TABLE `sys_role_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint COMMENT 'role ID',
  `menu_id` bigint COMMENT 'menu ID',
  PRIMARY KEY (`id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='relationship between user and menu';

-- system config
CREATE TABLE `sys_config` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`param_key` varchar(50) COMMENT 'key',
	`param_value` varchar(2000) COMMENT 'value',
	`status` tinyint DEFAULT 1 COMMENT 'status   0：hide   1：visible',
	`remark` varchar(500) COMMENT 'remark',
	PRIMARY KEY (`id`),
	UNIQUE INDEX (`param_key`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='sys config';


-- system log
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COMMENT 'user name',
  `operation` varchar(50) COMMENT 'user operation',
  `method` varchar(200) COMMENT 'method',
  `params` varchar(5000) COMMENT 'params',
  `time` bigint NOT NULL COMMENT 'time',
  `ip` varchar(64) COMMENT 'IP',
  `create_date` datetime COMMENT 'create time',
  PRIMARY KEY (`id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='sys log';


-- file upload
CREATE TABLE `sys_oss` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) COMMENT 'URL',
  `create_date` datetime COMMENT 'create time',
  PRIMARY KEY (`id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='upload documentation';


-- schedule job
CREATE TABLE `schedule_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'task id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean name',
  `params` varchar(2000) DEFAULT NULL COMMENT 'params',
  `cron_expression` varchar(100) DEFAULT NULL COMMENT 'cron expression',
  `status` tinyint(4) DEFAULT NULL COMMENT 'status  0：running  1：paused',
  `remark` varchar(255) DEFAULT NULL COMMENT 'remark',
  `create_time` datetime DEFAULT NULL COMMENT 'create time',
  PRIMARY KEY (`job_id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='schedule job';

-- schedule job log
CREATE TABLE `schedule_job_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'name id',
  `job_id` bigint(20) NOT NULL COMMENT 'name id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean',
  `params` varchar(2000) DEFAULT NULL COMMENT 'param',
  `status` tinyint(4) NOT NULL COMMENT 'task    0：success    1：fail',
  `error` varchar(2000) DEFAULT NULL COMMENT 'fail info',
  `times` int(11) NOT NULL COMMENT 'time',
  `create_time` datetime DEFAULT NULL COMMENT 'create time',
  PRIMARY KEY (`log_id`),
  KEY `job_id` (`job_id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='create time';



-- user list
CREATE TABLE `tb_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT 'user name',
  `mobile` varchar(20) NOT NULL COMMENT 'phone',
  `password` varchar(64) COMMENT 'password',
  `create_time` datetime COMMENT 'create time',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX (`username`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8mb4 COMMENT='user';






-- Init data
INSERT INTO `sys_user` (`user_id`, `username`, `password`, `salt`, `email`, `mobile`, `status`, `create_user_id`, `create_time`) VALUES ('1', 'admin', '9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d', 'YzcmCZNvbXocrsz9dm8e', 'root@renren.io', '13612345678', '1', '1', '2016-11-11 11:11:11');

INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(1, 0, 'System Management', NULL, NULL, 0, 'system', 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(2, 1, 'Admin List', 'sys/user', NULL, 1, 'admin', 1);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(3, 1, 'Role Management', 'sys/role', NULL, 1, 'role', 2);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(4, 1, 'Menu Management', 'sys/menu', NULL, 1, 'menu', 3);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(7, 6, 'View', NULL, 'sys:schedule:list,sys:schedule:info', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(8, 6, 'Add', NULL, 'sys:schedule:save', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(9, 6, 'Update', NULL, 'sys:schedule:update', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(10, 6, 'Delete', NULL, 'sys:schedule:delete', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(11, 6, 'Pause', NULL, 'sys:schedule:pause', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(12, 6, 'Resume', NULL, 'sys:schedule:resume', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(13, 6, 'Run', NULL, 'sys:schedule:run', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(14, 6, 'Log', NULL, 'sys:schedule:log', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(15, 2, 'View', NULL, 'sys:user:list,sys:user:info', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(16, 2, 'Add', NULL, 'sys:user:save,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(17, 2, 'Update', NULL, 'sys:user:update,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(18, 2, 'Delete', NULL, 'sys:user:delete', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(19, 3, 'View', NULL, 'sys:role:list,sys:role:info', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(20, 3, 'Add', NULL, 'sys:role:save,sys:menu:list', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(21, 3, 'Update', NULL, 'sys:role:update,sys:menu:list', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(22, 3, 'Delete', NULL, 'sys:role:delete', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(23, 4, 'View', NULL, 'sys:menu:list,sys:menu:info', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(24, 4, 'Add', NULL, 'sys:menu:save,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(25, 4, 'Update', NULL, 'sys:menu:update,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu`(menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(26, 4, 'Delete', NULL, 'sys:menu:delete', 2, NULL, 0);

INSERT INTO `sys_config` (`param_key`, `param_value`, `status`, `remark`) VALUES ('CLOUD_STORAGE_CONFIG_KEY', '{\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\",\"aliyunDomain\":\"\",\"aliyunEndPoint\":\"\",\"aliyunPrefix\":\"\",\"qcloudBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuBucketName\":\"ios-app\",\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"type\":1}', '0', '云存储配置信息');
INSERT INTO `schedule_job` (`bean_name`, `params`, `cron_expression`, `status`, `remark`, `create_time`) VALUES ('testTask', 'renren', '0 0/30 * * * ?', '0', '参数测试', now());


-- account:13612345678  password：admin
INSERT INTO `tb_user` (`username`, `mobile`, `password`, `create_time`) VALUES ('mark', '13612345678', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '2017-03-23 22:37:41');









CREATE TABLE QRTZ_JOB_DETAILS(
SCHED_NAME VARCHAR(120) NOT NULL,
JOB_NAME VARCHAR(200) NOT NULL,
JOB_GROUP VARCHAR(200) NOT NULL,
DESCRIPTION VARCHAR(250) NULL,
JOB_CLASS_NAME VARCHAR(250) NOT NULL,
IS_DURABLE VARCHAR(1) NOT NULL,
IS_NONCONCURRENT VARCHAR(1) NOT NULL,
IS_UPDATE_DATA VARCHAR(1) NOT NULL,
REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
JOB_NAME VARCHAR(200) NOT NULL,
JOB_GROUP VARCHAR(200) NOT NULL,
DESCRIPTION VARCHAR(250) NULL,
NEXT_FIRE_TIME BIGINT(13) NULL,
PREV_FIRE_TIME BIGINT(13) NULL,
PRIORITY INTEGER NULL,
TRIGGER_STATE VARCHAR(16) NOT NULL,
TRIGGER_TYPE VARCHAR(8) NOT NULL,
START_TIME BIGINT(13) NOT NULL,
END_TIME BIGINT(13) NULL,
CALENDAR_NAME VARCHAR(200) NULL,
MISFIRE_INSTR SMALLINT(2) NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
REPEAT_COUNT BIGINT(7) NOT NULL,
REPEAT_INTERVAL BIGINT(12) NOT NULL,
TIMES_TRIGGERED BIGINT(10) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_CRON_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
CRON_EXPRESSION VARCHAR(120) NOT NULL,
TIME_ZONE_ID VARCHAR(80),
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 VARCHAR(1) NULL,
    BOOL_PROP_2 VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_BLOB_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
BLOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
INDEX (SCHED_NAME,TRIGGER_NAME, TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_CALENDARS (
SCHED_NAME VARCHAR(120) NOT NULL,
CALENDAR_NAME VARCHAR(200) NOT NULL,
CALENDAR BLOB NOT NULL,
PRIMARY KEY (SCHED_NAME,CALENDAR_NAME))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_FIRED_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
ENTRY_ID VARCHAR(95) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
INSTANCE_NAME VARCHAR(200) NOT NULL,
FIRED_TIME BIGINT(13) NOT NULL,
SCHED_TIME BIGINT(13) NOT NULL,
PRIORITY INTEGER NOT NULL,
STATE VARCHAR(16) NOT NULL,
JOB_NAME VARCHAR(200) NULL,
JOB_GROUP VARCHAR(200) NULL,
IS_NONCONCURRENT VARCHAR(1) NULL,
REQUESTS_RECOVERY VARCHAR(1) NULL,
PRIMARY KEY (SCHED_NAME,ENTRY_ID))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SCHEDULER_STATE (
SCHED_NAME VARCHAR(120) NOT NULL,
INSTANCE_NAME VARCHAR(200) NOT NULL,
LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
CHECKIN_INTERVAL BIGINT(13) NOT NULL,
PRIMARY KEY (SCHED_NAME,INSTANCE_NAME))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_LOCKS (
SCHED_NAME VARCHAR(120) NOT NULL,
LOCK_NAME VARCHAR(40) NOT NULL,
PRIMARY KEY (SCHED_NAME,LOCK_NAME))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS(SCHED_NAME,JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);


CREATE TABLE hibernate_sequence (
  next_val BIGINT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO hibernate_sequence (next_val) VALUES(7);
INSERT INTO hibernate_sequence (next_val) VALUES(7);

-- sys_user_token
INSERT INTO sys_user_token (user_id, token, expire_time, update_time) VALUES(1, '77bfab0ea2ded44aa7ba998af598d47e', '2022-12-02 02:38:28', '2022-12-01 14:38:28');
INSERT INTO sys_user_token (user_id, token, expire_time, update_time) VALUES(2, 'I''m the token haha', '2032-12-12 00:00:00', NULL);

-- sys_user_role
INSERT INTO sys_user_role (id, user_id, role_id) VALUES(1, 1, 1);
INSERT INTO sys_user_role (id, user_id, role_id) VALUES(2, 2, 1);
INSERT INTO sys_user_role (id, user_id, role_id) VALUES(3, 3, 3);
INSERT INTO sys_user_role (id, user_id, role_id) VALUES(4, 4, 2);

-- sys_user
INSERT INTO sys_user (user_id, username, password, salt, email, mobile, status, create_user_id, create_time) VALUES(2, 'don''t touch me', '000', 'YzcmCZNvbXocrsz9dm8e', 'root@renren.io', '13612345678', 1, 1, '2016-11-11 11:11:11');
INSERT INTO sys_user (user_id, username, password, salt, email, mobile, status, create_user_id, create_time) VALUES(3, 'TA', '83ae89b8b792379d19a26e039c57fc971d20cb8a040693e9436cb39381f170e3', 'YzcmCZNvbXocrsz9dm8e', 'root@renren.io', '13612345678', 1, 3, '2016-11-11 11:11:11');
INSERT INTO sys_user (user_id, username, password, salt, email, mobile, status, create_user_id, create_time) VALUES(4, 'canapitest+4@gmail.com', '981dc1d64accc6d5d777f91855cca73fa78683074e515dc4aad3a07c92bec7ce', '1QtRVMD1gB785jVeanoS', '000@gmail.com', '12345678901', 1, 2, '2022-12-02 17:19:04');


-- sys_role_menu
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(17, 2, 35);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(18, 2, 36);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(19, 2, 37);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(20, 2, 38);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(21, 2, -666666);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(56, 3, 31);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(57, 3, 32);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(58, 3, 33);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(59, 3, 34);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(60, 3, -666666);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(22, 1, 1);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(23, 1, 2);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(24, 1, 15);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(25, 1, 16);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(26, 1, 17);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(27, 1, 18);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(28, 1, 3);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(29, 1, 19);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(30, 1, 20);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(31, 1, 21);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(32, 1, 22);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(33, 1, 4);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(34, 1, 23);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(35, 1, 24);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(36, 1, 25);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(37, 1, 26);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(38, 1, 5);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(39, 1, 6);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(40, 1, 7);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(41, 1, 8);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(42, 1, 9);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(43, 1, 10);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(44, 1, 11);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(45, 1, 12);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(46, 1, 13);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(47, 1, 14);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(48, 1, 27);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(49, 1, 29);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(50, 1, 30);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(51, 1, 31);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(52, 1, 32);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(53, 1, 33);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(54, 1, 34);
INSERT INTO sys_role_menu (id, role_id, menu_id) VALUES(55, 1, -666666);





-- sys_menu
INSERT INTO sys_menu (menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(31, 0, 'Token management', NULL, NULL, 0, 'admin', NULL);
INSERT INTO sys_menu (menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(32, 31, 'All Students', 'token/students', '', 1, 'log', 0);
INSERT INTO sys_menu (menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(33, 31, 'Token Logs', 'token/logs', '', 1, 'log', 0);
INSERT INTO sys_menu (menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(34, 31, 'Log by student', 'token/student-log', '', 1, 'bianji', 0);
INSERT INTO sys_menu (menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(35, 0, 'Student Token', '', '', 0, 'admin', 0);
INSERT INTO sys_menu (menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(36, 35, 'Past Resubmission', 'token/pastResubmission', '', 1, 'role', 0);
INSERT INTO sys_menu (menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(37, 35, 'Tokens', 'token/student', '', 1, 'log', 0);
INSERT INTO sys_menu (menu_id, parent_id, name, url, perms, `type`, icon, order_num) VALUES(38, 35, 'History', 'token/oneStudentLog', '', 1, 'mudedi', 0);


-- sys_role
INSERT INTO sys_role (role_id, role_name, remark, create_user_id, create_time) VALUES(1, 'super', '', 1, '2022-12-12 12:12:12');
INSERT INTO sys_role (role_id, role_name, remark, create_user_id, create_time) VALUES(2, 'student', '', 2, '2022-12-12 12:12:12');
INSERT INTO sys_role (role_id, role_name, remark, create_user_id, create_time) VALUES(3, 'TA', '', 3, '2022-12-12 12:12:12');


-- tokens
CREATE TABLE tokens (
  user_id INT NOT NULL,
  `timestamp` DATETIME NULL,
  token_count INT NULL,
  user_email VARCHAR(255) NULL,
  user_name VARCHAR(255) NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

-- verification
CREATE TABLE verification (
  id INT NOT NULL,
  code VARCHAR(255) NULL,
  email VARCHAR(255) NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO verification (id, code, email) VALUES(9, '000', 'canapitest+4@gmail.com');


-- spend_log_entity
CREATE TABLE spend_log_entity (
	id INT NOT NULL,
	source VARCHAR(255) NULL,
	`timestamp` DATETIME NULL,
	token_count INT NULL,
	`type` VARCHAR(255) NULL,
	user_id VARCHAR(255) NULL,
	user_name VARCHAR(255) NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO spend_log_entity (id, source, `timestamp`, token_count, `type`, user_id, user_name) VALUES(1, 'Module 1', '2022-12-02 02:48:17', 2, 'earn', '32473866', 'Daniel Wells');
INSERT INTO spend_log_entity (id, source, `timestamp`, token_count, `type`, user_id, user_name) VALUES(2, 'Module 1', '2022-12-02 02:48:17', 2, 'earn', '32465829', 'Bonald Dren');
INSERT INTO spend_log_entity (id, source, `timestamp`, token_count, `type`, user_id, user_name) VALUES(3, 'Qualtrics Survey: SV_8oIf0qAz5g0TFiK', '2022-12-02 02:48:23', 1, 'earn', '32467842', 'John Kohler');
INSERT INTO spend_log_entity (id, source, `timestamp`, token_count, `type`, user_id, user_name) VALUES(4, 'Qualtrics Survey: SV_8oIf0qAz5g0TFiK', '2022-12-02 02:48:23', 1, 'earn', '32467819', 'Stephanie Wood');
INSERT INTO spend_log_entity (id, source, `timestamp`, token_count, `type`, user_id, user_name) VALUES(5, 'Qualtrics Survey: SV_8oIf0qAz5g0TFiK', '2022-12-02 02:48:23', 1, 'earn', '32465829', 'Bonald Dren');
INSERT INTO spend_log_entity (id, source, `timestamp`, token_count, `type`, user_id, user_name) VALUES(6, 'Qualtrics Survey: SV_8oIf0qAz5g0TFiK', '2022-12-02 02:48:23', 1, 'earn', '32467829', 'Isabel Thomas');


