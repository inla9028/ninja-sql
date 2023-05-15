CREATE OR REPLACE PACKAGE NINJAMAIN.sp_utils
IS
    PROCEDURE clean_old_locks;
    PROCEDURE clean_old_bans;
    PROCEDURE LOG_MESSAGE(procedure_name IN VARCHAR, message IN VARCHAR);
END;
/