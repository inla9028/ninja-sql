SELECT a.subscription_type_id, a.soc, a.effective_date,
       a.expiration_date, a.displayable, a.add_mode, a.modify_mode,
       a.delete_mode, a.ninja_mode_activate, a.ninja_mode_change,
       a.ninja_mode_delete, a.ninja_replacement_soc, a.overidden_by_soc,
       a.additionally_adds_soc, a.ninja_default_soc
  FROM subscription_types_socs a
  WHERE a.soc                  IN ('BASIS', 'CALLWAIT')
    AND a.subscription_type_id IN ('PSFBREG1', 'PSGBREG1')
    AND a.expiration_date > sysdate
  ORDER by a.subscription_type_id

--== Update...
UPDATE subscription_types_socs a
--  SET a.add_mode = 'A' -- 'A'utomatic by Ninja
  SET a.add_mode = 'O' -- May be added by end-user
  WHERE a.soc                  IN ('BASIS', 'CALLWAIT')
    AND a.subscription_type_id IN ('PSFBREG1', 'PSGBREG1')
    AND a.expiration_date > SYSDATE


