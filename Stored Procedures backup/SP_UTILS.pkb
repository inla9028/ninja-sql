CREATE OR REPLACE PACKAGE BODY NINJAMAIN.sp_utils
IS
    --
    -- Purpose: Briefly explain the functionality of the package body
    --
    -- MODIFICATION HISTORY
    -- Person      Date        Comments
    -- ---------   ----------  ------------------------------------------
    -- Håkan       2018-11-06  Created.
    --

    /*
    ** Cleans locks in table ninjaconfig.sp_activation_bans that are old.
    */
    PROCEDURE clean_old_locks
    IS
        MY_ROW_COUNT INTEGER := 0;
        THRESHOLD    INTEGER := 10; -- 10 minute old locks will be removed.
    BEGIN
        -- LOG_MESSAGE('CLEAN_OLD_LOCKS', 'Cleaning old locks in NINJACONFIG.SP_ACTIVATION_BANS');
        --== Remove the locks older than threshold...
        UPDATE ninjaconfig.sp_activation_bans a
           SET a.in_use_id       = NULL
         WHERE a.in_use_id  IS NOT NULL
           AND a.sys_update_date < (SYSDATE - (THRESHOLD / (24 * 60)));

        MY_ROW_COUNT := SQL%ROWCOUNT;
        COMMIT WORK;

        IF MY_ROW_COUNT > 0
        THEN
            LOG_MESSAGE('CLEAN_OLD_LOCKS', 'Cleaned ' || TO_CHAR(MY_ROW_COUNT) || ' locks in NINJACONFIG.SP_ACTIVATION_BANS');
        END IF;
    END;
    
    /*
    ** Cleans old non-existing BANs from table ninjaconfig.sp_activation_bans.
    */
    PROCEDURE clean_old_bans
    IS
        MY_ROW_COUNT INTEGER := 0;
    BEGIN
        LOG_MESSAGE('CLEAN_OLD_BANS', 'Cleaning old BANs in NINJACONFIG.SP_ACTIVATION_BANS');
        --== Remove any BANs which no longer exists as Open or Tentative in Fokus
        DELETE 
          FROM ninjaconfig.sp_activation_bans a
         WHERE a.ban NOT IN (SELECT b.ban
                               FROM billing_account@fokus b
                              WHERE b.ban = a.ban
                                AND b.ban_status IN ('O', 'T'));

        MY_ROW_COUNT := SQL%ROWCOUNT;
        COMMIT WORK;
        
        LOG_MESSAGE('CLEAN_OLD_BANS', 'Cleaned ' || TO_CHAR(MY_ROW_COUNT) || ' old BANs from NINJACONFIG.SP_ACTIVATION_BANS');
    END;

    /*
    ** Inserts a row into a table using sysdate.
    */
    PROCEDURE log_message (procedure_name IN VARCHAR, MESSAGE IN VARCHAR)
    IS
    BEGIN
        INSERT INTO ninja_batchjob_log VALUES (SYSDATE, procedure_name, MESSAGE);
        COMMIT WORK;
    END log_message;
END;
/