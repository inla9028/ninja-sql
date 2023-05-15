select * from service_agreement sa1, billing_account b
where soc='PPTA' and sysdate between effective_date and expiration_date
and b.ban=sa1.ban and b.curr_root_ban != 0
and exists (select 1 from service_agreement sa2
where sa2.ban= sa1.ban
and sa2.subscriber_no=sa1.subscriber_no
and sa2.soc = 'PPTAVENN'
and sysdate between sa2.effective_date and sa2.expiration_date)
and rownum < 10

select * from billing_account where ban=477418404

select * from soc where soc like '%VENN'

select * from service_agreement sa, billing_account b where soc like 'PPTCVENN%'
and sysdate between effective_date and expiration_date
and sa.soc_ver_no=0
and b.ban=sa.ban
and b.curr_root_ban is null
and b.ban_status='O'
and rownum < 10

select * from billing_account where ban=185352408

select * from service_agreement where subscriber_no='GSM04793876223' and sysdate between effective_date and expiration_date

select * from service_agreement where subscriber_no='GSM04795143969' and soc = 'PPTCVENN'

select * from service_feature where subscriber_no='GSM04793080111' and soc in ('PPTCVENN','PPTC')


