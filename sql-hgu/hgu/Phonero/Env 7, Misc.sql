SELECT a.*
  FROM service_agreement a, subscriber s
 WHERE RTRIM(a.soc)    = 'PW10'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscriber_no = s.subscriber_no
   AND s.sub_status    = 'A'
;

/*
** List all PW10 subscriptions, with the APN (or a defined soc)...
*/
SELECT sf.ban, sf.subscriber_no, sf.soc, sf.operator_id, sf.application_id,
       sf.campaign, sf.feature_code, sf.service_type, sf.ftr_effective_date,
       sf.ftr_expiration_date, sf.ftr_add_sw_prm
  FROM service_agreement sa, service_feature sf
 WHERE RTRIM(sa.soc)    = 'PW10'
   AND sa.ban           = sf.ban
   AND sa.subscriber_no = sf.subscriber_no
   AND RTRIM(sf.soc)   IN ( 'HPAPN01', 'HPAPN02', 'HPAPN03', 'HPAPN04', 'HPAPN05', 'HPSMSP01' )
   AND SYSDATE    BETWEEN sf.ftr_effective_date AND NVL(sf.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
ORDER BY 1,2,3
;


SELECT a.*
  FROM service_agreement a
 WHERE 1 = 1
--   AND a.ban           = 217628502
   AND a.subscriber_no = 'GSM047' || '48861780'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2,3
;

SELECT a.ban, a.subscriber_no, a.soc, a.operator_id, a.application_id,
       a.campaign, a.feature_code, a.service_type, a.ftr_effective_date,
       a.ftr_expiration_date, a.ftr_add_sw_prm
  FROM service_feature a
 WHERE a.ban           = 217628502
   AND a.subscriber_no = 'GSM047' || '48860069'
   AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--   AND RTRIM(a.soc) LIKE 'CONBC%'
ORDER BY a.subscriber_no, a.ban, a.campaign, a.service_type, a.soc, a.feature_code, a.ftr_effective_date
;

SELECT a.*
  FROM service_feature a
 WHERE a.ban           = 217628502
   AND a.subscriber_no = 'GSM047' || '48860069'
   AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
ORDER BY 1,2,3
;

SELECT a.*
  FROM billing_account a
 WHERE a.customer_id = 217628502
;


SELECT a.*
  FROM service_agreement a
 WHERE a.subscriber_no = 'GSM047' || '48860001'
--   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2,3
;

SELECT a.*
  FROM tn_inv a
 WHERE a.ctn = '047'||'40400666'
;

SELECT a.*
  FROM tn_inv a
 WHERE a.nl         = 'PHO'
   AND a.ngp        = 'A'
   AND a.ctn_status = 'AA'
   AND a.ctn BETWEEN '04740399999' AND '04740550000'
   AND ROWNUM       < 101
ORDER BY 1
;

SELECT s.*
  FROM serial_item_inv s
 WHERE s.sim_type           = 505 -- SIM_TYPE 505 = 'Phonero mID UICC E1'
   AND s.curr_possession    = 'A'
   AND s.comited_to_pos_ind = 'N'
   AND ROWNUM               < 11
;

SELECT p.subscriber_no, p.dealer_code, s.*
  FROM serial_item_inv s, physical_device p
 WHERE p.subscriber_no IN (
          'GSM047' || '47230005'
   )
   AND p.equipment_no = s.serial_number
ORDER BY 1,3,4
;

SELECT a.soc, a.effective_date, a.operator_id, a.for_sale_ind, a.soc_description
     , a.soc_group, a.network_ind
  FROM soc a
 WHERE (
      a.soc LIKE 'ODB%'
   OR a.soc LIKE 'HP%'
  )
  AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 100)
ORDER BY 1,2
;

/*
** Find a subscription which doesn't have a set of socs...
*/
SELECT UNIQUE a.*
  FROM service_agreement a, subscriber s, service_agreement a2
 WHERE RTRIM(a.soc)    = 'PW10'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscriber_no = s.subscriber_no
   AND s.sub_status    = 'A'
   AND a.service_type  = 'P'
   AND 0 = (SELECT count(1) 
              FROM service_agreement a2
             WHERE a.ban           = a2.ban
               AND a.subscriber_no = a2.subscriber_no
               AND SYSDATE BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
               AND (a.soc        LIKE 'HPAPN%'
                 OR a.soc           = 'HPFORW01'
               )) 
;

/*
** Compare the MMS feature for two subscriptions...
*/
SELECT sf1.soc, sf1.feature_code
     , sf1.subscriber_no AS "SUB_NO_1", sf1.ftr_add_sw_prm AS "FEAT_PARAMS_NO_1"
     , sf2.subscriber_no AS "SUB_NO_2", sf2.ftr_add_sw_prm AS "FEAT_PARAMS_NO_2"
  FROM service_feature sf1, service_feature sf2
 WHERE (sf1.ban = 338361314 AND sf1.subscriber_no = 'GSM047'||'40401695')
   AND (sf2.ban = 889361317 AND sf2.subscriber_no = 'GSM047'||'48867828')
   AND sf1.soc          = 'PW10'
   AND sf1.soc          = sf2.soc
   AND sf1.feature_code = 'S-MMS2'
   AND sf1.feature_code = sf2.feature_code
   AND SYSDATE    BETWEEN sf1.ftr_effective_date AND sf1.ftr_expiration_date
   AND SYSDATE     BETWEEN sf2.ftr_effective_date AND sf2.ftr_expiration_date
ORDER BY sf1.soc, sf1.feature_code
;

/*
** List the MMS feature for all PW10 subscriptions...
*/
SELECT sf1.*
  FROM service_feature sf1
 WHERE sf1.soc          = 'PW10'
   AND sf1.feature_code = 'S-MMS2'
   AND SYSDATE    BETWEEN sf1.ftr_effective_date AND sf1.ftr_expiration_date
   AND (sf1.ban, sf1.subscriber_no) IN (SELECT a.ban, a.subscriber_no
                                          FROM service_agreement a, subscriber s
                                         WHERE RTRIM(a.soc)    = 'PW10'
                                           AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
                                           AND a.subscriber_no = s.subscriber_no
                                           AND s.sub_status    = 'A')
ORDER BY sf1.application_id, 2









