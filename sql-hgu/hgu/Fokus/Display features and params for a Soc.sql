--== List the features used on a specific soc
SELECT a.*
  FROM rated_feature@fokus a
 WHERE RTRIM (a.soc) IN ('NSHAPE144')
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY a.feature_code, a.soc
;


--== List the feature-codes, incl. switch-codes and feature types for a specific soc
SELECT a.*
  FROM feature@fokus a, rated_feature@fokus b
 WHERE RTRIM (b.soc) IN ('NSHAPE144')
   AND b.feature_code = A.feature_code
   AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
ORDER BY a.feature_code
;


--== List the feature-types for a specific soc
SELECT a.*
  FROM feature_types@fokus a
 WHERE a.feature_type IN (
          SELECT b.feature_type
            FROM feature@fokus b, rated_feature@fokus c
           WHERE RTRIM (c.soc) IN ('NSHAPE144')
             AND c.feature_code = b.feature_code)
ORDER BY a.feature_type
;

SELECT c.soc, a.*
  FROM feature_types@fokus a, feature@fokus b, rated_feature@fokus c
 WHERE a.feature_type = b.feature_type
   AND b.feature_code = c.feature_code
   AND RTRIM (c.soc) IN ('NSHAPE144')
ORDER BY 1, 2
;


--== List the switch-codes relevant for a specific soc
SELECT a.*
  FROM csm_switch_feature@fokus a
 WHERE a.switch_ftr_code IN (SELECT b.feature_code
                               FROM rated_feature@fokus b
                              WHERE RTRIM (b.soc) IN ('NSHAPE144'));

--== List the switch-features used by CSM
SELECT   a.*
    FROM csm_switch_feature@fokus a, rated_feature@fokus b
   WHERE RTRIM (b.soc) IN ('NSHAPE144')
     AND SYSDATE BETWEEN b.effective_date AND NVL (b.expiration_date, SYSDATE + 1)
     AND b.feature_code = a.switch_ftr_code
ORDER BY a.switch_ftr_code
;

