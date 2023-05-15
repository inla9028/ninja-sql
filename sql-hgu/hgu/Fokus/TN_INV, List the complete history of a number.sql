SELECT * FROM
(
SELECT a.ctn, a.last_trx_date, a.sys_creation_date, a.last_trx_code
     , a.ctn_status, a.nl, a.ngp, a.tn_in_use
  FROM tn_inv_history a
 WHERE a.ctn = '047' || '40612379'
UNION
SELECT a.ctn, a.last_trx_date, a.sys_creation_date, a.last_trx_code
     , a.ctn_status, a.nl, a.ngp, a.tn_in_use
  FROM tn_inv a
 WHERE a.ctn = '047' || '40612379'
)
ORDER BY 1,2
