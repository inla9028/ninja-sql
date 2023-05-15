SELECT a.print_category, a.sys_creation_date, a.sys_update_date,
       a.operator_id, a.application_id, a.dl_service_code,
       a.dl_update_stamp, a.print_cat_priority, a.bill_print_ind,
       a.csm_select_ind, a.inspector_user_id, a.print_cat_desc
  FROM ntcrefwork.print_categories a
 WHERE a.csm_select_ind = 'Y'
ORDER BY a.print_category
;

SELECT a.print_category, a.bill_print_ind, a.csm_select_ind, a.print_cat_desc
  FROM ntcrefwork.print_categories a
 WHERE a.csm_select_ind = 'Y'
ORDER BY a.print_category
;
