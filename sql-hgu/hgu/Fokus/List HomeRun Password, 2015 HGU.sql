SELECT MAX(SUBSTR(convrs_script, INSTR(convrs_script, 'username><ns2:password>', 1, 1) + 23, 8))  AS "PASSWORD"
  FROM dvc_trx_repos_save
 WHERE phd_id             = 'soho'
   AND dvc_trx_nm_cd NOT IN ('SHDEL')
   AND tn                 = '04748994603'
   AND dvc_trx_sts_cd     = 'CS'
   AND srv_trx_s_no       = (SELECT MAX(srv_trx_s_no)
                               FROM dvc_trx_repos_save
                              WHERE phd_id         = 'soho'
                                AND dvc_trx_nm_cd  NOT IN ('SHDEL')
                                AND tn             = '04748994603'
                                AND dvc_trx_sts_cd = 'CS')
;

-- DB-link...
-- final String sTableName = useHistoryTable ? "dvc_trx_repos_save" : "dvc_trx_repos";

SELECT MAX(SUBSTR(a.convrs_script, INSTR(a.convrs_script, 'username><ns2:password>', 1, 1) + 23, 8)) AS "PASSWORD"
  FROM dvc_trx_repos_save@fokus a
 WHERE a.phd_id             = 'soho'
   AND a.dvc_trx_nm_cd NOT IN ('SHDEL')
   AND a.tn                 = '04748994603'
   AND a.dvc_trx_sts_cd     = 'CS'
   AND a.srv_trx_s_no       = (SELECT MAX(srv_trx_s_no)
                               FROM dvc_trx_repos_save@fokus b
                              WHERE b.phd_id         = 'soho'
                                AND b.dvc_trx_nm_cd  NOT IN ('SHDEL')
                                AND b.tn             = '04748994603'
                                AND b.dvc_trx_sts_cd = 'CS')
;

SELECT a.*
  FROM dvc_trx_repos_save@fokus a
 WHERE a.phd_id             = 'soho'
   AND a.dvc_trx_nm_cd NOT IN ('SHDEL')
   AND a.tn                 = '04748994603'
   AND a.dvc_trx_sts_cd     = 'CS'
   AND a.srv_trx_s_no       = (SELECT MAX(srv_trx_s_no)
                               FROM dvc_trx_repos_save@fokus b
                              WHERE b.phd_id         = 'soho'
                                AND b.dvc_trx_nm_cd  NOT IN ('SHDEL')
                                AND b.tn             = '04748994603'
                                AND b.dvc_trx_sts_cd = 'CS')
;
