DROP PACKAGE POPULATE_BATCH_DISC_ADD;

CREATE OR REPLACE PACKAGE POPULATE_BATCH_DISC_ADD AS
    PROCEDURE POPULATE_FROM_FOKUS;
END POPULATE_BATCH_DISC_ADD;

 
/
DROP PACKAGE BODY POPULATE_BATCH_DISC_ADD;

CREATE OR REPLACE PACKAGE BODY populate_batch_disc_add
AS
    PROCEDURE populate_from_fokus
    IS
        ban           NUMBER (9);
        sub           VARCHAR2 (20);

        CURSOR c1
        IS
            SELECT sa.ban, sa.subscriber_no
              FROM subscriber@nrep11 s, service_agreement@nrep11 sa
             WHERE soc = 'PSFB'
               AND sa.effective_date BETWEEN TO_DATE('2015-06-25', 'YYYY-MM-DD') AND SYSDATE
               AND NVL (sa.expiration_date, SYSDATE + 1) > SYSDATE
               AND s.subscriber_no = sa.subscriber_no
               AND s.customer_id = sa.ban
               AND sub_status = 'A'
               AND NOT EXISTS
                           (SELECT bd.ban
                              FROM ban_discount@nrep11 bd
                             WHERE bd.ban = sa.ban
                               AND bd.subscriber_no = sa.subscriber_no
                               -- if there is any subscriber level discount on the subscriber, it should not get RITID2
                               --and bd.discount_code='RITID2'
                               AND SYSDATE BETWEEN bd.effective_date AND NVL (bd.expiration_date, SYSDATE + 1));

        update_row1   c1%ROWTYPE;
    BEGIN
        FOR update_row1 IN c1
        LOOP
            INSERT INTO batch_discount_addition
            VALUES (NULL,
                    update_row1.ban,
                    SUBSTR (update_row1.subscriber_no, 4, 11),
                    'RITID2',
                    'Sommerkampanje ringetid businessTalk',
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    'NinjaJob48');

            COMMIT;
        END LOOP;
    END populate_from_fokus;
END populate_batch_disc_add;
/
