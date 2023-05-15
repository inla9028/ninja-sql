--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Update MAN and activation BAN for Phonero.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE service_providers a
  SET a.root_ban           = 416063113
    , a.current_active_ban = 516063112
  WHERE a.service_provider_code = 'Phonero'
;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the current MAN and activation BAN for Phonero
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.service_provider_code, a.root_ban, a.current_active_ban
  FROM service_providers a
  WHERE a.service_provider_code = 'Phonero'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the activation BAN's belonging to a certain SP (Phonero)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.service_provider_code, a.ban, a.in_use_id
  FROM sp_activation_bans a
 WHERE a.service_provider_code = 'Phonero'
ORDER BY a.service_provider_code, a.in_use_id, a.ban
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Count the number of activation BAN's belonging to a certain SP (Phonero)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT COUNT(*) AS "BAN_COUNT"
  FROM sp_activation_bans a
  WHERE a.service_provider_code = 'Phonero'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Count the number of activation BAN's belonging to a certain SP (Phonero),
--== and also count the number of available subscriptions.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   COUNT (*) AS "BAN_COUNT",
         COUNT (*) * b.max_subscriptions AS "MAX_CAPACITY"
    FROM sp_activation_bans a, service_providers b
   WHERE a.service_provider_code = 'Phonero'
     AND b.service_provider_code = a.service_provider_code
GROUP BY b.max_subscriptions
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the activation BAN's registered as 'IN_USE'
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.service_provider_code, a.ban, a.in_use_id
  FROM sp_activation_bans a
  WHERE a.in_use_id IS NOT NULL
ORDER BY a.service_provider_code, a.ban
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Clear all IN_USE_ID's. It won't cause any harm... (Not a lot at least ;-)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE sp_activation_bans a
  SET a.in_use_id = NULL
  WHERE /*a.service_provider_code = 'Phonero'
    AND */a.in_use_id IS NOT NULL;
COMMIT;

