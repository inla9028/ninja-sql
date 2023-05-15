/*
** Display all account types (in Fokus)
*/
select a.acc_type, a.acc_sub_type, a.description
  from account_type@prod.world a
 where a.acc_type            not in ('H', 'S')
   and rtrim(a.acc_sub_type) not in ('T2', 'TX')
   and (
        a.acc_type            not in ('P') 
    and rtrim(a.acc_sub_type) not in ('P', 'R')
   )
order by a.acc_type, a.acc_sub_type, a.description
;

/*
** List the BAN types allowed to have certain print categories...
*/
SELECT pca.*
  FROM print_category_access pca
ORDER BY pca.print_category, pca.account_type, pca.account_sub_type
;

/*
** Trim any white-spaces in the existing data.
*/
update print_category_access pca
   set pca.account_sub_type  = rtrim(pca.account_sub_type)
 where pca.account_sub_type != rtrim(pca.account_sub_type)
;

/*
** Insert 'EE' aka Email invoice.
*/
insert into print_category_access
(
  print_category,
  account_type,
  account_sub_type,
  channel_code,
  effective_date,
  expiration_date,
  requires_email,
  description
  
)
select 'EE'                                    as "PRINT_CATEGORY"
     , a.acc_type                              as "ACCOUNT_TYPE"
     , rtrim(a.acc_sub_type)                   as "ACCOUNT_SUB_TYPE"
     , 'NETWEB'                                as "CHANNEL_CODE"
     , trunc(sysdate)                          as "EFFECTIVE_DATE"
     , to_date('4700-12-31', 'YYYY-MM-DD')     as "EXPIRATION_DATE"
     , 'Y'                                     as "REQUIRES_EMAIL"
     , 'HGU ' || to_char(sysdate, 'YYYY-MM-DD') as "DESCRIPTION"
  from account_type@prod.world a
 where a.acc_type            not in ('H', 'S')
   and rtrim(a.acc_sub_type) not in ('T2', 'TX')
   and (
        a.acc_type            not in ('P') 
    and rtrim(a.acc_sub_type) not in ('P', 'R')
   )
   and 0 = (select count(1)
              from print_category_access pca
             where pca.print_category   = 'EE'
               and pca.account_type     = a.acc_type
               and pca.account_sub_type = rtrim(a.acc_sub_type)
               and pca.channel_code     = 'NETWEB'
               and sysdate between pca.effective_date and pca.expiration_date)
;

/*
** Insert 'RG' aka Paper invoice.
*/
insert into print_category_access
(
  print_category,
  account_type,
  account_sub_type,
  channel_code,
  effective_date,
  expiration_date,
  requires_email,
  description
  
)
select 'RG'                                    as "PRINT_CATEGORY"
     , a.acc_type                              as "ACCOUNT_TYPE"
     , rtrim(a.acc_sub_type)                   as "ACCOUNT_SUB_TYPE"
     , 'NETWEB'                                as "CHANNEL_CODE"
     , trunc(sysdate)                          as "EFFECTIVE_DATE"
     , to_date('4700-12-31', 'YYYY-MM-DD')     as "EXPIRATION_DATE"
     , 'N'                                     as "REQUIRES_EMAIL"
     , 'HGU ' || to_char(sysdate, 'YYYY-MM-DD') as "DESCRIPTION"
  from account_type@prod.world a
 where a.acc_type            not in ('H', 'S')
   and rtrim(a.acc_sub_type) not in ('T2', 'TX')
   and (
        a.acc_type            not in ('P') 
    and rtrim(a.acc_sub_type) not in ('P', 'R')
   )
   and 0 = (select count(1)
              from print_category_access pca
             where pca.print_category   = 'RG'
               and pca.account_type     = a.acc_type
               and pca.account_sub_type = rtrim(a.acc_sub_type)
               and pca.channel_code     = 'NETWEB'
               and sysdate between pca.effective_date and pca.expiration_date)
;

/*
** Insert 'CM' aka Chess Email invoice.
*/
insert into print_category_access
(
  print_category,
  account_type,
  account_sub_type,
  channel_code,
  effective_date,
  expiration_date,
  requires_email,
  description
  
)
select 'CM'                                    as "PRINT_CATEGORY"
     , a.acc_type                              as "ACCOUNT_TYPE"
     , rtrim(a.acc_sub_type)                   as "ACCOUNT_SUB_TYPE"
     , 'NETWEB'                                as "CHANNEL_CODE"
     , trunc(sysdate)                          as "EFFECTIVE_DATE"
     , to_date('4700-12-31', 'YYYY-MM-DD')     as "EXPIRATION_DATE"
     , 'Y'                                     as "REQUIRES_EMAIL"
     , 'HGU ' || to_char(sysdate, 'YYYY-MM-DD') as "DESCRIPTION"
  from account_type@prod.world a
 where a.acc_type            in ('H')
   and rtrim(a.acc_sub_type) in ('CC', 'PC')
   and 0 = (select count(1)
              from print_category_access pca
             where pca.print_category   = 'CM'
               and pca.account_type     = a.acc_type
               and pca.account_sub_type = rtrim(a.acc_sub_type)
               and pca.channel_code     = 'NETWEB'
               and sysdate between pca.effective_date and pca.expiration_date)
;

/*
** Insert 'CP' aka Chess Paper invoice.
*/
insert into print_category_access
(
  print_category,
  account_type,
  account_sub_type,
  channel_code,
  effective_date,
  expiration_date,
  requires_email,
  description
  
)
select 'CP'                                    as "PRINT_CATEGORY"
     , a.acc_type                              as "ACCOUNT_TYPE"
     , rtrim(a.acc_sub_type)                   as "ACCOUNT_SUB_TYPE"
     , 'NETWEB'                                as "CHANNEL_CODE"
     , trunc(sysdate)                          as "EFFECTIVE_DATE"
     , to_date('4700-12-31', 'YYYY-MM-DD')     as "EXPIRATION_DATE"
     , 'N'                                     as "REQUIRES_EMAIL"
     , 'HGU ' || to_char(sysdate, 'YYYY-MM-DD') as "DESCRIPTION"
  from account_type@prod.world a
 where a.acc_type            in ('H')
   and rtrim(a.acc_sub_type) in ('CC', 'PC')
   and 0 = (select count(1)
              from print_category_access pca
             where pca.print_category   = 'CP'
               and pca.account_type     = a.acc_type
               and pca.account_sub_type = rtrim(a.acc_sub_type)
               and pca.channel_code     = 'NETWEB'
               and sysdate between pca.effective_date and pca.expiration_date)
;

/*
** Insert 'CS' aka Chess SMS invoice.
*/
insert into print_category_access
(
  print_category,
  account_type,
  account_sub_type,
  channel_code,
  effective_date,
  expiration_date,
  requires_email,
  description
  
)
select 'CS'                                    as "PRINT_CATEGORY"
     , a.acc_type                              as "ACCOUNT_TYPE"
     , rtrim(a.acc_sub_type)                   as "ACCOUNT_SUB_TYPE"
     , 'NETWEB'                                as "CHANNEL_CODE"
     , trunc(sysdate)                          as "EFFECTIVE_DATE"
     , to_date('4700-12-31', 'YYYY-MM-DD')     as "EXPIRATION_DATE"
     , 'N'                                     as "REQUIRES_EMAIL"
     , 'HGU ' || to_char(sysdate, 'YYYY-MM-DD') as "DESCRIPTION"
  from account_type@prod.world a
 where a.acc_type            in ('H')
   and rtrim(a.acc_sub_type) in ('CC', 'PC')
   and 0 = (select count(1)
              from print_category_access pca
             where pca.print_category   = 'CS'
               and pca.account_type     = a.acc_type
               and pca.account_sub_type = rtrim(a.acc_sub_type)
               and pca.channel_code     = 'NETWEB'
               and sysdate between pca.effective_date and pca.expiration_date)
;

/*
** List the BAN types allowed to have certain print categories...
*/
SELECT pca.*
  FROM print_category_access pca
ORDER BY pca.print_category, pca.account_type, pca.account_sub_type
;

-- commit work;
