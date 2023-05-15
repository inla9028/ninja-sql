INSERT INTO ninjateam.hgu_tmp_trans -- (SUBSCRIBER_NO, SOC, ACTION, REQUEST_TIME, PRIORITY, REQUEST_ID, MEMO_TEXT)
SELECT "SUBSCRIBER_NO", "SOC", "ACTION", "REQUEST_TIME", "PRIORITY", "REQUEST_ID", "MEMO_TEXT", "DEALER_CODE", "SALES_AGENT"
  FROM (
    SELECT /*+DRIVING_SITE(a)*/
           a.subscriber_no                          AS "SUBSCRIBER_NO",
           'CALLWAIT'                               AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           'As requested by Geir Ove @ Chilimobil'  AS "MEMO_TEXT",
           'SP06'                                   AS "DEALER_CODE",
           NULL                                     AS "SALES_AGENT"
      FROM service_agreement@nrep11 a
     WHERE RTRIM(a.soc) IN (
           'PVJA'
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@nrep11 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'CALLWAIT'
       )
UNION
    SELECT /*+DRIVING_SITE(a)*/
           a.subscriber_no                          AS "SUBSCRIBER_NO",
           'KONFERVS'                               AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           'As requested by Geir Ove @ Chilimobil'  AS "MEMO_TEXT",
           'SP06'                                   AS "DEALER_CODE",
           NULL                                     AS "SALES_AGENT"
      FROM service_agreement@nrep11 a
     WHERE RTRIM(a.soc) IN (
           'PVJA'
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@nrep11 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'KONFERVS'
       )
)
ORDER BY "SUBSCRIBER_NO"
;

SELECT a.soc, COUNT(1) AS "COUNT_ALL"
  FROM ninjateam.hgu_tmp_trans a
GROUP BY a.soc
ORDER BY 1
;

DELETE
  FROM ninjateam.hgu_tmp_trans a
 WHERE 0 = (
   SELECT COUNT(1)
     FROM subscriber@nrep11 s
    WHERE a.subscriber_no = s.subscriber_no
      AND SYSDATE         > s.effective_date
      AND s.sub_status    IN ('A', 'R')
 )
;

SELECT a.soc, COUNT(1) AS "COUNT_ACTIVE"
  FROM ninjateam.hgu_tmp_trans a
GROUP BY a.soc
ORDER BY 1
;

COMMIT WORK
;

/*
BEGIN
  -- Now Call the stored program
  ninjateam.hgu_procs.load_master_transactions_1
;
END;
*/
