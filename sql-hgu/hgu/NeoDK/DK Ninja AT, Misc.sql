select a.*
  from dealer_profile@fokus a
 where dealer like '10%'
;

/*
NINJAMASTER :: NINJA
*/
SELECT	default_channel_code, contact_id
  FROM	ninja_user
 WHERE	username = 'BSH_USER';

/*
NINJAMASTER :: Ninja Internal User :: N :: TELIA
*/
SELECT * FROM CHANNELS;

/*
TELIA :: 30001 :: (null) :: DFLT
*/
select a.dealer_code, a.fokus_user_id, a.ninja_comment, a.default_sales_agent_code
  from ninja_dealer_fokus_user a
 where a.dealer_code = 'TELIA';
 
update ninja_dealer_fokus_user a
   set a.fokus_user_id = 10091
 where a.dealer_code   = 'TELIA'
   and a.fokus_user_id = 30001
;

/*
(no rows)
*/
SELECT user_short_name, user_full_name
  FROM users@fokus
 WHERE user_id = 10091;


select u.*
  from users@fokus u
 WHERE u.user_full_name LIKE 'N%'
ORDER By u.user_full_name
;