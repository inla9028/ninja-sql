/*
** Display all account types (in Fokus)
*/
select a.acc_type, a.acc_sub_type, a.description
  from account_type@fokus a
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
select pcat.*
  from print_category_account_type pcat
order by pcat.print_category, pcat.account_type, pcat.account_sub_type
;

/*
** Trim any white-spaces in the existing data.
*/
update print_category_account_type pcat
   set pcat.account_sub_type  = rtrim(pcat.account_sub_type)
 where pcat.account_sub_type != rtrim(pcat.account_sub_type)
;

/*
** Insert 'EE' aka Email invoice.
*/
insert into print_category_account_type
(
  print_category,
  account_type,
  account_sub_type
)
select 'EE' as "PRINT_CATEGORY", a.acc_type, rtrim(a.acc_sub_type)
  from account_type@fokus a
 where a.acc_type            not in ('H', 'S')
   and rtrim(a.acc_sub_type) not in ('T2', 'TX')
   and (
        a.acc_type            not in ('P') 
    and rtrim(a.acc_sub_type) not in ('P', 'R')
   )
   and ('EE', a.acc_type, rtrim(a.acc_sub_type)) not in (
     select tmp.print_category, tmp.account_type, tmp.account_sub_type
       from print_category_account_type tmp
  )
;

/*
** Insert 'RG' aka Paper invoice.
*/
insert into print_category_account_type
(
  print_category,
  account_type,
  account_sub_type
)
select 'RG' as "PRINT_CATEGORY", a.acc_type, rtrim(a.acc_sub_type)
  from account_type@fokus a
 where a.acc_type            not in ('H', 'S')
   and rtrim(a.acc_sub_type) not in ('T2', 'TX')
   and (
        a.acc_type            not in ('P') 
    and rtrim(a.acc_sub_type) not in ('P', 'R')
   )
   and ('RG', a.acc_type, rtrim(a.acc_sub_type)) not in (
     select tmp.print_category, tmp.account_type, tmp.account_sub_type
       from print_category_account_type tmp
  )
;

/*
** Insert 'CM' aka Chess Email invoice.
*/
insert into print_category_account_type
(
  print_category,
  account_type,
  account_sub_type
)
select 'CM' as "PRINT_CATEGORY", a.acc_type, rtrim(a.acc_sub_type)
  from account_type@fokus a
 where a.acc_type            in ('H')
   and rtrim(a.acc_sub_type) in ('CC', 'PC')
   and ('CM', a.acc_type, rtrim(a.acc_sub_type)) not in (
     select tmp.print_category, tmp.account_type, tmp.account_sub_type
       from print_category_account_type tmp
  )
;

/*
** Insert 'CP' aka Chess Paper invoice.
*/
insert into print_category_account_type
(
  print_category,
  account_type,
  account_sub_type
)
select 'CP' as "PRINT_CATEGORY", a.acc_type, rtrim(a.acc_sub_type)
  from account_type@fokus a
 where a.acc_type            in ('H')
   and rtrim(a.acc_sub_type) in ('CC', 'PC')
   and ('CP', a.acc_type, rtrim(a.acc_sub_type)) not in (
     select tmp.print_category, tmp.account_type, tmp.account_sub_type
       from print_category_account_type tmp
  )
;

/*
** Insert 'CS' aka Chess SMS invoice.
*/
insert into print_category_account_type
(
  print_category,
  account_type,
  account_sub_type
)
select 'CS' as "PRINT_CATEGORY", a.acc_type, rtrim(a.acc_sub_type)
  from account_type@fokus a
 where a.acc_type            in ('H')
   and rtrim(a.acc_sub_type) in ('CC', 'PC')
   and ('CS', a.acc_type, rtrim(a.acc_sub_type)) not in (
     select tmp.print_category, tmp.account_type, tmp.account_sub_type
       from print_category_account_type tmp
  )
;

/*
** List the BAN types allowed to have certain print categories...
*/
select pcat.*
  from print_category_account_type pcat
order by pcat.print_category, pcat.account_type, pcat.account_sub_type
;

-- commit work;
