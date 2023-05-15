select --*

sts.*

from icim_order_to_subscription os, subscription_types_socs sts

where os.icim_agreement_code = 'PRIVATE.REGULAR'

and os.icim_product_agreement_code = 'NETCOM' -- or COOP 

and os.icim_subscription_type = 'FLEXI_TALK'

and os.icim_additional_offering = 'TLF12LEASC'

and os.icim_order_type = 'UPGRADE' -- or UPGRADE or ... 

and sts.subscription_type_id like os.priceplan_code || '%'

and sysdate between sts.effective_date and sts.expiration_date

order by icim_agreement_code, icim_product_agreement_code, icim_subscription_type, icim_additional_offering, icim_order_type

;

select *

from icim_product p, socs s

where p.icim_product_code = 'TB_STAT_SUBSCRIPTION'

and s.soc_type = p.soc_type

and s.soc_group = p.soc_group


