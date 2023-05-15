/*
** subscription_types_socs
*/
SELECT a.*
  FROM subscription_types_socs a
 WHERE a.subscription_type_id IN ( 'PW10REG1' )
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2
;

INSERT INTO subscription_types_socs
SELECT 'PW10REG1' AS "SUBSCRIPTION_TYPE_ID",
       DECODE(a.soc, 'VMMINIVCH', 'VMFREE', a.soc) AS "SOC",
       TRUNC(SYSDATE - 1) AS "EFFECTIVE_DATE",
       a.expiration_date, a.displayable, a.add_mode, a.modify_mode,
       a.delete_mode, a.ninja_mode_activate, a.ninja_mode_change,
       a.ninja_mode_delete, a.ninja_replacement_soc, a.overidden_by_soc,
       a.additionally_adds_soc, a.ninja_default_soc
  FROM subscription_types_socs a
 WHERE a.subscription_type_id IN ( 'PLDEREG1' )
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND (
       a.soc LIKE 'ODB%'
    OR a.soc IN ( 'VO2MMS', 'MMS02', 'IMS01', 'KONFER', 'CALLWAIT', 'VMMINIVCH')
   )
;

/*
** sub_typ_soc_channel
*/
SELECT a.*
  FROM sub_typ_soc_channel a
 WHERE a.subscription_type_id IN ( 'PW10REG1' )
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2
;

INSERT INTO sub_typ_soc_channel
SELECT 'PW10REG1' AS "SUBSCRIPTION_TYPE_ID",
       DECODE(a.soc, 'VMMINIVCH', 'VMFREE', a.soc) AS "SOC", a.channel_code,
       TRUNC(SYSDATE - 1) AS "EFFECTIVE_DATE",
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
 WHERE a.subscription_type_id IN ( 'PLDEREG1' )
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND (
       a.soc LIKE 'ODB%'
    OR a.soc IN ( 'VO2MMS', 'MMS02', 'IMS01', 'KONFER', 'CALLWAIT', 'VMMINIVCH')
   )
;

--
INSERT INTO sub_typ_soc_channel
SELECT a.subscription_type_id, a.soc, 'Phonero' AS "CHANNEL_CODE", a.effective_date,
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
 WHERE a.subscription_type_id IN ( 'PW10REG1' )
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.channel_code = 'NINJAMASTER'
   AND a.channel_code != 'Phonero'
ORDER BY 1,2
;

/*
** Rating Account Types...
*/
INSERT INTO rating_account_types
SELECT REPLACE(a.priceplan_code, 'PVGA','PW10') AS "PRICEPLAN_CODE",
       a.campaign_code, a.agreement_type, a.account_type, 'PO' AS "ACCOUNT_SUB_TYPE",
       REPLACE(a.subscription_type_id, 'PVGA','PW10') AS "SUBSCRIPTION_TYPE_ID",
       trunc(SYSDATE) AS "EFFECTIVE_DATE", a.sales_expiry_date, a.expiry_date
  FROM rating_account_types a
 WHERE a.priceplan_code = 'PVGA'
   AND SYSDATE BETWEEN a.effective_date AND a.expiry_date
;

