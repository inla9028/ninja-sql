SELECT r.*, ti.*
  FROM tn_inv@fokus ti, reserved_numbers r
 WHERE r.reserved_date > TRUNC(SYSDATE, 'MON')
   AND r.ctn           = ti.ctn
   AND ti.ctn_status   = 'AA'
ORDER BY r.dealer_code, r.reserved_date
;

DELETE
  FROM reserved_numbers r
 WHERE r.reserved_date  > TRUNC(SYSDATE, 'MON')
   AND r.ctn           IN (SELECT ti.ctn
                             FROM tn_inv@fokus ti
                            WHERE ti.ctn = r.ctn
                              AND ti.ctn_status = 'AA')
;

--

SELECT r.*, ti.*
  FROM tn_inv@fokus ti, reserved_numbers r
 WHERE r.reserved_date BETWEEN TO_DATE('2019-09-02 13:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2019-09-02 18:00', 'YYYY-MM-DD HH24:MI')
   AND r.ctn           = ti.ctn
   AND ti.ctn_status   = 'AA'
ORDER BY r.dealer_code, r.reserved_date
;

DELETE
  FROM reserved_numbers r
 WHERE r.reserved_date BETWEEN TO_DATE('2019-09-02 13:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2019-09-02 18:00', 'YYYY-MM-DD HH24:MI')
   AND r.ctn           IN (SELECT ti.ctn
                             FROM tn_inv@fokus ti
                            WHERE ti.ctn = r.ctn
                              AND ti.ctn_status = 'AA')
;
