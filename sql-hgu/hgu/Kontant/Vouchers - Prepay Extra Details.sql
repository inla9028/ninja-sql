SELECT ped_id, ped_code, phone_no, product_type, product_name, free_amount
     , sys_creation_date, sys_update_date, created_by, valid_from, valid_to
     , gen_id, gen_id_type, trans_id
  FROM prepay_extra_details
 WHERE phone_no IN ( '047' || '93493065', '47' || '93493065', '93493065' );


SELECT ped_id, ped_code, phone_no, product_type, product_name, free_amount
     , sys_creation_date, sys_update_date, created_by, valid_from, valid_to
     , gen_id, gen_id_type, trans_id
  FROM prepay_extra_details
 WHERE sys_creation_date BETWEEN TRUNC(SYSDATE) AND SYSDATE
   AND created_by = 'Ninja'
;

UPDATE prepay_extra_details
   SET phone_no                = SUBSTR(phone_no, 2)
     , gen_id                  = SUBSTR(gen_id, 2)
 WHERE sys_creation_date BETWEEN TRUNC(SYSDATE) AND SYSDATE
   AND created_by              = 'Ninja'
   AND phone_no             LIKE '+%'
   AND gen_id               LIKE '+%'
;