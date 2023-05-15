SELECT a.*
  FROM cdata.usg_all3 a
 WHERE a.subscriber_no = 'GSM047'||'98075335'
   AND a.ban           = 873620900
--   AND ROWNUM          < 201
;

SELECT a.ban, a.subscriber_no, a.b_number, count(1) AS "COUNT"
  FROM cdata.usg_all3 a
 WHERE a.subscriber_no = 'GSM047'||'98075335'
   AND a.ban           = 873620900
GROUP BY a.ban, a.subscriber_no, a.b_number
HAVING COUNT(1) < 3
ORDER BY 1,2,3
;
