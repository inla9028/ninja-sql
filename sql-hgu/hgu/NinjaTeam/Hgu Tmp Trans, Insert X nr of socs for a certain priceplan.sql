INSERT INTO ninjateam.hgu_tmp_trans -- (SUBSCRIBER_NO, SOC, ACTION, REQUEST_TIME, PRIORITY, REQUEST_ID, MEMO_TEXT)
SELECT "SUBSCRIBER_NO", "SOC", "ACTION", "REQUEST_TIME", "PRIORITY", "REQUEST_ID", "MEMO_TEXT", "DEALER_CODE", "SALES_AGENT"
  FROM (
    SELECT /*+DRIVING_SITE(a)*/
           a.subscriber_no                          AS "SUBSCRIBER_NO",
           'IMSVS'                                  AS "SOC",
           'ADD'                                    AS "ACTION",
           TRUNC(SYSDATE) + 21/24                   AS "REQUEST_TIME", -- At 21:00
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
              AND RTRIM(b.soc)    = 'IMSVS'
       )
       
   AND ROWNUM          < (4000 + 1)
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


BEGIN
  -- Now Call the stored program
  ninjateam.hgu_procs.load_master_transactions
;
END;


UPDATE master_transactions mt
   SET mt.stream = NVL((SELECT TO_CHAR(MOD(b.ban, 9) + 2) -- Stream 2 - 10
                          FROM billing_account@nrep11 b, subscriber@nrep11 s
                         WHERE s.subscriber_no IN (mt.subscriber_no)
                           AND s.customer_id    = b.ban
                           AND s.sub_status    IN ('A', 'R', 'S')), '99')
 WHERE mt.request_id IN ( 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') )
   AND mt.soc        IN ( 'IMSVS' )
;
