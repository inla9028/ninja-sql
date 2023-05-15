--
-- Replace....
--
SELECT t.subscriber_no
     , t.add_socs     AS "ADD_SOC", m1.sp_code AS "ADD_SPM_SERVICE"
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
  FROM batch_socs                         t
     , spm_service_mapping                m1
     , socs                               s1
 WHERE t.request_id         = 'HGU 2022-03-01'
   AND t.add_socs           = s1.soc
   AND s1.soc_type          = m1.soc_type
   AND s1.soc_group         = m1.soc_group
ORDER BY t.process_status, t.subscriber_no, "STATUS_DESC"
;

