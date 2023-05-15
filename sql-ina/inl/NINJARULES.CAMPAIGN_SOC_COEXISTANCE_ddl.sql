-- Start of DDL Script for Table NINJARULES.CAMPAIGN_SOC_COEXISTANCE
-- Generated 12/3/2007 3:06:35 PM from NINJARULES@NINJAPROD1

CREATE TABLE campaign_soc_coexistance
    (campaign                       VARCHAR2(15) NOT NULL,
    soc                            VARCHAR2(9) NOT NULL,
    effective_date                 DATE,
    expiration_date                DATE,
    description                    VARCHAR2(100))
/

-- Grants for Table
GRANT ALTER ON campaign_soc_coexistance TO ninjamain
/
GRANT DELETE ON campaign_soc_coexistance TO ninjamain
/
GRANT INDEX ON campaign_soc_coexistance TO ninjamain
/
GRANT INSERT ON campaign_soc_coexistance TO ninjamain
/
GRANT SELECT ON campaign_soc_coexistance TO ninjamain
/
GRANT UPDATE ON campaign_soc_coexistance TO ninjamain
/
GRANT REFERENCES ON campaign_soc_coexistance TO ninjamain
/
GRANT ON COMMIT REFRESH ON campaign_soc_coexistance TO ninjamain
/
GRANT QUERY REWRITE ON campaign_soc_coexistance TO ninjamain
/
GRANT DEBUG ON campaign_soc_coexistance TO ninjamain
/
GRANT FLASHBACK ON campaign_soc_coexistance TO ninjamain
/




-- Indexes for CAMPAIGN_SOC_COEXISTANCE

CREATE UNIQUE INDEX camp_soc_1uix ON campaign_soc_coexistance
  (
    campaign                        ASC
  )
/



-- Constraints for CAMPAIGN_SOC_COEXISTANCE

ALTER TABLE campaign_soc_coexistance
ADD PRIMARY KEY (campaign, soc)
USING INDEX
/


-- Triggers for CAMPAIGN_SOC_COEXISTANCE

CREATE OR REPLACE TRIGGER campaign_soc_coexistance_trg1
 BEFORE
  INSERT OR UPDATE
 ON campaign_soc_coexistance
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
    --== Handle the dates...
    --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
	IF :new.effective_date IS NULL
	THEN
		:new.effective_date := trunc(sysdate);
   	ELSE
		:new.effective_date := TRUNC(:new.effective_date);
	END IF;

	IF :new.expiration_date IS NULL
	THEN
		:new.expiration_date := TO_DATE('47001231','YYYYMMDD');
	ELSE
		:new.expiration_date := TRUNC(:new.expiration_date);
	END IF;

    --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
    --== Handle the description...
    --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
	IF :new.description IS NULL
	THEN
		:new.description := 'Added at ' || to_char(SYSDATE, 'YYYY-MM-DD HH24:MI');
	END IF;

	END;
/


-- Comments for CAMPAIGN_SOC_COEXISTANCE

COMMENT ON TABLE campaign_soc_coexistance IS 'Maps the addition of a promotion due to addition of a soc on specific priceplan(s)'
/
COMMENT ON COLUMN campaign_soc_coexistance.campaign IS 'The Campaign for which users should recieve a soc (as a gift?)'
/
COMMENT ON COLUMN campaign_soc_coexistance.description IS 'Description (if any)'
/
COMMENT ON COLUMN campaign_soc_coexistance.effective_date IS 'The effective date of the Rule'
/
COMMENT ON COLUMN campaign_soc_coexistance.expiration_date IS 'The expiration date of the rule'
/
COMMENT ON COLUMN campaign_soc_coexistance.soc IS 'The soc to add, if a subscriber using the campaign doesn''t have it'
/

-- End of DDL Script for Table NINJARULES.CAMPAIGN_SOC_COEXISTANCE

