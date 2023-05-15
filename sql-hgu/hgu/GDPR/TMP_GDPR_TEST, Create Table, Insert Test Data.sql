/*
** Create table
*/
CREATE TABLE tmp_gdpr_test
    (ban_no                         NUMBER(9,0),
    subscriber_no                  VARCHAR2(15 CHAR),
    sim_no                         VARCHAR2(22 CHAR),
    process_time                   DATE,
    status_desc                    VARCHAR2(2000 CHAR))
;

/*
** Grants...
*/
GRANT ALTER      ON tmp_gdpr_test TO ninjamain;
GRANT DELETE     ON tmp_gdpr_test TO ninjamain;
GRANT INDEX      ON tmp_gdpr_test TO ninjamain;
GRANT INSERT     ON tmp_gdpr_test TO ninjamain;
GRANT SELECT     ON tmp_gdpr_test TO ninjamain;
GRANT UPDATE     ON tmp_gdpr_test TO ninjamain;
GRANT REFERENCES ON tmp_gdpr_test TO ninjamain;

/*
** Display table
*/
SELECT a.*
  FROM tmp_gdpr_test a
ORDER BY a.process_time desc
;

/*
** Insert test-data.
*/
INSERT INTO tmp_gdpr_test VALUES(123456789,NULL,NULL,TO_DATE('2017-10-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Testing BAN...');
INSERT INTO tmp_gdpr_test VALUES(123456789,'GSM04792653600',NULL,TO_DATE('2017-10-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Testing BAN and SUB...');
INSERT INTO tmp_gdpr_test VALUES(NULL,NULL,'08947080041000000266',TO_DATE('2017-11-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'TESTING SIM');
INSERT INTO tmp_gdpr_test VALUES(NULL,NULL,'12121212121212121212',TO_DATE('2017-10-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Testing another SIM');
INSERT INTO tmp_gdpr_test VALUES(NULL,'92653600',NULL,TO_DATE('2017-10-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Testing SUB 1...');
INSERT INTO tmp_gdpr_test VALUES(NULL,'04792653600',NULL,TO_DATE('2017-10-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Testing SUB 2...');
INSERT INTO tmp_gdpr_test VALUES(NULL,'04792653600',NULL,TO_DATE('2017-09-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Testing SUB 3...');
INSERT INTO tmp_gdpr_test VALUES(NULL,'GSM04792653600',NULL,TO_DATE('2017-08-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Testing SUB 4...');
INSERT INTO tmp_gdpr_test VALUES(NULL,'GSM04792653600',NULL,TO_DATE('2017-07-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Testing SUB 5...');
INSERT INTO tmp_gdpr_test VALUES(NULL,'GSM04792653600',NULL,TO_DATE('2017-06-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Testing SUB 6...');

/*
** Miscellaneous...
*/
SELECT 1 FROM DUAL;



