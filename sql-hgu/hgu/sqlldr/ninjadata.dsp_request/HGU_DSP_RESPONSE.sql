SELECT a.request_user_id AS "ACCOUNT_IDS",
       a.dsp_id AS "PERSON_ID",
       DECODE(a.adr_birth_date,
              '',   '',
              NULL, '',
              SUBSTR(a.adr_birth_date, 0, 4) || '-' || SUBSTR(a.adr_birth_date, 5, 2) || '-' || SUBSTR(a.adr_birth_date, 7, 2)
       ) AS "ADR_BIRTH_DATE",
       a.adr_first_name, a.adr_last_name, a.adr_house_no, a.adr_street_name, a.adr_pob, 
       a.adr_house_letter, a.adr_storey, a.adr_door_no, a.adr_district,
       a.adr_zip, a.adr_city, a.adr_country,
       a.adr_gender, a.adr_stat, a.process_status,
       DECODE(a.process_status, 'PRSD_SUCCESS', '', a.status_desc) AS "STATUS_DESC"
  FROM hgu_dsp_response a
