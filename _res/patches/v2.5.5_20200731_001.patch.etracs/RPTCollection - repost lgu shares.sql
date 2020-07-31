drop table if exists zz_tmp_rptpayment
;

create table zz_tmp_rptpayment
select 
	rp.objid as rptpaymentid,
	cr.objid as receiptid, 
	cr.receiptdate,
	rp.refid as rptledgerid
from collectionvoucher cv
inner join remittance rem on cv.objid = rem.collectionvoucherid
inner join cashreceipt cr on rem.objid = cr.remittanceid
inner join rptpayment rp on cr.objid = rp.receiptid
where cr.receiptdate >= 'FROMDATE' and cr.receiptdate < 'TODATE'
;


create index ix_rptpaymentid on zz_tmp_rptpayment(rptpaymentid)
;
create index ix_receiptid on zz_tmp_rptpayment(receiptid)
;


delete from rptpayment_share 
where parentid in (select rptpaymentid from zz_tmp_rptpayment)
;

delete from cashreceipt_share 
where receiptid in (
	select distinct receiptid from zz_tmp_rptpayment
)
;

insert into cashreceipt_rpt_share_forposting (
	objid,
	receiptid,
	rptledgerid,
	txndate,
	error,
	msg
)
select
	rptpaymentid as objid,
	receiptid,
	rptledgerid,
	receiptdate as txndate,
	0 as error,
	null as msg
from zz_tmp_rptpayment	
;

drop table zz_tmp_rptpayment	
;

