alter table bldgrpu add dtconstructed date
;
alter table faas_previous add prevtaxability varchar(25)
;
alter table machrpu add smvid varchar(50)
;
alter table machpru add params text
;


CREATE TABLE `subdivision_assist` (
  `objid` varchar(50) NOT NULL,
  `parent_objid` varchar(50) NOT NULL,
  `taskstate` varchar(50) NOT NULL,
  `assignee_objid` varchar(50) NOT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `ux_parent_assignee` (`parent_objid`,`taskstate`,`assignee_objid`) USING BTREE,
  KEY `ix_parent_objid` (`parent_objid`) USING BTREE,
  KEY `ix_assignee_objid` (`assignee_objid`) USING BTREE,
  CONSTRAINT `subdivision_assist_ibfk_1` FOREIGN KEY (`parent_objid`) REFERENCES `subdivision` (`objid`),
  CONSTRAINT `subdivision_assist_ibfk_2` FOREIGN KEY (`assignee_objid`) REFERENCES `sys_user` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `subdivision_assist_item` (
  `objid` varchar(50) NOT NULL,
  `subdivision_objid` varchar(50) NOT NULL,
  `parent_objid` varchar(50) NOT NULL,
  `pintype` varchar(10) NOT NULL,
  `section` varchar(5) NOT NULL,
  `startparcel` int(255) NOT NULL,
  `endparcel` int(255) NOT NULL,
  `parcelcount` int(11) DEFAULT NULL,
  `parcelcreated` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_subdivision_objid` (`subdivision_objid`) USING BTREE,
  KEY `ix_parent_objid` (`parent_objid`) USING BTREE,
  CONSTRAINT `subdivision_assist_item_ibfk_1` FOREIGN KEY (`subdivision_objid`) REFERENCES `subdivision` (`objid`),
  CONSTRAINT `subdivision_assist_item_ibfk_2` FOREIGN KEY (`parent_objid`) REFERENCES `subdivision_assist` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;


drop table if exists batchgr_item
;
drop table if exists batchgr_task
;
drop table if exists batchgr
;

CREATE TABLE `batchgr` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(25) NOT NULL,
  `ry` int(255) NOT NULL,
  `lgu_objid` varchar(50) NOT NULL,
  `barangay_objid` varchar(50) NOT NULL,
  `rputype` varchar(15) DEFAULT NULL,
  `classification_objid` varchar(50) DEFAULT NULL,
  `section` varchar(10) DEFAULT NULL,
  `memoranda` varchar(100) DEFAULT NULL,
  `txntype_objid` varchar(50) DEFAULT NULL,
  `txnno` varchar(25) DEFAULT NULL,
  `txndate` datetime DEFAULT NULL,
  `effectivityyear` int(11) DEFAULT NULL,
  `effectivityqtr` int(11) DEFAULT NULL,
  `originlgu_objid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_barangay_objid` (`barangay_objid`) USING BTREE,
  KEY `ix_state` (`state`) USING BTREE,
  KEY `fk_lgu_objid` (`lgu_objid`) USING BTREE,
  KEY `ix_ry` (`ry`) USING BTREE,
  KEY `ix_txnno` (`txnno`) USING BTREE,
  KEY `ix_classificationid` (`classification_objid`) USING BTREE,
  KEY `ix_section` (`section`) USING BTREE,
  CONSTRAINT `batchgr_ibfk_1` FOREIGN KEY (`barangay_objid`) REFERENCES `sys_org` (`objid`),
  CONSTRAINT `batchgr_ibfk_2` FOREIGN KEY (`classification_objid`) REFERENCES `propertyclassification` (`objid`),
  CONSTRAINT `batchgr_ibfk_3` FOREIGN KEY (`lgu_objid`) REFERENCES `sys_org` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `batchgr_item` (
  `objid` varchar(50) NOT NULL,
  `parent_objid` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `rputype` varchar(15) NOT NULL,
  `tdno` varchar(50) NOT NULL,
  `fullpin` varchar(50) NOT NULL,
  `pin` varchar(50) NOT NULL,
  `suffix` int(255) NOT NULL,
  `newfaasid` varchar(50) DEFAULT NULL,
  `error` text,
  `subsuffix` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_batchgr_item_batchgr` (`parent_objid`) USING BTREE,
  KEY `fk_batchgr_item_newfaasid` (`newfaasid`) USING BTREE,
  KEY `fk_batchgr_item_tdno` (`tdno`) USING BTREE,
  KEY `fk_batchgr_item_pin` (`pin`) USING BTREE,
  CONSTRAINT `batchgr_item_ibfk_1` FOREIGN KEY (`parent_objid`) REFERENCES `batchgr` (`objid`),
  CONSTRAINT `batchgr_item_ibfk_2` FOREIGN KEY (`objid`) REFERENCES `faas` (`objid`),
  CONSTRAINT `batchgr_item_ibfk_3` FOREIGN KEY (`newfaasid`) REFERENCES `faas` (`objid`),
  CONSTRAINT `batchgr_item_ibfk_4` FOREIGN KEY (`objid`) REFERENCES `faas` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `batchgr_task` (
  `objid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `parentprocessid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `assignee_objid` varchar(50) DEFAULT NULL,
  `assignee_name` varchar(100) DEFAULT NULL,
  `assignee_title` varchar(80) DEFAULT NULL,
  `actor_objid` varchar(50) DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `actor_title` varchar(80) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `signature` longtext,
  `returnedby` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_assignee_objid` (`assignee_objid`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  CONSTRAINT `batchgr_task_ibfk_1` FOREIGN KEY (`refid`) REFERENCES `batchgr` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;




drop view if exists vw_batchgr
;

CREATE  VIEW `vw_batchgr` AS select `bg`.`objid` AS `objid`,`bg`.`state` AS `state`,`bg`.`ry` AS `ry`,`bg`.`lgu_objid` AS `lgu_objid`,`bg`.`barangay_objid` AS `barangay_objid`,`bg`.`rputype` AS `rputype`,`bg`.`classification_objid` AS `classification_objid`,`bg`.`section` AS `section`,`bg`.`memoranda` AS `memoranda`,`bg`.`txntype_objid` AS `txntype_objid`,`bg`.`txnno` AS `txnno`,`bg`.`txndate` AS `txndate`,`bg`.`effectivityyear` AS `effectivityyear`,`bg`.`effectivityqtr` AS `effectivityqtr`,`bg`.`originlgu_objid` AS `originlgu_objid`,`l`.`name` AS `lgu_name`,`b`.`name` AS `barangay_name`,`pc`.`name` AS `classification_name`,`t`.`objid` AS `taskid`,`t`.`state` AS `taskstate`,`t`.`assignee_objid` AS `assignee_objid` from ((((`batchgr` `bg` join `sys_org` `l` on((`bg`.`lgu_objid` = `l`.`objid`))) left join `sys_org` `b` on((`bg`.`barangay_objid` = `b`.`objid`))) left join `propertyclassification` `pc` on((`bg`.`classification_objid` = `pc`.`objid`))) left join `batchgr_task` `t` on(((`bg`.`objid` = `t`.`refid`) and isnull(`t`.`enddate`))))
;


CREATE TABLE `entity_mapping` (
  `objid` varchar(50) NOT NULL,
  `parent_objid` varchar(50) NOT NULL,
  `org_objid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE VIEW `vw_entity_mapping` AS select `r`.`objid` AS `objid`,`r`.`parent_objid` AS `parent_objid`,`r`.`org_objid` AS `org_objid`,`e`.`entityno` AS `entityno`,`e`.`name` AS `name`,`e`.`address_text` AS `address_text`,`a`.`province` AS `address_province`,`a`.`municipality` AS `address_municipality` from ((((`entity_mapping` `r` join `entity` `e` on((`r`.`objid` = `e`.`objid`))) left join `entity_address` `a` on((`e`.`address_objid` = `a`.`objid`))) left join `sys_org` `b` on((`a`.`barangay_objid` = `b`.`objid`))) left join `sys_org` `m` on((`b`.`parent_objid` = `m`.`objid`)))
;







CREATE TABLE `machine_smv` (
  `objid` varchar(50) NOT NULL,
  `parent_objid` varchar(50) NOT NULL,
  `machine_objid` varchar(50) NOT NULL,
  `expr` varchar(255) NOT NULL,
  `previd` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_parent_objid` (`parent_objid`) USING BTREE,
  KEY `ix_machine_objid` (`machine_objid`) USING BTREE,
  KEY `ix_previd` (`previd`) USING BTREE,
  CONSTRAINT `machine_smv_ibfk_1` FOREIGN KEY (`machine_objid`) REFERENCES `machine` (`objid`),
  CONSTRAINT `machine_smv_ibfk_2` FOREIGN KEY (`previd`) REFERENCES `machine_smv` (`objid`),
  CONSTRAINT `machine_smv_ibfk_3` FOREIGN KEY (`parent_objid`) REFERENCES `machrysetting` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE  VIEW `vw_machine_smv` AS select `ms`.`objid` AS `objid`,`ms`.`parent_objid` AS `parent_objid`,`ms`.`machine_objid` AS `machine_objid`,`ms`.`expr` AS `expr`,`ms`.`previd` AS `previd`,`m`.`code` AS `code`,`m`.`name` AS `name` from (`machine_smv` `ms` join `machine` `m` on((`ms`.`machine_objid` = `m`.`objid`)))
;
