DROP INDEX party_manager_events_idx1;

CREATE INDEX party_manager_events_idx1 ON party_manager_events
  (
    request_time                    ASC,
    process_status                  ASC
  )
/

DROP INDEX party_manager_events_idx2;

CREATE INDEX party_manager_events_idx2 ON party_manager_events
  (
    process_status                  ASC,
    process_time                    ASC
  )
/

