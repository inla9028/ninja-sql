UPDATE system_defaults sd
   SET sd.value = REPLACE(sd.value, 'NetCom', 'Telia')
 WHERE sd.key LIKE 'SMS_FORBRUK%'
   AND sd.value LIKE '%NetCom%'
;

UPDATE sms_messages sm
   SET sm.msg_text = REPLACE(sm.msg_text, 'NetCom', 'Telia')
 WHERE sm.msg_text LIKE '%NetCom%'
;

UPDATE sms_messages sm
   SET sm.msg_text = REPLACE(sm.msg_text, 'netcom.no', 'telia.no')
 WHERE sm.msg_text LIKE '%netcom.no%'
;

UPDATE sms_messages sm
   SET sm.msg_text      = 'Vårt første forsøk på å hente ditt nr har ikke lykkes. Vi har sendt ny bestilling, og nytt tidspunkt for overføring til Telia er :PORT_DATETIME. Hilsen Telia'
 WHERE sm.msg_id        = 6
   AND sm.language_code = 'NO'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Our first attempt to transfer your number did not succeed. We''ve sent a new order, and the new time for the transfer to Telia is :PORT_DATETIME. Regards Telia'
 WHERE sm.msg_id        = 6
   AND sm.language_code = 'EN'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Vårt andre forsøk på å hente ditt nr har ikke lykkes. Vi har sendt ny bestilling, og nytt tidspunkt for overføring til Telia er :PORT_DATETIME. Hilsen Telia'
 WHERE sm.msg_id        = 7
   AND sm.language_code = 'NO'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Our second attempt to transfer your number did not succeed. We''ve sent a new order, and the new time for the transfer to Telia is :PORT_DATETIME. Regards Telia'
 WHERE sm.msg_id        = 7
   AND sm.language_code = 'EN'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Hei, nummeret ditt er bestilt av annen operatør. Vi vil minne om at brudd på bindingstid faktureres med kr :PORT_PENALTY. Ring 05050 for spørsmål. Hilsen Telia'
 WHERE sm.msg_id        = 8
   AND sm.language_code = 'NO'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Hi, your number has been ordered by another operator. Please remember that any remaining commitment time will be charged with :PORT_PENALTY NOK. For questions, please call 05050. Regards Telia'
 WHERE sm.msg_id        = 8
   AND sm.language_code = 'EN'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Hei, nummeret ditt vil bli overført til Telia :PORT_DATETIME. Husk å ha det nye SIM-kortet klart. Hilsen Telia'
 WHERE sm.msg_id        = 9
   AND sm.language_code = 'NO'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Hi, your number wil be transfered to Telia at :PORT_DATETIME. Remember to have the new SIM-card available. Regards Telia'
 WHERE sm.msg_id        = 9
   AND sm.language_code = 'EN'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Velkommen til Telia! Nå er mobilnummeret ditt :MSISDN overført. Ha en fortsatt fin dag, hilsen Telia'
 WHERE sm.msg_id        = 10
   AND sm.language_code = 'NO'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Welcome to Telia! Your mobile phonenumber :MSISDN has been transferred. Have a nice day! Regards Telia'
 WHERE sm.msg_id        = 10
   AND sm.language_code = 'EN'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Velkommen til Telia! Nå er mobilnummeret ditt :MSISDN overført. Ha en fortsatt fin dag, hilsen Telia'
 WHERE sm.msg_id        = 11
   AND sm.language_code = 'NO'
;
UPDATE sms_messages sm
   SET sm.msg_text      = 'Welcome to Telia! Your mobile phonenumber :MSISDN has been transferred. Have a nice day! Regards Telia'
 WHERE sm.msg_id        = 11
   AND sm.language_code = 'EN'
;

UPDATE socs_descriptions sd
   SET sd.description = REPLACE(sd.description, 'NetCom', 'Telia')
 WHERE sd.description LIKE '%NetCom%'
;

UPDATE feature_parameter_desc fd
   SET fd.description = REPLACE(fd.description, 'NetCom', 'Telia')
 WHERE fd.description LIKE '%NetCom%'
;

UPDATE priceplan_campaign_descr pcd
   SET pcd.description = REPLACE(pcd.description, 'NetCom', 'Telia')
 WHERE pcd.description LIKE '%NetCom%'
;

UPDATE telephone_number_specification tns
   SET tns.comments = REPLACE(tns.comments, 'NetCom', 'Telia')
 WHERE tns.comments LIKE '%NetCom%'
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

INSERT INTO system_defaults (KEY,VALUE,VALUE_TYPE,DESCRIPTION) VALUES (
'BLOCK_ADDING_EXISTING_DISCOUNT_ENABLED', 'N', 'STRING', 'Block adding new discount when it is already exists'
);

INSERT INTO system_defaults (KEY,VALUE,VALUE_TYPE,DESCRIPTION) VALUES (
'DISCOUNT_FUNCTIONALITY_ENABLED_TYPE', 'New', 'STRING', 'The Discount functionality type enabled'
);

