UPDATE master_transactions a
   SET a.soc = 'MMS03'
 WHERE a.process_status = 'WAITING'
   AND a.request_id    IN (  'STLI15 2012-06-26',  'STLI15 2012-06-27' )
   AND a.request_time   >  SYSDATE
   AND a.soc = 'WDFPRE';

UPDATE master_transactions a
   SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
       , a.request_time = TO_DATE('2012-06-27 23:30', 'YYYY-MM-DD HH24:MI')
       , a.priority = a.priority + 1
  WHERE a.request_id         IN ('STLI15 2012-06-26')
    AND a.process_status = 'PRSD_ERROR'
    AND a.status_desc LIKE '%InvalidCombinationsException%missing soc%WDFPRE is required%'
;

UPDATE master_transactions a
   SET a.request_time = SYSDATE
 WHERE a.process_status = 'WAITING'
   AND a.request_id    IN (  'STLI15 2012-06-26',  'STLI15 2012-06-27' )
   AND a.request_time   >  SYSDATE
;

SELECT a.*
  FROM master_transactions a
 WHERE a.process_time > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
;

SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59' AS "PROCESS_TIME"
     , a.soc, a.process_status, COUNT(1) AS "COUNT"
  FROM master_transactions a
  WHERE a.request_id        IN (  'STLI15 2012-06-28' )
   AND a.request_time      >= TO_DATE('2012-06-28 21:10', 'YYYY-MM-DD HH24:MI')
   AND a.process_time BETWEEN TO_DATE('2012-06-28 21:10', 'YYYY-MM-DD HH24:MI') AND SYSDATE
GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59', a.soc, a.process_status
ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59', a.soc, a.process_status
;



SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM ninjadata.master_transactions a
 WHERE a.request_id        IN (  'STLI15 2012-06-26',  'STLI15 2012-06-27' )
   AND a.request_time      >= TO_DATE('2012-06-27 21:10', 'YYYY-MM-DD HH24:MI')
   AND a.process_time BETWEEN TO_DATE('2012-06-27 21:10', 'YYYY-MM-DD HH24:MI') AND SYSDATE
   AND a.process_status = 'PRSD_ERROR'
   AND a.status_desc LIKE '%SOC is not available%'
   AND ROWNUM < 11
;

SELECT a.ban, RTRIM(a.subscriber_no) AS "SUBSCRIBER_NO", RTRIM(a.soc) AS "PRICE_PLAN"
      , a.effective_date, a.expiration_date
  FROM service_agreement@fokus a
 WHERE a.subscriber_no IN ( 'GSM04792089870', 'GSM04798889032', 'GSM04759941511', 'GSM047580009105945', 'GSM04793861422', 'GSM047580009104476', 'GSM047580009032506', 'GSM04759944253', 'GSM04793607747', 'GSM04759946047' )
   AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
   AND a.service_type = 'P'
ORDER BY a.subscriber_no, a.soc
;

SELECT a.*
  FROM socs a
 WHERE a.soc_type = 'MMS'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the socs for a price plan.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   SUBSTR(a.subscription_type_id, 0, 4) AS "PRICE_PLAN", a.soc, a.effective_date
    FROM subscription_types_socs a, socs b
   WHERE a.subscription_type_id LIKE 'PK__REG1'
     AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.soc = b.soc
--     AND a.soc IN ('CON09', 'HOMERUN')
     AND b.soc_type IN ('MMS')
--     AND b.soc_group IN ('BASIC_NEW', 'SMALL_PRIV')
ORDER BY a.subscription_type_id, a.soc;


