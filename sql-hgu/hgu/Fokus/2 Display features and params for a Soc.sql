--== List the features used on a specific soc
SELECT /*+ driving_site(a)*/ a.*
  FROM rated_feature@fokus a
 WHERE RTRIM (a.soc) IN ( 'MDSIMEB' )
   AND SYSDATE BETWEEN A.effective_date AND nvl(A.expiration_date, SYSDATE + 1)
ORDER BY a.soc, a.feature_code 
;


--== List the feature-codes, incl. switch-codes and feature types for a specific soc
SELECT /*+ driving_site(a)*/ rtrim(b.soc) AS "SOC", a.*
  FROM feature@fokus a, rated_feature@fokus b
 WHERE RTRIM (b.soc) IN ( 'MDSIMEB' )
   AND b.feature_code = A.feature_code
   AND SYSDATE BETWEEN b.effective_date AND nvl(b.expiration_date, SYSDATE + 1)
ORDER BY 1, a.feature_code
;


--== List the feature-types for a specific soc
SELECT /*+ driving_site(a)*/ a.*
  FROM feature_types@fokus a
 WHERE a.feature_type IN (
          SELECT b.feature_type
            FROM feature@fokus b, rated_feature@fokus c
           WHERE RTRIM (c.soc) IN ( 'MDSIMEB' )
             AND c.feature_code = b.feature_code)
ORDER BY a.feature_type
;

SELECT /*+ driving_site(a)*/ c.soc, a.*
  FROM feature_types@fokus a, feature@fokus b, rated_feature@fokus c
 WHERE a.feature_type = b.feature_type
   AND b.feature_code = c.feature_code
   AND RTRIM (c.soc) IN ( 'MDSIMEB' )
ORDER BY 1, 2
;


--== List the switch-codes relevant for a specific soc
SELECT /*+ driving_site(a)*/ a.*
  FROM csm_switch_feature@fokus a
 WHERE a.switch_ftr_code IN (SELECT b.feature_code
                               FROM rated_feature@fokus b
                              WHERE RTRIM (b.soc) IN ( 'MDSIMEB' ));

SELECT /*+ driving_site(sf)*/ rf.soc, sf.*
  FROM csm_switch_feature@fokus sf, rated_feature@fokus rf
 WHERE sf.switch_ftr_code = rf.feature_code
   AND RTRIM(rf.soc)     IN ( 'MDSIMEB' )
ORDER BY 1,2
;

--== List the switch-features used by CSM
SELECT /*+ driving_site(a)*/ a.*
  FROM csm_switch_feature@fokus a, rated_feature@fokus b
 WHERE RTRIM (b.soc) IN ( 'MDSIMEB' )
   AND SYSDATE BETWEEN b.effective_date AND NVL (b.expiration_date, SYSDATE + 1)
   AND b.feature_code = a.switch_ftr_code
ORDER BY a.switch_ftr_code
;

