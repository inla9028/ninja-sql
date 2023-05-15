CREATE OR REPLACE PACKAGE NINJAMAIN.populate_service_transactions
AS
    PROCEDURE populate_remove_fpf_service;
    PROCEDURE populate_add_fpf_service;
    PROCEDURE christmas_campaign_2007;
    PROCEDURE log_message (procedure_name IN VARCHAR, MESSAGE IN VARCHAR);
END populate_service_transactions;
/