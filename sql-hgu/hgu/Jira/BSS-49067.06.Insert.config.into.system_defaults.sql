INSERT INTO system_defaults (KEY,VALUE,value_type,description) 
values ('NP_PRICE_RANK_APPLICATION_ID','NINRES','STRING','The application id to use when inserting future requests.');
INSERT INTO system_defaults (KEY,VALUE,value_type,description) 
values ('NP_PRICE_RANK_CFR_REASON_CD','INP','STRING','The reason code to use when inserting future requests');
INSERT INTO system_defaults (KEY,VALUE,value_type,description) 
values ('PARTY_MANAGER_EVENTS','N','STRING','If ''Y'', insert events when creating or changing name, birthDate, pid, tpid or email.');
INSERT INTO system_defaults (KEY,VALUE,value_type,description)
VALUES ('PARTY_MANAGER_STATUS','N','STRING','If ''Y'', insert events when changing status of BAN or subscription.');

INSERT INTO system_defaults (KEY,VALUE,value_type,description)
VALUES ('NP_PRICE_RANK_CFR','N','STRING','If ''Y'', create row in cfr_future_request when ranking internal porting.');

SELECT A.*
  FROM system_defaults A
 WHERE A.KEY IN (
    'NP_PRICE_RANK_APPLICATION_ID',
    'NP_PRICE_RANK_CFR_REASON_CD',
    'PARTY_MANAGER_EVENTS',
    'PARTY_MANAGER_STATUS',
    'NP_PRICE_RANK_CFR'
 )
ORDER BY 1
;

UPDATE system_defaults A
   SET A.VALUE = 'Y'
 WHERE A.KEY  IN ( 'NP_PRICE_RANK_CFR', 'PARTY_MANAGER_STATUS' )
;

UPDATE system_defaults A
   SET A.VALUE = 'Y'
 WHERE A.KEY  IN ( 'PARTY_MANAGER_STATUS', 'PARTY_MANAGER_EVENTS' )
;