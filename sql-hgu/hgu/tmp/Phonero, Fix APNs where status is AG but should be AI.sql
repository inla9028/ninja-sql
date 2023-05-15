WITH my_filter AS (SELECT UNIQUE a.subscriber_no FROM ninjateam.hgu_tmp_subs a)
SELECT /*+ driving_site(ri)*/
       sf.subscriber_no, ri.resource_name, ri.resource_number
     , ri.resource_status, ri.last_status_date, sf.ftr_add_sw_prm
  FROM my_filter mf, resources_inv@fokus ri, service_feature@fokus sf
 WHERE ri.last_msisdn         = '047'||mf.subscriber_no
   AND ri.resource_name       = 'ok.m2m'
   AND sf.subscriber_no       = 'GSM'||ri.last_msisdn
   AND sf.ftr_expiration_date > SYSDATE
   AND sf.soc                 = 'M2MAPN4'
   AND sf.feature_code        = 'S-M2A1'
   AND sf.ftr_add_sw_prm   LIKE '%IP='||ri.resource_number||'@%'
ORDER BY 1
;

WITH my_filter AS (SELECT UNIQUE a.subscriber_no FROM ninjateam.hgu_tmp_subs a)
SELECT /*+ driving_site(ri)*/
       'UPDATE resources_inv@fokus SET resource_status = ''AI'' WHERE ROWID = ''' || ri.rowid || ''';' AS "SQL"
  FROM my_filter mf, resources_inv@fokus ri, service_feature@fokus sf
 WHERE ri.last_msisdn         = '047'||mf.subscriber_no
   AND ri.resource_name       = 'ok.m2m'
   AND sf.subscriber_no       = 'GSM'||ri.last_msisdn
   AND sf.ftr_expiration_date > SYSDATE
   AND sf.soc                 = 'M2MAPN4'
   AND sf.feature_code        = 'S-M2A1'
   AND sf.ftr_add_sw_prm   LIKE '%IP='||ri.resource_number||'@%'
   AND ri.resource_status     = 'AG'
UNION
SELECT 'UPDATE ninja_time_port SET status = ''WAITING'', description = NULL, proc_attempts = 0 WHERE ninja_ref_id = ' || ntp.ninja_ref_id || ';' AS "SQL"
  FROM my_filter mf, resources_inv@fokus ri, service_feature@fokus sf, ninja_time_port ntp
 WHERE ri.last_msisdn         = '047'||mf.subscriber_no
   AND ri.resource_name       = 'ok.m2m'
   AND sf.subscriber_no       = 'GSM'||ri.last_msisdn
   AND sf.ftr_expiration_date > SYSDATE
   AND sf.soc                 = 'M2MAPN4'
   AND sf.feature_code        = 'S-M2A1'
   AND sf.ftr_add_sw_prm   LIKE '%IP='||ri.resource_number||'@%'
   AND ri.resource_status     = 'AG'
   AND ntp.ctn                = ri.last_msisdn
   AND ntp.action             = 'MOVE'
   AND ntp.status             = 'PRSD_ERROR'
   AND ntp.description     LIKE '%csMoveCtn00%Current resource status is AG%'
   AND ntp.ninja_ref_id       = (SELECT MAX(ntp2.ninja_ref_id)
                                   FROM ninja_time_port ntp2
                                  WHERE ntp2.ctn = ntp.ctn)
--ORDER BY 1
;

SELECT /*+ driving_site(sf)*/ sf.ftr_add_sw_prm
  FROM service_feature@fokus sf
 WHERE sf.subscriber_no      IN ( 'GSM047'||'48227316' )
   AND sf.ftr_expiration_date > SYSDATE
   AND sf.soc                 = 'M2MAPN4'
   AND sf.feature_code        = 'S-M2A1'
;

SELECT /*+ driving_site(sf)*/
       ri.resource_name, ri.resource_number, ri.resource_status, ri.last_status_date, ri.last_msisdn
  FROM resources_inv@fokus ri
 WHERE ri.resource_name   = 'ok.m2m'
   AND ri.resource_number = '10.60.58.8'
;

SELECT /*+ driving_site(sf)*/
       ri.resource_name, ri.resource_number, ri.resource_status, ri.last_status_date, ri.last_msisdn
  FROM resources_inv@fokus ri
 WHERE ri.resource_name   = 'ok.m2m'
   AND ri.resource_number = '10.60.58.8'
;

select UNIQUE a.*
  from ninjateam.hgu_tmp_subs a
order by 1
;

--delete from ninjateam.hgu_tmp_subs;
