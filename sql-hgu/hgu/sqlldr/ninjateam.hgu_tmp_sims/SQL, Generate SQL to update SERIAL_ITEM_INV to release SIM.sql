SELECT 'UPDATE serial_item_inv sii
   SET sii.application_id  = ''PK'',
       sii.item_ownership  = ''D'',
       sii.curr_possession = ''N''
 WHERE sii.serial_number   = '''|| a.sim_number || '''
   AND sii.serial_number NOT IN(SELECT DISTINCT pd.equipment_no
                                  FROM physical_device pd
                                 WHERE pd.equipment_no    = '''|| a.sim_number || '''
                                   AND pd.expiration_date IS NULL)
;

COMMIT;

' AS SQL
  FROM ninjateam.hgu_tmp_sims a
ORDER BY 1
;
