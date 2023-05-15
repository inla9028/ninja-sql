-- Start of DDL Script for Package Body NINJATEAM.MW_PROCS
-- Generated 2016-07-07 10:56:30 from NINJATEAM@NINJAPROD1

CREATE OR REPLACE 
PACKAGE mw_procs
   IS
     PROCEDURE load_master_transactions;
     PROCEDURE load_master_transactions_strs;
--     PROCEDURE load_service_transactions;
--     PROCEDURE load_talk2me_transactions;
--     PROCEDURE load_replaceable_socs;
--     PROCEDURE update_stream;
 
 END; -- Package Specification MW_PROCS
/


CREATE OR REPLACE 
PACKAGE BODY mw_procs
 IS
    PROCEDURE load_master_transactions
    IS
        CURSOR  tmp_trans
        IS
            SELECT  *
            FROM    mw_tmp_trans;
        v_tmp_trans tmp_trans%ROWTYPE;

        v_trans_number  NUMBER;


   BEGIN
       FOR v_tmp_trans IN tmp_trans
       LOOP
       --dbms_output.put_line('SUB - ' || v_tmp_trans.subscriber_no || ' Feat - ' || v_tmp_trans.feature);
            -- Get next transaction number
            SELECT  MAX(trans_number)+1
            INTO    v_trans_number
            FROM    ninjadata.master_transactions;

            -- Insert into master_transactions table
            INSERT
            INTO    ninjadata.master_transactions
                    (TRANS_NUMBER,
                    SUBSCRIBER_NO,
                    SOC,
                    ACTION_CODE,
                    NEW_SOC,
                    ENTER_TIME,
                    REQUEST_TIME,
                    PROCESS_TIME,
                    PROCESS_STATUS,
                    STATUS_DESC,
                    DEALER_CODE,
                    SALES_AGENT,
                    PRIORITY,
                    REQUEST_ID,
                    MEMO_TEXT,
                    STREAM)
            VALUES  (v_trans_number,
                    v_tmp_trans.subscriber_no,
                    v_tmp_trans.soc,
                    v_tmp_trans.action,
                    null,
                    null,
                    null,
                    null, -- PROCESS_TIME
                    'WAITING',
                    null,
                    v_tmp_trans.dealer_code,
                    v_tmp_trans.sales_agent,
                    1,
                    v_tmp_trans.request_id,
                    v_tmp_trans.memo_text,
                    /*substr(v_tmp_trans.subscriber_no, 14) +1)*/'1');
--                    substr(v_tmp_trans.subscriber_no, 14) +1);


             -- Any Parameters
             IF v_tmp_trans.feature IS NOT NULL
             THEN
                INSERT
                INTO    ninjadata.master_tran_features
                    (TRANS_NUMBER,
                    FEATURE_CODE)
                VALUES (v_trans_number,
                       v_tmp_trans.feature);

                -- Add The Parms
                INSERT
                INTO    ninjadata.master_tran_feature_parms
                    (TRANS_NUMBER,
                    FEATURE_CODE,
                    PARAMETER_CODE,
                    VALUE)
                VALUES (v_trans_number,
                        v_tmp_trans.feature,
                        v_tmp_trans.parameter,
                        v_tmp_trans.parm_value);

             END IF;

             -- Any Parameters2
             IF v_tmp_trans.feature2 IS NOT NULL
             THEN
                IF v_tmp_trans.feature <> v_tmp_trans.feature2 THEN
                INSERT
                INTO    ninjadata.master_tran_features
                    (TRANS_NUMBER,
                    FEATURE_CODE)
                VALUES (v_trans_number,
                       v_tmp_trans.feature2);
                END IF;

                -- Add The Parms
                INSERT
                INTO    ninjadata.master_tran_feature_parms
                    (TRANS_NUMBER,
                    FEATURE_CODE,
                    PARAMETER_CODE,
                    VALUE)
                VALUES (v_trans_number,
                        v_tmp_trans.feature2,
                        v_tmp_trans.parameter2,
                        v_tmp_trans.parm_value2);

             END IF;

             -- Any Parameters3
             IF v_tmp_trans.feature3 IS NOT NULL
             THEN
                IF v_tmp_trans.feature <> v_tmp_trans.feature3 AND v_tmp_trans.feature2 <> v_tmp_trans.feature3
                THEN
                INSERT
                INTO    ninjadata.master_tran_features
                    (TRANS_NUMBER,
                    FEATURE_CODE)
                VALUES (v_trans_number,
                       v_tmp_trans.feature3);
                END IF;

                -- Add The Parms
                INSERT
                INTO    ninjadata.master_tran_feature_parms
                    (TRANS_NUMBER,
                    FEATURE_CODE,
                    PARAMETER_CODE,
                    VALUE)
                VALUES (v_trans_number,
                        v_tmp_trans.feature3,
                        v_tmp_trans.parameter3,
                        v_tmp_trans.parm_value3);

             END IF;

             -- Any Parameters4
             IF v_tmp_trans.feature4 IS NOT NULL
             THEN
                IF v_tmp_trans.feature <> v_tmp_trans.feature4 AND v_tmp_trans.feature2 <> v_tmp_trans.feature4 AND
                v_tmp_trans.feature3 <> v_tmp_trans.feature4
                THEN
                INSERT
                INTO    ninjadata.master_tran_features
                    (TRANS_NUMBER,
                    FEATURE_CODE)
                VALUES (v_trans_number,
                       v_tmp_trans.feature4);
                END IF;

                -- Add The Parms
                INSERT
                INTO    ninjadata.master_tran_feature_parms
                    (TRANS_NUMBER,
                    FEATURE_CODE,
                    PARAMETER_CODE,
                    VALUE)
                VALUES (v_trans_number,
                        v_tmp_trans.feature4,
                        v_tmp_trans.parameter4,
                        v_tmp_trans.parm_value4);


             END IF;

        END LOOP;

       -- Commit work
       COMMIT;
       -- Remove the recs from the temp table..
       DELETE FROM mw_tmp_trans;
       COMMIT;
     END; -- load_master_transactions


    PROCEDURE load_master_transactions_strs
    IS
       CURSOR tmp_trans
       IS
          SELECT *
            FROM mw_tmp_trans;

       v_tmp_trans      tmp_trans%ROWTYPE;
       v_trans_number   NUMBER;
    BEGIN
       FOR v_tmp_trans IN tmp_trans
       LOOP
          -- Get next transaction number
          SELECT MAX (trans_number) + 1
            INTO v_trans_number
            FROM ninjadata.master_transactions;

          -- Insert into master_transactions table
          INSERT INTO ninjadata.master_transactions
                      (trans_number, subscriber_no,
                       soc, action_code, new_soc, enter_time, request_time,
                       process_time, process_status, status_desc, dealer_code,
                       sales_agent, priority, request_id, memo_text, stream
                      )
               VALUES (v_trans_number, v_tmp_trans.subscriber_no,
                       v_tmp_trans.soc, v_tmp_trans.action, NULL, NULL, NULL,
                       NULL,                                       -- PROCESS_TIME
                            'WAITING', NULL, v_tmp_trans.dealer_code,
                    v_tmp_trans.sales_agent, 1, v_tmp_trans.request_id, v_tmp_trans.memo_text,
                       DECODE (  MOD (SUBSTR (v_tmp_trans.subscriber_no, 4),
                                     10)
                              + 1,
                              NULL, 1,
                                MOD (SUBSTR (v_tmp_trans.subscriber_no, 4),
                                     10)
                              + 1)
                      );

          -- Any Parameters
          IF v_tmp_trans.feature IS NOT NULL
          THEN
             INSERT INTO ninjadata.master_tran_features
                         (trans_number, feature_code
                         )
                  VALUES (v_trans_number, v_tmp_trans.feature
                         );

             -- Add The Parms
             INSERT INTO ninjadata.master_tran_feature_parms
                         (trans_number, feature_code,
                          parameter_code, VALUE
                         )
                  VALUES (v_trans_number, v_tmp_trans.feature,
                          v_tmp_trans.parameter, v_tmp_trans.parm_value
                         );
          END IF;

          -- Any Parameters2
          IF v_tmp_trans.feature2 IS NOT NULL
          THEN
             IF v_tmp_trans.feature <> v_tmp_trans.feature2
             THEN
                INSERT INTO ninjadata.master_tran_features
                            (trans_number, feature_code
                            )
                     VALUES (v_trans_number, v_tmp_trans.feature2
                            );
             END IF;

             -- Add The Parms
             INSERT INTO ninjadata.master_tran_feature_parms
                         (trans_number, feature_code,
                          parameter_code, VALUE
                         )
                  VALUES (v_trans_number, v_tmp_trans.feature2,
                          v_tmp_trans.parameter2, v_tmp_trans.parm_value2
                         );
          END IF;

          -- Any Parameters3
          IF v_tmp_trans.feature3 IS NOT NULL
          THEN
             IF     v_tmp_trans.feature <> v_tmp_trans.feature3
                AND v_tmp_trans.feature2 <> v_tmp_trans.feature3
             THEN
                INSERT INTO ninjadata.master_tran_features
                            (trans_number, feature_code
                            )
                     VALUES (v_trans_number, v_tmp_trans.feature3
                            );
             END IF;

             -- Add The Parms
             INSERT INTO ninjadata.master_tran_feature_parms
                         (trans_number, feature_code,
                          parameter_code, VALUE
                         )
                  VALUES (v_trans_number, v_tmp_trans.feature3,
                          v_tmp_trans.parameter3, v_tmp_trans.parm_value3
                         );
          END IF;

          -- Any Parameters4
          IF v_tmp_trans.feature4 IS NOT NULL
          THEN
             IF     v_tmp_trans.feature <> v_tmp_trans.feature4
                AND v_tmp_trans.feature2 <> v_tmp_trans.feature4
                AND v_tmp_trans.feature3 <> v_tmp_trans.feature4
             THEN
                INSERT INTO ninjadata.master_tran_features
                            (trans_number, feature_code
                            )
                     VALUES (v_trans_number, v_tmp_trans.feature4
                            );
             END IF;

             -- Add The Parms
             INSERT INTO ninjadata.master_tran_feature_parms
                         (trans_number, feature_code,
                          parameter_code, VALUE
                         )
                  VALUES (v_trans_number, v_tmp_trans.feature4,
                          v_tmp_trans.parameter4, v_tmp_trans.parm_value4
                         );
          END IF;
       END LOOP;

       -- Commit work
       COMMIT;

       -- Remove the recs from the temp table..
       DELETE FROM mw_tmp_trans;

       COMMIT;
    END; -- load_master_transactions_strs

/*
    PROCEDURE update_stream
     IS
    CURSOR tmp_trx IS
        select mt.subscriber_no, trans_number, DECODE(mod(customer_id,10)+1,null,1,mod(customer_id,10)+1) stream
        from ninjadata.master_transactions mt, subscriber@PROD.WORLD s
        where process_status='WAITING'
        and s.subscriber_no=mt.subscriber_no
        and sub_status!='C';

        v_tmp_trx tmp_trx%ROWTYPE;

        BEGIN
        FOR v_tmp_trx IN tmp_trx
          LOOP
            update ninjadata.master_transactions mt
              set stream = v_tmp_trx.stream
            where trans_number=v_tmp_trx.trans_number
              and process_status='WAITING' ;
            commit;
          END LOOP;

   END;
*/

/*
    PROCEDURE load_service_transactions
    IS
        CURSOR  tmp_trans
        IS
            SELECT  *
            FROM    talk2me_tmp_trans;
        v_tmp_trans tmp_trans%ROWTYPE;

        v_trans_number  NUMBER;


   BEGIN
       FOR v_tmp_trans IN tmp_trans
       LOOP
            -- Get next transaction number
            SELECT  MAX(trans_number)+1
            INTO    v_trans_number
            FROM    ninjadata.service_transactions;


            -- Insert into service_transactions table
            INSERT
            INTO    ninjadata.service_transactions
                    (TRANS_NUMBER,
                    SUBSCRIBER_NO,
                    SOC,
                    ACTION_CODE,
                    ENTER_TIME,
                    REQUEST_TIME,
                    PROCESS_TIME,
                    PROCESS_STATUS,
                    STATUS_DESC,
                    DEALER_CODE,
                    SALES_AGENT,
                    PRIORITY,
                    SUCCESS_MSG_ID,
                    ERROR_MSG_ID,
                    MSG_STATUS_DESC)
            VALUES  (v_trans_number,
                    v_tmp_trans.subscriber_no,
                    v_tmp_trans.soc,
                    v_tmp_trans.action,
                    null, -- Enter time
                    null, -- Request Time
                    null, -- Process Time
                    null, -- Process Status
                    null, -- Status Desc
                    'NET', -- Dealer
                    'A', -- Sales Agent
                    1,
                    null, -- Success Msg Id
                    null, -- Error Msg id
                    null); -- MSG status desc.
        END LOOP;

       -- Commit work
       COMMIT;
       -- Remove the recs from the temp table..
       DELETE FROM talk2me_tmp_trans;
       COMMIT;
     END;
*/
/*
    PROCEDURE load_talk2me_transactions
    IS
        CURSOR  tmp_trans
        IS
            SELECT  *
            FROM    mw_tmp_trans;
        v_tmp_trans tmp_trans%ROWTYPE;

        v_trans_number  NUMBER;


   BEGIN
       FOR v_tmp_trans IN tmp_trans
       LOOP
       --dbms_output.put_line('SUB - ' || v_tmp_trans.subscriber_no || ' Feat - ' || v_tmp_trans.feature);
            -- Get next transaction number
            SELECT  MAX(trans_number)+1
            INTO    v_trans_number
            FROM    ninjadata.master_transactions;

            -- Insert into master_transactions table
            INSERT
            INTO    ninjadata.master_transactions
                    (TRANS_NUMBER,
                    SUBSCRIBER_NO,
                    SOC,
                    ACTION_CODE,
                    NEW_SOC,
                    ENTER_TIME,
                    REQUEST_TIME,
                    PROCESS_TIME,
                    PROCESS_STATUS,
                    STATUS_DESC,
                    DEALER_CODE,
                    SALES_AGENT,
                    PRIORITY)
            VALUES  (v_trans_number,
                    v_tmp_trans.subscriber_no,
                    v_tmp_trans.soc,
                    v_tmp_trans.action,
                    null,
                    null,
                    null,
                    null,
                    'IN_PROGRESS',
                    null,
                    null,
                    null,
                    1);

             -- Any Parameters
             IF v_tmp_trans.feature IS NOT NULL
             THEN
                INSERT
                INTO    ninjadata.master_tran_features
                    (TRANS_NUMBER,
                    FEATURE_CODE)
                VALUES (v_trans_number,
                       v_tmp_trans.feature);

                -- Add The Parms
                INSERT
                INTO    ninjadata.master_tran_feature_parms
                    (TRANS_NUMBER,
                    FEATURE_CODE,
                    PARAMETER_CODE,
                    VALUE)
                VALUES (v_trans_number,
                        v_tmp_trans.feature,
                        v_tmp_trans.parameter,
                        v_tmp_trans.parm_value);

             END IF;


        END LOOP;

       -- Commit work
       COMMIT;
       -- Remove the recs from the temp table..
       DELETE FROM mw_tmp_trans;
       COMMIT;
     END;
*/
/*
    PROCEDURE load_replaceable_socs
    IS
        CURSOR  tmp_socs
        IS
            SELECT  soc
            FROM    ninjarules.socs
            WHERE soc IN   ('DATAVAL',
                            'DATAVBH',
                            'DATAVCH',
                            'DATAVCL',
                            'DATAVDH',
                            'DATAVEH',
                            'DATAVFH',
                            'DATAVFP',
                            'DATAVGH',
                            'DATAVGP',
                            'DATAVHH',
                            'DATAVKH',
                            'DATAVMD',
                            'DATAVMP',
                            'DATAVMS',
                            'DATAVMT',
                            'DATAVOP',
                            'DATAVPH',
                            'DATAVPL',
                            'DATAVSH',
                            'DATAVSL',
                            'DATAVSP',
                            'DATAVXH',
                            'DATAVYH',
                            'DATAHSVS');
            v_tmp_socs tmp_socs%ROWTYPE;


        CURSOR  tmp_socs_selected (p_exist_soc IN VARCHAR2)
        IS
            SELECT  soc
            FROM ninjarules.socs
            WHERE soc LIKE 'DATA%'
            AND soc <> p_exist_soc;
        v_tmp_to_soc tmp_socs_selected%ROWTYPE;


   BEGIN
       FOR v_tmp_socs IN tmp_socs
       LOOP

        FOR v_tmp_to_soc IN tmp_socs_selected(v_tmp_socs.soc)
        LOOP

            INSERT
            INTO    ninjarules.tmp_rep_socs
                    (org_soc,
                    new_soc)
            VALUES  (v_tmp_to_soc.soc,
                    v_tmp_socs.soc);


        END LOOP;

        -- Commit work
        COMMIT;
       END LOOP;
       COMMIT WORK;
     END;
*/
/*
    PROCEDURE load_replaceable_socs
    IS
        CURSOR  tmp_socs
        IS
            SELECT  soc
            FROM    ninjarules.socs
            WHERE soc IN   ('FAXVAL',
                            'FAXVBH',
                            'FAXVCH',
                            'FAXVCL',
                            'FAXVDH',
                            'FAXVEH',
                            'FAXVFH',
                            'FAXVFP',
                            'FAXVGH',
                            'FAXVGP',
                            'FAXVHH',
                            'FAXVKH',
                            'FAXVMD',
                            'FAXVMP',
                            'FAXVMS',
                            'FAXVMT',
                            'FAXVOP',
                            'FAXVPH',
                            'FAXVPL',
                            'FAXVSH',
                            'FAXVSL',
                            'FAXVSP',
                            'FAXVXH',
                            'FAXVYH');
            v_tmp_socs tmp_socs%ROWTYPE;


        CURSOR  tmp_socs_selected (p_exist_soc IN VARCHAR2)
        IS
            SELECT  soc
            FROM ninjarules.socs
            WHERE soc LIKE 'FAXV%' OR soc = 'FAX01'
            AND soc <> p_exist_soc;
        v_tmp_to_soc tmp_socs_selected%ROWTYPE;


   BEGIN
       FOR v_tmp_socs IN tmp_socs
       LOOP

        FOR v_tmp_to_soc IN tmp_socs_selected(v_tmp_socs.soc)
        LOOP

            INSERT
            INTO    ninjarules.tmp_rep_socs
                    (org_soc,
                    new_soc)
            VALUES  (v_tmp_to_soc.soc,
                    v_tmp_socs.soc);


        END LOOP;

        -- Commit work
        COMMIT;
       END LOOP;
       COMMIT WORK;
     END;
*/
   -- Enter further code below as specified in the Package spec.
END; -- Package Body MW_PROCS
/


-- End of DDL Script for Package Body NINJATEAM.MW_PROCS

