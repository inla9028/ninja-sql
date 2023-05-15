select c.channel_id, c.name, c.channel_type, c.dealer_group, c.no_of_days_to_add_port_in_date
  from channels c
 where c.dealer_group = 'MinBedrift'
order by 1, 2, 3;

select c.*
  from channels c
 where c.dealer_group = 'MinBedrift'
order by 1, 2, 3;


update channels c
   set c.no_of_days_to_add_port_in_date = 3
 where c.dealer_group = 'MinBedrift'
;