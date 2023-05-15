--== Get available pricplans for an Upgrade via XLDB.
SELECT distinct(a.subscription_type_id)
	FROM bill_agr_types_sub_types a, bill_agr_typ_channel b
	WHERE a.account_type          = 'P'
	  AND a.account_sub_type      = 'C'
	  AND a.new_priceplan         = 'PKOF'
	  AND sysdate between a.effective_date AND a.expiration_date
	  AND a.bill_agr_types_sub_id = b.bill_agr_types_sub_id
	  AND b.channel_code          = 'NINJAMASTER'
	  AND sysdate between b.effective_date AND b.expiration_date

--
