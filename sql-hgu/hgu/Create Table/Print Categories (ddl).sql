--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Create print_category_access
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
CREATE TABLE print_category_access
    (print_category                VARCHAR2(10) NOT NULL,
     account_type                  VARCHAR2(1)  NOT NULL,
     account_sub_type              VARCHAR2(2)  NOT NULL,
     channel_code                  VARCHAR2(15) NOT NULL,
     effective_date                DATE,
     expiration_date               DATE,
     requires_email                VARCHAR2(1),
     description                   VARCHAR2(100))
/
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Grants for Table
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
GRANT ALTER ON print_category_access TO ninjamain
/
GRANT DELETE ON print_category_access TO ninjamain
/
GRANT INDEX ON print_category_access TO ninjamain
/
GRANT INSERT ON print_category_access TO ninjamain
/
GRANT SELECT ON print_category_access TO ninjamain
/
GRANT UPDATE ON print_category_access TO ninjamain
/
GRANT REFERENCES ON print_category_access TO ninjamain
/
GRANT ALTER ON print_category_access TO ninjateam
/
GRANT DELETE ON print_category_access TO ninjateam
/
GRANT INDEX ON print_category_access TO ninjateam
/
GRANT INSERT ON print_category_access TO ninjateam
/
GRANT SELECT ON print_category_access TO ninjateam
/
GRANT UPDATE ON print_category_access TO ninjateam
/
GRANT REFERENCES ON print_category_access TO ninjateam
/

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Constraints for print_category_access
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

ALTER TABLE print_category_access
ADD PRIMARY KEY (print_category, account_type, account_sub_type, channel_code)
/


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Triggers for print_category_access
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

CREATE OR REPLACE TRIGGER print_category_access_trg1
 BEFORE
  INSERT OR UPDATE
 ON print_category_access
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
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
    --== Check the values of 'requires_email'. Should be 'Y' or 'N'.
    --== Accept 'y' as 'Y', set everything else to 'N'.
    --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
	IF :new.requires_email IS NULL
	THEN
	    :new.requires_email := 'N';
	ELSE 
		IF :new.requires_email IN ('y', 'Y')
		THEN
		    :new.requires_email := 'Y';
		ELSE
		    :new.requires_email := 'N';
		END IF;
	END IF;
	

	--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
    --== Check the values of 'replacable_in_ninja'. Should be 'Y' or 'N'.
    --== Accept 'n' as 'N', set everything else to 'Y'.
    --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
    /*
	IF :new.replacable_in_ninja IS NULL
	THEN
	    :new.replacable_in_ninja := 'Y';
	ELSE 
		IF :new.replacable_in_ninja IN ('n', 'N')
		THEN
		    :new.replacable_in_ninja := 'N';
		ELSE
		    :new.replacable_in_ninja := 'Y';
		END IF;
	END IF;
	*/

    --==--==--==--==--==--==--==--==--==--==--==--==--==--==
    --== Default the channel_code to '*' if not specified.
    --==--==--==--==--==--==--==--==--==--==--==--==--==--==
--    IF :new.channel_code IS NULL
--	THEN
--		:new.channel_code := '*';
--	END IF;
--
	END;
/


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Comments for print_category_access
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
COMMENT ON TABLE print_category_access IS 'Describes which Print Categories are allowed on a account- type & sub type for a specific channel'
/
COMMENT ON COLUMN print_category_access.print_category IS 'The Print Category value'
/
COMMENT ON COLUMN print_category_access.account_type IS 'Fokus account type'
/
COMMENT ON COLUMN print_category_access.account_sub_type IS 'Fokus account sub type'
/
COMMENT ON COLUMN print_category_access.channel_code IS 'Channel Code (from channels)'
/
COMMENT ON COLUMN print_category_access.requires_email IS '''Y'' if the Print Category requires an email address, otherwise ''N'' (default)'
/
COMMENT ON COLUMN print_category_access.effective_date IS 'The effective date of the Rule'
/
COMMENT ON COLUMN print_category_access.expiration_date IS 'The expiration date of the rule'
/
COMMENT ON COLUMN print_category_access.description IS 'Description (if any)'
/

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Synonym ACCTP_SUBTP_CREDIT_LIMIT
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
CREATE SYNONYM ninjamain.print_category_access
  FOR NINJARULES.PRINT_CATEGORY_ACCESS
/

-- End of DDL Script

