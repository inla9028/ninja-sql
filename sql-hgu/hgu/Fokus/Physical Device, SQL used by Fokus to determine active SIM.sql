SELECT /*+ driving_site(pd1)*/ pd1.*
  FROM physical_device@fokus pd1, serial_item_inv@fokus sinv, item_definition@fokus itdf, manufacturer@fokus manf
 WHERE pd1.customer_id             = 743317414
   AND pd1.subscriber_no           = 'GSM04793489693'
   AND TRUNC (pd1.expiration_date) = TRUNC(SYSDATE) -- TO_DATE ('20180626', 'YYYYMMDD')
   AND pd1.expiration_date         = (SELECT MAX (pd2.expiration_date)
                                        FROM physical_device@fokus pd2
                                       WHERE pd2.customer_id             = pd1.customer_id
                                         AND pd2.subscriber_no           = pd1.subscriber_no
                                         AND TRUNC (pd2.expiration_date) = TRUNC (pd1.expiration_date)
                                         AND pd2.equipment_level         = pd1.equipment_level)
   /* Note: A comparison is made on Serial_Number and Unit_ESN which
      are not of the same domain although they have the same size */
   AND sinv.serial_number          = pd1.equipment_no
   AND itdf.item_id                = sinv.item_id
   AND manf.manf_cd                = itdf.manf_cd
;


SELECT pd1.*
  FROM physical_device pd1, serial_item_inv sinv, item_definition itdf, manufacturer manf
 WHERE pd1.customer_id             = 743317414
   AND pd1.subscriber_no           = 'GSM04793489693'
   AND TRUNC (pd1.expiration_date) = TRUNC(SYSDATE) -- TO_DATE ('20180626', 'YYYYMMDD')
   AND pd1.expiration_date         = (SELECT MAX (pd2.expiration_date)
                                        FROM physical_device pd2
                                       WHERE pd2.customer_id             = pd1.customer_id
                                         AND pd2.subscriber_no           = pd1.subscriber_no
                                         AND TRUNC (pd2.expiration_date) = TRUNC (pd1.expiration_date)
                                         AND pd2.equipment_level         = pd1.equipment_level)
   /* Note: A comparison is made on Serial_Number and Unit_ESN which
      are not of the same domain although they have the same size */
   AND sinv.serial_number          = pd1.equipment_no
   AND itdf.item_id                = sinv.item_id
   AND manf.manf_cd                = itdf.manf_cd
 ;

