SELECT sd.*
  FROM system_defaults sd
 WHERE sd.key LIKE 'EPOSTFAKTURA_SOC%'
ORDER BY 1;

UPDATE system_defaults sd
   SET sd.value = 'CHEPOFAK'
 WHERE sd.key   = 'EPOSTFAKTURA_SOC_CHESS';
