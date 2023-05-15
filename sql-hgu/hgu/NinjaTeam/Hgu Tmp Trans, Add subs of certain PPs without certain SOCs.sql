/*
** Use SQL from NREP11 to populate tmp table...
*/
INSERT INTO ninjateam.hgu_tmp_trans
SELECT s.subscriber_no AS "SUBSCRIBER_NO"
     , 'NSHAPE86'      AS "SOC"
     , 'ADD'           AS "ACTION"
     , NULL            AS "REQUEST_TIME"
     , NULL            AS "PRIORITY"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')            AS "REQUEST_ID"
     , 'Added "Velkomst-bonus" as part of Chess migration' AS "MEMO_TEXT"
     , 'CMIG'          AS "DEALER_CODE"
     , 'A'             AS "SALES_AGENT"
  FROM subscriber@nrep11 s, service_agreement@nrep11 sa1, billing_account@nrep11 ba
 WHERE RTRIM(sa1.soc) IN ('PMBQ', 'PMAE') -- With these priceplans
   AND SYSDATE BETWEEN sa1.effective_date AND NVL(sa1.expiration_date, SYSDATE + 1)
   AND sa1.subscriber_no = s.subscriber_no
   AND s.sub_status      = 'A'
   AND 0                 = (SELECT COUNT(1)
                              FROM service_agreement@nrep11 sa2
                             WHERE sa2.ban           = sa1.ban
                               AND sa2.subscriber_no = sa1.subscriber_no
                               AND RTRIM(sa2.soc)   IN ('NSHAPE86') -- Not with this soc
                               AND SYSDATE     BETWEEN sa2.effective_date AND NVL(sa2.expiration_date, SYSDATE + 1))
   AND sa1.ban           = ba.ban
   AND ba.bill_cycle     = 7 -- And with this bill-cycle
;

/*
** Check table...
*/
SELECT a.subscriber_no, a.soc, a.action, a.request_time, a.priority,
       a.request_id, a.memo_text, a.dealer_code, a.sales_agent
  FROM ninjateam.hgu_tmp_trans a
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

