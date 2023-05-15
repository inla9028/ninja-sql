--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display sms'es not yet sent.
--== Indexes:
--== 1) sms_msisdn
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.sms_msisdn, a.sms_text, a.sms_status, a.sms_created,
       a.sms_sendt, a.sms_priority, a.sms_send, a.sms_orig
  FROM smssend.sms_send_new a
 WHERE a.sms_msisdn IN ( '47' || '48045299', '47' || '92991488' )
;

--
-- Check if there are messages not sent!
--
SELECT TO_CHAR(A.sms_send, 'YYYY-MM-DD') AS "SMS_SEND", COUNT(1) AS "COUNT"
  FROM sms_send_new A
 WHERE A.sms_send < SYSDATE
   AND A.sms_status IS NULL
GROUP BY to_char(A.sms_send, 'YYYY-MM-DD')
ORDER BY 1
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display sent sms'es.
--== Indexes:
--== 1) sms_msisdn
--== 2) o sms_msisdn
--==    o sms_sendt
--== 3) sms_sendt
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.sms_msisdn, a.sms_text, a.sms_status, a.sms_created,
       a.sms_sendt, a.sms_priority, a.sms_send, a.sms_orig
  FROM smssend.sms_send_old a
 WHERE a.sms_msisdn IN ( '47' || '48045299', '47' || '92991488' )
   AND a.sms_sendt BETWEEN TRUNC(SYSDATE, 'MON') -- TO_DATE('2019-09-26', 'YYYY-MM-DD')
                       --AND TO_DATE('2015-12-07', 'YYYY-MM-DD')
                       AND SYSDATE
ORDER BY a.sms_sendt
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display sent sms'es for the last 7 days.
--== Indexes:
--== 1) sms_msisdn
--== 2) o sms_msisdn
--==    o sms_sendt
--== 3) sms_sendt
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.sms_msisdn, a.sms_text, a.sms_status, a.sms_created,
       a.sms_sendt, a.sms_priority, a.sms_send, a.sms_orig
  FROM smssend.sms_send_old a
 WHERE 1 = 1
   AND a.sms_msisdn IN ('47' || '48045299', '47' || '92991488')
   AND a.sms_sendt BETWEEN TRUNC(SYSDATE - 21) AND SYSDATE
--   AND a.sms_text LIKE 'Velkommen til NetCom%'
ORDER BY a.sms_sendt
;

