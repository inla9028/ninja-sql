select n1.main_number,n1. int_order_id, n2.TRX_DATETIME as best_sent_time, n1.TRX_DATETIME as conf_sent_time, 
LTRIM(TO_CHAR(TRUNC(n1.TRX_DATETIME - n2.TRX_DATETIME), '00')) || TO_CHAR(TRUNC(n1.TRX_DATETIME) + (n1.TRX_DATETIME - n2.TRX_DATETIME), ':HH24:MI:SS') AS "DAYS_HOURS_MIN_SEC",
 n1.CURR_NET_OPER as SP_code 
from  np_trx_detail n1, np_trx_detail n2
where n1.trx_code = 111
and n1.trx_source='EXT' and n1.RECIP_NET_OPER='815' 
and rtrim(n1.CURR_NET_OPER) in (select rtrim(NP_OPERATOR_CD) from  np_operator_codes
where rtrim(NP_OPERATOR_CD)=rtrim(n1.CURR_NET_OPER) and SP_ind='Y' and rtrim(NP_OPERATOR_CD)!='815')
and n1.TRX_DATETIME > sysdate -183
and n2.int_order_id=n1.int_order_id
and n2.trx_code='105' and n2.trx_source='INT'
and n1.INT_TRX_SEQ>n2.int_trx_seq
and n1.INITI_ORDER_SEQ=n2.INITI_ORDER_SEQ
and not exists (select 1 from np_trx_detail n3 where n3.int_order_id=n1.int_order_id and trx_code='108') 
and n1.TRX_DATETIME > n2.TRX_DATETIME
order by DAYS_HOURS_MIN_SEC desc


select * from  np_trx_detail where int_order_id=16817876