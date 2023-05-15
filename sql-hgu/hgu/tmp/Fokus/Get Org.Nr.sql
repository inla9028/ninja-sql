SELECT a.name_id, a.sys_creation_date, a.sys_update_date, a.operator_id,
       a.application_id, a.dl_service_code, a.dl_update_stamp,
       a.control_name, a.last_business_name, a.first_name,
       a.additional_title, a.name_format, a.birth_date, a.identify,
       a.id_type, a.comp_reg_id, a.kob, a.middle_initial,
       a.telemarket_id, a.conv_run_no, a.name_title_salutation,
       a.nationality_cd, a.gender, a.marital_status, a.role_ind
  FROM ntcappo.name_data a
  WHERE '884026172' IN (a.identify, a.comp_reg_id)

--
SELECT a.identify, COUNT(*) AS "COUNT"
  FROM ntcappo.name_data a
  WHERE a.identify IS NOT NULL
  GROUP BY a.identify
  ORDER BY a.identify


