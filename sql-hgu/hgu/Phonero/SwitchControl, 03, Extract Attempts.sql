SELECT a.srv_trx_s_no,  a.issuing_date_time, a.sys_creation_date,
       a.srv_trx_tp_cd, a.user_id, a.tn, a.imsi, a.hlr_id,
       a.srv_sts_cd, a.err_cd, a.complete_date_time, a.err_date_time
  FROM ntcappo.srv_trx_repos a
 WHERE a.tn IN (
       '047' || '48899152'
     , '047' || '48898671'
 )
;

-- A poor test...
SELECT a.srv_trx_s_no,  a.issuing_date_time, a.sys_creation_date,
       a.srv_trx_tp_cd, a.user_id, a.tn, a.imsi, a.hlr_id,
       a.srv_sts_cd, a.err_cd, a.complete_date_time, a.err_date_time
  FROM ntcappo.srv_trx_repos a
 WHERE /*a.user_id = '402304'
   AND */a.srv_trx_s_no BETWEEN 117270500 AND 117270540 -- Should hit rows 117270503 & 117270537
   AND ROWNUM < 101
;

SELECT a.srv_trx_s_no,  a.issuing_date_time, a.sys_creation_date,
       a.srv_trx_tp_cd, a.user_id, a.tn, a.imsi, a.hlr_id,
       a.srv_sts_cd, a.err_cd, a.complete_date_time, a.err_date_time
  FROM ntcappo.srv_trx_repos a
 WHERE a.srv_trx_s_no BETWEEN 117270500 AND 117270540
   AND ROWNUM < 101
;
