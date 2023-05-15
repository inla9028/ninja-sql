/*
**
** This scripts inserts records into NINJATEAM.HGU_TMP_TRANS using the db-link
** to OPPE10; thus this script needs to be ran as the NINJAMAIN user.
**
*/
INSERT INTO ninjateam.hgu_tmp_trans -- (SUBSCRIBER_NO, SOC, ACTION, REQUEST_TIME, PRIORITY, REQUEST_ID, MEMO_TEXT)
SELECT "SUBSCRIBER_NO", "SOC", "ACTION", "REQUEST_TIME", "PRIORITY", "REQUEST_ID", "MEMO_TEXT"
  FROM (
    SELECT a.subscriber_no                          AS "SUBSCRIBER_NO",
           'WDFPRE'                                 AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           'Håkan: Adding missing mandatory soc WDFPRE that /should/ have been added when prepaid subscriptions were created in the first place! You''re welcome, Fokus...' "MEMO_TEXT"
      FROM service_agreement@oppe10 a
     WHERE RTRIM(a.soc) IN (
           'PKOC', 'PKOD', 'PKOF', 'PKOG', 'PKOI', 'PKOM', 'PKON', 'PKOP', 'PKOS', 'PKOT', 'PKOU', 'PKOV', 'PKOX', 'PKOY'
           /*
           SELECT RTRIM(c.soc_first)
             FROM soc_illegal_comb@fokus c
            WHERE RTRIM (c.soc_second) = 'WDFPRE'
              AND SYSDATE BETWEEN c.effective_date AND NVL(c.expiration_date, SYSDATE + 1)
              AND c.illegal_ind        = 'T'
           */
       )
       AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
       AND a.subscriber_no NOT LIKE '000%'
       AND 0 = (
           SELECT COUNT(1)
             FROM service_agreement@oppe10 b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'WDFPRE'
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
      AND SYSDATE > s.effective_date
      AND s.sub_status = 'A'
 )
;

SELECT COUNT(1) AS "COUNT_ACTIVE"
  FROM ninjateam.hgu_tmp_trans
;

COMMIT WORK
;

