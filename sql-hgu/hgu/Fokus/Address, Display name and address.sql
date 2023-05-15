--==
--== Displays the (user) address(es).
--== NB! BAN needs to be used, due to indexes!
--==
SELECT a.ban, a.subscriber_no, a.link_type, a.birth_date,
       b.comp_reg_id, b.first_name, b.last_business_name, b.additional_title,
       c.adr_primary_ln, c.adr_secondary_ln, c.adr_email, a.sys_creation_date
  FROM address_name_link a, name_data b, address_data c
 WHERE a.ban           IN ( 683396303 )
   AND a.subscriber_no IN ('GSM047'||'93855173', '0000000000')
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.name_id       = b.name_id
   AND a.address_id    = c.address_id
ORDER BY a.ban, a.subscriber_no, a.link_type
;

SELECT *
  FROM
(
    SELECT anl.ban, anl.subscriber_no, s.sub_status, anl.link_type, anl.birth_date,
           nd.comp_reg_id, nd.first_name, nd.last_business_name, ad.adr_street_name,
           ad.adr_house_no, ad.adr_zip, anl.adr_city, ad.adr_email,
           anl.effective_date, anl.expiration_date
      FROM address_name_link anl, name_data nd, address_data ad, subscriber s
     WHERE anl.ban           = s.customer_id
       AND anl.subscriber_no = s.subscriber_no
       AND s.sub_status     IN ('A', 'R', 'S', 'C')
       AND s.subscriber_no  IN (
             'GSM04740103338',
             'GSM04740016967'
       )
       AND SYSDATE     BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
       AND anl.name_id         = nd.name_id
       AND anl.address_id      = ad.address_id
UNION
    SELECT anl.ban, anl.subscriber_no, s.sub_status, anl.link_type, anl.birth_date,
           nd.comp_reg_id, nd.first_name, nd.last_business_name, ad.adr_street_name,
           ad.adr_house_no, ad.adr_zip, anl.adr_city, ad.adr_email,
           anl.effective_date, anl.expiration_date
      FROM address_name_link anl, name_data nd, address_data ad, subscriber s
     WHERE anl.ban           = s.customer_id
       AND anl.subscriber_no = '0000000000'
       AND s.sub_status     IN ('A', 'R', 'S', 'C')
       AND s.subscriber_no  IN (
             'GSM04740103338',
             'GSM04740016967'
       )
       AND SYSDATE     BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
       AND anl.name_id         = nd.name_id
       AND anl.address_id      = ad.address_id
)
ORDER BY 1, 2, 3
;

SELECT anl.ban, anl.subscriber_no, s.sub_status, anl.link_type, anl.birth_date,
       nd.comp_reg_id, nd.first_name, nd.last_business_name, ad.adr_street_name,
       ad.adr_house_no, ad.adr_zip, anl.adr_city, ad.adr_email,
       anl.effective_date, anl.expiration_date
  FROM address_name_link anl, name_data nd, address_data ad, subscriber s
 WHERE anl.ban           = s.customer_id
   AND anl.subscriber_no = s.subscriber_no
   AND s.sub_status     IN ('A', 'R', 'S', 'C')
   AND s.subscriber_no  IN (
         'GSM04740007843',
         'GSM04740028458',
         'GSM04740057804',
         'GSM04740090743',
         'GSM04740095388',
         'GSM04740102127',
         'GSM04740102956',
         'GSM04740103737',
         'GSM04740146938',
         'GSM04740149662'
   )
   AND SYSDATE     BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id         = nd.name_id
   AND anl.address_id      = ad.address_id
ORDER BY anl.subscriber_no, s.sub_status, anl.link_type
;

--==
--== Displays the (user) address(es), via DB-link.
--== NB! BAN needs to be used, due to indexes!
--==
SELECT a.ban, a.subscriber_no, a.link_type, a.birth_date,
       b.comp_reg_id, b.first_name, b.last_business_name, b.additional_title,
       c.adr_primary_ln, c.adr_secondary_ln, c.adr_email --, b.*
  FROM address_name_link@fokus a, name_data@fokus b, address_data@fokus c
 WHERE a.ban           = 648549806 
   AND a.subscriber_no = '0000000000'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.name_id       = b.name_id
   AND a.address_id    = c.address_id
ORDER BY a.ban, a.subscriber_no, a.link_type
;

SELECT a.ban, a.subscriber_no, a.link_type, a.birth_date,
       b.comp_reg_id, b.first_name, b.last_business_name, b.additional_title,
       c.adr_primary_ln, c.adr_secondary_ln, c.adr_email, a.sys_creation_date
       , c.*
  FROM address_name_link@fokus a, name_data@fokus b, address_data@fokus c
 WHERE a.ban           IN ( 683396303 )
   AND a.subscriber_no IN ('GSM047'||'93855173', '0000000000')
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.name_id       = b.name_id
   AND a.address_id    = c.address_id
ORDER BY a.ban, a.subscriber_no, a.link_type
;

SELECT 
      --a.*, b.*, c.*
      --b.*
      c.*
  FROM address_name_link@fokus a, name_data@fokus b, address_data@fokus c
 WHERE a.ban           = 491783908 
   AND a.subscriber_no = 'GSM047580009224246'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.name_id       = b.name_id
   AND a.address_id    = c.address_id
ORDER BY a.ban, a.subscriber_no, a.link_type
;
