/*
** Simply list the column NAME_DATA.IDENTIFY using the BAN number
*/
SELECT UNIQUE t1.ban, nd.identify AS "ORG_NUMBER"
  FROM tmp_hgu_ftr_current t1, address_name_link@fokus anl, name_data@fokus nd
 WHERE 1 = 1 
--   AND t1.ban = 471891705
   AND t1.ban = anl.ban
   AND SYSDATE BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1000)
   AND anl.link_type = 'L'
   AND anl.name_id = nd.name_id
ORDER BY nd.identify
;

