CREATE TABLE soc_inherit_expiration_rules(
    soc_ancestor                   VARCHAR2(9),
    soc_heir                       VARCHAR2(9),
    action                         VARCHAR2(1),
    effective_date                 DATE,
    expiration_date                DATE,
    description                    VARCHAR2(200)
);

-- Grants for Table
GRANT SELECT ON soc_inherit_expiration_rules TO ninjarstaging;
GRANT ALTER ON soc_inherit_expiration_rules TO ninjamain;
GRANT DELETE ON soc_inherit_expiration_rules TO ninjamain;
GRANT INDEX ON soc_inherit_expiration_rules TO ninjamain;
GRANT INSERT ON soc_inherit_expiration_rules TO ninjamain;
GRANT SELECT ON soc_inherit_expiration_rules TO ninjamain;
GRANT UPDATE ON soc_inherit_expiration_rules TO ninjamain;
GRANT REFERENCES ON soc_inherit_expiration_rules TO ninjamain;
GRANT ON COMMIT REFRESH ON soc_inherit_expiration_rules TO ninjamain;
GRANT QUERY REWRITE ON soc_inherit_expiration_rules TO ninjamain;
GRANT DEBUG ON soc_inherit_expiration_rules TO ninjamain;
GRANT FLASHBACK ON soc_inherit_expiration_rules TO ninjamain;
GRANT ALTER ON soc_inherit_expiration_rules TO ninjadata;
GRANT DELETE ON soc_inherit_expiration_rules TO ninjadata;
GRANT INDEX ON soc_inherit_expiration_rules TO ninjadata;
GRANT INSERT ON soc_inherit_expiration_rules TO ninjadata;
GRANT SELECT ON soc_inherit_expiration_rules TO ninjadata;
GRANT UPDATE ON soc_inherit_expiration_rules TO ninjadata;
GRANT REFERENCES ON soc_inherit_expiration_rules TO ninjadata;
GRANT ALTER ON soc_inherit_expiration_rules TO ninjaconfig;
GRANT DELETE ON soc_inherit_expiration_rules TO ninjaconfig;
GRANT INDEX ON soc_inherit_expiration_rules TO ninjaconfig;
GRANT INSERT ON soc_inherit_expiration_rules TO ninjaconfig;
GRANT SELECT ON soc_inherit_expiration_rules TO ninjaconfig;
GRANT UPDATE ON soc_inherit_expiration_rules TO ninjaconfig;
GRANT REFERENCES ON soc_inherit_expiration_rules TO ninjaconfig;
GRANT SELECT ON soc_inherit_expiration_rules TO backupninjarules;
GRANT SELECT ON soc_inherit_expiration_rules TO readonly;
GRANT SELECT ON soc_inherit_expiration_rules TO ninjarstaging2;

-- Indexes for soc_inherit_expiration_rules
CREATE INDEX soc_inherit_exp_rules_idx1 ON soc_inherit_expiration_rules (
    soc_ancestor                    ASC,
    soc_heir                        ASC
);
CREATE INDEX soc_inherit_exp_rules_idx2 ON soc_inherit_expiration_rules (
    effective_date                 ASC,
    expiration_date                ASC
);

-- Comments for soc_inherit_expiration_rules
COMMENT ON TABLE soc_inherit_expiration_rules IS 'Declares which socs should inherit their expiration dates from which socs, under certain conditions';
COMMENT ON COLUMN soc_inherit_expiration_rules.soc_ancestor IS 'The ancestor soc to inherit the expiration date from';
COMMENT ON COLUMN soc_inherit_expiration_rules.soc_heir IS 'The soc who inherits the expiration date';
COMMENT ON COLUMN soc_inherit_expiration_rules.action IS '"A" for Add, "M" for Mandatory, "*" for Any. Delete does not apply, obviously...';
COMMENT ON COLUMN soc_inherit_expiration_rules.effective_date IS 'First day when rule is active';
COMMENT ON COLUMN soc_inherit_expiration_rules.expiration_date IS 'Last day when rule is active';
COMMENT ON COLUMN soc_inherit_expiration_rules.description IS 'One would think that a description on a column called ''DESCRIPTION'' wouldn''t be needed, am I right? :-)';

