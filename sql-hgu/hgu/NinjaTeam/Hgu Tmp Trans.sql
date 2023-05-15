SELECT a.subscriber_no, a.soc, a.action, a.request_time, a.priority,
       a.request_id, a.memo_text, a.dealer_code, a.sales_agent
  FROM hgu_tmp_trans a
;

UPDATE hgu_tmp_trans a
   SET a.subscriber_no = 'GSM047'||a.subscriber_no
 WHERE LENGTH(a.subscriber_no) = 8
;

UPDATE hgu_tmp_trans a
   SET a.subscriber_no = 'GSM'||a.subscriber_no
 WHERE LENGTH(a.subscriber_no) = 11
;

DELETE
  FROM hgu_tmp_trans
;


