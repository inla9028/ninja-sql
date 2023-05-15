SELECT a.ban, a.subscriber_no, a.dealer_code, a.sales_agent, a.soc 
DECODE(s.rms_ref_od, '1', 'FRIFASKON', '2', 'FRIFASYT','FRIFAS') as soc
  FROM subscriber@NEDE10 s, service_agreement@NEDE10 a  
  WHERE s.customer_id = a.ban
    and s.subscriber_no=a.subscriber_no
    AND s.sub_status='A'
    and a.subscriber_no!='0000000000'
    and a.soc in ('FRIFAS','FRIFASKON','FRIFASYT') 
    AND SYSDATE BETWEEN a.effective_date AND a.expiration_date 
    AND NOT EXISTS ( 
      SELECT '' FROM service_agreement@NEDE10 b
        WHERE b.ban           = a.ban 
          AND b.subscriber_no = '0000000000'
          AND rtrim(b.soc) = 'FRIFASJEF'
          AND SYSDATE BETWEEN b.effective_date AND b.expiration_date           
    )
    
    select * from service_agreement@NEDE10 where soc='FRIFASJEF'
    
    select * from service_agreement@NEDE10 where ban = 121395008
    and subscriber_no = 'GSM04745457060'
    
    select * from subscriber@NEDE10 where subscriber_no='GSM04745457060'
    
    select * from subscription_types_socs s,  service_agreement@NEDE10 c
                where subscriber_no = 'GSM04745457060'
                and rtrim(s.subscription_type_id)=rtrim(c.soc)||'REG1'
                AND s.soc in ('FRIFAS','FRIFASKON','FRIFASYT') 
                and sysdate between s.effective_date and s.expiration_date
                and sysdate between c.effective_date and c.expiration_date
