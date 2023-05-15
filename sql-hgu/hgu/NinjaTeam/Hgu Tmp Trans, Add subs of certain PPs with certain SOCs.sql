/*
** Use SQL from NREP11 to populate tmp table...
*/
INSERT INTO ninjateam.hgu_tmp_trans
SELECT s.subscriber_no AS "SUBSCRIBER_NO"
     , RTRIM(sa2.soc)  AS "SOC"
     , 'DELETE'        AS "ACTION"
     , NULL            AS "REQUEST_TIME"
     , NULL            AS "PRIORITY"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')            AS "REQUEST_ID"
     , 'Deleting "' || RTRIM(sa2.soc) || '" as it is an illegal soc for "' || RTRIM(sa1.soc) || '" subscriptions, accidentally added by MARV' AS "MEMO_TEXT"
     , 'KSA1'          AS "DEALER_CODE"
     , 'A'             AS "SALES_AGENT"
  FROM subscriber@nrep11 s, service_agreement@nrep11 sa1, service_agreement@nrep11 sa2
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = sa1.ban
   AND s.subscriber_no  = sa1.subscriber_no
   AND SYSDATE     BETWEEN sa1.effective_date AND NVL(sa1.expiration_date, SYSDATE + 1)
   AND RTRIM(sa1.soc)   IN ('PW10')
   AND sa1.ban           = sa2.ban
   AND sa1.subscriber_no = sa2.subscriber_no
   AND SYSDATE     BETWEEN sa2.effective_date AND NVL(sa2.expiration_date, SYSDATE + 1)
   AND sa2.soc          IN ('IMS01', 'IMS02')
   AND ROWNUM            < 1001
;

/*
** Check table...
*/
SELECT a.subscriber_no, a.soc, a.action, a.request_time, a.priority,
       a.request_id, a.memo_text, a.dealer_code, a.sales_agent
  FROM ninjateam.hgu_tmp_trans a
 WHERE ROWNUM < 11
;

/*
** Check row count...
*/
SELECT COUNT(1) AS "COUNT"
  FROM ninjateam.hgu_tmp_trans a
;

/*
** Commit...?
*/
COMMIT WORK;

