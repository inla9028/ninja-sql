DELETE FROM spm_priceplan_mapping;

INSERT INTO spm_priceplan_mapping 
VALUES('Chilimobil','VOICE','PVJA',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Added PVJA as VOICE.');
INSERT INTO spm_priceplan_mapping 
VALUES('Chilimobil','PREPAID_B','PVJE',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Added PVJE as PREPAID_B.');
INSERT INTO spm_priceplan_mapping 
VALUES('Chilimobil','PREPAID_A','PVJD',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Added PVJD as PREPAID_A.');
INSERT INTO spm_priceplan_mapping 
VALUES('Chilimobil','MBB','PVJC',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Added PVJC as MBB.');
INSERT INTO spm_priceplan_mapping 
VALUES('NewCo','VOICE','PW20',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Added PW20 as VOICE.');
INSERT INTO spm_priceplan_mapping 
VALUES('Phonero','VOICE','PW10',TO_DATE('2017-05-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Added PW10 as VOICE, for now.');
INSERT INTO spm_priceplan_mapping 
VALUES('PhoneroOnline','VOICE','PW10',TO_DATE('2017-08-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Phonero needed a second user for Online transactions');
INSERT INTO spm_priceplan_mapping 
VALUES('Svea','MBB','PVSB',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Added PVSB as MBB.');
INSERT INTO spm_priceplan_mapping 
VALUES('Svea','VOICE','PVSA',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Added PVSA as VOICE.');
INSERT INTO spm_priceplan_mapping 
VALUES('Telavox','MBB','PVGC',TO_DATE('2018-06-06 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Added PVGC as MBB.');
INSERT INTO spm_priceplan_mapping 
VALUES('Telavox','VOICE','PVGA',TO_DATE('2018-06-06 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'H�kan: Added PVGA as VOICE.');

DELETE FROM spm_service_mapping;

INSERT INTO spm_service_mapping 
VALUES('APN1','HPAPN','HPAPN01',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('APN2','HPAPN','HPAPN02',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('APN3','HPAPN','HPAPN03',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('APN4','HPAPN','HPAPN04',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('APN5','HPAPN','HPAPN05',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_18XX','ODB','ODBP1',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_5_DIGIT_NUMBERS','ODB','ODBP4',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_8XX','ODB','ODBP2',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_ALL_OUTGOING_CALLS','ODB','ODB4',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_ALL_OUTGOING_CALLS_EX_SMS','ODB','ODB4B',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_ALL_OUTGOING_INTERNATIONAL','ODB','ODB5',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CALL_FORWARDING','ODB','ODBCF',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CALL_INCOMING','ODB','ODB1',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CALL_ROAMING','ODB','ODB3',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CALL_ROAMING_INCOMING','ODB','ODB2',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CPA_AMOUNT_100','ODB','ODBCPA4',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CPA_AMOUNT_1000','ODB','ODBCPA3',TO_DATE('2017-11-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CPA_AMOUNT_2000','ODB','ODBCPA5',TO_DATE('2017-11-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CPA_AMOUNT_250','ODB','ODBCPA1',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CPA_AMOUNT_500','ODB','ODBCPA2',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CPA_CONTENT','ODB','ODBCPA',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_CPA_GOODS_AND_SERVICES','ODB','ODBCPAG',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_DATA_ALL','ODB','ODB8B',TO_DATE('2019-01-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_DATA_ALL_RESTART_REQUIRED','ODB','ODB8',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_DATA_ROAMING','ODB','ODB9',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_DONATION_NUMBERS','ODB','ODBP3',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_OUTGOING_CALLS_EX_HOME','ODB','ODB6',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_PREPAID_AWAITING_REGISTRATION','ODB','ODB12',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_TELETORG_820','ODB','ODB7B',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_TELETORG_829','ODB','ODB7C',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_TELETORG_ALL','ODB','ODB7',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_TOPUP','ODB','ODBTOPUP',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_VISUAL_VOICEMAIL','ODB','ODBVVM',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_VOICEMAIL','ODB','ODBVMS',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_WELCOME_SMS','ODB','ODBWSMS',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('BAR_WHO_CALLED','ODB','ODBWHO',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('CALL_FORWARD','CALLFORWARD','REGULAR',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('CALL_TRANSFER','CALLTRANS','REGULAR',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('CALL_WAIT','CALLHCALLW','CAWAIT',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('CONFERENCE','KONFERANSE','DUMMY',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_100GB','GPRS','CONV64',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_10GB','GPRS','CONV62',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_20GB','GPRS','CONV63',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_5GB','GPRS','CONV61',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_1000GB_EU','SPVOC','SPVOC09EU',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_10GB','SPVOC','SPVOC05',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_12GB_EU','SPVOC','SPVOC05EU',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_1GB_EU','SPVOC','SPVOC01EU',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_250MB','SPVOC','SPVOC02',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_25GB','SPVOC','SPVOC06',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_25GB_EU','SPVOC','SPVOC10EU',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_2GB','SPVOC','SPVOC03',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_2GB_EU','SPVOC','SPVOC03EU',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_30GB_EU','SPVOC','SPVOC06EU',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_3GB_EU','SPVOC','SPVOC07EU',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_500MB_EU','SPVOC','SPVOC02EU',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_5GB','SPVOC','SPVOC04',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_5GB_EU','SPVOC','SPVOC04EU',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_CHILI_6GB_EU','SPVOC','SPVOC08EU',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_LARGE','GPRS','CONV58',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_MEDIUM','GPRS','CONV57',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SHAPING_10MBPS','DATA_SHAPING3','TUVS11',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SHAPING_20MBPS','DATA_SHAPING4','TUVS12',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SHAPING_40MBPS','DATA_SHAPING4','TUVS13',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SMALL','GPRS','CONV56',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_100GB','SPVOS','SPVOSH11',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_10GB','SPVOS','SPVOSH02',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_15GB_WITH_ROD_RLH_TOPUP','SPVOS','SPVOSV04',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_20GB','SPVOS','SPVOSH03',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_2GB','SPVOS','SPVOSH01',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_2GB_WITH_ROD_RLH_TOPUP','SPVOS','SPVOSV01',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_30GB','SPVOS','SPVOSH04',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_32GB_WITH_ROD_RLH_TOPUP','SPVOS','SPVOSV05',TO_DATE('2019-01-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_40GB','SPVOS','SPVOSH05',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_4GB_WITH_ROD_RLH_TOPUP','SPVOS','SPVOSV02',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_50GB','SPVOS','SPVOSH06',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_60GB','SPVOS','SPVOSH07',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_70GB','SPVOS','SPVOSH08',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_80GB','SPVOS','SPVOSH09',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_8GB_WITH_ROD_RLH_TOPUP','SPVOS','SPVOSV03',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_90GB','SPVOS','SPVOSH10',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_HUDYA_0MB','SPVOS','SPVOSH12',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_HUDYA_12GB','SPVOS','SPVOSH19',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_HUDYA_1GB','SPVOS','SPVOSH15',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_HUDYA_2GB','SPVOS','SPVOSH16',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_HUDYA_300MB','SPVOS','SPVOSH13',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_HUDYA_30GB','SPVOS','SPVOSH20',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_HUDYA_3GB','SPVOS','SPVOSH17',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_HUDYA_500MB','SPVOS','SPVOSH14',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_SVEA_HUDYA_6GB','SPVOS','SPVOSH18',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('DATA_XL','GPRS','CONV59',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('FAX','FAX','REGULAR',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('FIXED_PRICE','FIXEDPRICE','SPFAST01',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('GPRS','GPRS','REGULAR',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('GSM_DATA','DATA','REGULAR',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('GSM_DATA_BDA26','DATA','BDA26',TO_DATE('2017-08-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('GSM_DATA_ISDN','DATA','ISDN',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('HIDDEN_NUMBER','CLIR','DUMMY',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('KONFERANSE','KONFERANSE','KONFER',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('M2M_APN_BBS','M2M','SEL_APN_VS',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('M2M_APN_NETS','M2M','M2MAPNVS',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('M2M_APN_VPN','M2M','SEL_APN',TO_DATE('2018-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('MBB_SIM_A','TWINCON','TWINCON',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('MBB_SIM_B','TWINCON','TWINCON02',TO_DATE('2018-11-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('MBB_SIM_C','TWINCON','TWINCON03',TO_DATE('2018-11-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('MBB_SIM_D','TWINCON','TWINCON04',TO_DATE('2018-11-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('MBB_SIM_E','TWINCON','TWINCON05',TO_DATE('2018-11-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('MBN_HLR_TRIGGER','FSB','MBN',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('MMS','MMS','DUMMY',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('MOBILE_VOICE_RECORDER','MVRC','MVRCVS',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('MULTI_SIM_A','MSIM','MSIMA',TO_DATE('2018-11-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('MULTI_SIM_B','MSIM','MSIMB',TO_DATE('2018-11-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('NUMBER_PRESENTATION','CLIP','CLIPRE',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('PRIORITY_VOICE_SIM','NETWORKPRIORITY','NETPRIO1',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('PRIORITY_VOICE_SIM','NETWORKPRIORITY','NETPRIOVS',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('ROAMING_DATA_CONTROL_AMOUNT_1000','MDRC','C1',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('ROAMING_DATA_CONTROL_AMOUNT_10000','MDRC','C4',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('ROAMING_DATA_CONTROL_AMOUNT_199','MDRC','MDRCC6',TO_DATE('2018-11-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('ROAMING_DATA_CONTROL_AMOUNT_3000','MDRC','C2',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('ROAMING_DATA_CONTROL_AMOUNT_5000','MDRC','C3',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('ROAMING_DATA_CONTROL_AMOUNT_50000','MDRC','C5',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('ROAMING_DATA_CONTROL_AMOUNT_NO_LIMIT','MDRC','CNOLIMIT',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('ROAMING_DATA_CONTROL_EU_DEFAULT','MDRC','CEU',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('SMS_COPY','SMS+','DUMMY',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('SMS_STORAGE','SMS-STORAGE','DUMMY',TO_DATE('2017-11-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('STOP_SMS_QUOTA_NOTIFICATION','STOPSMS','REGULAR',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('SURF_PACK_LARGE','GPRS','SURF_L_VS',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('SURF_PACK_MEDIUM','GPRS','SURF_M_VS',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('SURF_PACK_SMALL','GPRS','SURF_S_VS',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('SURF_PACK_XL','GPRS','SURF_XL_VS',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('TRAFFIC_QUOTA_UNLIMITED','NOLIM','NOLIM',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('TRILLING_SIM_A','TSIM','TSIMA',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('TRILLING_SIM_B','TSIM','TSIMB',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('VOICEMAIL','VOICEMAIL','VMS',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('VOICEMAIL','VOICEMAIL2','VMS2',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('VOICEMAIL_BUSINESS','VOICEMAIL','BUSINESS',TO_DATE('2018-09-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('VOICEMAIL_SECURITY','VOICEMAIL','SECURITY',TO_DATE('2018-09-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('VOLTE','COMPOUND','HPIMS02',TO_DATE('2017-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO spm_service_mapping 
VALUES('VOLTE','IMS','IMSVS',TO_DATE('2018-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL);

DELETE FROM spm_feature_mapping;

INSERT INTO spm_feature_mapping 
VALUES('APN1','IP','IP','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN1','NAME','NAME','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN1','TYPE','TYPE','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN1','VPLMN','VPLMN','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN2','IP','IP','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN2','NAME','NAME','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN2','TYPE','TYPE','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN2','VPLMN','VPLMN','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN3','IP','IP','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN3','NAME','NAME','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN3','TYPE','TYPE','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN3','VPLMN','VPLMN','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN4','IP','IP','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN4','NAME','NAME','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN4','TYPE','TYPE','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN4','VPLMN','VPLMN','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN5','IP','IP','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN5','NAME','NAME','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN5','TYPE','TYPE','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('APN5','VPLMN','VPLMN','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('GSM_DATA_BDA26','MSISDN','MSISDN','Y','B-DA26');
INSERT INTO spm_feature_mapping 
VALUES('GSM_DATA_ISDN','MSISDN','MSISDN','Y','ISDN96');
INSERT INTO spm_feature_mapping 
VALUES('SMS_COPY','COPY-EMAIL','COPY-EMAIL','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('SMS_COPY','COPY-MSISDN','COPY-MSISDN','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('SMS_COPY','FORWARD-MSISDN','MSISDN','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('SMS_STORAGE','ACTIVE','ACTIVE','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('SMS_STORAGE','MO-EMAIL','MOEMAIL','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('SMS_STORAGE','MT-EMAIL','MTEMAIL','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_BUSINESS','EMAIL','EMAIL','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_BUSINESS','LANGUAGE','LANGUAGE','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_BUSINESS','NOTIFY-TYPE','NOTIFY-TYPE','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_BUSINESS','PO-PHONE-NUM','PO-PHONE-NUM','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_BUSINESS','VVM','VVM','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_BUSINESS','WHO-CALLED','WHO-CALLED','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_SECURITY','EMAIL','EMAIL','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_SECURITY','LANGUAGE','LANGUAGE','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_SECURITY','NOTIFY-TYPE','NOTIFY-TYPE','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_SECURITY','PO-PHONE-NUM','PO-PHONE-NUM','N',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_SECURITY','VVM','VVM','Y',NULL);
INSERT INTO spm_feature_mapping 
VALUES('VOICEMAIL_SECURITY','WHO-CALLED','WHO-CALLED','Y',NULL);