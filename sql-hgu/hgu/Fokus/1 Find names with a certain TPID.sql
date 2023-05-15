SELECT /*+ driving_site(anl)*/
       anl.ban, decode(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
     , anl.link_type, anl.birth_date, nd.tpid, nd.comp_reg_id, nd.e_faktura_ref
     , nd.first_name, nd.last_business_name, nd.additional_title
     , nd.name_format, nd.role_ind
     , nd.id_type, nd.identify, nd.name_id
     , anl.effective_date
  FROM address_name_link@fokus anl
     , name_data@fokus         nd
 WHERE nd.tpid        IN ( '7fbadcfc-7f84-49d5-b6a7-3ee7748aed4f' )
   AND nd.name_id     = anl.name_id
   AND TRUNC(SYSDATE) BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
ORDER BY anl.ban, decode(anl.link_type, 'C', 0, 'L', 1, 'B', 2, 'U', 3, 4), anl.subscriber_no
;
