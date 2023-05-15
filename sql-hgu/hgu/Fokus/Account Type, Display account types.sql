--==
--== Display all account types
--==
select a.acc_type, a.acc_sub_type, a.description
  from account_type a
order by a.acc_type, a.acc_sub_type, a.description
;

--==
--== Display all account types - and all columns...
--==
select a.*
  from account_type a
;

--==--==--== Same as above, but via db-link from the Ninja database... --==--==--==

--==
--== Display all account types
--==
select a.acc_type, a.acc_sub_type, a.description
  from account_type@fokus a
order by a.acc_type, a.acc_sub_type, a.description
;

--==
--== Display all account types - and all columns...
--==
select a.*
  from account_type@fokus a
;
