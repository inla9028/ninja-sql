CREATE OR REPLACE PACKAGE BODY NINJAMAIN.populate_service_transactions
AS
    -- Procedure for adding Fixed Price to Fixed Lines (FPF)
    -- service to subscribers, which ban have an apropriate ban level
    -- Fixed Price to Fixed Lines (FPF) soc
    PROCEDURE populate_add_fpf_service
    IS
    /*
    cursor c1 is

    -- A view on OPPE10 is used here to improve performance
    SELECT *
      FROM dd.ninja_subscriber_w2@OPPE10 a
      WHERE exists (select 1 from subscription_types_socs s
                    where rtrim(s.subscription_type_id)=rtrim(a.c_soc)||'REG1'
                    AND s.soc in ('FRIFAS','FRIFASKON','FRIFASYT')
                    and sysdate between s.effective_date and s.expiration_date);


      coursor_row c1%ROWTYPE;
    */
    BEGIN
        /*
        for coursor_row in c1 loop

            insert into service_transactions values(
            null,
            coursor_row.subscriber_no,
            coursor_row.soc,
            'ADD',
            null,
            null,
            null,
            'WAITING',
            null,
            coursor_row.dealer_code,
            coursor_row.sales_agent,
            1,
            null,
            null,
            null,
            null,
            null
            );

            commit;

        end loop;
        */
        log_message ('POPULATE_ADD_FPF_SERVICE',
                     'Inserted 0 rows into NINJADATA.SERVICE_TRANSACTIONS');
    END populate_add_fpf_service;

    -- Procedure for removing Fixed Price to Fixed Lines (FPF)
    -- service from subscribers, which ban doesn't have an apropriate ban level
    -- Fixed Price to Fixed Lines (FPF) soc
    PROCEDURE populate_remove_fpf_service
    IS
    /*
    cursor c1 is

    -- A view on OPPE10 is used here to improve performance
    SELECT *
      FROM dd.ninja_subscriber_w1@oppe10;

      coursor_row c1%ROWTYPE;
    */
    BEGIN
        /*
        for coursor_row in c1 loop

            insert into service_transactions values(
            null,
            coursor_row.subscriber_no,
            coursor_row.soc,
            'DELETE',
            null,
            null,
            null,
            'WAITING',
            null,
            coursor_row.dealer_code,
            coursor_row.sales_agent,
            1,
            null,
            null,
            null,
            null,
            null
            );

            commit;

        end loop;
        */
        log_message ('POPULATE_REMOVE_FPF_SERVICE',
                     'Inserted 0 rows into NINJADATA.SERVICE_TRANSACTIONS');
    END populate_remove_fpf_service;

    -- Procedure for adding SOC to the customers that have one of the campaigns,
    -- listed in CMAPAIGN_SOC_COEXISTANCE Ninja table (x-mas 2007 campaign)
    PROCEDURE christmas_campaign_2007
    IS
        CURSOR c1
        IS
            SELECT a.ban,
                   a.subscriber_no,
                   a.dealer_code,
                   a.sales_agent,
                   cs.soc
              FROM service_agreement@nrep11 a, campaign_soc_coexistance cs
             WHERE a.service_type     = 'P'
               AND a.effective_date  >= cs.effective_date
               AND a.expiration_date  > SYSDATE
               AND SYSDATE      BETWEEN cs.effective_date AND cs.expiration_date
               AND RTRIM (a.campaign) = cs.campaign
               AND NOT EXISTS
                           (SELECT ''
                              FROM service_agreement@nrep11 b
                             WHERE b.ban           = a.ban
                               AND b.subscriber_no = a.subscriber_no
                               AND RTRIM (b.soc)   = cs.soc
                               AND SYSDATE BETWEEN b.effective_date AND b.expiration_date);

        coursor_row    c1%ROWTYPE;
        my_row_count   INTEGER := 0;
    BEGIN
        FOR coursor_row IN c1
        LOOP
            INSERT INTO service_transactions
            VALUES (NULL,
                    coursor_row.subscriber_no,
                    coursor_row.soc,
                    'ADD',
                    NULL,
                    NULL,
                    NULL,
                    'WAITING',
                    NULL,
                    coursor_row.dealer_code,
                    coursor_row.sales_agent,
                    1,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL);

            my_row_count := my_row_count + SQL%ROWCOUNT;

            COMMIT;
        END LOOP;

        log_message ('CHRISTMAS_CAMPAIGN_2007',
                     'Inserted ' || TO_CHAR (my_row_count) || ' rows into NINJADATA.SERVICE_TRANSACTIONS');
    END christmas_campaign_2007;

    /*
    ** Inserts a row into a table using sysdate.
    */
    PROCEDURE log_message (procedure_name IN VARCHAR, MESSAGE IN VARCHAR)
    IS
    BEGIN
        INSERT INTO ninja_batchjob_log VALUES (SYSDATE, procedure_name, MESSAGE);
        COMMIT WORK;
    END log_message;
END populate_service_transactions;
/