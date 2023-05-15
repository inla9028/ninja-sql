SELECT a.ban, a.subscriber_no, a.soc, a.operator_id, s.sub_status
     , ti.nl, ti.ngp, ti.ctn_status
  FROM service_agreement@fokus a, subscriber@fokus s, tn_inv@fokus ti
 WHERE a.service_type = 'P'
   AND SYSDATE  BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscriber_no = s.subscriber_no
   AND a.ban           = s.customer_id
   AND s.sub_status    = 'A'
   AND s.subscriber_no = 'GSM'||ti.ctn
   AND RTRIM(ti.nl)    = 'NET'
   AND RTRIM(ti.ngp)   = 'A'
   AND ROWNUM < 21
;
/*
704551316   GSM04792618121  PVHR        400141  A   NET A   AA
606377117   GSM04746509634  PPUR        1       A   NET A   AG
225673219   GSM04740000006  PSLA        1       A   NET A   AI
487103905   GSM04740000022  PSBC        400454  A   NET A   AI
590641213   GSM04740000041  PPUR        1       A   NET A   AI
144512118   GSM04740000049  PPUR        400586  A   NET A   AI
797703212   GSM04740000051  PPEB        400901  A   NET A   AI
711981217   GSM04740000052  PPBD        1       A   NET A   AI
766797013   GSM04740000062  PSFI        500347  A   NET A   AI
766797013   GSM04740000063  PSFI        500347  A   NET A   AI
994122307   GSM04740000066  PPUX        401582  A   NET A   AI
850090804   GSM04740000067  PKOO        402097  A   NET A   AI
383834116   GSM04740000076  PPUS        400441  A   NET A   AI
373386218   GSM04740000086  PPUS        400888  A   NET A   AI
649827110   GSM04740000087  PPUR        400888  A   NET A   AI
719817306   GSM04740000114  PPUS        502201  A   NET A   AI
995676210   GSM04740000115  PPEB        1       A   NET A   AI
803162213   GSM04740000117  PPEA        1       A   NET A   AI
753741404   GSM04740000128  PSSN        400624  A   NET A   AI
199716804   GSM04740000130  PKOO        400458  A   NET A   AI
*/

SELECT a.*
  FROM service_agreement@fokus a
 WHERE a.subscriber_no IN ( 'GSM047'||'40000114', 'GSM047'||'40000114' )
   AND (SYSDATE - 1 BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
     OR SYSDATE     BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
ORDER BY 1,2,3
;

/*
** Mark the current number, Ctrl+H and replace...
*/
SELECT mhr.msisdn_begin_range, mhr.msisdn_end_range, mhr.phy_hlr,
       mhr.sys_creation_date, mhr.description, lp.phd_id
  FROM msisdn_hlr_relation mhr, logic_phd lp
 WHERE mhr.phy_hlr = lp.logical_dvc_id
   AND '047'||'40000114' BETWEEN mhr.msisdn_begin_range AND mhr.msisdn_end_range
   AND LENGTH('047'||'40000114') = LENGTH(mhr.msisdn_begin_range)
ORDER BY mhr.msisdn_begin_range
;

/*
** Via db-link...
*/
SELECT mhr.msisdn_begin_range, mhr.msisdn_end_range, mhr.phy_hlr,
       mhr.sys_creation_date, mhr.description, lp.phd_id
  FROM msisdn_hlr_relation@fokus mhr, logic_phd@fokus lp
 WHERE mhr.phy_hlr = lp.logical_dvc_id
   AND '047'||'40000114' BETWEEN mhr.msisdn_begin_range AND mhr.msisdn_end_range
   AND LENGTH('047'||'40000114') = LENGTH(mhr.msisdn_begin_range)
ORDER BY mhr.msisdn_begin_range
;

/*
** List all number-ranges with a certain HLR.
*/
SELECT mhr.msisdn_begin_range, mhr.msisdn_end_range, mhr.phy_hlr,
       mhr.sys_creation_date, mhr.description
  FROM msisdn_hlr_relation mhr
 WHERE mhr.phy_hlr = '59'
ORDER BY mhr.msisdn_begin_range
;

/*
** Again, via db-link.
*/
SELECT mhr.msisdn_begin_range, mhr.msisdn_end_range, mhr.phy_hlr,
       mhr.sys_creation_date, mhr.description
  FROM msisdn_hlr_relation@fokus mhr
 WHERE mhr.phy_hlr = '59'
ORDER BY mhr.msisdn_begin_range
;

-- Same as above, but MUCH quicker :-D
SELECT ngpnl.*
  FROM ngp_nl_assignment@fokus ngpnl
 WHERE ngpnl.nl  = 'PRD'
--   AND ngpnl.ngp = 'A'
;

SELECT ti.*
  FROM tn_inv@fokus ti
 WHERE ti.ctn IN ('047'||'40000114', '047'||'40000114')
;


/*
** Find an available number on the same group and location as another number.
*/
SELECT ti2.*
  FROM tn_inv@fokus ti, tn_inv@fokus ti2
 WHERE ti.ctn         = '047'||'40000114'
   AND ti.nl          = ti2.nl
   AND ti.ngp         = ti2.ngp
   AND ti2.ctn_status = 'AA'
   AND ti2.nl    NOT IN ( 'IMP', 'EXP' )
   AND ROWNUM         < 11
;

SELECT RTRIM(nldl.nl_id) AS "NL_ID", RTRIM(nl.nl_type) AS "NL_TYPE", COUNT(1) AS "COUNT"
  FROM nl_dealer_link@fokus nldl, number_location@fokus nl, ngp_nl_assignment@fokus ngpnl
 WHERE RTRIM(nldl.dealer_code) = 'DRFT'
   AND SYSDATE           BETWEEN nldl.effective_date AND NVL(nldl.expiration_date, SYSDATE + 1)
   AND nldl.nl_id              = nl.nl_id
   AND nl.nl_id                = ngpnl.nl (+)
GROUP BY RTRIM(nldl.nl_id), RTRIM(nl.nl_type)
ORDER BY 1, 2
;

SELECT RTRIM(nldl.nl_id) AS "NL_ID", RTRIM(nl.nl_type) AS "NL_TYPE", COUNT(1) AS "COUNT"
  FROM nl_dealer_link@fokus nldl, number_location@fokus nl, ngp_nl_assignment@fokus ngpnl
 WHERE SYSDATE           BETWEEN nldl.effective_date AND NVL(nldl.expiration_date, SYSDATE + 1)
   AND nldl.nl_id              = nl.nl_id
   AND nl.nl_id                = ngpnl.nl (+)
   AND RTRIM(nl.nl_id)         = 'PRD'
GROUP BY RTRIM(nldl.nl_id), RTRIM(nl.nl_type)
ORDER BY 1, 2
;


