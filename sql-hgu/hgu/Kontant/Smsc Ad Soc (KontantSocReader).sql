--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Indexes in the 'fokus.smsc_ad_soc' table.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== o subscriber_no
--== o-o processed
--==   o request_seq_no
--== o request_seq_no
--== o timestamp
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the content of the Fokus requested record
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.soc, a.action, a.type, a.timestamp,
       a.processed, a.arg1, a.processed_date, a.ninja_processed_date,
       a.ninja_status_text, a.request_seq_no
  FROM fokus.smsc_ad_soc a
 WHERE a.subscriber_no = 'GSM047' || '92099849'
ORDER BY a.request_seq_no
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display an overview of all requests for a given subscriber
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.soc, a.arg1, a.action, to_char(a.TIMESTAMP, 'YYYY-MM-DD') AS "REQ_DATE", COUNT(*) AS "COUNT"
  FROM fokus.smsc_ad_soc a
 WHERE a.subscriber_no = 'GSM047' || '90599373'
GROUP BY a.subscriber_no, a.soc, a.arg1, a.action, to_char(a.TIMESTAMP, 'YYYY-MM-DD')
ORDER BY to_char(a.TIMESTAMP, 'YYYY-MM-DD'), a.subscriber_no, a.soc, a.action
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the 20 newest records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.soc, a.action, a.type, a.timestamp,
       a.processed, a.arg1, a.processed_date, a.ninja_processed_date,
       a.ninja_status_text, a.request_seq_no
  FROM fokus.smsc_ad_soc a
  WHERE a.request_seq_no > (SELECT MAX(b.request_seq_no) - 20 FROM fokus.smsc_ad_soc b)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display a grouping of the requests today.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action, NVL(a.soc, 'n/a') AS "SOC", a.arg1, COUNT(*) AS "COUNT"
  FROM fokus.smsc_ad_soc a
  WHERE a.timestamp > TRUNC(SYSDATE)
  GROUP BY a.action, NVL(a.soc, 'n/a'), a.arg1
  ORDER BY a.action, NVL(a.soc, 'n/a'), a.arg1
  --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Indexes in the 'fokus.smsc_ad_soc' table.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== o subscriber_no
--== o-o processed
--==   o request_seq_no
--== o request_seq_no
--== o timestamp
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the content of the Fokus requested record
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.soc, a.action, a.type, a.timestamp,
       a.processed, a.arg1, a.processed_date, a.ninja_processed_date,
       a.ninja_status_text, a.request_seq_no
  FROM fokus.smsc_ad_soc a
  WHERE a.subscriber_no = 'GSM04741575632'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the 20 newest records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.soc, a.action, a.type, a.dealer_code, a.timestamp,
       a.processed, a.arg1, a.processed_date, a.ninja_processed_date,
       a.ninja_status_text, a.request_seq_no
  FROM fokus.smsc_ad_soc a
  WHERE a.request_seq_no > (SELECT MAX(b.request_seq_no) - 20 FROM fokus.smsc_ad_soc b)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display a grouping of the requests today.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action, NVL(a.soc, 'n/a') AS "SOC", a.arg1, COUNT(*) AS "COUNT"
  FROM fokus.smsc_ad_soc a
  WHERE a.timestamp > TRUNC(SYSDATE)
  GROUP BY a.action, NVL(a.soc, 'n/a'), a.arg1
  ORDER BY a.action, NVL(a.soc, 'n/a'), a.arg1
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display a grouping of the non-soc requests for the last 7 days..
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action, a.arg1, COUNT(*) AS "COUNT"
  FROM fokus.smsc_ad_soc a
  WHERE a.timestamp       > TRUNC(SYSDATE - 7)
    AND NVL(a.soc, 'n/a') = 'n/a'
  GROUP BY a.action, a.arg1
  ORDER BY a.action, a.arg1
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records that Ninja failed to copy for the last 7 days.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.soc, a.action, a.type, a.timestamp,
       a.processed, a.arg1, a.processed_date, a.ninja_processed_date,
       a.ninja_status_text, a.request_seq_no
  FROM fokus.smsc_ad_soc a
  WHERE a.timestamp             > TRUNC(SYSDATE - 7)
    AND NVL(a.processed, 'n/a') = 'E'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display a grouping of the records that Ninja failed to copy for the last 7 days.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action, NVL(a.soc, 'n/a') AS "SOC", a.arg1, COUNT(*) AS "COUNT"
  FROM fokus.smsc_ad_soc a
  WHERE a.timestamp             > TRUNC(SYSDATE - 7)
    AND NVL(a.processed, 'n/a') = 'E'
  GROUP BY a.action, NVL(a.soc, 'n/a'), a.arg1
  ORDER BY a.action, NVL(a.soc, 'n/a'), a.arg1
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display a grouping of the non-soc requests for the last 7 days..
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action, a.arg1, COUNT(*) AS "COUNT"
  FROM fokus.smsc_ad_soc a
  WHERE a.timestamp       > TRUNC(SYSDATE - 7)
    AND NVL(a.soc, 'n/a') = 'n/a'
  GROUP BY a.action, a.arg1
  ORDER BY a.action, a.arg1
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records that Ninja failed to copy for the last 7 days.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.soc, a.action, a.type, a.timestamp,
       a.processed, a.arg1, a.processed_date, a.ninja_processed_date,
       a.ninja_status_text, a.request_seq_no
  FROM fokus.smsc_ad_soc a
  WHERE a.timestamp             > TRUNC(SYSDATE - 7)
    AND NVL(a.processed, 'n/a') = 'E'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display a grouping of the records that Ninja failed to copy for the last 7 days.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action, NVL(a.soc, 'n/a') AS "SOC", a.arg1, COUNT(*) AS "COUNT"
  FROM fokus.smsc_ad_soc a
  WHERE a.timestamp             > TRUNC(SYSDATE - 7)
    AND NVL(a.processed, 'n/a') = 'E'
  GROUP BY a.action, NVL(a.soc, 'n/a'), a.arg1
  ORDER BY a.action, NVL(a.soc, 'n/a'), a.arg1
;


