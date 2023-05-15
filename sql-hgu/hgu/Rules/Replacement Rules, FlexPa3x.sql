select *
  from priceplan_replacements
 where 1 = 1
   and org_soc like 'BASIS%'
   --and trim(new_priceplan) in ( 'FLEXPA33', 'FLEXPA41' )
   and new_priceplan like 'FLEXPA%'
order by new_priceplan, org_priceplan, org_soc
;

select new_priceplan, count(*) as "BASIS_SOCS_COUNT"
  from priceplan_replacements
 where 1 = 1
   and org_soc like 'BASIS%'
   --and trim(new_priceplan) in ( 'FLEXPA33', 'FLEXPA41' )
   and new_priceplan like 'FLEXPA%'
group by new_priceplan
order by new_priceplan
;

/*
** List the "new" replacement rules for a set of price-plans.
*/
select '*' as "ORG_PRICEPLAN", substr(a.subscription_type_id, 0,8) as "NEW_PRICEPLAN",
       decode(a.soc, 'BASIS',   'BASIS1',
                     'BASIS1',   'BASIS',
                     'BASISAF', 'BASISA',
                     'BASISBF', 'BASISB',
                     'BASISCF', 'BASISC',
                     'BASISA',  'BASISAF',
                     'BASISB',  'BASISBF',
                     'BASISC',  'BASISCF',
                     'BASIS') as "ORG_SOC",
       a.soc as "NEW_SOC", 'R' as "REPLACEMENT_MODE"
  from subscription_types_socs a
 where ((a.subscription_type_id like 'FLEXPA3_REG1'
      or a.subscription_type_id like 'FLEXPA4_REG1')
    and a.subscription_type_id > 'FLEXPA37REG1')
    and a.soc like 'BASIS%'
    and a.add_mode = 'O'
    and sysdate between a.effective_date and a.expiration_date
order by a.subscription_type_id, a.soc
;

SELECT supplier_name,
DECODE(supplier_id, 10000, 'IBM',
                    10001, 'Microsoft',
                    10002, 'Hewlett Packard',
                    'Gateway') result
FROM suppliers;