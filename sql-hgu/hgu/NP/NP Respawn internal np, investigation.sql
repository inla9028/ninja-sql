SELECT f.port_number, f.port_request_date, f.curr_net_oper AS "DONOR_CODE"
 FROM (
    SELECT /*+ DRIVING_SITE(nni) parallel(nni,4)  USE_HASH(nni nod d) FULL(nod) */
           '047'||nni.port_number port_number,
           get_actual_porting_date2(nod.int_order_id) AS "PORT_REQUEST_DATE",
           d.curr_net_oper
      FROM np_number_info@fokus    nni,
           np_order_data@fokus     nod,
           np_trx_detail@fokus     d,
           np_operator_codes@fokus o
     WHERE nod.int_order_id = nni.int_order_id
       AND nod.int_order_id = d.int_order_id
       AND d.curr_net_oper  = o.np_operator_cd
       AND o.sp_ind         = 'Y'
       AND NVL(o.expiration_date, SYSDATE + 1) > SYSDATE
       AND o.np_operator_cd <> '815'
       AND TRIM (nod.order_status) IN ('C', 'E', 'L')
       AND d.trx_code       = 111 -- GODK
      --AND TRIM (d.curr_net_oper) IN ('703', '718', '721', '809', '817', '820', '823', '890', '897', '898')
       AND TRUNC (nni.port_request_date) >= TRUNC (SYSDATE - 1)
    ) f,
   (
    SELECT a.ctn AS "PORT_NUMBER",
           a.date_time_port AS "PORT_REQUEST_DATE",
           a.donor_code
      FROM ninja_time_port a
      WHERE a.status        IN ( 'WAITING', 'PRSD_SUCCESS')
        AND a.ninja_action   = 'NETCOM_MOVE'
        AND a.date_time_port < SYSDATE + 100
    ) n
 WHERE f.port_number    = n.port_number(+)
   AND TRUNC(f.port_request_date) = TRUNC(n.port_request_date(+))
   AND n.port_number   IS NULL
   AND f.curr_net_oper <> '817'
ORDER BY port_request_date ASC
;

CREATE FUNCTION "SAS"."GET_ACTUAL_PORTING_DATE2" (p_int_order_id IN NUMBER)
RETURN DATE
IS
v_actual_porting_date DATE;
cursor c1 is
SELECT
request_exec_date actual_porting_date
FROM cdata.np_trx_detail td
WHERE td.int_order_id = p_int_order_id
ORDER BY td.sys_creation_date desc;
begin
open c1;
fetch c1 into v_actual_porting_date;
close c1;
RETURN v_actual_porting_date;
END get_actual_porting_date2;
