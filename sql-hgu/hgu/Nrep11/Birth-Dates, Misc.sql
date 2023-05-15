SELECT COUNT(1) AS "ADR_COUNT"
  FROM tmp_addresses_w_names
;

SELECT COUNT(1) AS "EARLY_BIRTH_DATE_COUNT"
  FROM tmp_addresses_w_names A
 WHERE A.birth_date < to_date('1912-01-01', 'YYYY-MM-DD')
;

SELECT A.*
  FROM tmp_addresses_w_names A
 WHERE A.birth_date < to_date('1912-01-01', 'YYYY-MM-DD')
--   AND A.comp_reg_id IS NOT NULL
--   AND LENGTH(A.comp_reg_id) = 11
;

WITH my_filter AS (
  SELECT A.ban
    FROM tmp_addresses_w_names A
   WHERE A.birth_date < to_date('1900-01-01', 'YYYY-MM-DD'))
SELECT UNIQUE A.ban, A.subscriber_no, A.link_type, A.first_name, A.last_business_name, A.birth_date
     ,  'INSERT INTO batch_name_update (ban, link_type, chg_birth_date, birth_date, name_type, requestor_id, process_status) VALUES (' || A.ban || ', ''' || A.link_type || ''', ''Y'', TO_DATE(''19' || to_char(A.birth_date, 'YY-MM-DD') || ''', ''YYYY-MM-DD''), ''P'', ''HGU ' || to_char(SYSDATE, 'YYYY-MM-DD') || ''', ''WAITING'');' AS "SQL1"
  FROM tmp_addresses_w_names A, my_filter b
 WHERE A.ban = b.ban
ORDER BY A.ban, A.link_type, A.subscriber_no
;

SELECT A.ban, A.link_type, A.first_name, A.last_business_name, A.birth_date, A.comp_reg_id
     , '19' || substr(A.comp_reg_id, 5, 2) || '-' || substr(A.comp_reg_id, 3, 2) || '-' || substr(A.comp_reg_id, 0, 2) AS "TEST"
     ,  'INSERT INTO batch_name_update (ban, link_type, chg_birth_date, birth_date, name_type, requestor_id, process_status) VALUES (' || A.ban || ', ''' || A.link_type || ''', ''Y'', TO_DATE(''19' || to_char(A.birth_date, 'YY-MM-DD') || ''', ''YYYY-MM-DD''), ''P'', ''HGU ' || to_char(SYSDATE, 'YYYY-MM-DD') || ''', ''WAITING'');' AS "SQL1"
  FROM tmp_addresses_w_names A
 WHERE A.birth_date < to_date('1912-01-01', 'YYYY-MM-DD')
   AND A.comp_reg_id IS NOT NULL
   AND LENGTH(A.comp_reg_id) = 11
;


DELETE
  FROM tmp_addresses_w_names A
 WHERE A.birth_date IS NULL
;