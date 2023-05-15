UPDATE ninjadata.sp_pp_activations a
SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
WHERE a.load_file_ref_id IN ('Chess02-P-4277 in.txt', 'Chess02-P-4277 in.txt')
AND a.process_status = 'PRSD_ERROR'
AND a.status_desc LIKE '%Failed to create subscription%';

commit;

select count ( * ) from sp_pp_activations a
WHERE a.load_file_ref_id IN ('Chess02-P-4277 in.txt', 'Chess02-P-4277 in.txt')
AND a.process_status = 'PRSD_ERROR'
AND a.status_desc LIKE '%Failed to create subscription%'

SELECT count( *) as ban_count, count( *) * b.max_subscriptions as current_max_capacity
  FROM ninjaconfig.sp_activation_bans a, ninjaconfig.service_providers b
where a.service_provider_code = 'Chess2'
  and b.service_provider_code = a.service_provider_code
group by b.max_subscriptions
