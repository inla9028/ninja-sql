--== Display Voicemail Language Codes
SELECT *
  FROM generic_codes@prod
  WHERE gen_type = 'VM_LAGUAGE'
  ORDER BY gen_type, gen_code;

--== Display Publish Level Codes
SELECT gen_type, gen_code, gen_desc, sys_creation_date, sys_update_date, operator_id
  FROM generic_codes@fokus
 WHERE gen_type = 'PUB'
ORDER BY gen_type, gen_code
;

--== Display the entire content - though sorted...
SELECT *
  FROM generic_codes@prod
  ORDER BY gen_type, gen_code;

--== Display the marketting indicators
SELECT MKT_IND_CD, MKT_IND_DESC
  FROM MARKETING_INDICATOR_CODES@prod
ORDER BY MKT_IND_CD, MKT_IND_DESC;

