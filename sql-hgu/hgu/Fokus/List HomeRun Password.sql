--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the password for a given subscriber.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUBSTR (convrs_script,
               INSTR (convrs_script, 'MSISDN><PASSWORD>', 1, 1) + 17,
               8
              ) AS PASSWORD
  FROM dvc_trx_repos@prod
 WHERE phd_id         = 'Wlan'
   AND dvc_trx_nm_cd IN ('HRADD', 'HRMAD', 'HRRST')
   AND tn             = '04746440001' --==--==--==--== Subscriber goes here...
   AND dvc_trx_sts_cd = 'CS'
   AND srv_trx_s_no   =
          (SELECT MAX (srv_trx_s_no)
             FROM dvc_trx_repos@prod
            WHERE phd_id         = 'Wlan'
              AND dvc_trx_nm_cd IN ('HRADD', 'HRMAD', 'HRRST')
              AND tn             = '04746440001' --==--==--==--== ...and here.
              AND dvc_trx_sts_cd = 'CS')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the phd_id's available for a specific user.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.tn, a.phd_id, COUNT(*) AS "COUNT"
    FROM dvc_trx_repos@prod a
   WHERE a.tn = '04746440001'
GROUP BY a.tn, a.phd_id
ORDER BY a.tn, a.phd_id;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the rows where phd_id indicates a Wireless Office.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.phd_id, a.dvc_trx_nm_cd, a.dvc_trx_sts_cd, a.srv_trx_s_no,
       SUBSTR(convrs_script, INSTR(convrs_script, 'MSISDN><PASSWORD>', 1, 1) + 17, 8) AS "PASSWORD",
       a.convrs_script
    FROM dvc_trx_repos@prod a
   WHERE a.tn     = '04746440001'
     AND a.phd_id = 'Wlan';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the row(s) where phd_id indicates a Wireless Office.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.*
    FROM dvc_trx_repos@prod a
   WHERE a.tn     = '04746440001'
     AND a.phd_id = 'Wlan';

