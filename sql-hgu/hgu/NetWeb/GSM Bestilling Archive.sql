--== Display records processed today (or for the last 12 hours).
SELECT a.msisdn, a.dato, a.created_by, a.modified_by, a.created_date,
       a.modified_date, a.type, a.sms_text, a.process_status,
       a.status_desc
  FROM ninjadata.gsm_bestilling_archive a
  WHERE a.dato > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'));

--== Display an overview of the request-types processed today (or for the last 12 hours).
SELECT a.type, COUNT(*) AS "COUNT"
  FROM ninjadata.gsm_bestilling_archive a
  WHERE a.dato > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
  GROUP BY a.type
  ORDER BY a.type;

