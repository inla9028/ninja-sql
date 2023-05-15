SELECT sd.*
  FROM system_defaults sd
 WHERE (sd.key LIKE 'SMS_FORBRUK%' or sd.key LIKE 'SMS_HOMERUN%' or sd.key LIKE 'BLOCK%')
   AND sd.value LIKE '%Telia%'
ORDER BY 1, 2
;

SELECT sm.*
  FROM sms_messages sm
 WHERE sm.msg_text LIKE '%Telia%'
ORDER BY 1, 2
;

SELECT sm.*
  FROM sms_messages sm
 WHERE sm.msg_text LIKE '%telia.no%'
ORDER BY 1, 2
;

SELECT sd.*
  FROM socs_descriptions sd
 WHERE sd.description LIKE '%Telia%'
ORDER BY 1, 2
;

SELECT fd.*
  FROM feature_parameter_desc fd
 WHERE fd.description LIKE '%Telia%'
ORDER BY 1, 2
;

SELECT pcd.*
  FROM priceplan_campaign_descr pcd
 WHERE pcd.description LIKE '%Telia%'
ORDER BY 1, 2
;

SELECT tns.*
  FROM telephone_number_specification tns
 WHERE tns.comments LIKE '%Telia%'
ORDER BY 1, 2
;

SELECT sd.*
  FROM system_defaults sd
 WHERE sd.key LIKE 'BLOCK%'
ORDER BY 1, 2
;

