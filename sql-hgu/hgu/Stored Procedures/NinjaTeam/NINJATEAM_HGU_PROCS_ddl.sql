-- Start of DDL Script for Package Body NINJATEAM.HGU_PROCS
-- Generated 2016-07-07 10:55:23 from NINJATEAM@NINJAPROD1

CREATE OR REPLACE 
PACKAGE hgu_procs
IS
   PROCEDURE load_master_transactions;
   PROCEDURE load_master_transactions_1;
   PROCEDURE load_master_trans_replace;
   PROCEDURE load_master_trans_replace_1;
END;
/


CREATE OR REPLACE 
PACKAGE BODY hgu_procs
IS
   PROCEDURE load_master_transactions
   IS
      CURSOR tmp_trans
      IS
         SELECT *
           FROM hgu_tmp_trans;

      v_tmp_trans      tmp_trans%ROWTYPE;
   BEGIN
      FOR v_tmp_trans IN tmp_trans
      LOOP
         -- Insert into master_transactions table
         INSERT INTO ninjadata.master_transactions
                     (trans_number, subscriber_no,
                      soc, action_code, new_soc, enter_time, request_time,
                      process_time, process_status, status_desc, dealer_code,
                      sales_agent, priority, request_id,
                      memo_text,
                      stream
                     )
              VALUES (NULL, v_tmp_trans.subscriber_no,
                      v_tmp_trans.soc, v_tmp_trans.action, NULL, NULL,
                      v_tmp_trans.request_time, NULL, 'WAITING', NULL, v_tmp_trans.dealer_code,
                      v_tmp_trans.sales_agent, v_tmp_trans.priority, v_tmp_trans.request_id,
                      v_tmp_trans.memo_text,
                      DECODE (  MOD (SUBSTR (v_tmp_trans.subscriber_no, 4),
                                     10)
                              + 1,
                              NULL, 1,
                                MOD (SUBSTR (v_tmp_trans.subscriber_no, 4),
                                     10)
                              + 1
                             )
                     );
      END LOOP;

      -- Commit work
      COMMIT;

      -- Remove the recs from the temp table..
      DELETE FROM hgu_tmp_trans;

      COMMIT;
   END;

   PROCEDURE load_master_transactions_1
   IS
      CURSOR tmp_trans
      IS
         SELECT *
           FROM hgu_tmp_trans;

      v_tmp_trans      tmp_trans%ROWTYPE;
   BEGIN
      FOR v_tmp_trans IN tmp_trans
      LOOP
         -- Insert into master_transactions table
         INSERT INTO ninjadata.master_transactions
                     (trans_number, subscriber_no,
                      soc, action_code, new_soc, enter_time, request_time,
                      process_time, process_status, status_desc, dealer_code,
                      sales_agent, priority, request_id, memo_text, stream
                     )
              VALUES (NULL, v_tmp_trans.subscriber_no,
                      v_tmp_trans.soc, v_tmp_trans.action, NULL, NULL,
                      v_tmp_trans.request_time, NULL, 'WAITING', NULL,v_tmp_trans.dealer_code,
                      v_tmp_trans.sales_agent, v_tmp_trans.priority, v_tmp_trans.request_id,
                      v_tmp_trans.memo_text, 1
                     );
      END LOOP;

      -- Commit work
      COMMIT;

      -- Remove the recs from the temp table..
      DELETE FROM hgu_tmp_trans;

      COMMIT;
   END;

   PROCEDURE load_master_trans_replace
   IS
      CURSOR tmp_trans
      IS
         SELECT *
           FROM hgu_tmp_replace;

      v_tmp_trans      tmp_trans%ROWTYPE;
   BEGIN
      FOR v_tmp_trans IN tmp_trans
      LOOP
         -- Insert into master_transactions table
         INSERT INTO ninjadata.master_transactions
                     (trans_number, subscriber_no,
                      soc, action_code, new_soc, enter_time, request_time,
                      process_time, process_status, status_desc, dealer_code,
                      sales_agent, priority, request_id,
                      memo_text,
                      stream
                     )
              VALUES (NULL, v_tmp_trans.subscriber_no,
                      v_tmp_trans.soc_old, 'REPLACE', v_tmp_trans.soc_new, NULL,
                      v_tmp_trans.request_time, NULL, 'WAITING', NULL, v_tmp_trans.dealer_code,
                      v_tmp_trans.sales_agent, v_tmp_trans.priority, v_tmp_trans.request_id,
                      v_tmp_trans.memo_text,
                      DECODE (  MOD (SUBSTR (v_tmp_trans.subscriber_no, 4),
                                     10)
                              + 1,
                              NULL, 1,
                                MOD (SUBSTR (v_tmp_trans.subscriber_no, 4),
                                     10)
                              + 1
                             )
                     );
      END LOOP;

      -- Commit work
      COMMIT;

      -- Remove the recs from the temp table..
      DELETE FROM hgu_tmp_replace;

      COMMIT;
   END;

   PROCEDURE load_master_trans_replace_1
   IS
      CURSOR tmp_trans
      IS
         SELECT *
           FROM hgu_tmp_replace;

      v_tmp_trans      tmp_trans%ROWTYPE;
   BEGIN
      FOR v_tmp_trans IN tmp_trans
      LOOP
         -- Insert into master_transactions table
         INSERT INTO ninjadata.master_transactions
                     (trans_number, subscriber_no,
                      soc, action_code, new_soc, enter_time, request_time,
                      process_time, process_status, status_desc, dealer_code,
                      sales_agent, priority, request_id, memo_text, stream
                     )
              VALUES (NULL, v_tmp_trans.subscriber_no,
                      v_tmp_trans.soc_old, 'REPLACE', v_tmp_trans.soc_new, NULL,
                      v_tmp_trans.request_time, NULL, 'WAITING', NULL, v_tmp_trans.dealer_code,
                      v_tmp_trans.sales_agent, v_tmp_trans.priority, v_tmp_trans.request_id,
                      v_tmp_trans.memo_text, 1
                     );
      END LOOP;

      -- Commit work
      COMMIT;

      -- Remove the recs from the temp table..
      DELETE FROM hgu_tmp_replace;

      COMMIT;
   END;
END;
/


-- End of DDL Script for Package Body NINJATEAM.HGU_PROCS

