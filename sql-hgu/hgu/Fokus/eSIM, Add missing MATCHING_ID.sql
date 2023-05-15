select siv.*
  from serial_item_inv siv
 where siv.serial_number IN ('08947080041000010646', '08947080041000009648')
;

select siv.serial_number, siv.sys_update_date, siv.matching_id, siv.sim_type
     , rowid
     , '1$at1-samsung.oberthur.net$' || substr(rowid,0,13) AS "ACT_CODE"
  from serial_item_inv siv
 where siv.sim_type = '410'
   and siv.matching_id is null
;

-- 1$at1-samsung.oberthur.net$0GV63WGYQDI6Q
--                            1234567890123
--                            AACCKTAC1AAG4OWAAA
-- 1$at1-samsung.oberthur.net$AACCKTAC1AAG4

update serial_item_inv siv
   set siv.matching_id = '1$at1-samsung.oberthur.net$' || substr(rowid,0,13)
 where siv.sim_type = '410'
   and siv.matching_id is null
;