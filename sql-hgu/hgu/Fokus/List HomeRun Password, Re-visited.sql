--
-- Check towards the "new" table...
--
select substr(convrs_script,instr(convrs_script,'MSISDN><PASSWORD>',1,1)+17,8) AS PASSWORD
   from dvc_trx_repos
  where phd_id = 'Wlan'
    and dvc_trx_nm_cd in ('HRADD','HRMAD','HRRST')
    and tn = '047' || '45465500'
    and dvc_trx_sts_cd = 'CS'
    and srv_trx_s_no = (select max(srv_trx_s_no) from dvc_trx_repos
        where phd_id = 'Wlan'
          and dvc_trx_nm_cd in ('HRADD','HRMAD','HRRST')
          and tn = '047' || '45465500'
          and dvc_trx_sts_cd = 'CS'
    )
;


--
-- Check towards the archive table...
--
select substr(convrs_script,instr(convrs_script,'MSISDN><PASSWORD>',1,1)+17,8) AS PASSWORD
   from dvc_trx_repos_save
  where phd_id = 'Wlan'
    and dvc_trx_nm_cd in ('HRADD','HRMAD','HRRST')
    and tn = '047' || '45465500'
    and dvc_trx_sts_cd = 'CS'
    and srv_trx_s_no = (
       select max(srv_trx_s_no)
         from dvc_trx_repos_save
        where phd_id = 'Wlan'
          and dvc_trx_nm_cd in ('HRADD','HRMAD','HRRST')
          and tn = '047' || '45465500'
          and dvc_trx_sts_cd = 'CS'
    )
;