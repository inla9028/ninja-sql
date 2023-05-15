INSERT INTO socs VALUES ('HPTSP01', 'DATA_SHAPING', NULL, 'HPTSP01', 'N', NULL);

INSERT INTO soc_type_group VALUES ('DATA_SHAPING', 'HPTSP01', 'GET bucket profile 1', 'HPTSP01');

INSERT INTO socs_descriptions VALUES ('HPTSP01', 'NO', 'Data Bucket med Profil');
INSERT INTO socs_descriptions VALUES ('HPTSP01', 'EN', 'Data Bucket with Profile');

INSERT INTO subscription_types_socs
SELECT a.subscription_type_id, 'HPTSP01' AS "SOC", TRUNC(SYSDATE) AS "EFFECTIVE_DATE",
       a.expiration_date, a.displayable, a.add_mode, a.modify_mode,
       a.delete_mode, a.ninja_mode_activate, a.ninja_mode_change,
       a.ninja_mode_delete, a.ninja_replacement_soc, a.overidden_by_soc,
       a.additionally_adds_soc, a.ninja_default_soc
  FROM subscription_types_socs a
 WHERE a.subscription_type_id = 'PW20'||'REG1'
   AND a.soc                  = 'DATA01'
;

INSERT INTO sub_typ_soc_channel
SELECT a.subscription_type_id, 'HPTSP01' AS "SOC", a.channel_code, TRUNC(SYSDATE) AS "EFFECTIVE_DATE",
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
 WHERE a.subscription_type_id = 'PW20'||'REG1'
   AND a.soc                  = 'DATA01'
;
