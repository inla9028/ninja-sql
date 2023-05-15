CREATE OR REPLACE PACKAGE NINJAMAIN.dowe_interface
  IS
  FUNCTION add_request_record
     ( p_order_id IN VARCHAR2)
     RETURN  INTEGER;

  FUNCTION add_failure
     ( p_order_id IN VARCHAR2,
       p_ban_id IN VARCHAR2,
       p_sub_id IN VARCHAR2,
       p_err_mess IN VARCHAR2)
     RETURN  INTEGER;

  FUNCTION add_success
     ( p_order_id IN VARCHAR2,
       p_ban_id   IN VARCHAR2,
       p_sub_id   IN VARCHAR2,
       p_adr_stat IN VARCHAR2)
     RETURN  INTEGER;

  FUNCTION get_ban
     ( p_order_id IN VARCHAR2)
     RETURN  VARCHAR2;

  FUNCTION get_sub
     ( p_order_id IN VARCHAR2)
     RETURN  VARCHAR2;

END; -- Package Specification DOWE_INTERFACE

 
/