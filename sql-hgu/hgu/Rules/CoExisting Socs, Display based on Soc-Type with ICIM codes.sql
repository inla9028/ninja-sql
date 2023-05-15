/*
** List all illegal combinations of DATA/GPRS socs, including the ICIM codes...
*/
select a.soc AS "A_SOC", c.icim_product_code AS "A_ICIM"
     , a.coexisting_soc as "B_SOC", e.icim_product_code AS "B_CODE"
  from coexisting_socs a, socs b, icim_product c, socs d, icim_product e
 where b.soc in (a.soc, a.coexisting_soc)
   and (b.soc_type = c.soc_type and b.soc_group = c.soc_group)
   and b.soc_type IN ( 'DATA', 'GPRS' )
   and a.coexisting_soc = d.soc
   and (d.soc_type = e.soc_type and d.soc_group = e.soc_group)
group by a.soc, c.icim_product_code, a.coexisting_soc, e.icim_product_code
order by a.soc, c.icim_product_code, a.coexisting_soc, e.icim_product_code
;