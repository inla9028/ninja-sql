SELECT d.trx_code, d.trx_source, d.int_order_id, c.trx_desc, d.sys_creation_date
     , d.sys_update_date, d.operator_id, u.user_full_name, d.trx_datetime
     , d.trx_status, d.request_exec_date, d.conf_exec_date, d.text_comment
     , d.customer_name, d.customer_id, d.main_number
  FROM NP_TRX_DETAIL d, NP_TRX_CODES c, users u
 WHERE d.int_order_id = 12404717
   AND d.trx_code = c.trx_code
   AND d.trx_source = c.trx_source
   AND d.operator_id = u.user_id(+)
ORDER BY d.sys_creation_date
;

SELECT a.*
  FROM NP_TRX_DETAIL a
;

/*
NTCAPPO NP_FORMATTED_DATA  
NTCAPPO NP_INT_TRANSACTIONS
NTCAPPO NP_NUMBER_INFO     
NTCAPPO NP_ORDER_DATA      
NTCAPPO NP_TRX_DETAIL      
NTCAPPO NP_TRX_ERRORS      
NTCAPPO NP_TRX_SERIES      
NTCREFWORK  NP_AUTO_RULES                 
NTCREFWORK  NP_INT_PORTING_INF            
NTCREFWORK  NP_INT_RETURN_INF             
NTCREFWORK  NP_OPERATOR_CODES             
NTCREFWORK  NP_OPERATOR_CODES_15_00       
NTCREFWORK  NP_ORDER_STATUS               
NTCREFWORK  NP_ORDER_VALID_STEPS          
NTCREFWORK  NP_POLICY                     
NTCREFWORK  NP_PORTING_CASE               
NTCREFWORK  NP_PRODUCT                    
NTCREFWORK  NP_REJECTION_ERROR_CODES      
NTCREFWORK  NP_REJECTION_ERROR_CODES_15_00
NTCREFWORK  NP_REJ_FU_MEMO_RELATION       
NTCREFWORK  NP_RETURN_NGP_NL_COMB         
NTCREFWORK  NP_TRANSACTION_STATUS         
NTCREFWORK  NP_TRX_CODES                  
NTCREFWORK  NP_TRX_COL_CONTROL            
*/
