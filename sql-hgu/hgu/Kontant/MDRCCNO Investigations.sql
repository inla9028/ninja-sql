SELECT a.subscriber_no, a.soc, a.action, a.type, a.timestamp,
       a.processed, a.arg1, a.processed_date, a.ninja_processed_date,
       a.ninja_status_text, a.request_seq_no
  FROM fokus.smsc_ad_soc@kontant.world a
  WHERE a.subscriber_no = 'GSM04740250085'
ORDER BY a.timestamp
;

SELECT TO_CHAR(a.TIMESTAMP, 'YYYY-MM-DD') AS "DATE",
       a.subscriber_no, a.soc, a.action, count(1) AS "COUNT"
  FROM fokus.smsc_ad_soc@kontant.world a
-- WHERE a.subscriber_no = 'GSM04740250085'
 WHERE a.subscriber_no = 'GSM04740606507'
GROUP BY TO_CHAR(a.TIMESTAMP, 'YYYY-MM-DD'), a.subscriber_no, a.soc, a.action
ORDER BY TO_CHAR(a.TIMESTAMP, 'YYYY-MM-DD'), a.subscriber_no, a.soc, a.action
;


SELECT * FROM (
SELECT TO_CHAR(a.TIMESTAMP, 'YYYY-MM-DD') AS "DATE",
       a.subscriber_no, a.soc, a.action, count(1) AS "COUNT"
  FROM fokus.smsc_ad_soc@kontant.world a
 WHERE a.TIMESTAMP > trunc(SYSDATE - 3)
GROUP BY TO_CHAR(a.TIMESTAMP, 'YYYY-MM-DD'), a.subscriber_no, a.soc, a.action
ORDER BY TO_CHAR(a.TIMESTAMP, 'YYYY-MM-DD'), a.subscriber_no, a.soc, a.action
) WHERE "COUNT" > 100
;

SELECT * FROM (
    SELECT a.subscriber_no, a.soc, a.action, COUNT(1) AS "COUNT"
      FROM fokus.smsc_ad_soc@kontant.world a
     WHERE a.TIMESTAMP > TRUNC(SYSDATE - 3)
    GROUP BY a.subscriber_no, a.soc, a.action
    ORDER BY a.subscriber_no, a.soc, a.action
) WHERE "COUNT" > 150
ORDER BY "COUNT" DESC
;


SELECT TO_CHAR(a.TIMESTAMP, 'YYYY-MM-DD') AS "DATE",
       a.soc, a.action, COUNT(1) AS "COUNT"
  FROM fokus.smsc_ad_soc@kontant.world a
 WHERE a.soc = 'MDRCCNO'
   AND a.timestamp > TRUNC(SYSDATE - 26)
GROUP BY TO_CHAR(a.TIMESTAMP, 'YYYY-MM-DD'), a.soc, a.action
ORDER BY a.soc, a.action, "DATE"
;
