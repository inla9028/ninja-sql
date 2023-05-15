--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy records from 'master_chg_pp_trans' to 'tb_processing_trans' in order
--== for the price plan's and commitments to be handled properly.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjadata.master_chg_pp_trans (
       subscriber_no, new_priceplan, new_campaign_code,
       new_subscription_type, handle_commitment, effective_date,
       dealer, sales_agent, reason_code, memo_text,
       waive_fees, enter_time, request_time, process_time,
       process_status, status_desc, priority, requestor_id,
       skip_ninja_validation) 
SELECT a.subscriber_no, a.priceplan, a.campaign, a.priceplan || 'REG1',
       a.handle_commitment, NULL, a.dealer_code, a.sales_agent, a.reason_code,
       a.memo_text, a.waive_fees, SYSDATE, SYSDATE, NULL, 'WAITING', NULL,
       3, a.requestor_id, 'N'
  FROM ninjadata.tb_processing_trans a
 WHERE a.requestor_id   = 'AFL 27.04.2010'
  and enter_time > sysdate -2;
 
 
 SELECT a.subscriber_no, a.priceplan, a.campaign, a.priceplan || 'REG1',
       a.handle_commitment, NULL, a.dealer_code, a.sales_agent, a.reason_code,
       a.memo_text, a.waive_fees, SYSDATE, SYSDATE, NULL, 'WAITING', NULL,
       3, a.requestor_id, 'N'
  FROM ninjadata.tb_processing_trans a
 WHERE a.requestor_id   = 'AFL 27.04.2010'
 and enter_time > sysdate -2;
