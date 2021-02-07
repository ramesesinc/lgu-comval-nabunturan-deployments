
alter table eor add lockid varchar(50) null 
; 

create index ix_lockid on eor (lockid) 
;


alter table eor_remittance add lockid varchar(50) null 
; 


alter table eor_share add receiptitemid varchar(50) null 
; 
