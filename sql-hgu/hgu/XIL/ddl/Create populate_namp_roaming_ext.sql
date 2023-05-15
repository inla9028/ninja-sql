CREATE OR REPLACE 
PACKAGE xil_batch AS
    PROCEDURE populate_namp_roaming_ext;
    PROCEDURE log_message(procedure_name IN VARCHAR, message IN VARCHAR);
END xil_batch;
/

CREATE OR REPLACE
PACKAGE BODY xil_batch
AS
    /*
    ** Extract the result of the query (using nrep11 dblink) into table.
    */
    PROCEDURE populate_namp_roaming_ext
    IS
        CURSOR c1
        IS
            SELECT SUBSTR(sa.subscriber_no, 5)  AS "MSISDN"
                 , sii.imsi                     AS "IMSI"
                 , '62'                         AS "HOMENETWORKID"
                 , 'I'                          AS "ACTION"
                 , 'ALL'                        AS "MESSAGETYPE"
                 , sa.sys_creation_date         AS "EVENTTIME"
              FROM data_no.service_agreement@nrep11 sa
                 , data_no.serial_item_inv@nrep11   sii
                 , data_no.physical_device@nrep11   pd 
             WHERE pd.subscriber_no   = sa.subscriber_no 
               AND pd.ban             = sa.ban 
               AND pd.device_type     = 'E'              -- E = Equipment
               AND pd.expiration_date IS NULL            -- Last active...
               AND pd.equipment_level = 1                -- Primary SIM card
               AND sii.serial_number  = pd.equipment_no 
               AND sii.sim_status     = 'R'              -- R = Regular
               AND RTRIM(sa.soc)      = 'ODBWSMS' 
               AND sa.expiration_date > SYSDATE;

        cursor_row   c1%ROWTYPE;
        MY_ROW_COUNT INTEGER := 0;
    BEGIN
        LOG_MESSAGE('populate_namp_roaming_ext', '1/4: Clearing table ''namp_roaming_ext''');
        COMMIT;
        
        DELETE
          FROM namp_roaming_ext;
        
        LOG_MESSAGE('populate_namp_roaming_ext', '2/4: Cleared table ''namp_roaming_ext''');
        
        LOG_MESSAGE('populate_namp_roaming_ext', '3/4: Extracting rows from NREP11...');
        FOR cursor_row IN c1
        LOOP
            INSERT
              INTO namp_roaming_ext
                   (msisdn,            imsi,            homenetworkid,            actiontype,        messagetype,            eventtime           )
            VALUES (cursor_row.msisdn, cursor_row.imsi, cursor_row.homenetworkid, cursor_row.action, cursor_row.messagetype, cursor_row.eventtime);

           MY_ROW_COUNT := MY_ROW_COUNT + SQL%ROWCOUNT;
           -- Commit work
           COMMIT;
        END LOOP;
        LOG_MESSAGE('populate_namp_roaming_ext', '4/4: Inserted ' || TO_CHAR(MY_ROW_COUNT) || ' rows into table ''namp_roaming_ext''');
        COMMIT;
    END populate_namp_roaming_ext;

    /*
    ** Inserts a row into a table using sysdate.
    */
    PROCEDURE log_message (procedure_name IN VARCHAR, MESSAGE IN VARCHAR)
    IS
    BEGIN
        INSERT INTO xil_batch_log VALUES (SYSDATE, procedure_name, message);
        --COMMIT WORK;
    END log_message;
END xil_batch;
/
