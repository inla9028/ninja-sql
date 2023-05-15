/*
** Inserts for a new SP + Dealer which may access Phonero subscriptions.
*/

/*INSERT INTO dealers
SELECT 'PO02' AS "DEALER_CODE", a.dealer_group
  FROM dealers a
 WHERE a.dealer_code = 'PO01'
;*/

SELECT a.*
  FROM dealers a
 WHERE a.dealer_code IN ('PO01','PO02')
ORDER BY 1
;


INSERT INTO channels
SELECT 'PhoneroOnline' AS "CHANNEL_CODE", 'Phonero Online' AS "CHANNEL_DESC"
     , a.default_man_ind, a.default_dealer_code
  FROM channels a
 WHERE a.channel_code         = 'Phonero'
   AND a.default_dealer_code  = 'PO01'
;

SELECT a.*
  FROM channels a
 WHERE a.channel_code IN ('Phonero', 'PhoneroOnline')
ORDER BY 1
;


INSERT INTO ninja_user
SELECT 'PhoneroOnline' AS "USERNAME", a.default_channel_code, a.contact_id
  FROM ninja_user a
 WHERE a.username = 'Phonero'
;

SELECT a.*
  FROM ninja_user a
 WHERE a.username IN ('Phonero', 'PhoneroOnline')
ORDER BY 1
;


INSERT INTO service_providers
SELECT 'PhoneroOnline' AS "SERVICE_PROVIDER_CODE"
     , 862976313       AS "ROOT_BAN"
     , 172976318       AS "CURRENT_ACTIVE_BAN"
     , a.max_subscriptions
     , 'PO02'          AS "DEALER_CODE"
     , a.short_name, a.language_code, a.ban_sub_type, a.operator_code,
       a.last_business_name, a.first_name, a.adr_country, a.adr_zip,
       a.adr_street_name, a.adr_city, a.adr_house_letter,
       a.adr_house_no, a.adr_door_no, a.adr_story, a.adr_email,
       a.physical_hlr_cd, a.min_no_of_activation_bans,
       a.ban_structure_ind, a.max_subs_per_tree, a.expiration_date,
       a.bill_cycle
  FROM service_providers a
 WHERE a.service_provider_code = 'Phonero'
   AND SYSDATE < NVL(a.expiration_date, SYSDATE + 1)
;

SELECT a.*
  FROM service_providers a
 WHERE a.service_provider_code IN ('Phonero', 'PhoneroOnline')
   AND SYSDATE < NVL(a.expiration_date, SYSDATE + 1)
 ORDER BY 1
;


INSERT INTO ninja_jobs
SELECT a.machine_id
     , 95                                  AS "JOB_ID"
     , 'STOPPED'                           AS "JOB_STATUS"
     , 'N'                                 AS "WAS_RUNNING"
     , a.sleep_time, a.next_exec_time, a.status_time
     , NULL                                AS "STATUS_DESC"
     , a.exec_method
     , REPLACE(a.job_desc, 'PO01', 'PO02') AS "JOB_DESC"
     , a.fixed_start, a.hlr_based
  FROM ninja_jobs a
 WHERE a.exec_method = 'monitorSPBans'
   AND a.machine_id  = 'NINJAP1_DEMON'
   AND a.job_id      = 94
;

SELECT a.machine_id, a.job_id, a.exec_method, a.job_desc
  FROM ninja_jobs a
 WHERE a.machine_id  = 'NINJAP1_DEMON'
   AND a.job_id      IN ( 94, 95 )
ORDER BY 1,2
;


INSERT INTO ninja_jobs_parameters
SELECT a.machine_id
     , 95                                                     AS "JOB_ID"
     , a.parameter_order
     , REPLACE(a.parameter_value, 'Phonero', 'PhoneroOnline') AS "PARAMETER_VALUE"
     , a.parameter_description
  FROM ninja_jobs_parameters a
 WHERE a.machine_id  = 'NINJAP1_DEMON'
   AND a.job_id      = 94
;

SELECT a.machine_id, a.job_id, a.parameter_order, a.parameter_value
  FROM ninja_jobs_parameters a
 WHERE a.machine_id  = 'NINJAP1_DEMON'
   AND a.job_id      IN ( 94, 95 )
ORDER BY 1,2,3
;


-- Remember to check if we need configurations per channel/subscription-type as well!!!
INSERT INTO sub_typ_soc_channel
SELECT a.subscription_type_id, a.soc, 'PhoneroOnline' AS "CHANNEL_CODE",
       a.effective_date, a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
 WHERE a.channel_code = 'Phonero'
;

SELECT a.channel_code, a.subscription_type_id, count(1) AS "COUNT"
  FROM sub_typ_soc_channel a
 WHERE a.channel_code IN ('Phonero', 'PhoneroOnline')
GROUP BY a.channel_code, a.subscription_type_id
ORDER BY 1,2
;


-- Remember to update SYSTEM_DEFAULTS. 
INSERT INTO system_defaults VALUES (
    'NP_POST_MOVE_CANCEL_RESUME_SOURCE_COMBINATIONS',
    'S/PO/PW10',
    'STRING',
    'Acc.Type, SubType and Priceplan (formatted "A/B/C, D/E/F") for which to perform a cancel/resume'
);

INSERT INTO system_defaults VALUES (
    'NP_POST_MOVE_CANCEL_RESUME_TARGET_COMBINATIONS',
    'S/PO/PW10',
    'STRING',
    'Acc.Type, SubType and Priceplan (formatted "A/B/C, D/E/F") for which to perform a cancel/resume'
);

/*
** Warning - the following config change is incompatible with current code,
** it needs to be added during deployment of new Ninja code!!!!
*/ 
INSERT INTO system_defaults VALUES (
    'SP_DEALER_CODES_SHARING_ACCESS',
    'CH01=CH07, PO01=PO02',
    'STRING',
    'Dealers who may access each others via SP/SPM (formatted as "DLR1=DLR2, DLR3=DLR4, DLR1=DLR4")'
);

SELECT a.*
  FROM system_defaults a
 WHERE a.KEY IN (
   'NP_POST_MOVE_CANCEL_RESUME_SOURCE_COMBINATIONS',
   'NP_POST_MOVE_CANCEL_RESUME_TARGET_COMBINATIONS',
   'SP_DEALER_CODES_SHARING_ACCESS'
 )
ORDER BY 1
;


