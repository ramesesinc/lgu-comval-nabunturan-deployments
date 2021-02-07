
alter table cashreceipt_share add receiptitemid varchar(50) null 
go

create index ix_receiptitemid on cashreceipt_share (receiptitemid) 
go
