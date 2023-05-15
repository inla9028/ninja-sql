select a.*
  from print_category_access a
 where a.print_category = 'EF'
--   and a.account_type   = 'I'
order by 1,2,3,4
;

SELECT a.*
  FROM print_category_account_type a
 where a.print_category = 'EF'
--   and a.account_type   = 'I'
ORDER BY 1, 2, 3
;

insert into print_category_account_type (print_category, account_type, account_sub_type)
select 'EF'               AS "PRINT_CATEGORY"
     , a.account_type
     , a.account_sub_type
  from print_category_access a
 where a.account_type   = 'I'
   and a.print_category = 'EE'
group by a.print_category, a.account_type, a.account_sub_type
;

insert into print_category_access (print_category, account_type, account_sub_type, channel_code, effective_date, expiration_date, requires_email, description)
select 'EF'               AS "PRINT_CATEGORY"
     , a.account_type
     , a.account_sub_type
     , 'IGNORE'           AS "CHANNEL_CODE"
     , TRUNC(SYSDATE)     AS "EFFECTIVE_DATE"
     , a.expiration_date
     , 'N'                AS "REQUIRES_EMAIL"
     , 'HGU 2021-11-30'   AS "DESCRIPTION"
  from print_category_access a
 where a.account_type   = 'I'
   and a.print_category = 'EE'
   and a.channel_code   = 'DOWE'
;

-- B/HI
--insert into print_category_account_type (print_category, account_type, account_sub_type)
select 'EF'               AS "PRINT_CATEGORY"
     , a.account_type
     , a.account_sub_type
  from print_category_access a
 where a.account_type     = 'B'
   and a.account_sub_type = 'HI'
   and a.print_category   = 'EE'
group by a.print_category, a.account_type, a.account_sub_type
;

-- B/HI
--insert into print_category_access (print_category, account_type, account_sub_type, channel_code, effective_date, expiration_date, requires_email, description)
select 'EF'               AS "PRINT_CATEGORY"
     , a.account_type
     , a.account_sub_type
     , 'IGNORE'           AS "CHANNEL_CODE"
     , TRUNC(SYSDATE)     AS "EFFECTIVE_DATE"
     , a.expiration_date
     , 'N'                AS "REQUIRES_EMAIL"
     , 'HGU 2021-11-30'   AS "DESCRIPTION"
  from print_category_access a
 where a.account_type     = 'B'
   and a.account_sub_type = 'HI'
   and a.print_category   = 'EE'
   and a.channel_code     = 'NETWEB'
;
