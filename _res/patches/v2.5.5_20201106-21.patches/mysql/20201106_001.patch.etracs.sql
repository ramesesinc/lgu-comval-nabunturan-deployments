create table sys_email_queue (
	`objid` varchar(50) not null, 
	`refid` varchar(50) not null, 
	`state` int not null, 
	`reportid` varchar(50) null, 
	`dtsent` datetime not null, 
	`to` varchar(255) not null, 
	`subject` varchar(255) not null, 
	`message` text not null, 
	`errmsg` longtext null, 
	constraint pk_sys_email_queue primary key (objid) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 
create index ix_refid on sys_email_queue (refid)
; 
create index ix_state on sys_email_queue (state)
; 
create index ix_reportid on sys_email_queue (reportid)
; 
create index ix_dtsent on sys_email_queue (dtsent)
; 


alter table sys_email_queue add connection varchar(50) null 
;



CREATE TABLE `online_business_application` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(20) NOT NULL,
  `dtcreated` datetime NOT NULL,
  `createdby_objid` varchar(50) NOT NULL,
  `createdby_name` varchar(100) NOT NULL,
  `controlno` varchar(25) NOT NULL,
  `prevapplicationid` varchar(50) NOT NULL,
  `business_objid` varchar(50) NOT NULL,
  `appyear` int(11) NOT NULL,
  `apptype` varchar(20) NOT NULL,
  `appdate` date NOT NULL,
  `lobs` text NOT NULL,
  `infos` longtext NOT NULL,
  `requirements` longtext NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `dtapproved` datetime DEFAULT NULL,
  `approvedby_objid` varchar(50) DEFAULT NULL,
  `approvedby_name` varchar(150) DEFAULT NULL,
  `approvedappno` varchar(25) DEFAULT NULL,
  constraint pk_online_business_application PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
create index `ix_state` on online_business_application (`state`)
;
create index `ix_dtcreated` on online_business_application (`dtcreated`)
;
create index `ix_controlno` on online_business_application (`controlno`)
;
create index `ix_prevapplicationid` on online_business_application (`prevapplicationid`)
;
create index `ix_business_objid` on online_business_application (`business_objid`)
;
create index `ix_appyear` on online_business_application (`appyear`)
;
create index `ix_appdate` on online_business_application (`appdate`)
;
create index `ix_dtapproved` on online_business_application (`dtapproved`)
;
create index `ix_approvedby_objid` on online_business_application (`approvedby_objid`)
;
create index `ix_approvedby_name` on online_business_application (`approvedby_name`)
;
alter table online_business_application add CONSTRAINT `fk_online_business_application_business_objid` 
	FOREIGN KEY (`business_objid`) REFERENCES `business` (`objid`)
;
alter table online_business_application add CONSTRAINT `fk_online_business_application_prevapplicationid` 
	FOREIGN KEY (`prevapplicationid`) REFERENCES `business_application` (`objid`)
;
