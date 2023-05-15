SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TOAV PRJ4441')
    AND a.request_time > TRUNC(SYSDATE)
  GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.process_status
  ORDER BY "REQUEST_TIME", a.process_status;


UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', 
      a.request_time   = TO_DATE('2009-05-20 00:10', 'YYYY-MM-DD HH24:MI')
  WHERE a.request_id    IN ('TOAV PRJ4441')
    AND a.process_status = 'WAITING'
    AND a.soc            = 'VMMINIVS'
    AND TO_CHAR(a.request_time, 'YYYY-MM-DD') = '2009-05-19';
