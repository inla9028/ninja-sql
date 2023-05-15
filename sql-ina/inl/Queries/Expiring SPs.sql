select account_sub_type, description, ban_status, count(*)
from billing_account b, account_type a
where account_type='S'
and account_sub_type in('ST','DI','YO','AX','CB','AC','MF','TM','MO','MB','CM','MC')
and ban_status not in ('C','N')
and acc_type='S'
and acc_sub_type = account_sub_type
group by account_sub_type, description, ban_status
order by account_sub_type, ban_status

select account_sub_type,  ban_status, count(*)
from billing_account b
where account_type='S'
and account_sub_type in('ST','DI','YO','AX','CB','AC','MF','TM','MO','MB','CM','MC')
and ban_status not in ('C','N')
group by account_sub_type,  ban_status
order by account_sub_type, ban_status

select * from account_type
where acc_sub_type in('ST','DI','YO','AX','CB','AC','MF','TM','MO','MB','CM','MC')

select * from subscriber where sub_status != 'C' 
and customer_id in (select ban from billing_account
where account_type='S'
and account_sub_type in('ST','DI','YO','AX','CB','AC','MF','TM','MO','MB','CM','MC')
and ban_status not in ('C','N'))
