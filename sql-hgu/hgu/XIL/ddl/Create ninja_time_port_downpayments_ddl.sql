CREATE TABLE ninja_time_port_downpayments (
    ninja_ref_id                   NUMBER(8,0),
    soc                            VARCHAR2(9 CHAR),
    full_rate                      NUMBER(*,2),
    installments                   NUMBER(8,0))
/

-- Grants for Table
GRANT ALTER ON ninja_time_port_downpayments TO ninjamain_pt
/
GRANT DELETE ON ninja_time_port_downpayments TO ninjamain_pt
/
GRANT INDEX ON ninja_time_port_downpayments TO ninjamain_pt
/
GRANT INSERT ON ninja_time_port_downpayments TO ninjamain_pt
/
GRANT SELECT ON ninja_time_port_downpayments TO ninjamain_pt
/
GRANT UPDATE ON ninja_time_port_downpayments TO ninjamain_pt
/
GRANT REFERENCES ON ninja_time_port_downpayments TO ninjamain_pt
/
GRANT ON COMMIT REFRESH ON ninja_time_port_downpayments TO ninjamain_pt
/
GRANT QUERY REWRITE ON ninja_time_port_downpayments TO ninjamain_pt
/
GRANT DEBUG ON ninja_time_port_downpayments TO ninjamain_pt
/
GRANT FLASHBACK ON ninja_time_port_downpayments TO ninjamain_pt
/

-- Indexes for ninja_time_port_downpayments

CREATE UNIQUE INDEX ntp_downpayments_idx1 ON ninja_time_port_downpayments
  (
    ninja_ref_id                    ASC,
    soc                             ASC
  )
/


-- Constraints for ninja_time_port_downpayments

ALTER TABLE ninja_time_port_downpayments
ADD CHECK ("SOC" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE ninja_time_port_downpayments
ADD CHECK ("NINJA_REF_ID" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE ninja_time_port_downpayments
ADD CHECK ("FULL_RATE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE ninja_time_port_downpayments
ADD CHECK ("INSTALLMENTS" IS NOT NULL)
ENABLE NOVALIDATE
/


-- Comments for ninja_time_port_downpayments

COMMENT ON COLUMN ninja_time_port_downpayments.ninja_ref_id IS 'Unique Key for the Port Order'
/
COMMENT ON COLUMN ninja_time_port_downpayments.soc IS 'The Fokus Soc Code'
/
COMMENT ON COLUMN ninja_time_port_downpayments.full_rate IS 'The Full rate/amount of the downpayment'
/
COMMENT ON COLUMN ninja_time_port_downpayments.installments IS 'The number of installments'
/
/

-- Foreign Key
ALTER TABLE ninja_time_port_downpayments
ADD CONSTRAINT ntp_downpayments_fk2 FOREIGN KEY (ninja_ref_id)
REFERENCES ninja_time_port (ninja_ref_id)
ENABLE NOVALIDATE
/

ALTER TABLE ninja_time_port_downpayments
ADD CONSTRAINT ntp_downpayments_fk1 FOREIGN KEY (ninja_ref_id, soc)
REFERENCES ninja_time_port_services (ninja_ref_id,soc)
ENABLE NOVALIDATE
/

