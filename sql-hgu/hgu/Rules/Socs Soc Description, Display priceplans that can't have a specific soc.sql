--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the priceplans that aren't configured to allow a specific soc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.soc, b.description
   FROM socs_soc_descriptions a, soc_descriptions b
   WHERE a.soc_name_id = b.soc_name_id
     AND (   (LOWER (b.description) LIKE '%connect%')
          OR (LOWER (b.description) LIKE '%bredbånd%')
          OR (LOWER (b.description) LIKE '%mobilt%')
/*          OR (LOWER (b.description) LIKE '%mobilt%')
          OR (LOWER (b.description) LIKE '%mobilt%')
          OR (LOWER (b.description) LIKE '%mobilt%')
          OR (LOWER (b.description) LIKE '%mobilt%')*/
         )
     AND a.language_code = 'NO'
     AND a.soc LIKE 'P%'
     AND 0 =
            (SELECT COUNT (*)
               FROM subscription_types_socs c
              WHERE c.subscription_type_id = a.soc || 'REG1'
                AND 'NCNO_EF' = c.soc
                AND SYSDATE BETWEEN c.effective_date AND c.expiration_date)
ORDER BY b.description, a.soc;

