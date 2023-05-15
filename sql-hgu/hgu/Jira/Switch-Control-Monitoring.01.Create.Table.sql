CREATE TABLE switch_control_monitoring (
    queue_name                     VARCHAR2(32 CHAR),
    queue_size                     NUMBER(6,0),
    queue_capacity                 NUMBER(6,0),
    lower_threshold                NUMBER(6,0),
    upper_threshold                NUMBER(6,0),
    switch_phd_id                  VARCHAR2(64 CHAR),
    switch_priority                VARCHAR2(64 CHAR),
    update_interval                NUMBER(6,0),
    last_update_date               DATE,
    description                    VARCHAR2(200 CHAR)
)
/

INSERT INTO switch_control_monitoring 
VALUES('HLRI_TOTAL',0,70,100,1500,'hlri','30,40',120,TO_DATE('2016-11-29 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'The High and Low queues (30,40) in Fokus');


-- Grants for Table
GRANT ALTER ON switch_control_monitoring TO ninjarules
/
GRANT DELETE ON switch_control_monitoring TO ninjarules
/
GRANT INDEX ON switch_control_monitoring TO ninjarules
/
GRANT INSERT ON switch_control_monitoring TO ninjarules
/
GRANT SELECT ON switch_control_monitoring TO ninjarules
/
GRANT UPDATE ON switch_control_monitoring TO ninjarules
/
GRANT REFERENCES ON switch_control_monitoring TO ninjarules
/
GRANT SELECT ON switch_control_monitoring TO ninjarstaging
/
GRANT ALTER ON switch_control_monitoring TO ninjamain
/
GRANT DELETE ON switch_control_monitoring TO ninjamain
/
GRANT INDEX ON switch_control_monitoring TO ninjamain
/
GRANT INSERT ON switch_control_monitoring TO ninjamain
/
GRANT SELECT ON switch_control_monitoring TO ninjamain
/
GRANT UPDATE ON switch_control_monitoring TO ninjamain
/
GRANT REFERENCES ON switch_control_monitoring TO ninjamain
/
GRANT ALTER ON switch_control_monitoring TO ninjadata
/
GRANT DELETE ON switch_control_monitoring TO ninjadata
/
GRANT INDEX ON switch_control_monitoring TO ninjadata
/
GRANT INSERT ON switch_control_monitoring TO ninjadata
/
GRANT SELECT ON switch_control_monitoring TO ninjadata
/
GRANT UPDATE ON switch_control_monitoring TO ninjadata
/
GRANT REFERENCES ON switch_control_monitoring TO ninjadata
/
GRANT SELECT ON switch_control_monitoring TO ninjacstaging
/
GRANT SELECT ON switch_control_monitoring TO readonly
/
GRANT SELECT ON switch_control_monitoring TO ninjarstaging2
/


