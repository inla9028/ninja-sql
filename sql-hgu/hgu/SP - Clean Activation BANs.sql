SELECT a.service_provider_code, ba.ban_status, COUNT(1) AS "COUNT"
  FROM sp_activation_bans a, billing_account@fokus ba
 WHERE a.ban = ba.ban(+)
GROUP BY a.service_provider_code, ba.ban_status
ORDER BY 1,2
;

DELETE
  FROM sp_activation_bans A
 WHERE 0 = (SELECT COUNT(1)
              FROM billing_account@fokus ba
             WHERE ba.ban        = a.ban
               AND ba.ban_status = 'O')
;
