DROP INDEX party_mgr_pid_update_idx1;

CREATE INDEX party_mgr_pid_update_idx1 ON party_mgr_pid_update
  (
    request_time                    ASC,
    process_status                  ASC
  )
/

DROP INDEX party_mgr_pid_update_idx2;

CREATE INDEX party_mgr_pid_update_idx2 ON party_mgr_pid_update
  (
    process_status                  ASC,
    process_time                    ASC
  )
/

