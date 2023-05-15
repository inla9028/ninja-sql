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
           'ODB2'                                   AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           'Pavel: Adding ODB2, ODB3 and ODB9 to MBB B2B' "MEMO_TEXT",
           NULL                                     AS "DEALER_CODE",
           NULL                                     AS "SALES_AGENT"
      FROM service_agreement@oppe10 a
     WHERE RTRIM(a.soc) IN (
           'PFUK','PSCA','PSCB','PSCG','PSCN','PSCS','PSCT','PSCU','PSCV','PSDA','PSDB','PSDN','PSDO','PSDP',
           'PSDS','PSDT','PSMF','PSMG','PSMH','PSMI','PSMJ','PSMK','PSMQ','PSMR','PSMS','PSMT','PSMU','PSMV',
           'PSMW','PSOA','PSOB','PSOC','PSOD','PSOE','PSOF'
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@oppe10 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'ODB2'
       )
UNION
    SELECT a.subscriber_no                          AS "SUBSCRIBER_NO",
           'ODB3'                                   AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           'Pavel: Adding ODB2, ODB3 and ODB9 to MBB B2B' "MEMO_TEXT",
           NULL                                     AS "DEALER_CODE",
           NULL                                     AS "SALES_AGENT"
      FROM service_agreement@oppe10 a
     WHERE RTRIM(a.soc) IN (
           'PFUK','PSCA','PSCB','PSCG','PSCN','PSCS','PSCT','PSCU','PSCV','PSDA','PSDB','PSDN','PSDO','PSDP',
           'PSDS','PSDT','PSMF','PSMG','PSMH','PSMI','PSMJ','PSMK','PSMQ','PSMR','PSMS','PSMT','PSMU','PSMV',
           'PSMW','PSOA','PSOB','PSOC','PSOD','PSOE','PSOF'
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@oppe10 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'ODB3'
       )
UNION
    SELECT a.subscriber_no                          AS "SUBSCRIBER_NO",
           'ODB9'                                   AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           'Pavel: Adding ODB2, ODB3 and ODB9 to MBB B2B' "MEMO_TEXT",
           NULL                                     AS "DEALER_CODE",
           NULL                                     AS "SALES_AGENT"
      FROM service_agreement@oppe10 a
     WHERE RTRIM(a.soc) IN (
           'PFUK','PSCA','PSCB','PSCG','PSCN','PSCS','PSCT','PSCU','PSCV','PSDA','PSDB','PSDN','PSDO','PSDP',
           'PSDS','PSDT','PSMF','PSMG','PSMH','PSMI','PSMJ','PSMK','PSMQ','PSMR','PSMS','PSMT','PSMU','PSMV',
           'PSMW','PSOA','PSOB','PSOC','PSOD','PSOE','PSOF'
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@oppe10 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'ODB9'
       )
)
ORDER BY "SUBSCRIBER_NO"
;

SELECT COUNT(1) AS "COUNT_ALL"
  FROM ninjateam.hgu_tmp_trans
;

DELETE
  FROM ninjateam.hgu_tmp_trans a
 WHERE 0 = (
   SELECT COUNT(1) 
     FROM subscriber@oppe10 s
    WHERE a.subscriber_no = s.subscriber_no
      AND SYSDATE         > s.effective_date
      AND s.sub_status    = 'A'
 )
;

SELECT COUNT(1) AS "COUNT_ACTIVE"
  FROM ninjateam.hgu_tmp_trans
;

COMMIT WORK
;

BEGIN
  -- Now Call the stored program
  ninjateam.hgu_procs.load_master_transactions
;
END;


