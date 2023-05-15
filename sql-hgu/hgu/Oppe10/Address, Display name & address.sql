--==
--== Displays the (user) address(es).
--== NB! BAN needs to be used, due to indexes!
--==
SELECT a.ban, a.subscriber_no, a.link_type,
       b.first_name, b.last_business_name, b.birth_date, 
       c.adr_primary_ln, c.adr_secondary_ln, c.adr_email
  FROM address_name_link a, name_data b, address_data c
  WHERE a.ban           = 994608503
--    AND a.subscriber_no = 'GSM04798456107'
    AND SYSDATE         < NVL(a.expiration_date, SYSDATE + 1)
    AND a.name_id       = b.name_id
    AND a.address_id    = c.address_id
  ORDER BY a.ban, a.subscriber_no, a.link_type

