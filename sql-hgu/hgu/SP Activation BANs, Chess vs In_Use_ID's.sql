--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Update MAN and activation BAN for Chess.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE service_providers a
  SET a.root_ban           = 472183417
    , a.current_active_ban = 113406417
  WHERE a.service_provider_code = 'Phonero'
;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the current MAN and activation BAN for Chess
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.service_provider_code, a.root_ban, a.current_active_ban
  FROM service_providers a
  WHERE a.service_provider_code = 'Phonero'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the activation BAN's belonging to a certain SP (Phonero)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.service_provider_code, a.ban, a.in_use_id, a.sys_update_date
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
--== Count the number of activation BAN's of all SP's
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.service_provider_code, 
         COUNT (1) AS "BAN_COUNT",
         COUNT (1) * b.max_subscriptions AS "MAX_CAPACITY"
    FROM sp_activation_bans a, service_providers b
   WHERE b.service_provider_code = a.service_provider_code
     AND SYSDATE                 < NVL(b.expiration_date, SYSDATE + 1)
GROUP BY a.service_provider_code, b.max_subscriptions
ORDER BY 1
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
SELECT a.service_provider_code, a.ban, a.in_use_id, a.sys_update_date
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

