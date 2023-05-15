SELECT /*+parallel (name_data 8)*/ COUNT (*)
  FROM name_data
 WHERE TO_CHAR (birth_date, 'DDMMYY') = SUBSTR (identify, 1, 6)
   AND comp_reg_id IS NULL
   AND LENGTH (TRIM (identify)) = '11'
;
 
--
SELECT /*+parallel (name_data 8)*/ a.link_type, n.*
 FROM name_data n, address_name_link a
WHERE TO_CHAR (n.birth_date, 'DDMMYY') = SUBSTR (n.identify, 1, 6)
  AND n.comp_reg_id IS NULL
  AND LENGTH (TRIM (n.identify)) = '11'
  AND n.name_id = a.name_id
  AND NVL(a.expiration_date, SYSDATE + 1) > SYSDATE
  AND ROWNUM < 11
;
 
-- (1) Update birth-date should it be empty.
UPDATE /*+parallel (name_data 8)*/ name_data n
   SET n.birth_date = TO_DATE(SUBSTR (n.identify, 1, 6), 'DDMMYY')
 WHERE n.birth_date IS NULL
   AND LENGTH (TRIM (n.identify)) = '11'
   AND SUBSTR (n.identify, 3, 2) IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')
   AND SUBSTR (n.identify, 1, 2) BETWEEN '01' AND '31'
   AND RTRIM(n.id_type) NOT IN ('C', 'COMP', 'F')
;
 
-- (2) Update the birth-date should it not be empty, but not matching IDENTIFY
UPDATE /*+parallel (name_data 8)*/ name_data n
   SET n.birth_date = TO_DATE(SUBSTR (n.identify, 1, 6), 'DDMMYY')
 WHERE n.birth_date IS NOT NULL
   AND LENGTH (TRIM (n.identify)) = '11'
   AND TO_CHAR (n.birth_date, 'DDMMYY') != SUBSTR (n.identify, 1, 6)
   AND SUBSTR (n.identify, 3, 2) IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')
   AND SUBSTR (n.identify, 1, 2) BETWEEN '01' AND '31'
   AND RTRIM(n.id_type) NOT IN ('C', 'COMP', 'F')
;

-- (1) 11:02:33  ORA-01843: not a valid month
SELECT /*+parallel (name_data 8)*/ n.*
 FROM name_data n
WHERE n.birth_date IS NULL
  AND LENGTH (TRIM (n.identify)) = '11'
  AND SUBSTR (n.identify, 3, 2) NOT IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')
;

-- (1) 11:11:34  ORA-01847: day of month must be between 1 and last day of month
SELECT /*+parallel (name_data 8)*/ n.*
 FROM name_data n
WHERE n.birth_date IS NULL
  AND LENGTH (TRIM (n.identify)) = '11'
  AND SUBSTR (n.identify, 1, 2) NOT BETWEEN '01' AND '31'
;
 
 
 SELECT a.*
   FROM address_name_link a
  WHERE a.name_id IN (
            255339054,
            255381060,
            255417297,
            255607715,
            255566174)
    AND NVL(a.expiration_date, SYSDATE + 1) > SYSDATE
;

SELECT /*+parallel (name_data 8)*/ a.link_type, count(1)
  FROM name_data n, address_name_link a
 WHERE TO_CHAR (n.birth_date, 'DDMMYY') = SUBSTR (n.identify, 1, 6)
   AND n.comp_reg_id IS NULL
   AND LENGTH (TRIM (n.identify)) = '11'
   AND n.name_id = a.name_id
   AND NVL(a.expiration_date, SYSDATE + 1) > SYSDATE
GROUP BY a.link_type
ORDER BY a.link_type
;
