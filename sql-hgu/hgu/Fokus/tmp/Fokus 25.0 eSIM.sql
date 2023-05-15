desc TMDREFTEST_B.SIM_TYPE;

desc SERIAL_ITEM_INV;

select a.owner, a.table_name, a.column_name
     , a.data_type, a.data_length, a.nullable
  from all_tab_columns a
 where a.column_name IN ('MATCHING_ID', 'SIM_TYPE')
order by 1,2
;

select a.*
  from all_tables a
 where a.table_name = 'SIM_TYPE'
order by 1,2
;

SELECT pd.ban, pd.subscriber_no, pd.imsi, pd.equipment_no, pd.equipment_level,
       pd.effective_date, pd.expiration_date
  FROM physical_device pd
 WHERE 1 = 1
   --AND pd.imsi IN ('242029004825376')
   --AND pd.imsi like ( '%8001311')
   AND pd.customer_id = 131469504
   --AND pd.subscriber_no in ('GSM04792653600')
   AND (pd.expiration_date IS NULL OR pd.expiration_date > SYSDATE - 1)
   --AND pd.imsi in ()
   AND ROWNUM < 20
 ;
 
 /*
BAN       SUB                 IMSI            EQUIP_ID                EFF_DATE
131469504   GSM04740604873      242029003834568 08947080026017039720    1   2011-08-22 12:37    
131469504   GSM04740604873      242029003834569 08947080026017039738    0   2011-10-13 11:22    
131469504   GSM04740623799      242029003826181 08947080026016955850    1   2011-11-23 14:33    
131469504   GSM04740623799      242029003834570 08947080026017039746    0   2011-12-07 12:33    
131469504   GSM04740627568      242029004069718 08947080026019340027    1   2011-12-08 13:22    
131469504   GSM04745495157      242029003834571 08947080026017039753    1   2011-11-30 10:27    
131469504   GSM047580009901708  242029003826183 08947080026016955876    1   2011-08-26 10:23    
*/

select a.*
  from serial_item_inv a
 where a.serial_number in (
  '08947080026017039720', '08947080026017039738'
, '08947080026016955850', '08947080026017039746'
, '08947080026019340027', '08947080026017039753'
 );
 
select a.owner, a.table_name, a.column_name
     , a.data_type, a.data_length, a.nullable
  from all_tab_columns a
 where a.column_name IN ('SIM_TYPE', 'SIM_TYPE_ID')
   and a.owner       IN ('NTCTAPP12', 'TMDREFTEST_B')
order by 1,2;

select a.*
  from TMDREFTEST_B.sim_type a
order by 1,2
;

select a.owner, a.table_name, a.column_name
     , a.data_type, a.data_length, a.nullable
  from all_tab_columns a
 where a.table_name  IN ('SIM_TYPE')
   and a.column_name IN ('SIM_CARD_SIZE')
--   and a.owner       IN ('NTCTAPP12', 'TMDREFTEST_B')
order by 1,2;

select a.*
  from serial_item_inv a
 where 1 = 1
   and nvl(a.sim_type, 'N/A') != 'N/A'
   and rownum < 3
;

select a.*
  from all_tab_columns a
 where rownum < 3
;

select a.*
  from sim_type a
 --where NVL(a.pki_ind, 'N') != 'N'
order by 1
;

select siv.*
  from serial_item_inv siv
 where siv.sys_creation_date > sysdate - 30
;

select siv.*
  from serial_item_inv siv
 where siv.serial_number in (
    '08947080001200000000'
  , '08947080001200000110'
  , '08947080001200000128'
  , '08947080001200000136'
  , '08947080001200000144'
  , '08947080001200000151'
  , '08947080001200000169'
  , '08947080001200000177'
  , '08947080001200000185'
  , '08947080001200000193'
);

SELECT LENGTH(TRIM(siv.matching_id)) AS "LEN_MATCHING_ID"
     , LENGTH(TRIM(siv.sim_type))    AS "LEN_SIM_TYPE"
     , COUNT(1) AS "COUNT"
  FROM serial_item_inv siv
 WHERE siv.serial_number In (
      '08947080001200000000', '08947080001200000110'
    , '08947080001200000128', '08947080001200000136'
    , '08947080001200000144', '08947080001200000151'
    , '08947080001200000169', '08947080001200000177'
    , '08947080001200000185', '08947080001200000193'
  )
GROUP BY LENGTH(TRIM(siv.matching_id)), LENGTH(TRIM(siv.sim_type))
ORDER BY 1, 2;


select a.owner, a.table_name, a.column_name
     , a.data_type, a.data_length, a.nullable
  from all_tab_columns a
 where a.column_name IN ('MATCHING_ID')
   and a.owner       IN ('NTCTAPP12', 'TMDREFTEST_B')
order by 1,2;

SELECT NVL(a.sim_card_size, 'N/A') AS "SIM_CARD_SIZE", COUNT(1) AS "COUNT"
  FROM sim_type a
GROUP BY NVL(a.sim_card_size, 'N/A')
ORDER BY 1;

SELECT NVL(st.pki_ind, 'N/A') AS "PKI_IND"
     , COUNT(1) AS "COUNT"
  FROM sim_type st
GROUP BY st.pki_ind
ORDER BY 1;

SELECT NVL(siv.sim_type, 'N/A') AS "SIM_TYPE"
     , COUNT(1) AS "COUNT"
  FROM serial_item_inv siv
GROUP BY NVL(siv.sim_type, 'N/A')
ORDER BY 1;  

SELECT st.sim_type_id AS "SIM_TYPE"
     , NVL(siv.sim_type, 'N/A') AS "SERIAL_ITEM_INV"
     , COUNT(1) AS "COUNT"
  FROM sim_type st, serial_item_inv siv
 WHERE st.sim_type_id = siv.sim_type(+)
GROUP BY st.sim_type_id, siv.sim_type
ORDER BY 1, 2;

SELECT ai.table_owner, ai.table_name, ai.index_name, ai.uniqueness
  FROM all_indexes ai
 WHERE ai.table_owner = 'NTCTAPP12'
   AND ai.table_name  = 'SERIAL_ITEM_INV'
ORDER BY 1,2,3;

SELECT uic.*
  FROM user_ind_columns uic
 WHERE uic.table_name = 'SERIAL_ITEM_INV'
ORDER BY 1,2,4,3;

SELECT siv.serial_number, siv.item_id, siv.sim_type, siv.matching_id
  FROM serial_item_inv siv
 WHERE siv.serial_number = '08947080001200000000'
;

SELECT pd.customer_id, pd.subscriber_no, pd.equipment_no, pd.device_type
     , siv.item_id, siv.sim_type, siv.matching_id
  FROM physical_device pd, serial_item_inv siv
 WHERE pd.expiration_date   IS NULL
   AND pd.equipment_level   = '1'
   AND pd.sys_creation_date BETWEEN TO_DATE('2016-10-01', 'YYYY-MM-DD') AND TO_DATE('2016-10-20', 'YYYY-MM-DD')
   AND pd.equipment_no      = siv.serial_number(+)
ORDER BY 1,2,3;




