SELECT a.* FROM socs a WHERE a.soc IN ('PUMC', 'PUMD');
SELECT a.* FROM subscription_types a WHERE a.subscription_type_id IN ('PUMCREG1', 'PUMDREG1');
SELECT a.* FROM subscription_types_socs a WHERE a.subscription_type_id IN ('PUMCREG1', 'PUMDREG1') AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1) ORDER BY a.subscription_type_id, a.soc;
SELECT a.* FROM sub_typ_soc_channel a WHERE a.subscription_type_id IN ('PUMCREG1', 'PUMDREG1');
--SELECT a.* FROM rated_feature@prod a WHERE RTRIM(a.soc) IN ('PUMD', 'VMSENTRAL') AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1) ORDER BY a.soc, a.feature_code;
SELECT a.* FROM account_type_admin_priceplan a WHERE a.admin_priceplan IN ('PUMC', 'PUMD') ORDER BY a.admin_priceplan, a.account_type, a.account_sub_type;
SELECT a.* FROM soc_action_rules a WHERE a.soc IN ('PUMC', 'PUMD');
SELECT a.* FROM ninja_pp_change_reason_codes a WHERE a.pp_to IN ('PUMC', 'PUMD');
SELECT a.* FROM bill_agr_types_sub_types a WHERE a.new_priceplan IN ('PUMC', 'PUMD') AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1) ORDER BY a.new_priceplan, a.org_priceplan;

