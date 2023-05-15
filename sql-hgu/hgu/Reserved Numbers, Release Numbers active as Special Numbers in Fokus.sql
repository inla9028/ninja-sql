SELECT r.*, t.ctn_status, t.nl, t.ngp, t.tn_in_use
     , f.ban, f.subscriber_no, f.soc, f.ftr_special_telno, f.soc_seq_no
     , f.ftr_effective_date, f.ftr_expiration_date, f.feature_code, f.ftr_add_sw_prm
     -- , f.*
  FROM service_feature@fokus f, tn_inv@fokus t, reserved_numbers r
 WHERE r.reserved_date > TRUNC(SYSDATE - 50) -- TRUNC(SYSDATE, 'MON')
   AND 'GSM'|| r.ctn   = f.ftr_special_telno
   AND SYSDATE   BETWEEN f.ftr_effective_date AND NVL(f.ftr_expiration_date, SYSDATE + 1)
   AND t.ctn           = r.ctn(+)
ORDER BY r.dealer_code, r.reserved_date
;

DELETE
  FROM reserved_numbers r
 WHERE r.reserved_date  > TRUNC(SYSDATE - 50) -- TRUNC(SYSDATE, 'MON')
   AND r.ctn           IN (SELECT REPLACE(f.ftr_special_telno, 'GSM', '') AS "FTR_SPECIAL_TELNO"
                             FROM service_feature@fokus f
                            WHERE f.ftr_special_telno = 'GSM'|| r.ctn
                              AND SYSDATE     BETWEEN f.ftr_effective_date AND NVL(f.ftr_expiration_date, SYSDATE + 1))
;

---
-- Wrong. But check if any active SIMs are connected to the reserved numbers in stead.
SELECT r.*, t.ctn_status, t.nl, t.ngp, t.tn_in_use, pd.equipment_no, pd.imsi, f.*
  FROM service_feature@fokus f, tn_inv@fokus t, reserved_numbers r, physical_device@fokus pd
 WHERE r.reserved_date > TRUNC(SYSDATE - 50) -- TRUNC(SYSDATE, 'MON')
   AND 'GSM'|| r.ctn   = f.ftr_special_telno
   AND SYSDATE   BETWEEN f.ftr_effective_date AND NVL(f.ftr_expiration_date, SYSDATE + 1)
   and f.ban           = pd.ban
   AND 'GSM'|| r.ctn   = pd.subscriber_no
   AND pd.expiration_date IS NULL
   AND t.ctn           = r.ctn(+)
ORDER BY r.dealer_code, r.reserved_date
;
