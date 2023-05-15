/*
**
** This scripts inserts records into NINJATEAM.HGU_TMP_TRANS using the db-link
** to OPPE10; thus this script needs to be ran as the NINJAMAIN user.
**
*/
INSERT INTO ninjateam.hgu_tmp_trans -- (SUBSCRIBER_NO, SOC, ACTION, REQUEST_TIME, PRIORITY, REQUEST_ID, MEMO_TEXT)
SELECT "SUBSCRIBER_NO", "SOC", "ACTION", "REQUEST_TIME", "PRIORITY", "REQUEST_ID", "MEMO_TEXT", "DEALER_CODE", "SALES_AGENT"
  FROM (
    SELECT a.subscriber_no                          AS "SUBSCRIBER_NO",
           'NSHAPE79'                               AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           '60GB Xmas campaign 2017'                AS "MEMO_TEXT",
           NULL                                     AS "DEALER_CODE",
           NULL                                     AS "SALES_AGENT"
      FROM service_agreement@oppe10 a
     WHERE RTRIM(a.soc) IN (
           'PPUT'
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@oppe10 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'NSHAPE79'
       )
UNION
    SELECT a.subscriber_no                          AS "SUBSCRIBER_NO",
           'NSHAPE80'                               AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           '60GB Xmas campaign 2017'                AS "MEMO_TEXT",
           NULL                                     AS "DEALER_CODE",
           NULL                                     AS "SALES_AGENT"
      FROM service_agreement@oppe10 a
     WHERE RTRIM(a.soc) IN (
           'PPUX'
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@oppe10 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'NSHAPE80'
       )
UNION
    SELECT a.subscriber_no                          AS "SUBSCRIBER_NO",
           'NSHAPE81'                               AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           '60GB Xmas campaign 2017'                AS "MEMO_TEXT",
           NULL                                     AS "DEALER_CODE",
           NULL                                     AS "SALES_AGENT"
      FROM service_agreement@oppe10 a
     WHERE RTRIM(a.soc) IN (
           'PPUY'
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@oppe10 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'NSHAPE81'
       )
UNION
    SELECT a.subscriber_no                          AS "SUBSCRIBER_NO",
           'NSHAPE82'                               AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           '60GB Xmas campaign 2017'                AS "MEMO_TEXT",
           NULL                                     AS "DEALER_CODE",
           NULL                                     AS "SALES_AGENT"
      FROM service_agreement@oppe10 a
     WHERE RTRIM(a.soc) IN (
           'PPEF'
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@oppe10 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'NSHAPE82'
       )
UNION
    SELECT a.subscriber_no                          AS "SUBSCRIBER_NO",
           'NSHAPE83'                               AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           '60GB Xmas campaign 2017'                AS "MEMO_TEXT",
           NULL                                     AS "DEALER_CODE",
           NULL                                     AS "SALES_AGENT"
      FROM service_agreement@oppe10 a
     WHERE RTRIM(a.soc) IN (
           'PPEC'
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@oppe10 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'NSHAPE83'
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
     FROM subscriber@oppe10 s
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
  ninjateam.hgu_procs.load_master_transactions
;
END;
*/
