SELECT sd.*
  FROM system_defaults sd
 WHERE (sd.key LIKE 'SMS_FORBRUK%' or sd.key LIKE 'SMS_HOMERUN%' or sd.key LIKE 'BLOCK%')
   AND sd.value LIKE '%NetCom%'
ORDER BY 1, 2
;

SELECT sm.*
  FROM sms_messages sm
 WHERE sm.msg_text LIKE '%NetCom%'
ORDER BY 1, 2
;

SELECT sm.*
  FROM sms_messages sm
 WHERE sm.msg_text LIKE '%netcom.no%'
ORDER BY 1, 2
;

SELECT sd.*
  FROM socs_descriptions sd
 WHERE sd.description LIKE '%NetCom%'
ORDER BY 1, 2
;

SELECT fd.*
  FROM feature_parameter_desc fd
 WHERE fd.description LIKE '%NetCom%'
ORDER BY 1, 2
;

SELECT pcd.*
  FROM priceplan_campaign_descr pcd
 WHERE pcd.description LIKE '%NetCom%'
ORDER BY 1, 2
;

SELECT tns.*
  FROM telephone_number_specification tns
 WHERE tns.comments LIKE '%NetCom%'
ORDER BY 1, 2
;

SELECT sd.*
  FROM system_defaults sd
 WHERE sd.key LIKE 'BLOCK%'
    OR sd.key LIKE 'DISCOUNT%'
ORDER BY 1, 2
;

