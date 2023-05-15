/*
select a.*
  from service_agreement@wh10p a
 where a.subscriber_no = 'GSM047' || '92653600'
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.ban, a.subscriber_no, a.soc
;

SELECT rtrim(a.soc_first) as "SOC_FIRST", rtrim(a.soc_second) as "SOC_SECOND",
       a.effective_date, a.illegal_ind
  FROM soc_illegal_comb@fokus a
 WHERE 'WDFPRE' IN (RTRIM (a.soc_first), RTRIM (a.soc_second))
   AND SYSDATE BETWEEN a.effective_date AND NVL (a.expiration_date, SYSDATE + 1)
   AND a.illegal_ind = 'T'
ORDER BY a.soc_first, a.soc_second
;

select a.*
  from service_agreement@oppe10 a
 where a.subscriber_no = 'GSM047' || '92653600'
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.ban, a.subscriber_no, a.soc
;

*/

/*
**
** This scripts inserts records into NINJATEAM.HGU_TMP_TRANS using the db-link
** from NINJATEAM to WH10P; thus this script needs to be ran as the NINJATEAM
** user.
**
*/
INSERT INTO hgu_tmp_trans (SUBSCRIBER_NO, SOC, ACTION, REQUEST_TIME, PRIORITY, REQUEST_ID, MEMO_TEXT)
SELECT "SUBSCRIBER_NO", "SOC", "ACTION", "REQUEST_TIME", "PRIORITY", "REQUEST_ID", "MEMO_TEXT"
  FROM (
    SELECT a.subscriber_no                          AS "SUBSCRIBER_NO",
           'WDFPRE'                                 AS "SOC",
           'ADD'                                    AS "ACTION",
           NULL                                     AS "REQUEST_TIME",
           NULL                                     AS "PRIORITY",
           'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
           'H�kan: Adding missing mandatory soc WDFPRE that /should/ have been added when prepaid subscriptions were created in the first place! You''re welcome, Fokus...' "MEMO_TEXT"
      FROM service_agreement@wh10p a
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
             FROM service_agreement@wh10p b
            WHERE a.ban           = b.ban
              AND a.subscriber_no = b.subscriber_no
              AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
              AND RTRIM(b.soc)    = 'WDFPRE'
       )
)
ORDER BY "SUBSCRIBER_NO"
;

SELECT COUNT(1) AS "COUNT"
  FROM hgu_tmp_trans
;

COMMIT WORK
;

