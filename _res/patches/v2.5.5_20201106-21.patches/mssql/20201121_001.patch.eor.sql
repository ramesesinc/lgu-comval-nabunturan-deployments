select objid 
into ztmp_delete_paymentorder
from eor_paymentorder
go 

insert into eor_paymentorder_cancelled (
	objid, txndate, txntype, txntypename, payer_objid, payer_name, 
	paidby, paidbyaddress, particulars, amount, expirydate, refid, 
	refno, info, origin, controlno, locationid, items, state, 
	email, mobileno
)
select 
	po.objid, po.txndate, po.txntype, po.txntypename, po.payer_objid, po.payer_name, 
	po.paidby, po.paidbyaddress, po.particulars, po.amount, po.expirydate, po.refid, 
	po.refno, po.info, po.origin, po.controlno, po.locationid, po.items, po.state, 
	po.email, po.mobileno 
from ztmp_delete_paymentorder z 
	inner join eor_paymentorder po on po.objid = z.objid 
	left join eor_paymentorder_cancelled c on c.objid = po.objid 
	left join eor on eor.paymentrefid = po.objid 
where c.objid is null and eor.objid is null 
go 

drop table ztmp_delete_paymentorder
go 

delete from eor_paymentorder where objid in (
	select objid from eor_paymentorder_cancelled 
)
go 
