/*
** Display all account types (in Fokus)
*/
select a.acc_type, a.acc_sub_type, a.description
  from account_type@fokus a
 where a.acc_type     not in ('H', 'S')
   and a.acc_sub_type not in ('T2', 'TX')
   and (
        a.acc_type     not in ('P') 
    and a.acc_sub_type not in ('P', 'R')
   )
order by a.acc_type, a.acc_sub_type, a.description
;

/*
** Display all Print Categories (in Fokus)
*/
SELECT PRINT_CATEGORY, PRINT_CAT_PRIORITY, BILL_PRINT_IND
     , CSM_SELECT_IND, PRINT_CAT_DESC
  FROM print_categories@fokus
 WHERE csm_select_ind = 'Y'
ORDER BY PRINT_CATEGORY
;

/*
** List the BAN types allowed to have certain print categories...
*/
select pca.*
  from print_category_access pca
;

/*
** List the BAN types allowed to have certain print categories...
*/
select pcat.*
  from print_category_account_type pcat
;
