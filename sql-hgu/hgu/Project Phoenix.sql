/*
** List all lines with NetCom in it...
*/
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== SMS Forbruk...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT sd.*
  FROM system_defaults sd
 WHERE sd.key LIKE 'SMS_FORBRUK%'
   AND sd.value LIKE '%NetCom%'
ORDER BY 1, 2
;

UPDATE system_defaults sd
   SET sd.value = REPLACE(sd.value, 'NetCom', 'Telia')
 WHERE sd.key LIKE 'SMS_FORBRUK%'
   AND sd.value LIKE '%NetCom%'
;

SELECT sd.*
  FROM system_defaults sd
 WHERE sd.key LIKE 'SMS_FORBRUK%'
   AND sd.value LIKE '%Telia%'
ORDER BY 1, 2
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== SMS Messages
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT sm.*
  FROM sms_messages sm
 WHERE sm.msg_text LIKE '%NetCom%'
ORDER BY 1, 2
;

UPDATE sms_messages sm
   SET sm.msg_text = REPLACE(sm.msg_text, 'NetCom', 'Telia')
 WHERE sm.msg_text LIKE '%NetCom%'
;

SELECT sm.*
  FROM sms_messages sm
 WHERE sm.msg_text LIKE '%Telia%'
ORDER BY 1, 2
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== SMS Messages, url's.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT sm.*
  FROM sms_messages sm
 WHERE sm.msg_text LIKE '%netcom.no%'
ORDER BY 1, 2
;

UPDATE sms_messages sm
   SET sm.msg_text = REPLACE(sm.msg_text, 'netcom.no', 'telia.no')
 WHERE sm.msg_text LIKE '%netcom.no%'
;

SELECT sm.*
  FROM sms_messages sm
 WHERE sm.msg_text LIKE '%telia.no%'
ORDER BY 1, 2
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Soc descriptions
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT sd.*
  FROM socs_descriptions sd
 WHERE sd.description LIKE '%NetCom%'
ORDER BY 1, 2
;

UPDATE socs_descriptions sd
   SET sd.description = REPLACE(sd.description, 'NetCom', 'Telia')
 WHERE sd.description LIKE '%NetCom%'
;

SELECT sd.*
  FROM socs_descriptions sd
 WHERE sd.description LIKE '%Telia%'
ORDER BY 1, 2
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Feature parameter descriptions
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT fd.*
  FROM feature_parameter_desc fd
 WHERE fd.description LIKE '%NetCom%'
ORDER BY 1, 2
;

UPDATE feature_parameter_desc fd
   SET fd.description = REPLACE(fd.description, 'NetCom', 'Telia')
 WHERE fd.description LIKE '%NetCom%'
;

SELECT fd.*
  FROM feature_parameter_desc fd
 WHERE fd.description LIKE '%Telia%'
ORDER BY 1, 2
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Priceplans descriptions
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT pcd.*
  FROM priceplan_campaign_descr pcd
 WHERE pcd.description LIKE '%NetCom%'
ORDER BY 1, 2
;

UPDATE priceplan_campaign_descr pcd
   SET pcd.description = REPLACE(pcd.description, 'NetCom', 'Telia')
 WHERE pcd.description LIKE '%NetCom%'
;

SELECT pcd.*
  FROM priceplan_campaign_descr pcd
 WHERE pcd.description LIKE '%Telia%'
ORDER BY 1, 2
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Telephone number specs - comments only, but why not?
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT tns.*
  FROM telephone_number_specification tns
 WHERE tns.comments LIKE '%NetCom%'
ORDER BY 1, 2
;

UPDATE telephone_number_specification tns
   SET tns.comments = REPLACE(tns.comments, 'NetCom', 'Telia')
 WHERE tns.comments LIKE '%NetCom%'
;

SELECT tns.*
  FROM telephone_number_specification tns
 WHERE tns.comments LIKE '%Telia%'
ORDER BY 1, 2
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== System Defaults - SMS'es from HOMERUN
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT sd.*
  FROM system_defaults sd
 WHERE sd.key LIKE 'SMS_HOMERUN%'
ORDER BY 1, 2
;

INSERT INTO system_defaults VALUES('SMS_HOMERUN_CODEWORD',
'HOMERUN'
, 'STRING', 'The code-word sent to 1989 to trigger the job');

INSERT INTO system_defaults VALUES('SMS_HOMERUN_SENDER',
'Telia'
, 'STRING', 'The sender of the SMSes to the users');

INSERT INTO system_defaults VALUES('SMS_HOMERUN_MSG_ACTIVATED',
'Vi takker for din bestilling av Homerun. Du vil få en SMS når tjenesten er aktivisert'
, 'STRING', 'SMS stating that Homerun has been activated');

INSERT INTO system_defaults VALUES('SMS_HOMERUN_MSG_ERROR',
'Beklager, noe gikk galt ved bestilling av HomeRun. Vennligst kontakt kundeservice på tlf 05051 eller https://telia.no/tjeneste/homerun'
, 'STRING', 'SMS stating that there was ');

INSERT INTO system_defaults VALUES('SMS_HOMERUN_MSG_NOT_AVAILABLE',
'Beklager, HomeRun kan ikke aktiveres på ditt abonnement (${Priceplan}). HomeRun er tilgjengelig på Telias bedrifts- og dataabonnementer.'
, 'STRING', 'SMS stating that Homerun was not available for addition. ${Priceplan} can be used...');

INSERT INTO system_defaults VALUES('SMS_HOMERUN_MSG_PASSWORD',
'Din HomeRun tjeneste er allerede aktivert. Brukernavnet er mobilnummer (${Username}) og passordet er: (${Password}). For hjelp: https://telia.no/tjeneste/homerun'
, 'STRING', 'SMS containing the ${Username} and ${Password} for the Homerun service.');

INSERT INTO system_defaults VALUES('SMS_HOMERUN_MSG_PASSWORD_ORDERED',
'Nytt HomeRun passord er bestilt, du vil straks få en ny SMS når det er aktivisert.'
, 'STRING', 'SMS containing the ${Username} and ${Password} for the Homerun service.');

INSERT INTO system_defaults VALUES('SMS_HOMERUN_MSG_PASSWORD_NOT_FOUND',
'Beklager, du har HomeRun tjenesten men vi finner ikke igjen ditt passord. Vennligst kontakt kundeservice på tlf 05051 eller https://telia.no/tjeneste/homerun'
, 'STRING', 'SMS explaining that user has Homerun, but we could not find his password.');

SELECT sd.*
  FROM system_defaults sd
 WHERE sd.key LIKE 'SMS_HOMERUN%'
ORDER BY 1, 2
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Misc...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT sd.*
  FROM system_defaults sd
 WHERE sd.key LIKE 'BLOCK%'
ORDER BY 1, 2
;

INSERT INTO system_defaults (KEY,VALUE,VALUE_TYPE,DESCRIPTION) VALUES (
'BLOCK_ADDING_EXISTING_DISCOUNT_ENABLED', 'N', 'STRING', 'Block adding new discount when it is already exists'
);

SELECT sd.*
  FROM system_defaults sd
 WHERE sd.key LIKE 'BLOCK%'
ORDER BY 1, 2
;

