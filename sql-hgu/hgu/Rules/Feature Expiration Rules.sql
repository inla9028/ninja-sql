SELECT * FROM FEATURE_EXPIRATION_RULES;

SELECT a.soc1, a.feature_code1, a.soc2, a.feature_code2, a.must_be_expired
  FROM feature_expiration_rules a
  WHERE a.soc1 IN ('CONBC10', 'CONBC02')
     OR a.soc2 IN ('CONBC10', 'CONBC02');

SELECT a.soc2, a.feature_code1, a.feature_code2, COUNT(*) AS "COUNT"
  FROM feature_expiration_rules a
  GROUP BY a.soc2, a.feature_code1, a.feature_code2
  ORDER BY a.soc2, a.feature_code1, a.feature_code2;

SELECT a.soc1, a.feature_code1, a.soc2, a.feature_code2, a.must_be_expired
  FROM feature_expiration_rules a
  WHERE a.soc1 = 'PANA';

SELECT a.soc1, a.feature_code1, a.soc2, a.feature_code2, a.must_be_expired
  FROM feature_expiration_rules a
  WHERE a.feature_code1 = 'S-PERS'
  ORDER BY a.soc1, a.feature_code1, a.soc2, a.feature_code2;

