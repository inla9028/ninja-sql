
SELECT  ci.feature_code, bd.language_code, fb.bp_bill_format
   FROM     charge_info           ci,
                  bill_category         bc, 
                  feature_bill_category fb ,
                  --feature_category fb ,
                  bill_desc             bd
WHERE    rtrim(ci.feature_code)= 'PORTOU'
   --AND      
   --ci.ftr_revenue_code = 'U'
   AND      
   ci.charge_type = 'F'
   AND      rtrim(ci.feature_category) = rtrim(fb.feature_category)
   --AND      fb.bp_bill_format = <BP_FORMAT from billing_parameters table>
    and      fb.bp_bill_format = bc.bp_bill_format
    and      fb.category_code = bc.category_code
    and      bd.bill_desc_seq_num  = bc.desc_seq
    --and      bd.language_code  = <language from billing_parameters table>;
    --group by feature_code
    
    
    select * from feature_category where ftr_category='TAXZ'
    
    select * from bill_category 
    
    select * from feature_bill_category where feature_category='TAXZ'
    
    select * from bill_desc where bill_desc_seq_num=1003694
    where desc_text like 'Prepaid%'
    
    select * from charge where ban = 132195009 and feature_code='CRNOTX'
    
    select * from charge_info where feature_code='CHRGXT'
    
    
    select * from adjustment_reason where reason_code='KORGEC'
    
    select * from adjustment_reason where bl_txt_ovr_ind = 'Y'
    
    SELECT rtrim(a.soc) AS CODE, rtrim(b.language_code) AS LANGUAGE, rtrim(b.desc_text) AS DESC_TEXT 
   FROM soc a, bill_desc b 
WHERE a.expiration_date is null 
--and a.soc like 'INSUR%'
       and a.soc_desc_seq = b.bill_desc_seq_num 
       
       SELECT soc, language_code, count(*) 
   FROM soc a, bill_desc b 
WHERE a.expiration_date is null 
--and a.soc like 'INSUR%'
       and a.soc_desc_seq = b.bill_desc_seq_num 
       group by soc, language_code having count(*) > 1


    
    select desc_text from feature, bill_desc where feature_code='ACTFEE'
    and ftr_desc_seq = bill_desc_seq_num
    
    select * from feature_types where feature_type='FCH'
    
    select * from charge where chg_creation_date between '1-NOV-2007' and 
      select * from charge where ban = 132195009 and ent_seq_no in (213116544,
213116545,
213116546,
213116547,
213116548
)
    
    select * from cycle_control where cycle_code=1 and cycle_run_year=2008
    
    select * from adjustment where actv_reason_code='DEPRET'
    
select * from billing_account where bill_cycle=1 and ban_status='O'

select * from bill where ban=132195009

select * from charge where ban = 132195009
and actv_bill_seq_no >= ( select bl_cur_bill_seq_no from billing_account where ban =  132195009 )

select bl_cur_bill_seq_no from billing_account where ban =  132195009

select * from charge where 
actv_bill_seq_no >= ( select bl_cur_bill_seq_no from billing_account where ban =  132195009 and bill_cycle=1 and ban_status = 'O' )
and feature_code='FLEX'
and rownum < 2

select bl_cur_bill_seq_no from billing_account where ban =  132195009

select * from charge where feature_code='KORFAK'  and rownum < 2

SELECT *   FROM CHARGE  WHERE ban = 132195009   AND ent_seq_no = 213116544

SELECT *   FROM CHARGE  WHERE ftr_revenue_code='O' and subscriber_no is not null


