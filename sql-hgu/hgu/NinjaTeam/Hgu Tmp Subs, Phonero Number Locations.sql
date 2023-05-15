SELECT ti.ctn, ti.last_trx_uid, u.user_full_name, ti.ctn_status, ti.nl, ti.ngp, ti.tn_in_use
  FROM hgu_tmp_subs a, tn_inv@fokus ti, users@fokus u
 WHERE a.subscriber_no = ti.ctn
   AND ti.last_trx_uid = u.user_id(+)
ORDER BY 1
;

SELECT ti.ctn_status, ti.nl, ti.ngp, ti.tn_in_use, count(1) AS "COUNT"
  FROM hgu_tmp_subs a, tn_inv@fokus ti
 WHERE a.subscriber_no = ti.ctn
GROUP BY ti.ctn_status, ti.nl, ti.ngp, ti.tn_in_use
ORDER BY 1,2,3,4
;

UPDATE hgu_tmp_subs a
   SET a.soc = (SELECT ti.ctn_status
                  FROM tn_inv@fokus ti
                 WHERE a.subscriber_no = ti.ctn)
;

SELECT a.soc, count(1) AS "COUNT"
  FROM hgu_tmp_subs a
GROUP BY a.soc
ORDER BY 1
;

/*
AA is OK!

Number status  Existing NL  Existing GRP  Change to NL  Change to GRP
AI             IMP          A             PHO           A
AG             IMP          A             PHO           A
AG             EXP          A             PHO           A
AS             IMP          A             PHO           A             
*/

SELECT ti.ctn_status, ti.nl, ti.ngp, ti.tn_in_use, count(1) AS "COUNT"
  FROM hgu_tmp_subs a, tn_inv@fokus ti
 WHERE a.subscriber_no = ti.ctn
   AND (
         (ti.ctn_status = 'AI' AND ti.nl = 'IMP' AND ti.ngp = 'A')
      OR (ti.ctn_status = 'AG' AND ti.nl = 'IMP' AND ti.ngp = 'A')
      OR (ti.ctn_status = 'AG' AND ti.nl = 'EXP' AND ti.ngp = 'A')
      OR (ti.ctn_status = 'AS' AND ti.nl = 'IMP' AND ti.ngp = 'A'))
GROUP BY ti.ctn_status, ti.nl, ti.ngp, ti.tn_in_use
ORDER BY 1,2,3,4
;

SELECT a.subscriber_no AS "CTN", 'PHO' AS "NL", 'A' AS "NGP"
  FROM hgu_tmp_subs a, tn_inv@fokus ti
 WHERE a.subscriber_no = ti.ctn
/*   AND ((ti.ctn_status = 'AI' AND ti.nl = 'IMP' AND ti.ngp = 'A')
     OR (ti.ctn_status = 'AG' AND ti.nl = 'IMP' AND ti.ngp = 'A')
     OR (ti.ctn_status = 'AG' AND ti.nl = 'EXP' AND ti.ngp = 'A')
     OR (ti.ctn_status = 'AS' AND ti.nl = 'IMP' AND ti.ngp = 'A'))
*/   AND a.subscriber_no IN ('04740400004', '04740409395' )
ORDER BY 1,2,3
;

SELECT a.*
  FROM tn_inv@fokus a
 WHERE a.ctn = '047'||'40409395'
;
