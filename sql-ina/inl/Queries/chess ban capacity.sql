SELECT count(*) as ban_count, count(*) * b.max_subscriptions as current_max_capacity
  FROM ninjaconfig.sp_activation_bans a, ninjaconfig.service_providers b
where a.service_provider_code = 'Chess2'
  and b.service_provider_code = a.service_provider_code
group by b.max_subscriptions

