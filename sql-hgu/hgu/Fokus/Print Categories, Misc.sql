select c.customer_id, c.e_post, ba.ban, ba.bl_prt_category
     , ba.account_type, ba.account_sub_type, ba.ban_status
  from customer c, billing_account ba
 where c.customer_id = 490008901
   and c.customer_id = ba.ban
   and ba.ban_status = 'O'
;


select ba.bl_prt_category as "PRT_CATEGORY", ba.*
  from billing_account ba
 where ba.ban = 490008901
;


select c.e_post as "E_MAIL", c.*
  from customer c
 where c.customer_id = 490008901
;

