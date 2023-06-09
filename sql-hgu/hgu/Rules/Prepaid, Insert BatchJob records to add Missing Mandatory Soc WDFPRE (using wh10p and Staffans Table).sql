/*
SELECT soc, COUNT(1) AS "ANTALL"
  FROM avd2010.TMP_SLG_CLEA_PREP_20120704@wh10P
GROUP BY soc
ORDER BY soc
;

SELECT a.*
  FROM avd2010.TMP_SLG_CLEA_PREP_20120704@wh10P a
WHERE ROWNUM < 11
;
*/

/*
**
** This scripts inserts records into NINJATEAM.HGU_TMP_TRANS using the db-link
** from NINJATEAM to WH10P; thus this script needs to be ran as the NINJATEAM
** user.
** We read from a temporary table generated by Staffan Lindberg to get the socs
** to add.
**
*/
INSERT INTO hgu_tmp_trans (SUBSCRIBER_NO, SOC, ACTION, REQUEST_TIME, PRIORITY, REQUEST_ID, MEMO_TEXT)
SELECT "SUBSCRIBER_NO", "SOC", "ACTION", "REQUEST_TIME", "PRIORITY", "REQUEST_ID", "MEMO_TEXT"
  FROM (
    SELECT a.subscriber_no                                          AS "SUBSCRIBER_NO",
           a.soc                                                    AS "SOC",
           'ADD'                                                    AS "ACTION",
           TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD') || ' 21:10', 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME",
--           TO_DATE('2012-06-27 21:10', 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME",
--           NULL                                                     AS "PRIORITY",
           a.priority + 1                                           AS "PRIORITY",
           a.request_id || ' ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')    AS "REQUEST_ID",
           a.memo_text                                              AS "MEMO_TEXT"
      FROM avd2010.TMP_SLG_CLEA_PREP_20120704@wh10p a
     WHERE a.soc IN ( 'MMS03' )
)
ORDER BY "SUBSCRIBER_NO"
;

SELECT h.soc, COUNT(1) AS "COUNT"
  FROM hgu_tmp_trans h
GROUP BY h.soc
ORDER BY h.soc
;

COMMIT WORK
;

