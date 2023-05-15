--
-- Phonero
--
-- SMS
INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('PO01',      'SMS',       'PW10', 'B-SMSO', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('PO01',      'SMS',       'PW10', 'B-SMST', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('PO02',      'SMS',       'PW10', 'B-SMSO', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('PO02',      'SMS',       'PW10', 'B-SMST', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

-- MMS
INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('PO01',      'MMS',       'PW10', 'S-MMS2', NULL,           NULL,            'Enabling reprovisioning of MMS')
;


INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('PO02',      'MMS',       'PW10', 'S-MMS2', NULL,           NULL,            'Enabling reprovisioning of MMS')
;

--
-- NewCo
--
-- PW20: SMS
INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('NWCO',      'SMS',       'PW20', 'B-SMSO', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('NWCO',      'SMS',       'PW20', 'B-SMST', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

-- PW20: MMS
INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('NWCO',      'MMS',       'PW20', 'S-MMS2', NULL,           NULL,            'Enabling reprovisioning of MMS')
;

-- PW21: SMS
INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('NWCO',      'SMS',       'PW21', 'B-SMSO', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('NWCO',      'SMS',       'PW21', 'B-SMST', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

-- PW21: MMS
INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('NWCO',      'MMS',       'PW21', 'S-MMS2', NULL,           NULL,            'Enabling reprovisioning of MMS')
;

-- PW22: SMS
INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('NWCO',      'SMS',       'PW22', 'B-SMSO', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('NWCO',      'SMS',       'PW22', 'B-SMST', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

-- PW22: MMS
INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('NWCO',      'MMS',       'PW22', 'S-MMS2', NULL,           NULL,            'Enabling reprovisioning of MMS')
;


--
-- Telio
--
-- PW30: SMS
INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('SP01',      'SMS',       'PW30', 'B-SMSO', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('SP01',      'SMS',       'PW30', 'B-SMST', NULL,           NULL,            'Enabling reprovisioning of SMS')
;

-- PW30: MMS
INSERT INTO reprovision_rules (dealer_code, reprov_type, soc,    feature,  effective_date, expiration_date, comments)
                       VALUES ('SP01',      'MMS',       'PW30', 'S-MMS2', NULL,           NULL,            'Enabling reprovisioning of MMS')
;

SELECT a.*
  FROM reprovision_rules a
-- WHERE a.dealer_code LIKE 'PO0%'
ORDER BY 1,2,3,4,5
;
