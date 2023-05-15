SELECT a.pp_from, a.pp_to, a.new_campaign, a.new_commitment,
       a.reason_code
  FROM ninja_pp_change_reason_codes a
-- WHERE 'PSVB' IN (a.pp_from, a.pp_to)
 WHERE '*' IN (a.pp_from, a.pp_to)
-- WHERE a.new_commitment = '0'
-- WHERE a.new_campaign IN ( '*', '000000000' )
ORDER BY a.pp_to, a.pp_from, a.new_campaign, a.new_commitment, a.reason_code
;
