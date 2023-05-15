-- Display all columns
SELECT a.ban, a.acc_type, a.acc_sub_type, a.subscriber_no, a.sub_status,
       a.priceplan, a.soc_old, a.soc_new, a.dealer_code, a.sales_agent,
       a.job1_status, a.job2_status, a.job3_status, a.process_status,
       a.process_time, a.memo_text
  FROM hgu_tmp_tele2 a
 WHERE a.sub_status    = 'R'
   AND a.acc_type     IN ('I')
   AND a.acc_sub_type IN ('T2', 'TX')
;

-- Display an overview
SELECT a.acc_type, a.acc_sub_type, a.sub_status, COUNT(1) AS "COUNT"
  FROM hgu_tmp_tele2 a
GROUP BY a.acc_type, a.acc_sub_type, a.sub_status
ORDER BY a.acc_type, a.acc_sub_type, a.sub_status
;

-- Display an overview
SELECT a.acc_type, a.acc_sub_type, a.sub_status, a.priceplan, a.soc_old, a.job1_status, COUNT(1) AS "COUNT"
  FROM hgu_tmp_tele2 a
 WHERE a.soc_old IS NOT NULL
GROUP BY a.acc_type, a.acc_sub_type, a.sub_status, a.priceplan, a.soc_old, a.job1_status
ORDER BY a.acc_type, a.acc_sub_type, a.sub_status, a.priceplan, a.soc_old, a.job1_status
;

-- Display an overview
SELECT a.priceplan, a.sub_status, a.soc_new, a.job2_status, COUNT(1) AS "COUNT"
  FROM hgu_tmp_tele2 a
 WHERE a.soc_new IS NOT NULL
GROUP BY a.priceplan, a.sub_status, a.soc_new, a.job2_status
ORDER BY a.priceplan, a.sub_status, a.soc_new, a.job2_status
;

-- List subscribers who would need their Traffic Shaping socs replaced and those who need it added.
SELECT t2.ban, t2.acc_type, t2.acc_sub_type, t2.subscriber_no, t2.sub_status, t2.priceplan, 
       t2.soc_old, 'REPLACE' AS "ACTION", t2.soc_new, t2.job2_status,
       'Replacing soc ' || t2.soc_old || ' with ' || t2.soc_new || ' as priceplan is ' || t2.priceplan AS "DESCRIPTION"
  FROM hgu_tmp_tele2 t2
 WHERE t2.soc_old      IS NOT NULL
   AND t2.soc_new      IS NOT NULL
   AND t2.soc_old      != t2.soc_new
   AND t2.acc_type     IN ('I')
   AND t2.acc_sub_type IN ('T2', 'TX')
UNION
SELECT t2.ban, t2.acc_type, t2.acc_sub_type, t2.subscriber_no, t2.sub_status, t2.priceplan, 
       t2.soc_old, 'ADD' AS "ACTION", t2.soc_new, t2.job2_status,
       'Adding soc ' || t2.soc_new || ' as priceplan is ' || t2.priceplan AS "DESCRIPTION"
  FROM hgu_tmp_tele2 t2
 WHERE t2.soc_old      IS     NULL
   AND t2.soc_new      IS NOT NULL
   AND t2.acc_type     IN ('I')
   AND t2.acc_sub_type IN ('T2', 'TX')
ORDER BY 2, 3, 5, 6
;

-- List overview of subscribers that do not need to change Traffic Shaping soc vs thos who need.
SELECT a.priceplan, a.sub_status, a.soc_old, a.soc_new, COUNT(1) AS "COUNT"
  FROM hgu_tmp_tele2 a
 WHERE a.soc_new IS NOT NULL
GROUP BY a.priceplan, a.sub_status, a.soc_old, a.soc_new
ORDER BY a.priceplan, a.sub_status, a.soc_old, a.soc_new
;

-- List subscribers that didn't receive a traffic shaping soc.
SELECT a.acc_type, a.acc_sub_type, a.sub_status, a.priceplan, a.soc_old, COUNT(1) AS "COUNT"
  FROM hgu_tmp_tele2 a
 WHERE a.priceplan  IS NOT NULL
   AND a.sub_status IN ('A', 'R')
   AND a.soc_new    IS NULL
GROUP BY a.acc_type, a.acc_sub_type, a.sub_status, a.priceplan, a.soc_old
ORDER BY a.acc_type, a.acc_sub_type, a.sub_status, a.priceplan, a.soc_old
;

-- List the rows for which the Traffic Shaping soc was not available for addition
SELECT t2.priceplan, t2.soc_new, COUNT(1) AS "COUNT"
  FROM hgu_tmp_tele2 t2, ninjadata.master_transactions mt
 WHERE t2.subscriber_no  = mt.subscriber_no
   AND mt.request_id     = 'TELE2 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND mt.action_code    = 'ADD'
   AND mt.process_status = 'PRSD_ERROR'
   AND mt.status_desc LIKE '%SOC is not available%'
GROUP BY t2.priceplan, t2.soc_new
ORDER BY t2.priceplan, t2.soc_new
;
   
