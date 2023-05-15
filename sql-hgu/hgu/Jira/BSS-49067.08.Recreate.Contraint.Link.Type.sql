ALTER TABLE party_manager_events
DROP CONSTRAINT party_manager_events_con2
/

ALTER TABLE party_manager_events
ADD CONSTRAINT party_manager_events_con2 CHECK ( link_type IN ('B', 'C' ,'L', 'U'))
/
