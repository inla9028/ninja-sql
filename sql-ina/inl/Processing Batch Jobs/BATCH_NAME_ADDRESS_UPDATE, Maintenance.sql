SELECT a.transaction_number, a.link_type, a.ban_no, a.subscriber_no,
       a.last_business_name, a.first_name, a.birth_date, a.adr_city,
       a.adr_zip, a.adr_house_no, a.adr_street_name, a.adr_pob,
       a.adr_district, a.adr_country, a.adr_house_letter, a.adr_storey,
       a.adr_door_no, a.adr_gender, a.allow_advertising_ind,
       a.adr_home_phone, a.email_addr, a.adr_listed_ind,
       a.publish_level, a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.request_user_id,
       a.role_ind, a.company_id, a.adr_co_name, a.dsp_ind,
       a.additional_title
  FROM batch_name_address_update a
  where request_user_id='MHN 31.03.2011'
  and record_creation_date > sysdate -1
  and a.process_status='PRSD_ERROR'
  
  SELECT a.process_status, COUNT(*) AS "Count", substr(COUNT(*)/60/60, 0, 6) AS "Hours, or", 
       SUBSTR(COUNT(*)/60, 0, 6) AS "Minutes"
  FROM ninjadata.batch_name_address_update a
  WHERE a.request_user_id IN ('MHN 31.03.2011')
  and record_creation_date > sysdate -1
  GROUP BY a.process_status
  ORDER BY a.process_status

SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
FROM batch_name_address_update a
  where request_user_id='MHN 31.03.2011'
  and process_status='PRSD_ERROR'
  ORDER BY a.status_desc
