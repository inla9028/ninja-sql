--
-- Replace....
--
SELECT t.subscriber_no
     , t.soc     AS "SOC_OLD", m1.sp_code AS "SPM_SERVICE_OLD"
     , t.new_soc AS "SOC_NEW", m2.sp_code AS "SPM_SERVICE_NEW"
     , t.request_time, t.process_time, t.process_status
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (t.status_desc,
                           0,
                           INSTR (t.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (t.status_desc,
                               0,
                               INSTR (t.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM master_transactions                t
     , spm_service_mapping                m1
     , spm_service_mapping                m2
     , socs                               s1
     , socs                               s2
 WHERE t.request_id         = 'Chili 2021-09-30'
   AND t.soc                = s1.soc
   AND s1.soc_type          = m1.soc_type
   AND s1.soc_group         = m1.soc_group
   AND t.new_soc            = s2.soc
   AND s2.soc_type          = m2.soc_type
   AND s2.soc_group         = m2.soc_group
ORDER BY t.process_status, t.subscriber_no, "STATUS_DESC"
;



SELECT t.request_id
     , t.soc     AS "SOC_OLD", m1.sp_code AS "SPM_SERVICE_OLD"
     , t.new_soc AS "SOC_NEW", m2.sp_code AS "SPM_SERVICE_NEW"
     , t.process_status, COUNT(*) AS "COUNT"
  FROM master_transactions                t
     , spm_service_mapping                m1
     , spm_service_mapping                m2
     , socs                               s1
     , socs                               s2
 WHERE t.request_id         = 'Chili 2021-09-30'
   AND t.soc                = s1.soc
   AND s1.soc_type          = m1.soc_type(+)
   AND s1.soc_group         = m1.soc_group(+)
   AND t.new_soc            = s2.soc(+)
   AND s2.soc_type          = m2.soc_type(+)
   AND s2.soc_group         = m2.soc_group(+)
GROUP BY t.request_id, t.soc, t.soc, m1.sp_code, t.new_soc, m2.sp_code, t.process_status
ORDER BY t.request_id, t.soc, t.soc, m1.sp_code, t.new_soc, m2.sp_code, t.process_status
;

--
-- Add or modify....
--
SELECT t.subscriber_no, t.soc, m.sp_code AS "SPM_SERVICE"
     , t.request_time, t.process_time, t.process_status
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (t.status_desc,
                           0,
                           INSTR (t.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (t.status_desc,
                               0,
                               INSTR (t.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM master_transactions t
     , spm_service_mapping m
     , socs                s
 WHERE t.request_id = 'Chili 2021-09-30'
   AND t.soc        = s.soc
   AND s.soc_type   = m.soc_type
   AND s.soc_group  = m.soc_group
ORDER BY t.process_status, t.subscriber_no, "STATUS_DESC"
;


SELECT t.request_id, t.action_code, t.soc, m.sp_code AS "SPM_SERVICE", t.process_status, COUNT(*) AS "COUNT"
  FROM master_transactions t
     , spm_service_mapping m
     , socs                s
 WHERE t.request_id IN ( 'Chili 2021-09-30' )
   AND t.soc        = s.soc
   AND s.soc_type   = m.soc_type
   AND s.soc_group  = m.soc_group
GROUP BY t.request_id, t.action_code, t.soc, m.sp_code, t.process_status
ORDER BY t.request_id, t.action_code, t.soc, m.sp_code, t.process_status
;