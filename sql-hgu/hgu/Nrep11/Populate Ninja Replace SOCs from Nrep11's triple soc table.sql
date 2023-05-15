/*
-- 1
LOPTF1	  INSURLS1	INSURLS1U	------>	INSURLS4	INSURLS4U
LOPTF1	  INSURLS2	INSURLS2U	------>	INSURLS4	INSURLS4U
LOPTF1	  INSURLS2	INSURLS2V	------>	INSURLS4	INSURLS4V

-- 2
LOBTF1	  INSURLS3	INSURLS3V	------>	INSURLS5	INSURLS5V

-- 3
LOPTF1	  INSURLS1	          ------>	INSURLS4
LOPTF1	  INSURLS2	          ------>	INSURLS4	

-- 4
LOPTFREP1	INSURLS2	INSURLS2U	------>	INSURLS4	INSURLS4U

-- 5
LOPTFREP1	INSURLS2	          ------>	INSURLS4	
LOBTFREP1	INSURLS3	          ------>	INSURLS5	
*/

/*
 1
LOPTF1	  INSURLS1	INSURLS1U	------>	INSURLS4	INSURLS4U
LOPTF1	  INSURLS2	INSURLS2U	------>	INSURLS4	INSURLS4U
LOPTF1	  INSURLS2	INSURLS2V	------>	INSURLS4	INSURLS4V
*/
INSERT INTO batch_replace_keep_exp_date
SELECT a.subscriber_no
     , a.soc2        AS "OLD_SOC"
     , a.soc3        AS "OLD_SOC_PROMO"
     , 'INSURLS4'    AS "NEW_SOC"
     , DECODE(a.soc3
       , 'INSURLS2V', 'INSURLS4V'
       , 'INSURLS4U'
       )             AS "NEW_SOC_PROMO"
     , NULL          AS "DEALER_CODE"
     , NULL          AS "SALES_AGENT"
     , 'SO_2020_067 VAT setup Svitsj Insurances'  AS "MEMO_TEXT"
     , 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , NULL          AS "ENTER_TIME"
     , NULL          AS "REQUEST_TIME"
     , NULL          AS "PROCESS_TIME"
     , 'IN_PROGRESS' AS "PROCESS_STATUS"
     , NULL          AS "STATUS_DESC"
  FROM tmp_msisdns_w_soc_soc_soc@nrep11 a
 WHERE a.sub_status IN ( 'A' )
   AND a.soc1        = 'LOPTF1'
   AND a.soc2       IN ( 'INSURLS1', 'INSURLS2' )
   AND a.soc3       IN ( 'INSURLS1U', 'INSURLS2U', 'INSURLS2V' )
--   AND ROWNUM < 21
;

/*
 2
LOBTF1	  INSURLS3	INSURLS3V	------>	INSURLS5	INSURLS5V
*/
INSERT INTO batch_replace_keep_exp_date
SELECT a.subscriber_no
     , a.soc2        AS "OLD_SOC"
     , a.soc3        AS "OLD_SOC_PROMO"
     , 'INSURLS5'    AS "NEW_SOC"
     , 'INSURLS5V'   AS "NEW_SOC_PROMO"
     , NULL          AS "DEALER_CODE"
     , NULL          AS "SALES_AGENT"
     , 'SO_2020_067 VAT setup Svitsj Insurances'  AS "MEMO_TEXT"
     , 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , NULL          AS "ENTER_TIME"
     , NULL          AS "REQUEST_TIME"
     , NULL          AS "PROCESS_TIME"
     , 'IN_PROGRESS' AS "PROCESS_STATUS"
     , NULL          AS "STATUS_DESC"
  FROM tmp_msisdns_w_soc_soc_soc@nrep11 a
 WHERE a.sub_status IN ( 'A' )
   AND a.soc1        = 'LOBTF1'
   AND a.soc2        = 'INSURLS3'
   AND a.soc3        = 'INSURLS3V'
--   AND ROWNUM < 21
;

/*
 3
LOPTF1	  INSURLS1	          ------>	INSURLS4
LOPTF1	  INSURLS2	          ------>	INSURLS4
*/
INSERT INTO batch_replace_keep_exp_date
SELECT a.subscriber_no
     , a.soc2        AS "OLD_SOC"
     , a.soc3        AS "OLD_SOC_PROMO"
     , 'INSURLS4'    AS "NEW_SOC"
     , NULL          AS "NEW_SOC_PROMO"
     , NULL          AS "DEALER_CODE"
     , NULL          AS "SALES_AGENT"
     , 'SO_2020_067 VAT setup Svitsj Insurances'  AS "MEMO_TEXT"
     , 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , NULL          AS "ENTER_TIME"
     , NULL          AS "REQUEST_TIME"
     , NULL          AS "PROCESS_TIME"
     , 'IN_PROGRESS' AS "PROCESS_STATUS"
     , NULL          AS "STATUS_DESC"
  FROM tmp_msisdns_w_soc_soc_soc@nrep11 a
 WHERE a.sub_status IN ( 'A' )
   AND a.soc1        = 'LOPTF1'
   AND a.soc2       IN ( 'INSURLS1', 'INSURLS2' )
   AND a.soc3       IS NULL
--   AND ROWNUM < 21
;

/*
 4
LOPTFREP1	INSURLS2	INSURLS2U	------>	INSURLS4	INSURLS4U
*/
INSERT INTO batch_replace_keep_exp_date
SELECT a.subscriber_no
     , a.soc2        AS "OLD_SOC"
     , a.soc3        AS "OLD_SOC_PROMO"
     , 'INSURLS4'    AS "NEW_SOC"
     , 'INSURLS4U'   AS "NEW_SOC_PROMO"
     , NULL          AS "DEALER_CODE"
     , NULL          AS "SALES_AGENT"
     , 'SO_2020_067 VAT setup Svitsj Insurances'  AS "MEMO_TEXT"
     , 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , NULL          AS "ENTER_TIME"
     , NULL          AS "REQUEST_TIME"
     , NULL          AS "PROCESS_TIME"
     , 'IN_PROGRESS' AS "PROCESS_STATUS"
     , NULL          AS "STATUS_DESC"
  FROM tmp_msisdns_w_soc_soc_soc@nrep11 a
 WHERE a.sub_status IN ( 'A' )
   AND a.soc1        = 'LOPTFREP1'
   AND a.soc2        = 'INSURLS2'
   AND a.soc3        = 'INSURLS2U'
--   AND ROWNUM < 21
;

/*
 5
LOPTFREP1	INSURLS2	          ------>	INSURLS4	
LOBTFREP1	INSURLS3	          ------>	INSURLS5	
*/
INSERT INTO batch_replace_keep_exp_date
SELECT a.subscriber_no
     , a.soc2        AS "OLD_SOC"
     , NULL          AS "OLD_SOC_PROMO"
     , DECODE(a.soc2
       , 'INSURLS2', 'INSURLS4'
       , 'INSURLS5'
       )             AS "NEW_SOC"
     , NULL          AS "NEW_SOC_PROMO"
     , NULL          AS "DEALER_CODE"
     , NULL          AS "SALES_AGENT"
     , 'SO_2020_067 VAT setup Svitsj Insurances'  AS "MEMO_TEXT"
     , 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , NULL          AS "ENTER_TIME"
     , NULL          AS "REQUEST_TIME"
     , NULL          AS "PROCESS_TIME"
     , 'IN_PROGRESS' AS "PROCESS_STATUS"
     , NULL          AS "STATUS_DESC"
  FROM tmp_msisdns_w_soc_soc_soc@nrep11 a
 WHERE a.sub_status IN ( 'A' )
   AND a.soc1       IN ( 'LOPTFREP1', 'LOBTFREP1' )
   AND a.soc2       IN ( 'INSURLS2', 'INSURLS3' )
   AND a.soc3       IS NULL
--   AND ROWNUM < 21
;

SELECT a.old_soc, a.old_soc_promo, a.new_soc, a.new_soc_promo, COUNT(1) AS "COUNT"
  FROM batch_replace_keep_exp_date a
 WHERE a.request_id = 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY a.old_soc, a.old_soc_promo, a.new_soc, a.new_soc_promo
ORDER BY a.old_soc, a.old_soc_promo, a.new_soc, a.new_soc_promo
;

-- COMMIT WORK;

/*

-- Displaying the logic matrix...
SELECT n.soc1 AS "SWITCH", a.old_soc, a.old_soc_promo, a.new_soc, a.new_soc_promo, COUNT(1) AS "COUNT"
  FROM batch_replace_keep_exp_date a, tmp_msisdns_w_soc_soc_soc@nrep11 n
 WHERE a.request_id    = 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.subscriber_no = n.subscriber_no
GROUP BY n.soc1, a.old_soc, a.old_soc_promo, a.new_soc, a.new_soc_promo
ORDER BY n.soc1, a.old_soc, a.old_soc_promo, a.new_soc, a.new_soc_promo
;

*/
