SELECT *
  FROM csm_status_activity
 WHERE csa_activity_rsn_code = 'MM'
;

SELECT a.sub_status_last_act, a.sub_status_rsn_code
FROM subscriber a
WHERE a.subscriber_no = 'GSM04791877534'
  AND a.sub_status = 'A'
;

SELECT a.csa_activity_code, a.csa_activity_rsn_code, a.csa_activity_desc, a.csa_activity_rsn_desc
  FROM csm_status_activity a
 WHERE a.csa_activity_code = 'MCN'
   AND a.csa_activity_rsn_code = 'MM'
;
