alter table online_business_application add (
	contact_name varchar(255) not null, 
	contact_address varchar(255) not null, 
	contact_email varchar(255) not null, 
	contact_mobileno varchar(15) null 
)
;
