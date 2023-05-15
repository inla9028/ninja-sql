SELECT RTRIM(nldl.nl_id) AS "NL_ID"
     , RTRIM(nl.nl_type) AS "NL_TYPE"
     , RTRIM(ngpnl.ngp)  AS "NGP_ID"
  FROM nl_dealer_link@fokus nldl, number_location@fokus nl, ngp_nl_assignment@fokus ngpnl
 WHERE RTRIM(nldl.dealer_code) = 'NWCO'
   AND SYSDATE           BETWEEN nldl.effective_date AND NVL(nldl.expiration_date, SYSDATE + 1)
   AND nldl.nl_id              = nl.nl_id
   AND nl.nl_id                = ngpnl.nl (+)
ORDER BY nl.nl_dsc ASC
;

/*
** Fokus directly...
*/
SELECT RTRIM(nldl.nl_id) AS "NL_ID"
     , RTRIM(nl.nl_type) AS "NL_TYPE"
     , RTRIM(ngpnl.ngp)  AS "NGP_ID"
  FROM nl_dealer_link nldl, number_location nl, ngp_nl_assignment ngpnl
 WHERE RTRIM(nldl.dealer_code) = 'NWCO'
   AND SYSDATE           BETWEEN nldl.effective_date AND NVL(nldl.expiration_date, SYSDATE + 1)
   AND nldl.nl_id              = nl.nl_id
   AND nl.nl_id                = ngpnl.nl (+)
ORDER BY nl.nl_dsc ASC
;

SELECT RTRIM(nldl.dealer_code) AS "DEALER_CODE", RTRIM(nldl.nl_id) AS "NL_ID", COUNT(1) AS "COUNT"
  FROM nl_dealer_link nldl, number_location nl, ngp_nl_assignment ngpnl
 WHERE RTRIM(nldl.dealer_code) IN ( 'SP01', 'SP02', 'SP03', 'SP04', 'SP05', 'NWCO', 'NWCO', 'SP08', 'PO01')
   AND SYSDATE           BETWEEN nldl.effective_date AND NVL(nldl.expiration_date, SYSDATE + 1)
   AND nldl.nl_id              = nl.nl_id
   AND nl.nl_id                = ngpnl.nl (+)
GROUP BY RTRIM(nldl.dealer_code), RTRIM(nldl.nl_id)
ORDER BY 1,2
;
