ALTER TABLE ninjaconfig.service_providers ADD (
  parent      VARCHAR2(1 CHAR),
  parent_name VARCHAR2(64 CHAR),
  child       VARCHAR2(1 CHAR),
  child_name  VARCHAR2(64 CHAR),
  child_id    VARCHAR2(2 CHAR)
)
;