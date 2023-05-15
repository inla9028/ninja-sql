-- Job #1 :: Replace the wrong NSHAPE*
INSERT INTO ninjadata.master_transactions
(
    trans_number, subscriber_no, soc, action_code, new_soc,
    enter_time, request_time, process_time, process_status, status_desc, 
    dealer_code, sales_agent, priority, request_id,
    memo_text,
    stream
)
SELECT NULL, t2.subscriber_no, t2.soc_old, 'REPLACE', t2.soc_new,
       SYSDATE, SYSDATE, NULL, 'WAITING', NULL,
       t2.dealer_code, t2.sales_agent, 1, 'TELE2 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
       'Replacing soc ' || t2.soc_old || ' with ' || t2.soc_new || ' as priceplan is ' || t2.priceplan,
       NULL
  FROM hgu_tmp_tele2 t2
 WHERE t2.soc_old      IS NOT NULL
   AND t2.soc_new      IS NOT NULL
   AND t2.soc_old      != t2.soc_new
   AND t2.acc_type     IN ('I')
   AND t2.acc_sub_type IN ('T2', 'TX')
;

-- Job #2 :: Add the NSHAPE* socs for all subscribers who didn't have one previously.
INSERT INTO ninjadata.master_transactions
(
    trans_number, subscriber_no, soc, action_code, new_soc,
    enter_time, request_time, process_time, process_status, status_desc, 
    dealer_code, sales_agent, priority, request_id,
    memo_text,
    stream
)
SELECT NULL, t2.subscriber_no, t2.soc_new, 'ADD', NULL,
       SYSDATE, SYSDATE, NULL, 'WAITING', NULL,
       t2.dealer_code, t2.sales_agent, 1, 'TELE2 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
       'Adding soc ' || t2.soc_new || ' as priceplan is ' || t2.priceplan,
       NULL
  FROM hgu_tmp_tele2 t2
 WHERE t2.soc_old      IS     NULL
   AND t2.soc_new      IS NOT NULL
   AND t2.acc_type     IN ('I')
   AND t2.acc_sub_type IN ('T2', 'TX')
;

UPDATE hgu_tmp_tele2 t2
   SET t2.job2_status = 'IN_PROGRESS'
 WHERE ((t2.soc_old IS NOT NULL AND t2.soc_new IS NOT NULL AND t2.soc_old != t2.soc_new)
     OR (t2.soc_old IS NULL AND t2.soc_new IS NOT NULL))
   AND t2.acc_type     IN ('I')
   AND t2.acc_sub_type IN ('T2', 'TX')
;

-- COMMIT WORK;
   
-- Wait until the job has finished...
SELECT   a.request_id, a.action_code, a.soc, a.process_status, COUNT(*) AS "COUNT",
         TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 8.654) / 3600), '9999999'))) || ' hours ' ||
         TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 8.654) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
    FROM ninjadata.master_transactions a
   WHERE a.request_id = 'TELE2 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY a.request_id, a.action_code, a.soc, a.process_status
ORDER BY a.request_id, a.action_code, a.soc, a.process_status
;

UPDATE hgu_tmp_tele2 t2
   SET t2.job2_status = (SELECT a.process_status 
                           FROM ninjadata.master_transactions a 
                          WHERE a.subscriber_no = t2.subscriber_no
                            AND a.request_id    = 'TELE2 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
                            AND a.action_code  IN ('ADD', 'REPLACE'))
 WHERE t2.soc_new IS NOT NULL
   AND t2.job2_status = 'IN_PROGRESS'
--   AND t2.job2_status IS NOT NULL
;

-- Display overview in TMP table..
SELECT a.priceplan, a.sub_status, a.soc_new, a.job2_status, COUNT(1) AS "COUNT"
  FROM hgu_tmp_tele2 a
 WHERE a.job2_status IS NOT NULL
GROUP BY a.priceplan, a.sub_status, a.soc_new, a.job2_status
ORDER BY a.priceplan, a.sub_status, a.soc_new, a.job2_status
;

-- Display the failed records, with cause...
SELECT t2.ban, t2.acc_type, t2.acc_sub_type, t2.subscriber_no, t2.sub_status,
       t2.priceplan, t2.soc_old, mt.action_code AS "ACTION", t2.soc_new,
       mt.process_status, SUBSTR(RTRIM(SUBSTR(mt.status_desc, 0, INSTR(mt.status_desc || ' [ID', ' [ID'))), INSTR(mt.status_desc, ' ') + 1) AS "STATUS_DESC"
  FROM hgu_tmp_tele2 t2, ninjadata.master_transactions mt
 WHERE t2.job2_status   = 'PRSD_ERROR'
   AND t2.subscriber_no = mt.subscriber_no
   AND mt.request_id    = 'TELE2 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
ORDER BY 2, 3, 5, 6, 8
;
