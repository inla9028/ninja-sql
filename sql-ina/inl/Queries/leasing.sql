select * from subscriber where sub_status='A'

select * from subscriber where subscriber_no='GSM04793002233'

select * from soc where soc= 'PSFW'

select * from soc_illegal_comb where soc_first like 'LEAS1%' or soc_second like 'LEAS1%'

select * from soc_loan where soc='LEAS1'

select * from commit_soc_relation
where soc like 'LEAS3%'

select * from campaign_commitments where campaign_seq=2112

select * from service_agreement where soc in ('LEAS2','LEAS1') and expiration_date > sysdate order by subscriber_no

select * from service_agreement where subscriber_no='GSM04793001845'

select * from acc_ban_lock where ban=109338004

select * from campaign where campaign like 'PSFW%'


select * from service_feature where soc = 'LEAS1' and ftr_soc_ver_no=1

select * from service_feature where subscriber_no='GSM04793001846' and soc = 'LEAS2'

select * from physical_device where equipment_no='08947080004002290467'

select * from SOC_ACC_TYP_LOAN_REL

select * from campaign_commitments where imei_ind='Y' and sale_exp_date is null and campaign in (
'PPTO12OP',
'PPTP12OP',
'PPTZ12OP',
'PPTQ12OP',
'PSFW12OP')


select * from soc_acc_typ_rel where soc like 'LEAS%'
