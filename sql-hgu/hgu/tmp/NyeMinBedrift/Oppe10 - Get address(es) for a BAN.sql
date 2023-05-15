SELECT a.ban, -- OR a.customer_id AS "ban",
       a.link_type,
       a.subscriber_no, 
       b.adr_city,
       b.adr_co_name,
       b.adr_country,
       b.adr_district,
       b.adr_door_no,
       b.adr_email,
       b.adr_house_letter,
       b.adr_house_no,
       b.adr_pob,
       b.adr_status,
       b.adr_story,
       b.adr_street_name,
       b.adr_type,
       b.adr_zip,
       b.co_ind,
       c.first_name,
       c.last_business_name
  FROM dd.address_name_link a, dd.address_data b, dd.name_data c
  WHERE a.address_id = b.address_id
--    AND a.ban        = 430214403
    AND a.customer_id = 430214403
    AND a.name_id     = c.name_id
    AND nvl(a.expiration_date, SYSDATE) > TRUNC(SYSDATE)
