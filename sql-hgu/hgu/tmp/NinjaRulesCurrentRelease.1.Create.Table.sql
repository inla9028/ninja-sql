CREATE TABLE ninja_rules_current_release
    (release_id                     VARCHAR2(40 CHAR) ,
    author                         VARCHAR2(8 CHAR),
    staging_time                   DATE,
    description                    VARCHAR2(2000 BYTE))
/

-- Grants for Table
GRANT SELECT ON ninja_rules_current_release TO ninjarstaging
/
GRANT SELECT ON ninja_rules_current_release TO ninjamain
/
GRANT SELECT ON ninja_rules_current_release TO backupninjarules
/
GRANT SELECT ON ninja_rules_current_release TO ninjarstaging2
/

-- Constraints for NINJA_RULES_CURRENT_RELEASE

ALTER TABLE ninja_rules_current_release
ADD CONSTRAINT ninja_rules_current_release_pk PRIMARY KEY (release_id)
USING INDEX
/