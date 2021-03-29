[getFunds]
select 
	fund_objid as objid, 
	fund_code as code, 
	fund_title as title  
from eor_remittance_fund 
where remittanceid = $P{remittanceid} 
order by fund_code, fund_title  


[getJevEntries]
select 
	acctid, acctcode, acctname, 
	0.0 as debit, sum(amount) as credit 
from vw_remittance_eor_item 
where remittanceid = $P{remittanceid} 
	and fundid = $P{fundid} 
	and txntype <> 'rptcol' 
group by acctid, acctcode, acctname 
order by acctcode, acctname 


[getReceipts]
select distinct receiptid 
from vw_remittance_eor_item 
where remittanceid = $P{remittanceid} 
	and fundid like $P{fundid} 


[getNonRPTIncomes]
select 
	acctid, acctcode, acctname, 
	0.0 as debit, sum(amount) as credit 
from vw_remittance_eor_item 
where remittanceid = $P{remittanceid} 
	and fundid = $P{fundid} 
	and txntype <> 'rptcol' 
group by acctid, acctcode, acctname 
order by acctcode, acctname 


[getRPTIncomes]
select 
  acctid, acctcode, acctname, 
  0.0 as debit, sum(amount) as credit 
from vw_remittance_eor_item 
where remittanceid = $P{remittanceid} 
  and fundid = $P{fundid} 
  and txntype = 'rptcol' 
group by acctid, acctcode, acctname 
order by acctcode, acctname 
