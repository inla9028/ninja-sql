-- -- LOCK TABLE ninja_time_port IN EXCLUSIVE MODE;

-- ALTER SESSION SET ddl_lock_timeout=180;

ALTER TABLE ninja_time_port
 MODIFY action VARCHAR2(16 CHAR)
;

-- ALTER SESSION SET ddl_lock_timeout=0;
