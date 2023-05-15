SELECT ba.ban, nd.first_name, nd.last_business_name, nd.birth_date, ad.adr_zip
  FROM billing_account ba, address_name_link anl, name_data nd, address_data ad
 WHERE 1 = 1
   AND ba.ban_status       = 'O'
   AND ba.account_type     = 'I'
   AND ba.account_sub_type = 'R'
   AND ba.ban              = anl.ban
   AND SYSDATE       BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.link_type       = 'L'
   AND anl.name_id         = nd.name_id
   AND anl.address_id      = ad.address_id
   AND nd.comp_reg_id      IS NULL
   AND ROWNUM < 11
;

SELECT a.*
  FROM address_data a
;

SELECT n.*
  FROM name_data n
;

SELECT l.*
  FROM address_name_link l
;

/*
Indexes:
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_1IX   CUSTOMER_ID     
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_1IX   SUBSCRIBER_NO   
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_1IX   BAN             
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_1UQ   LINK_SEQ_NO     
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_2IX   SUBSCRIBER_NO   
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_2IX   EFFECTIVE_DATE  
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_2IX   BAN             
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_3IX   NAME_ID         
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_4IX   ADDRESS_ID      
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_5IX   BAN             
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_5IX   LINK_TYPE       
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_5IX   EXPIRATION_DATE 
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_5IX   SUBSCRIBER_NO   
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_6IX   LINK_TYPE       
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_6IX   ADR_ZIP         
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_6IX   CONTROL_NAME    
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_6IX   ADDITIONAL_TITLE
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_7IX   CONTROL_NAME    
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_7IX   BIRTH_DATE      
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_8IX   BAN             
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_8IX   EFFECTIVE_DATE  
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_8IX   SYS_NC00026$    
ADDRESS_NAME_LINK   ADDRESS_NAME_LINK_8IX   SUBSCRIBER_NO   
*/

SELECT c.*
  FROM customer c
;

SELECT b.*
  FROM billing_account b
;

/*
DSP_ID = name_data.comp_reg_id

Private individual: billing_account.account_type = 'I'
                  : billing_account.account_sub_type = 'R'

billing_account.ban_status = 'O'
billing_account.ban = address_name_link.ban

*/
SELECT ba.ban, nd.first_name, nd.last_business_name, nd.birth_date, ad.adr_zip
     , nd.comp_reg_id, LENGTH(nd.comp_reg_id) AS "LEN_OF_DSP_ID"
  FROM billing_account ba, address_name_link anl, name_data nd, address_data ad
 WHERE 1 = 1
   --AND SYSDATE BETWEEN ba.effective_date AND NVL(ba.expiration_date, SYSDATE + 1)
   AND ba.ban_status       = 'O'
   AND ba.account_type     = 'I'
   AND ba.account_sub_type = 'R'
   AND ba.ban              = anl.ban
   AND anl.link_type       = 'L'
   AND anl.name_id         = nd.name_id
   AND anl.address_id      = ad.address_id
   AND nd.comp_reg_id      IS NOT NULL
   AND ROWNUM < 11
;

SELECT ba.ban, nd.first_name, nd.last_business_name, nd.birth_date, ad.adr_zip
  FROM billing_account ba, address_name_link anl, name_data nd, address_data ad
WHERE 1 = 1
   AND ba.ban_status       = 'O'
   AND ba.account_type     = 'I'
   AND ba.account_sub_type = 'R'
   AND ba.ban              = anl.ban
   AND SYSDATE       BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.link_type       = 'L'
   AND anl.name_id         = nd.name_id
   AND anl.address_id      = ad.address_id
   AND nd.comp_reg_id      IS NULL
   AND ROWNUM < 11
;

/*
ban         first_name      last_business_name  birth_date  adr_zip
672786605   TARJE           HELLEBUST           1960-04-01  0287
672786605   TARJE           HELLEBUST           1960-04-01  0287
672786605   TARJE           HELLEBUST           1960-04-01  0287
100388008   BIRGER NILS     CHRISTIANSEN        1931-04-19  0955
100388008   BIRGER          CHRISTIANSEN        1931-04-19  0955
100388008   BIRGER NILS     CHRISTIANSEN        1931-04-19  0955
876286600   GRZEGORZ M      SWIDERSKI           1970-09-03  5010
227757309   LUIS ALBERTO    LOPEZ               1966-08-20  1832
227757309   LUIS ALBERTO    LOPEZ               1966-08-20  1832
227757309   LUIS ALBERTO    LOPEZ               1966-08-20  1832
*/

SELECT anl.*
  FROM address_name_link anl
 WHERE anl.ban             = 672786605
   AND anl.link_type       = 'L'
;

SELECT /*+ hash(ba,anl) */ ba.ban, nd.first_name, nd.last_business_name, nd.birth_date, ad.adr_zip
  FROM billing_account@fokus ba, address_name_link@fokus anl, name_data@fokus nd, address_data@fokus ad
 WHERE ba.ban_status       = 'O'
   AND ba.account_type     = 'I'
   AND ba.ban              = anl.ban
   AND SYSDATE       BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.link_type       = 'L'
   AND anl.name_id         = nd.name_id
   AND anl.address_id      = ad.address_id
   AND nd.comp_reg_id      IS NULL
   AND NOT EXISTS (
      SELECT ''
        FROM dsp_request dr
       WHERE dr.customer_id    = ba.ban
         AND dr.process_status = 'WAITING')
   AND ROWNUM < 11
;

SELECT /*+ hash(ba,anl) */ ba.ban, nd.first_name, nd.last_business_name, nd.birth_date, ad.adr_zip
  FROM billing_account@fokus ba, address_name_link@fokus anl, name_data@fokus nd, address_data@fokus ad
 WHERE ba.ban_status       = 'O'
   AND ba.account_type     = 'I'
   AND ba.ban              = anl.ban
   AND SYSDATE       BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.link_type       = 'L'
   AND anl.name_id         = nd.name_id
   AND anl.address_id      = ad.address_id
   AND nd.comp_reg_id      IS NULL
   AND (ba.ban, 'WAITING') not in (SELECT dr.customer_id, dr.process_status FROM dsp_request dr)
   AND ROWNUM < 11
;
