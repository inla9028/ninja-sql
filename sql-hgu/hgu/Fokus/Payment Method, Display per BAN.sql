SELECT a.ban, a.sys_creation_date, a.payment_method, a.payment_sub_method, a.bank_acct_no, a.bank_branch_code
  FROM ban_pym_mtd a
 WHERE a.ban = 820232908
;

select a.*
from all_tab_columns a
where a.column_name = 'PAYMENT_METHOD'
order by a.owner
;
/*
TMDAPPO	BILL
TMDAPPO	RMS_CURRENCY_COUNT
TMDAPPO	DIRECT_DEBIT_REQUEST
TMDAPPO	BAN_PYM_MTD
TMDAPPO	BILL_HISTORY
TMDAPPO	BAN_PYM_MTD_SAVE
TMDAPPO	PYM_SUMMARY
TMDAPPO	CAS_WORK_DETAILS
TMDAPPO	DIRECT_DEBIT_REQUEST_SAVE
*/