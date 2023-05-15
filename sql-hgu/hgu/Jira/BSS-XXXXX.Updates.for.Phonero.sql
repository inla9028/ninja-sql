INSERT INTO sub_typ_soc_channel
SELECT a.subscription_type_id, a.soc,
       REPLACE(a.channel_code, 'NINJAMASTER', 'Phonero') AS "CHANNEL_CODE",
       a.effective_date, a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
 WHERE a.subscription_type_id = 'PW10' || 'REG1'
--   AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
   AND a.channel_code = 'NINJAMASTER'
   AND 0 = (SELECT COUNT(1)
              FROM sub_typ_soc_channel b
             WHERE a.subscription_type_id = b.subscription_type_id
               AND a.soc                  = b.soc
               AND b.channel_code         = 'Phonero')
;

UPDATE sub_typ_soc_channel a
   SET a.effective_date = to_date('2017-06-12', 'YYYY-MM-DD')
 WHERE a.channel_code         = 'Phonero'
;

UPDATE subscription_types_socs a
   SET a.effective_date = to_date('2017-06-12', 'YYYY-MM-DD')
 WHERE a.subscription_type_id = 'PW10' || 'REG1'
;

DELETE
  FROM allowable_upgrades a
 WHERE a.new_priceplan      = 'PW10'
   AND a.current_priceplan != 'PW10'
;

UPDATE allowable_upgrades a
   SET a.effective_date = to_date('2017-06-12', 'YYYY-MM-DD')
 WHERE a.new_priceplan  = 'PW10'
;

INSERT INTO account_type_sub_type
SELECT a.account_type, 'PO' AS "ACCOUNT_SUB_TYPE", a.icim_agreement_type,
       a.icim_agreement_sub_type, a.icim_agreement_item, a.comments
  FROM account_type_sub_type a
 WHERE a.account_type     = 'S'
   AND a.account_sub_type = 'C2'
;

UPDATE billing_agreement_types a
   SET a.effective_date   = to_date('2017-06-12', 'YYYY-MM-DD')
 WHERE a.account_type     = 'S'
   AND a.account_sub_type = 'PO'
;

UPDATE priceplans a
   SET a.sales_effective_date = to_date('2017-06-12', 'YYYY-MM-DD')
 WHERE a.priceplan_code = 'PW10'
;

UPDATE priceplans a
   SET a.validate_number_group = 'N'
 WHERE a.priceplan_code        = 'PW10'
--   AND SYSDATE BETWEEN a.sales_effective_date AND a.sales_expiry_date
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

DELETE
  FROM rating_account_types a
 WHERE a.priceplan_code    = 'PW10'
   AND a.account_type     != 'S'
   AND a.account_sub_type != 'PO'
;

UPDATE rating_account_types a
   SET a.effective_date = to_date('2017-06-12', 'YYYY-MM-DD')
 WHERE a.priceplan_code = 'PW10'
;

