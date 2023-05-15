-- Inserts data in Fokus tables for new SP (Telio)
-- should run on Fokus reference schema

INSERT INTO dealer_profile 
VALUES('SP01 ',sysdate, NULL,NULL,NULL,'DMS  ',NULL,'2 ','2 ','Telio Telecom AS','Y',TO_DATE('2011-07-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'      ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'986 378 162',NULL,NULL,NULL,'-1   ',NULL,NULL,'N','N','N',NULL);
INSERT INTO dealer_profile 
VALUES('SP02 ',sysdate, NULL,NULL,NULL,'DMS  ',NULL,'2 ','2 ','Altibox AS','Y',TO_DATE('2011-07-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'      ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'984 586 612',NULL,NULL,NULL,'-1   ',NULL,NULL,'N','N','N',NULL);

INSERT INTO item_definition 
VALUES('TELIO UICC D1  ',sysdate,TO_DATE('2011-07-13 09:32:31', 'YYYY-MM-DD HH24:MI:SS'),101062,'OL    ','0    ',0,'53','Telio UICC D1','E','Y','E','53','10        ','TELIO UICC D1  ',NULL,'V',NULL,'MILLENAGE',NULL);

INSERT INTO sim_type 
VALUES('53',sysdate,sysdate,202503,'MAN','0    ',0,'Telio UICC D1','P','N','72');

INSERT INTO logic_phd 
VALUES('72',sysdate,NULL,100666,'Logic ','0    ',0,'Tio','72','S');

INSERT INTO nl_dealer_link 
VALUES('TLO','SP01 ',sysdate,sysdate,null,101062,'OL    ','0    ',0,NULL);
INSERT INTO nl_dealer_link 
VALUES('SLO','SP01 ',sysdate,sysdate,null,101062,'OL    ','0    ',0,NULL);

INSERT INTO acctp_ranges 
VALUES('S','TE','M','04740140000',sysdate,null,101062,'OL    ','0    ',0,'04740149999','TLO');
INSERT INTO acctp_ranges 
VALUES('S','TE','M','047580008990000',sysdate,null,101062,'OL    ','0    ',0,'047580008999999','SLO');
 
INSERT INTO tn_grouping 
VALUES('04740140000',sysdate,null,101062,'OL    ','0    ',0,'04740147999','A  ','S','TE');
INSERT INTO tn_grouping 
VALUES('04740148000',sysdate,null,101062,'OL    ','0    ',0,'04740149999','DM ','S','TE');
INSERT INTO tn_grouping 
VALUES('047580008990000',sysdate,null,101062,'OL    ','0    ',0,'047580008997999','MBB','S','TE');
INSERT INTO tn_grouping 
VALUES('047580008998000',sysdate,null,101062,'OL    ','0    ',0,'047580008999999','DMM','S','TE');

INSERT INTO msisdn_hlr_relation 
VALUES('04740140000','04740149999','72',sysdate,null,101062,'OL    ','0    ',0,'Tildelt Telio');
INSERT INTO msisdn_hlr_relation 
VALUES('047580008990000','047580008999999','72',sysdate,null,101062,'OL    ','0    ',0,'Maskin til Maskin tildelt Telio');


