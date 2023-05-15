-- Main table
SELECT MAX(SUBSTR(convrs_script, INSTR(convrs_script, 'username><ns2:password>', 1, 1) + 23, 8))  AS "Password"
  FROM dvc_trx_repos
WHERE phd_id = 'soho'
   AND dvc_trx_nm_cd not in ('SHDEL')
   AND tn = '04740704070'
   AND dvc_trx_sts_cd = 'CS'
   AND srv_trx_s_no = (SELECT MAX(srv_trx_s_no)
                         FROM dvc_trx_repos
                        WHERE phd_id = 'soho'
                          AND dvc_trx_nm_cd NOT IN ('SHDEL')
                          AND tn = '04740704070'
                          AND dvc_trx_sts_cd = 'CS')
;

-- Archive table
SELECT MAX(SUBSTR(convrs_script, INSTR(convrs_script, 'username><ns2:password>', 1, 1) + 23, 8))  AS "Password"
  FROM dvc_trx_repos_save
WHERE phd_id = 'soho'
   AND dvc_trx_nm_cd not in ('SHDEL')
   AND tn = '04740704070'
   AND dvc_trx_sts_cd = 'CS'
   AND srv_trx_s_no = (SELECT MAX(srv_trx_s_no)
                         FROM dvc_trx_repos_save
                        WHERE phd_id = 'soho'
                          AND dvc_trx_nm_cd NOT IN ('SHDEL')
                          AND tn = '04740704070'
                          AND dvc_trx_sts_cd = 'CS')
;