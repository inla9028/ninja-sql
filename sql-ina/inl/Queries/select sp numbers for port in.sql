select ctn, nl, ngp from subscriber s, billing_account b, tn_inv where ban_status='O'
and account_type='S'
and sub_status='A'
and s.customer_id = b.ban
and 'GSM'||ctn=subscriber_no
and ctn_status='AI'
and nl='SIT'
and rownum <10

