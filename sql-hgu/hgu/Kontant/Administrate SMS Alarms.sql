--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the alarms
--==  21	Ina (Ninja)
--==  20	Glenn (Ninja)
--==  19	Håkan (Ninja)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.param, a.param_group, a.param_seq, a.value, a.description
  FROM adm_settings a
  WHERE a.param_group = 'SYSTEM_CHECK'
    AND a.param       = 'SUBSCRIBER'
--    AND a.param_seq  IN (19,20,21) -- ninja team
    AND a.param_seq  IN (22) -- ninja team

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the alarms for Håkan
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.param, a.param_group, a.param_seq, a.value, a.description
  FROM adm_settings a
  WHERE a.param_group = 'SYSTEM_CHECK'
    AND a.param       = 'SUBSCRIBER'
    AND a.param_seq   = 19;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the alarms for Glenn
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.param, a.param_group, a.param_seq, a.value, a.description
  FROM adm_settings a
  WHERE a.param_group = 'SYSTEM_CHECK'
    AND a.param       = 'SUBSCRIBER'
    AND a.param_seq   = 20;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the alarms for Ina
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.param, a.param_group, a.param_seq, a.value, a.description
  FROM adm_settings a
  WHERE a.param_group = 'SYSTEM_CHECK'
    AND a.param       = 'SUBSCRIBER'
    AND a.param_seq   = 21;






