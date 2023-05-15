SELECT *
  FROM (SELECT apn,
               call_characteristic,
               apn_short_name,
               csm_displ_ind
          FROM access_point_name
         WHERE apn LIKE '222%'
           AND ROWNUM < 1001)
 WHERE ROWNUM < 11
ORDER BY DBMS_RANDOM.random;

;
