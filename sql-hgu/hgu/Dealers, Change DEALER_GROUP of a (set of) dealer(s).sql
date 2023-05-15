/*
** List all available dealer groups and the number dealers assigned to each
*/
select a.dealer_group, count(1) as "COUNT"
  from dealers a
 group by a.dealer_group
 order by a.dealer_group
;

/*
** Simply display the dealer(s) we're looking for...
*/
select a.*
  from dealers a
 where a.dealer_code in ( '1105', '2363', '8302')
;

/*
** Update the dealer(s) we're interested in...
*/
update dealers a
   set a.dealer_group = 'TeliaShop'
 where a.dealer_code = '1105'
;

update dealers a
   set a.dealer_group = 'TeliaShop'
 where a.dealer_code = '2363'
;

update dealers a
   set a.dealer_group = 'TeliaCSR'
 where a.dealer_code = '8302'
;
