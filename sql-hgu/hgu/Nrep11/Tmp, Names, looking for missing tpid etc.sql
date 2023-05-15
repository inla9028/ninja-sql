select ba.account_type, anl.customer_id, anl.subscriber_no, anl.link_type, anl.name_id
     , nd.first_name, nd.last_business_name, nd.tpid, length(nd.tpid) AS "TPID_LEN"
  from billing_account   ba 
     , address_name_link anl
     , name_data         nd
 where ba.account_type  IN ( 'B' )
   and ba.ban_status    IN ( 'O' )
   and anl.ban          = ba.ban
   and SYSDATE          BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
   and anl.link_type    IN ( 'B', 'L', 'U' )
   and nd.name_id       = anl.name_id
   and nd.name_format   = 'P'
   and (nd.tpid         is null
     or length(nd.tpid) not in ( 36 ))
   AND nd.first_name    NOT IN ( ',', '.' )
   AND nd.last_business_name NOT IN ( ',', '.' )
and rownum < 21
;