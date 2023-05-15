SELECT a.*
  FROM user_source a
  WHERE 1 = 1
AND ROWNUM < 11
;

SELECT a.*
  FROM user_source a
 WHERE lower(a.text) LIKE '%oppe10%'
;


SELECT a.*
  FROM all_source a
 WHERE lower(a.text) LIKE '%oppe10%'
;

