CREATE OR REPLACE PACKAGE BODY NINJAMAIN.MONTHLY_REFILL_HELPER
AS
   PROCEDURE create_monthly_refill_records
   IS
      numofwaiting      NUMBER (9);
      streamcounter     NUMBER (2);
      masterjobstatus   VARCHAR2 (15);
      jobid             NUMBER (6);

      CURSOR c1
      IS
         SELECT *
           FROM monthly_refill_charges;

--where process_status is null;
--and rownum < 1000;
      update_row        c1%ROWTYPE;
   BEGIN
      FOR update_row IN c1
      LOOP
         INSERT INTO batch_charge_addition
              VALUES (NULL, update_row.ban_no, update_row.subscriber_no,
                      NULL, NULL, update_row.amount,
                      update_row.user_bill_text, update_row.memo_text,
                      update_row.effective_date, NULL,
                      update_row.process_time, update_row.status_desc,
                      update_row.record_creation_date, update_row.request_id,
                      DECODE (MOD (update_row.subscriber_no, 10) + 2,
                              NULL, 1,
                              MOD (update_row.subscriber_no, 10) + 2
                             ),
                      update_row.request_user_id);

--update monthly_refill_charges
--set process_status = 'INSERTED'
         DELETE      monthly_refill_charges
               WHERE subscriber_no = update_row.subscriber_no;

         COMMIT;
      END LOOP;

--select count(*) into numOfWaiting
--from batch_charge_addition
--WHERE request_user_id='KONTANT'
--AND charge_code='FLEX'
--AND actv_reason_code = 'PRPCHG'
--AND process_status='WAITING';

      --== set status to 'C' only when almost all charges are processed
      --== otherwise the charge creation process is twice slower
      --IF numOfWaiting <= 1000 THEN
      UPDATE ninja_jobs_control
         SET last_run_status = 'C',
             last_exec_date = SYSDATE
       WHERE job_id = 'MONTHLYREFILL';

      COMMIT;

--END IF;
      SELECT job_status
        INTO masterjobstatus
        FROM ninja_jobs
       WHERE job_id = 0 AND machine_id = 'NINJAP2Z_DEMON';
       --== The machine id ought to be passed as an argument rather than being "hardcoded"...

      IF (masterjobstatus = 'RUNNING' OR masterjobstatus = 'SLEEPING')
      THEN
         streamcounter := 1;

         WHILE streamcounter < 12
         LOOP
            jobid := -1;

            BEGIN
               SELECT njp.job_id
                 INTO jobid
                 FROM ninja_jobs nj, ninja_jobs_parameters njp
                WHERE nj.exec_method            = 'batchChargeAddition'
                  AND njp.job_id                = nj.job_id
                  AND njp.parameter_order       = 2
                  AND njp.parameter_description = 'Stream'
                  AND njp.parameter_value       = TO_CHAR (streamcounter);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  DBMS_OUTPUT.put_line ('no_data_found for stream ' || streamcounter);
            END;

            UPDATE ninja_jobs
               SET job_status = 'STARTING', next_exec_time = SYSDATE
             WHERE job_status = 'STOPPED' AND job_id = jobid;
             
            UPDATE ninja_jobs
               SET next_exec_time = SYSDATE
             WHERE job_status = 'SLEEPING' AND job_id = jobid;

            COMMIT;
            streamcounter := streamcounter + 1;
         END LOOP;
      END IF;
   END;

   PROCEDURE truncate_monthly_refill_chg
   IS
      cursor1   INTEGER;
   BEGIN
      cursor1 := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (cursor1, 'TRUNCATE TABLE MONTHLY_REFILL_CHARGES', DBMS_SQL.native);
      DBMS_SQL.close_cursor (cursor1);
   END truncate_monthly_refill_chg;

--Reset status to WAITING for failed records with certain error description
   PROCEDURE reset_status_to_waiting
   IS
   BEGIN
      UPDATE ninjadata.batch_charge_addition a
         SET a.process_status = 'WAITING',
             a.process_time   = NULL,
             a.status_desc    = NULL
       WHERE a.record_creation_date > TRUNC (SYSDATE)
         AND a.process_status = 'PRSD_ERROR'
         AND (   a.status_desc LIKE '%has been changed since last retrieved%'
              OR a.status_desc LIKE '%Please try accessing account again later%'
              OR a.status_desc LIKE 'Attempting to assign Default Fokus User but encountered a null value%'
              OR a.status_desc LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service%'
             );

      COMMIT;
   END reset_status_to_waiting;
END;
/