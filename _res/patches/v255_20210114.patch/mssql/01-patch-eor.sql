
alter table eor add lockid varchar(50) null 
go 

create index ix_lockid on eor (lockid) 
go 


alter table eor_remittance add lockid varchar(50) null 
go 


alter table eor_share add receiptitemid varchar(50) null 
go
