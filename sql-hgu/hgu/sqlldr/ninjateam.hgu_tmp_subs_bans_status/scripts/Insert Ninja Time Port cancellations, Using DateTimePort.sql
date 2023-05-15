SELECT a.*
  FROM ninjadata.ninja_time_port a
 WHERE a.date_time_port BETWEEN TO_DATE('2017-01-01','YYYY-MM-DD') AND SYSDATE
   AND a.action         = 'CANC'
   AND a.ninja_action   = 'CANCEL'
   AND a.status         = 'PRSD_SUCCESS'
;

INSERT INTO hgu_tmp_subs_bans_status
SELECT a.ban
     , NULL AS "ACC_TYPE", NULL AS "ACC_SUB_TYPE"
     , 'GSM'||a.ctn AS "SUBSCRIBER_NO"
     , NULL AS "SUB_STATUS"
     , s.dealer_code
     , a.date_time_port
     , NULL AS "SUB_STATUS_DATE"
  FROM ninjadata.ninja_time_port           a,
       ninjaconfig.service_providers       s
 WHERE a.date_time_port BETWEEN TO_DATE('2017-01-01','YYYY-MM-DD') AND SYSDATE
   AND a.action         = 'CANC'
   AND a.ninja_action   = 'CANCEL'
   AND a.user_id        = s.service_provider_code(+)
;

COMMIT WORK
;
