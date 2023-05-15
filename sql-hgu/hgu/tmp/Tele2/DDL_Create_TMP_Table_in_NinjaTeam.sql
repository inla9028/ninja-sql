CREATE TABLE hgu_tmp_tele2
    (ban                           NUMBER(9,0),
    acc_type                       VARCHAR2(9 BYTE),
    acc_sub_type                   VARCHAR2(9 BYTE),
    subscriber_no                  VARCHAR2(18 BYTE),
    sub_status                     VARCHAR2(5 BYTE),    
    priceplan                      VARCHAR2(9 BYTE),
    soc_old                        VARCHAR2(9 BYTE),
    soc_new                        VARCHAR2(9 BYTE),
    dealer_code                    VARCHAR2(5 BYTE),
    sales_agent                    VARCHAR2(5 BYTE),
    job1_status                    VARCHAR2(32 BYTE),
    job2_status                    VARCHAR2(32 BYTE),
    job3_status                    VARCHAR2(32 BYTE),
    process_status                 VARCHAR2(32 BYTE),
    process_time                   DATE,
    memo_text                      VARCHAR2(300 BYTE))
/

-- Grants for Table
GRANT ALTER ON hgu_tmp_tele2 TO ninjamain
/
GRANT DELETE ON hgu_tmp_tele2 TO ninjamain
/
GRANT INDEX ON hgu_tmp_tele2 TO ninjamain
/
GRANT INSERT ON hgu_tmp_tele2 TO ninjamain
/
GRANT SELECT ON hgu_tmp_tele2 TO ninjamain
/
GRANT UPDATE ON hgu_tmp_tele2 TO ninjamain
/
GRANT REFERENCES ON hgu_tmp_tele2 TO ninjamain
/




-- Indexes for hgu_tmp_tele2

CREATE INDEX hgu_tmp_tele2_idx1 ON hgu_tmp_tele2
  (
    subscriber_no                   ASC,
    sub_status                      ASC
  )
/

CREATE INDEX hgu_tmp_tele2_idx2 ON hgu_tmp_tele2
  (
    ban                      ASC
  )
/

CREATE INDEX hgu_tmp_tele2_idx3 ON hgu_tmp_tele2
  (
    priceplan                ASC,
    soc_old                  ASC,
    soc_new                  ASC
  )
/

CREATE INDEX hgu_tmp_tele2_idx4 ON hgu_tmp_tele2
  (
    process_status                 ASC,
    process_time                   ASC
  )
/

