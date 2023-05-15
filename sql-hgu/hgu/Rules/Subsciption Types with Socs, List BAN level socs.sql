/**
 * Display the rules/records we have configured for BAN level socs.
 * @order Price plan (aka subscription type id)
 */
SELECT   a.subscription_type_id, a.soc, a.effective_date,
         a.expiration_date, a.displayable, a.add_mode, a.modify_mode,
         a.delete_mode, a.ninja_mode_activate, a.ninja_mode_change,
         a.ninja_mode_delete, a.ninja_replacement_soc, a.overidden_by_soc,
         a.additionally_adds_soc, a.ninja_default_soc
    FROM ninjarules.subscription_types_socs a
   WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND EXISTS (
            SELECT ''
              FROM soc@prod b
             WHERE a.soc            = RTRIM (b.soc)
               AND b.soc_level_code = 'B'
               AND SYSDATE    BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1))
ORDER BY a.subscription_type_id, a.soc;

/*
SELECT b.*
  FROM soc@prod b
 WHERE 'TFBASIS' = RTRIM (b.soc);
*/

