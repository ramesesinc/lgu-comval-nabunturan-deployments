
drop table if exists vw_remittance_eor_item 
;
drop view if exists vw_remittance_eor_item 
;
create view vw_remittance_eor_item as 
select 
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  cri.parentid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  cri.item_fund_objid AS fundid, 
  cri.item_objid AS acctid, 
  cri.item_code AS acctcode, 
  cri.item_title AS acctname, 
  cri.remarks AS remarks, 
  cri.amount as amount,
  c.txntype as txntype  
from eor_remittance r 
  inner join eor c on c.remittanceid = r.objid 
  inner join eor_item cri on cri.parentid = c.objid 
;


drop table if exists vw_remittance_eor_share 
;
drop view if exists vw_remittance_eor_share
;
create view vw_remittance_eor_share as 
select 
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  cri.parentid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  cri.refitem_objid as refacctid, 
  cri.refitem_code as refacctcode, 
  cri.refitem_title as refaccttitle, 
  cri.payableitem_objid AS acctid, 
  cri.payableitem_code AS acctcode, 
  cri.payableitem_title AS acctname, 
  cri.share as amount, 
  c.txntype as txntype 
from eor_remittance r 
  inner join eor c on c.remittanceid = r.objid 
  inner join eor_share cri on cri.parentid = c.objid 
;
