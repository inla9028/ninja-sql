--==
--== Display the Fokus user for a dealer..
--==
SELECT   a.dealer_code, a.fokus_user_id, a.ninja_comment,
         a.default_sales_agent_code
    FROM ninja_dealer_fokus_user a
   WHERE a.dealer_code LIKE 'X44_'
ORDER BY a.dealer_code;

--==
--== Display which dealer group a dealer is part of...
--==
SELECT a.dealer_code, a.dealer_group, b.description
  FROM dealers a, dealer_groups b
 WHERE a.dealer_code LIKE 'X44_'
   AND a.dealer_group = b.dealer_group
ORDER BY a.dealer_code;

--==
--== Display all info contained in Ninja DB about a dealer.
--==
SELECT   a.dealer_code, a.fokus_user_id, a.ninja_comment,
         a.default_sales_agent_code, b.dealer_group, c.description
    FROM ninja_dealer_fokus_user a, dealers b, dealer_groups c
   WHERE a.dealer_code LIKE 'X44_'
     AND a.dealer_code  = b.dealer_code
     AND b.dealer_group = c.dealer_group
ORDER BY a.dealer_code;

--==
--== List the similar dealers in Fokus - if any - via a db-link.
--==
SELECT a.user_id, a.user_effective_date, a.user_expiration_date,
       a.user_short_name, a.user_full_name  
  FROM users@prod a
 WHERE a.user_short_name like 'X44%'
ORDER BY a.user_short_name;

