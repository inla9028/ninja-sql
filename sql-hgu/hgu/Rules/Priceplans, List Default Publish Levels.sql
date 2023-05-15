--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the priceplans configured in Ninja, and their default publish levels
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.priceplan_code, c.description,
       NVL(a.default_publish_level, 'N/A') AS "DEFAULT_PUBLISH_LEVEL"
  FROM ninjarules.priceplans a, socs_soc_descriptions b, soc_descriptions c
  WHERE a.priceplan_code = b.soc
    AND b.language_code  = 'NO'
    AND b.soc_name_id    = c.soc_name_id
  ORDER BY "DEFAULT_PUBLISH_LEVEL" --a.priceplan_code, c.description
  ;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the priceplans configured in Ninja, and their default publish
--== levels, with description from Fokus.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.priceplan_code, c.description, 
       NVL(a.default_publish_level, 'N/A') AS "DEFAULT_PUBLISH_LEVEL",
       d.gen_desc AS "PUBLISH_LEVEL_DESCRIPTION"
  FROM ninjarules.priceplans a, socs_soc_descriptions b, soc_descriptions c, generic_codes@prod d
  WHERE a.priceplan_code  = b.soc
    AND b.language_code   = 'NO'
    AND b.soc_name_id     = c.soc_name_id
    AND d.gen_code        = a.default_publish_level(+)
    AND 'PUB'             = RTRIM(d.gen_type)
  ORDER BY a.priceplan_code, c.description;
  
