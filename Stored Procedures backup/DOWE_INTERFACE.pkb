CREATE OR REPLACE PACKAGE BODY NINJAMAIN.DOWE_INTERFACE
IS

   FUNCTION add_request_record
    ( p_order_id IN VARCHAR2)
    RETURN INTEGER
    IS
    CURSOR cur_sel_exist ( p_ref_nr IN VARCHAR2 )
    IS
        SELECT  *
        FROM    DOWE_QUEUE
        WHERE   DOWE_ORDER_ID = p_ref_nr;

        v_dowe_rec  cur_sel_exist%ROWTYPE;

   BEGIN
     OPEN     cur_sel_exist ( p_order_id );
     FETCH    cur_sel_exist INTO v_dowe_rec;
     IF cur_sel_exist%NOTFOUND
     THEN
         INSERT INTO DOWE_QUEUE
                (DOWE_ORDER_ID,
                 DOWE_REQUEST_DT)
         VALUES (p_order_id,
                 sysdate);
         COMMIT;
         CLOSE cur_sel_exist;
         RETURN 0;
     ELSE
         CLOSE cur_sel_exist;
         RETURN 1;
     END IF;
   EXCEPTION
      WHEN OTHERS THEN
          RETURN 1;
   END;

   FUNCTION add_failure
    ( p_order_id IN VARCHAR2,
      p_ban_id   IN VARCHAR2,
      p_sub_id   IN VARCHAR2,
      p_err_mess IN VARCHAR2)
   RETURN INTEGER
   IS
   BEGIN
       UPDATE DOWE_QUEUE
       SET    DOWE_BAN_ID      = p_ban_id,
              DOWE_SUB_CTN     = p_sub_id,
              DOWE_ERR_MESSAGE = p_err_mess,
              DOWE_PROC_STATUS = 'N',
              DOWE_PROC_DT     = sysdate
       WHERE  DOWE_ORDER_ID    = p_order_id;
       COMMIT;
       RETURN 0;
   EXCEPTION
      WHEN OTHERS THEN
          RETURN 1;
   END;

   FUNCTION add_success
    ( p_order_id IN VARCHAR2,
      p_ban_id   IN VARCHAR2,
      p_sub_id   IN VARCHAR2,
      p_adr_stat IN VARCHAR2)
   RETURN INTEGER
   IS
   BEGIN
       UPDATE DOWE_QUEUE
       SET    DOWE_BAN_ID      = p_ban_id,
              DOWE_SUB_CTN     = p_sub_id,
              DOWE_ADR_STATUS  = p_adr_stat,
              DOWE_PROC_STATUS = 'Y',
              DOWE_PROC_DT     = sysdate
       WHERE  DOWE_ORDER_ID    = p_order_id;
       COMMIT;
       RETURN 0;
   EXCEPTION
      WHEN OTHERS THEN
          RETURN 1;
   END;

   FUNCTION get_ban
    ( p_order_id IN VARCHAR2)
    RETURN VARCHAR2
    IS
     v_ban_id VARCHAR2(9);
   BEGIN
       SELECT DOWE_BAN_ID INTO v_ban_id
       FROM   DOWE_QUEUE
       WHERE  DOWE_ORDER_ID = p_order_id;
       RETURN v_ban_id;
   EXCEPTION
      WHEN OTHERS THEN
          RETURN 'ERROR';
   END;


   FUNCTION get_sub
    ( p_order_id IN VARCHAR2)
    RETURN VARCHAR2
    IS
     v_sub_id VARCHAR2(15);
   BEGIN
       SELECT DOWE_SUB_CTN INTO v_sub_id
       FROM   DOWE_QUEUE
       WHERE  DOWE_ORDER_ID = p_order_id;
       RETURN v_sub_id;
   EXCEPTION
      WHEN OTHERS THEN
          RETURN 'ERROR';
   END;

   -- Enter further code below as specified in the Package spec.
END; -- Package Body DOWE_INTERFACE 
/