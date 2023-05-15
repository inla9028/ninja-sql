CREATE OR REPLACE PACKAGE NINJAMAIN.archive_ninjadata_tables
IS
    PROCEDURE archive_memo_transactions;
    PROCEDURE LOG_MESSAGE(procedure_name IN VARCHAR, message IN VARCHAR);
END;
/