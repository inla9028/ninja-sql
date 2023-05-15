SELECT /*+DRIVING_SITE(a)*/
       COUNT(1) AS "COUNT"
  FROM ninja_sub_change_status@ni01pn a
 WHERE a.request_reference_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.process_status       = 'WAITING'
;

SELECT s.dealer_code, COUNT(1) AS "COUNT"
  FROM subscriber s 
 WHERE s.subscriber_no IN (SELECT a.subscriber_no
                             FROM ninja_sub_change_status@ni01pn a
                            WHERE a.request_reference_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
                              AND a.process_status       = 'WAITING')
   AND s.sub_status = 'A'
GROUP BY s.dealer_code
ORDER BY 1
;

UPDATE subscriber s
   SET s.dealer_code = 'MARV'
--   SET s.dealer_code = 'MARV', s.org_dealer_code = 'MARV'
--   SET s.dealer_code = 'CH01'
--   SET s.dealer_code = 'CH01', s.org_dealer_code = 'CH01' 
 WHERE s.subscriber_no IN (SELECT a.subscriber_no
                             FROM ninja_sub_change_status@ni01pn a
                            WHERE a.request_reference_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
                              AND a.process_status       = 'WAITING')
   AND s.sub_status = 'A'
;

SELECT s.dealer_code, COUNT(1) AS "COUNT"
  FROM subscriber s 
 WHERE s.subscriber_no IN (SELECT a.subscriber_no
                             FROM ninja_sub_change_status@ni01pn a
                            WHERE a.request_reference_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
                              AND a.process_status       = 'WAITING')
   AND s.sub_status = 'A'
GROUP BY s.dealer_code
ORDER BY 1
;


COMMIT WORK
;

