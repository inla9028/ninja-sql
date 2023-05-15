DROP PACKAGE ARCHIVE_NINJADATA_TABLES;

CREATE OR REPLACE PACKAGE archive_ninjadata_tables
IS
    PROCEDURE archive_memo_transactions;
    PROCEDURE LOG_MESSAGE(procedure_name IN VARCHAR, message IN VARCHAR);
END;
/
DROP PACKAGE BODY ARCHIVE_NINJADATA_TABLES;

CREATE OR REPLACE PACKAGE BODY archive_ninjadata_tables
IS
    --
    -- Purpose: Briefly explain the functionality of the package body
    --
    -- MODIFICATION HISTORY
    -- Person      Date        Comments
    -- ---------   ----------  ------------------------------------------
    -- Håkan       2015-03-06  Created.
    -- Håkan       2015-03-06  Added archive_memo_transactions which archives MASTER_MEMO_TRANSACTIONS
    -- Håkan       2015-03-06  Added log_message.
    --

    /*
    ** Moves old and processed records from the table...:
    ** o ninjadata.master_memo_transactions
    ** ...into...:
    ** o ninjadata.arch_master_memo_transactions
    */
    PROCEDURE archive_memo_transactions
    IS
 --   DECLARE
        MY_ROW_COUNT INTEGER := 0;
    BEGIN
        LOG_MESSAGE('ARCHIVE_MEMO_TRANSACTIONS', 'Inserting rows into NINJADATA.ARCH_MASTER_MEMO_TRANSACTIONS');

        --== Copy the rows that has been processed...
        INSERT INTO ninjadata.arch_master_memo_transactions
             SELECT *
               FROM ninjadata.master_memo_transactions a
              WHERE a.process_status != 'WAITING'
                AND a.enter_time < TRUNC (SYSDATE);

        MY_ROW_COUNT := SQL%ROWCOUNT;
        COMMIT WORK;

        LOG_MESSAGE('ARCHIVE_MEMO_TRANSACTIONS', 'Inserted ' || TO_CHAR(MY_ROW_COUNT) || ' rows into NINJADATA.ARCH_MASTER_MEMO_TRANSACTIONS');
        LOG_MESSAGE('ARCHIVE_MEMO_TRANSACTIONS', 'Removing copied rows from NINJADATA.MASTER_MEMO_TRANSACTIONS');

        --== ...and remove the copied rows.
        DELETE FROM ninjadata.master_memo_transactions a
              WHERE a.process_status != 'WAITING'
                AND a.enter_time < TRUNC (SYSDATE);

        MY_ROW_COUNT := SQL%ROWCOUNT;
        COMMIT WORK;

        LOG_MESSAGE('ARCHIVE_MEMO_TRANSACTIONS', 'Removed ' || TO_CHAR(MY_ROW_COUNT) || ' rows from NINJADATA.MASTER_MEMO_TRANSACTIONS');
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
