SELECT a.ctn, a.sys_creation_date, a.sys_update_date, a.operator_id,
       a.application_id, a.dl_service_code, a.dl_update_stamp,
       a.last_trx_date, a.last_trx_code, a.last_trx_uid, a.ctn_status,
       a.nl, a.ngp, a.special_trx_date, a.tn_in_use, a.reason, a.pni,
       a.special_trx_no, a.conv_run_no
  FROM tn_inv a, subscriber b
  WHERE b.sub_status = 'C'
    AND b.subscriber_no = 'GSM' || a.ctn
    AND a.ctn_status    NOT IN ('AA', 'AI') 
;

SELECT ti.*
  FROM tn_inv ti
 WHERE ti.ctn = '047' || '40675148'
;


SELECT RTRIM(nldl.nl_id) AS "NL_ID", RTRIM(nl.nl_type) AS "NL_TYPE", RTRIM(ngpnl.ngp) AS "NGP_ID"
  FROM nl_dealer_link nldl, number_location nl, ngp_nl_assignment ngpnl
 WHERE RTRIM(nldl.dealer_code) = 'DRFT'
   AND SYSDATE BETWEEN nldl.effective_date AND NVL(nldl.expiration_date, SYSDATE + 1)
   AND nldl.nl_id = nl.nl_id
   AND nl.nl_id   = ngpnl.nl (+)
ORDER BY nl.NL_DSC ASC
;

SELECT RTRIM(nldl.nl_id) AS "NL_ID", RTRIM(nl.nl_type) AS "NL_TYPE", COUNT(1) AS "COUNT"
  FROM nl_dealer_link nldl, number_location nl, ngp_nl_assignment ngpnl
 WHERE RTRIM(nldl.dealer_code) = 'DRFT'
   AND SYSDATE           BETWEEN nldl.effective_date AND NVL(nldl.expiration_date, SYSDATE + 1)
   AND nldl.nl_id              = nl.nl_id
   AND nl.nl_id                = ngpnl.nl (+)
GROUP BY RTRIM(nldl.nl_id), RTRIM(nl.nl_type)
ORDER BY 1, 2
;

--==
--== List the number of available numbers for NetCom, eh, I mean Telia.
--==
SELECT ti.nl, ti.ngp, ti.ctn_status, COUNT(1) AS "COUNT"
  FROM tn_inv ti
 WHERE ti.nl  = 'NET'
   AND ti.ngp = 'A'
GROUP BY ti.nl, ti.ngp, ti.ctn_status
ORDER BY 1,2,3
;

-- Same as above, but MUCH quicker :-D
SELECT ngpnl.*
  FROM ngp_nl_assignment ngpnl
 WHERE ngpnl.nl  = 'NET'
   AND ngpnl.ngp = 'A'
;



