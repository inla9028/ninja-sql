INSERT INTO socs
SELECT 'PW10' AS "SOC", a.soc_type, a.cloneable, a.soc_group, a.compound_soc, a.allow_manual_expiration_date
  FROM socs a
 WHERE a.soc = 'PVGA'
;

INSERT INTO socs_descriptions
SELECT 'PW10' AS "SOC", a.language_code, REPLACE(a.description, 'Telavox', 'Phonero') AS "DESCRIPTION"
  FROM socs_descriptions a
 WHERE a.soc = 'PVGA'
;

INSERT INTO sub_typ_soc_channel
SELECT REPLACE(a.subscription_type_id, 'PVGA','PW10') AS "SUBSCRIPTION_TYPE_ID",
       REPLACE(a.soc, 'VGA', 'W10') AS "SOC", 'Phonero' AS "CHANNEL_CODE",
       TRUNC(SYSDATE) AS "EFFECTIVE_DATE", a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
 WHERE a.channel_code         = 'Telavox'
   AND a.subscription_type_id = 'PVGAREG1'
   AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
;

INSERT INTO subscription_types
SELECT REPLACE(a.subscription_type_id, 'PVGA','PW10') AS "SUBSCRIPTION_TYPE_ID", a.defined_cleanable
  FROM subscription_types a
 WHERE a.subscription_type_id = 'PVGAREG1'
;

INSERT INTO subscription_types_socs
SELECT REPLACE(a.subscription_type_id, 'PVGA','PW10') AS "SUBSCRIPTION_TYPE_ID",
       REPLACE(a.soc, 'VGA', 'W10') AS "SOC", TRUNC(SYSDATE) AS "EFFECTIVE_DATE",
       a.expiration_date, a.displayable, a.add_mode, a.modify_mode,
       a.delete_mode, a.ninja_mode_activate, a.ninja_mode_change,
       a.ninja_mode_delete, a.ninja_replacement_soc, a.overidden_by_soc,
       a.additionally_adds_soc, a.ninja_default_soc
  FROM subscription_types_socs a
 WHERE a.subscription_type_id = 'PVGAREG1'
   AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
;

INSERT INTO sub_typ_soc_channel
SELECT REPLACE(a.subscription_type_id, 'PVGA','PW10') AS "SUBSCRIPTION_TYPE_ID",
       REPLACE(a.soc, 'VGA', 'W10') AS "SOC", 
       REPLACE(a.channel_code, 'Telavox', 'Phonero') AS "CHANNEL_CODE", TRUNC(SYSDATE) AS "EFFECTIVE_DATE",
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
 WHERE a.subscription_type_id = 'PVGAREG1'
   AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
;

INSERT INTO allowable_upgrades
SELECT REPLACE(a.current_priceplan, 'PVGA','PW10') AS "CURRENT_PRICEPLAN",
       REPLACE(a.new_priceplan,     'PVGA','PW10') AS "NEW_PRICEPLAN",
       a.new_campaign, a.curr_a_band_rem_comm_months, a.curr_m_band_rem_comm_months,
       TRUNC(SYSDATE) AS "EFFECTIVE_DATE", a.expiry_date
  FROM allowable_upgrades a
 WHERE a.new_priceplan = 'PVGA'
   AND a.current_priceplan = 'PVGA'
   AND SYSDATE BETWEEN a.effective_date AND a.expiry_date
ORDER BY 1,2
;

INSERT INTO account_type_sub_type
SELECT a.account_type, 'PO' AS "ACCOUNT_SUB_TYPE", a.icim_agreement_type,
       a.icim_agreement_sub_type, a.icim_agreement_item, a.comments
  FROM account_type_sub_type a
 WHERE a.account_type     = 'S'
   AND a.account_sub_type = 'C2'
;

INSERT INTO billing_agreement_types
SELECT a.agreement_type, a.account_type, 'PO' AS "ACCOUNT_SUB_TYPE",
       a.tree_allowed, a.non_tree_allowed, TRUNC(SYSDATE) AS "EFFECTIVE_DATE",
       a.expiry_date
  FROM billing_agreement_types a
 WHERE a.account_type     = 'S'
   AND a.account_sub_type = 'C2'
   AND SYSDATE BETWEEN a.effective_date AND a.expiry_date
;

INSERT INTO priceplans
SELECT REPLACE(a.priceplan_code, 'PVGA','PW10') AS "PRICEPLAN_CODE", a.priceplan_type, a.priceplan_bill_type,
       a.discontinued_from_rules, a.priceplan_to_use_in_rules,
       a.no_of_days_forced_act, a.default_publish_level,
       a.default_number_group, a.validate_number_group,
       a.default_number_length, a.icim_subscription_type,
       trunc(SYSDATE) AS "SALES_EFFECTIVE_DATE", a.sales_expiry_date
  FROM priceplans a
 WHERE a.priceplan_code = 'PVGA'
   AND SYSDATE BETWEEN a.sales_effective_date AND a.sales_expiry_date
;

INSERT INTO feature_parameters
SELECT * FROM (
    SELECT 'PW10' AS "SOC", a.feature_code, a.parameter_code, a.parameter_type,
           a.mandatory, 'N' AS "DISPLAYABLE", 
           DECODE(a.default_value
                , '50', '77'
                , a.default_value) AS "DEFAULT_VALUE"
         , a.validation_id, a.is_cloneable, a.modifiable
      FROM feature_parameters a
     WHERE a.soc = 'MMS02'
     ORDER BY 1,2,3
)
;

INSERT INTO socs_features VALUES ('PW10', 'S-MMS2', 'REGULAR')
;

INSERT INTO rating_account_types
SELECT REPLACE(a.priceplan_code, 'PVGA','PW10') AS "PRICEPLAN_CODE",
       a.campaign_code, a.agreement_type, a.account_type, 'PO' AS "ACCOUNT_SUB_TYPE",
       REPLACE(a.subscription_type_id, 'PVGA','PW10') AS "SUBSCRIPTION_TYPE_ID",
       trunc(SYSDATE) AS "EFFECTIVE_DATE", a.sales_expiry_date, a.expiry_date
  FROM rating_account_types a
 WHERE a.priceplan_code = 'PVGA'
   AND SYSDATE BETWEEN a.effective_date AND a.expiry_date
;

INSERT INTO dealers
SELECT 'PO01' AS "DEALER_CODE", a.dealer_group
  FROM dealers a
 WHERE a.dealer_code = 'SP05'
;


