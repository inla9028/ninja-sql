SELECT a.*
  FROM hgu_tmp_subs a
ORDER BY a.param2, a.subscriber_no
;

/*
DELETE
  FROM hgu_tmp_subs
;
*/

SELECT a.*
  FROM hgu_tmp_subs a
 WHERE a.subscriber_no = '46619935'
;

UPDATE hgu_tmp_subs a
   SET a.subscriber_no = '047'||a.subscriber_no
  WHERE length(a.subscriber_no) = 8
;

UPDATE hgu_tmp_subs a
   SET a.param4 = (SELECT ti.ctn_status FROM tn_inv@fokus ti WHERE ti.ctn = a.subscriber_no)
     , a.param5 = (SELECT ti.nl         FROM tn_inv@fokus ti WHERE ti.ctn = a.subscriber_no)
     , a.param6 = (SELECT ti.ngp        FROM tn_inv@fokus ti WHERE ti.ctn = a.subscriber_no)
;
