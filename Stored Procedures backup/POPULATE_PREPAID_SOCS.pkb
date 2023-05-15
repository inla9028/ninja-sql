CREATE OR REPLACE PACKAGE BODY NINJAMAIN.populate_prepaid_socs
AS
    PROCEDURE add_wdfpre_service
    IS
        CURSOR c1
        IS
            SELECT s.subscriber_no,
                   'WDFPRE' soc,
                   'ADD' action,
                   SYSDATE AS request_time,
                   '2' priority,
                   'STLI15-' || TO_CHAR (SYSDATE, 'DD.MM.YYYY') AS request_id,
                   'All PKx subs should have WDFPRE soc. Adding SOC due to error in preactivation of PKx priceplans. On request by BEDA1062 and STLI15 (Using Ninja Batch Job). '
                       AS memo_text
              FROM vw_ninja_sub_to_get_wdfpre@nrep11 s;

        cursor_row   c1%ROWTYPE;
        MY_ROW_COUNT INTEGER := 0;
    BEGIN
        LOG_MESSAGE('ADD_WDFPRE_SERVICE', 'Inserting rows into NINJADATA.MASTER_TRANSACTIONS');
        FOR cursor_row IN c1
        LOOP
            INSERT INTO master_transactions (trans_number,
                                             subscriber_no,
                                             soc,
                                             action_code,
                                             new_soc,
                                             enter_time,
                                             request_time,
                                             process_time,
                                             process_status,
                                             status_desc,
                                             dealer_code,
                                             sales_agent,
                                             priority,
                                             request_id,
                                             memo_text,
                                             stream)
            VALUES (
                       NULL,
                       cursor_row.subscriber_no,
                       cursor_row.soc,
                       cursor_row.action,
                       NULL,
                       NULL,
                       cursor_row.request_time,
                       NULL,
                       'WAITING',
                       NULL,
                       NULL,
                       NULL,
                       cursor_row.priority,
                       cursor_row.request_id,
                       cursor_row.memo_text,
                       DECODE (
                           MOD (SUBSTR (cursor_row.subscriber_no, 4), 10) + 1,
                           NULL, 1,
                           MOD (SUBSTR (cursor_row.subscriber_no, 4), 10) + 1));

            MY_ROW_COUNT := MY_ROW_COUNT + SQL%ROWCOUNT;
            -- Commit work
            COMMIT;
        END LOOP;
        LOG_MESSAGE('ADD_WDFPRE_SERVICE', 'Inserted ' || TO_CHAR(MY_ROW_COUNT) || ' rows into NINJADATA.MASTER_TRANSACTIONS');
    END add_wdfpre_service;

    PROCEDURE add_mpodpre01_service
    IS
        CURSOR c2
        IS
            SELECT s.subscriber_no,
                   'MPODPRE01' soc,
                   'ADD' action,
                   SYSDATE AS request_time,
                   '2' priority,
                   'STLI15-' || TO_CHAR (SYSDATE, 'DD.MM.YYYY') AS request_id,
                   'All voice PKx subs (except PKOD and PKOU) should have GPRS soc. Adding MPODPRE01 due to error in preactivation of PKx priceplans. On request by BEDA1062 and STLI15 (Using Ninja Batch Job). '
                       AS memo_text
              FROM vw_ninja_sub_to_get_mpodpre01@nrep11 s;

        cursor_row   c2%ROWTYPE;
        MY_ROW_COUNT INTEGER := 0;
    BEGIN
        LOG_MESSAGE('ADD_MPODPRE01_SERVICE', 'Inserting rows into NINJADATA.MASTER_TRANSACTIONS');
        FOR cursor_row IN c2
        LOOP
            INSERT INTO master_transactions (trans_number,
                                             subscriber_no,
                                             soc,
                                             action_code,
                                             new_soc,
                                             enter_time,
                                             request_time,
                                             process_time,
                                             process_status,
                                             status_desc,
                                             dealer_code,
                                             sales_agent,
                                             priority,
                                             request_id,
                                             memo_text,
                                             stream)
            VALUES (
                       NULL,
                       cursor_row.subscriber_no,
                       cursor_row.soc,
                       cursor_row.action,
                       NULL,
                       NULL,
                       cursor_row.request_time,
                       NULL,
                       'WAITING',
                       NULL,
                       NULL,
                       NULL,
                       cursor_row.priority,
                       cursor_row.request_id,
                       cursor_row.memo_text,
                       DECODE (
                           MOD (SUBSTR (cursor_row.subscriber_no, 4), 10) + 1,
                           NULL, 1,
                           MOD (SUBSTR (cursor_row.subscriber_no, 4), 10) + 1));

            MY_ROW_COUNT := MY_ROW_COUNT + SQL%ROWCOUNT;
            -- Commit work
            COMMIT;
        END LOOP;
        LOG_MESSAGE('ADD_MPODPRE01_SERVICE', 'Inserted ' || TO_CHAR(MY_ROW_COUNT) || ' rows into NINJADATA.MASTER_TRANSACTIONS');
    END add_mpodpre01_service;


    PROCEDURE add_vmb2cp01_service
    IS
        CURSOR c3
        IS
            SELECT s.subscriber_no,
                   'VMB2CP01' soc,
                   'ADD' action,
                   SYSDATE AS request_time,
                   '2' priority,
                   'STLI15-' || TO_CHAR (SYSDATE, 'DD.MM.YYYY') AS request_id,
                   'All voice PKx subs should have a voicemail SOC. Adding VMB2CP01 due to error in preactivation of PKx priceplans. On request by BEDA1062 and STLI15 (Using Ninja Batch Job). '
                       AS memo_text
              FROM vw_ninja_sub_to_get_VMB2CP01@nrep11 s;

        cursor_row   c3%ROWTYPE;
        MY_ROW_COUNT INTEGER := 0;
    BEGIN
        LOG_MESSAGE('ADD_VMB2CP01_SERVICE', 'Inserting rows into NINJADATA.MASTER_TRANSACTIONS');
        FOR cursor_row IN c3
        LOOP
            INSERT INTO master_transactions (trans_number,
                                             subscriber_no,
                                             soc,
                                             action_code,
                                             new_soc,
                                             enter_time,
                                             request_time,
                                             process_time,
                                             process_status,
                                             status_desc,
                                             dealer_code,
                                             sales_agent,
                                             priority,
                                             request_id,
                                             memo_text,
                                             stream)
            VALUES (
                       NULL,
                       cursor_row.subscriber_no,
                       cursor_row.soc,
                       cursor_row.action,
                       NULL,
                       NULL,
                       cursor_row.request_time,
                       NULL,
                       'WAITING',
                       NULL,
                       NULL,
                       NULL,
                       cursor_row.priority,
                       cursor_row.request_id,
                       cursor_row.memo_text,
                       DECODE (
                           MOD (SUBSTR (cursor_row.subscriber_no, 4), 10) + 1,
                           NULL, 1,
                           MOD (SUBSTR (cursor_row.subscriber_no, 4), 10) + 1));

           MY_ROW_COUNT := MY_ROW_COUNT + SQL%ROWCOUNT;
           -- Commit work
            COMMIT;
        END LOOP;
        LOG_MESSAGE('ADD_VMB2CP01_SERVICE', 'Inserted ' || TO_CHAR(MY_ROW_COUNT) || ' rows into NINJADATA.MASTER_TRANSACTIONS');
    END add_vmb2cp01_service;

    PROCEDURE add_mms03_service
    IS
        CURSOR c4
        IS
            SELECT s.subscriber_no,
                   'MMS03' soc,
                   'ADD' action,
                   SYSDATE AS request_time,
                   '2' priority,
                   'STLI15-' || TO_CHAR (SYSDATE, 'DD.MM.YYYY') AS request_id,
                   'All PKx subs should have MMS soc. Adding MMS03 SOC due to error in preactivation of PKx priceplans. On request by BEDA1062 and STLI15 (Using Ninja Batch Job). '
                       AS memo_text
              FROM vw_ninja_sub_to_get_mms03@nrep11 s;

        cursor_row   c4%ROWTYPE;
        MY_ROW_COUNT INTEGER := 0;
    BEGIN
        LOG_MESSAGE('ADD_MMS03_SERVICE', 'Inserting rows into NINJADATA.MASTER_TRANSACTIONS');
        FOR cursor_row IN c4
        LOOP
            INSERT INTO master_transactions (trans_number,
                                             subscriber_no,
                                             soc,
                                             action_code,
                                             new_soc,
                                             enter_time,
                                             request_time,
                                             process_time,
                                             process_status,
                                             status_desc,
                                             dealer_code,
                                             sales_agent,
                                             priority,
                                             request_id,
                                             memo_text,
                                             stream)
            VALUES (
                       NULL,
                       cursor_row.subscriber_no,
                       cursor_row.soc,
                       cursor_row.action,
                       NULL,
                       NULL,
                       cursor_row.request_time,
                       NULL,
                       'WAITING',
                       NULL,
                       NULL,
                       NULL,
                       cursor_row.priority,
                       cursor_row.request_id,
                       cursor_row.memo_text,
                       DECODE (
                           MOD (SUBSTR (cursor_row.subscriber_no, 4), 10) + 1,
                           NULL, 1,
                           MOD (SUBSTR (cursor_row.subscriber_no, 4), 10) + 1));

            MY_ROW_COUNT := MY_ROW_COUNT + SQL%ROWCOUNT;
            -- Commit work
            COMMIT;
        END LOOP;
        LOG_MESSAGE('ADD_MMS03_SERVICE', 'Inserted ' || TO_CHAR(MY_ROW_COUNT) || ' rows into NINJADATA.MASTER_TRANSACTIONS');
    END add_mms03_service;

    PROCEDURE add_mms04_service
    IS
        CURSOR c5
        IS
            SELECT s.subscriber_no,
                   'MMS04' soc,
                   'ADD' action,
                   SYSDATE AS request_time,
                   '2' priority,
                   'STLI15-' || TO_CHAR (SYSDATE, 'DD.MM.YYYY') AS request_id,
                   'All PKOP / PKOS subs should have MMS04 soc. Adding SOC due to error in preactivation of PKx priceplans. On request by BEDA1062 and STLI15 (Using Ninja Batch Job). '
                       AS memo_text
              FROM vw_ninja_sub_to_get_mms04@nrep11 s;

        cursor_row   c5%ROWTYPE;
        MY_ROW_COUNT INTEGER := 0;
    BEGIN
        LOG_MESSAGE('ADD_MMS04_SERVICE', 'Inserting rows into NINJADATA.MASTER_TRANSACTIONS');
        FOR cursor_row IN c5
        LOOP
            INSERT INTO master_transactions (trans_number,
                                             subscriber_no,
                                             soc,
                                             action_code,
                                             new_soc,
                                             enter_time,
                                             request_time,
                                             process_time,
                                             process_status,
                                             status_desc,
                                             dealer_code,
                                             sales_agent,
                                             priority,
                                             request_id,
                                             memo_text,
                                             stream)
            VALUES (
                       NULL,
                       cursor_row.subscriber_no,
                       cursor_row.soc,
                       cursor_row.action,
                       NULL,
                       NULL,
                       cursor_row.request_time,
                       NULL,
                       'WAITING',
                       NULL,
                       NULL,
                       NULL,
                       cursor_row.priority,
                       cursor_row.request_id,
                       cursor_row.memo_text,
                       DECODE (
                           MOD (SUBSTR (cursor_row.subscriber_no, 4), 10) + 1,
                           NULL, 1,
                           MOD (SUBSTR (cursor_row.subscriber_no, 4), 10) + 1));

            MY_ROW_COUNT := MY_ROW_COUNT + SQL%ROWCOUNT;
            -- Commit work
            COMMIT;
        END LOOP;
        LOG_MESSAGE('ADD_MMS04_SERVICE', 'Inserted ' || TO_CHAR(MY_ROW_COUNT) || ' rows into NINJADATA.MASTER_TRANSACTIONS');
    END add_mms04_service;

    /*
    ** Inserts a row into a table using sysdate.
    */
    PROCEDURE log_message (procedure_name IN VARCHAR, MESSAGE IN VARCHAR)
    IS
    BEGIN
        INSERT INTO ninja_batchjob_log VALUES (SYSDATE, procedure_name, MESSAGE);
        COMMIT WORK;
    END log_message;
END populate_prepaid_socs;
/