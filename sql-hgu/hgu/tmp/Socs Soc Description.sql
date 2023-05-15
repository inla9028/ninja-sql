SELECT A.*
  FROM socs_descriptions a
  WHERE a.soc         IN ('PBTB', 'PPUA', 'PUMB', 'PPTC')
    AND a.Language_Code = 'NO'
  ORDER BY A.soc -- , a.language_code
;

select a.*, b.*
  FROM SOCS_DESCRIPTIONS A, socs b
  WHERE LOWER(a.description) LIKE '%travel%'
    and a.language_code = 'NO'
    and a.soc           = b.soc
  ORDER BY a.soc -- , a.language_code
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==  
--== List a priceplan (with its' name) and all available socs (with their names)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscription_type_id, b.description AS "PP_DESC", a.soc, c.description AS "SOC_DESC", a.effective_date,
       a.expiration_date, a.displayable, a.add_mode, a.modify_mode,
       a.delete_mode, a.ninja_mode_activate, a.ninja_mode_change,
       a.ninja_mode_delete, a.ninja_replacement_soc, a.overidden_by_soc,
       a.additionally_adds_soc, a.ninja_default_soc
  FROM subscription_types_socs A, socs_descriptions b, socs_descriptions c
  WHERE a.subscription_type_id = 'PSDH' || 'REG1'
    AND SYSDATE          BETWEEN a.EFFECTIVE_DATE AND a.EXPIRATION_DATE
    AND SUBSTR(a.subscription_type_id, 1, LENGTH (a.subscription_type_id) - 4) = b.soc
    AND b.language_code        = 'NO'
    AND a.soc                  = c.soc
    AND c.language_code        = b.language_code
  ORDER BY a.subscription_type_id, a.soc;
