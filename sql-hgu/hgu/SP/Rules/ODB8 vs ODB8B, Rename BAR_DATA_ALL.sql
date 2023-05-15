/*
** 1. Remap BAR_DATA_ALL for Phonero to BAR_DATA_ALL_RESTART_REQUIRED 
** 2. Enable ODB8 (again) for Chilimobil
**  a) subscription_types_socs
**  b) sub_typ_soc_channel
** 3. Map 
*/

-- READ
-- 1.
SELECT a.*
  FROM spm_service_mapping a
WHERE a.soc_type   = 'ODB'
  AND a.soc_group IN ('ODB8', 'ODB8B')
ORDER BY 1,2,3
;

-- 1.

SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc || ' (' || sd1.description || ')' AS "SOC", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') || ' (' || sd2.description || ')' AS "PRICE_PLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping     sp
     , subscription_types_socs sts
     , socs                    s
     , socs_descriptions       sd1
     , socs_descriptions       sd2
 WHERE sts.subscription_type_id IN (SELECT a.soc_code || 'REG1'
                                      FROM spm_priceplan_mapping a
                                     WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                  = s.soc
   AND s.soc                    = sd1.soc
   AND sd1.language_code        = 'NO'
   AND sts.add_mode             = 'O'
   AND sts.subscription_type_id = sd2.soc || 'REG1'
   AND sd2.language_code        = 'NO'
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
   AND s.soc IN ('ODB8', 'ODB8B')
ORDER BY sp.sp_code, s.soc, sts.subscription_type_id
;

-- 2a.
SELECT a.*
  FROM subscription_types_socs a
 WHERE a.soc                  IN ('ODB8', 'ODB8B')
   AND a.subscription_type_id IN ('PVJA'||'REG1', 'PVJC'||'REG1', 'PVJD'||'REG1', 'PVJE'||'REG1')
   AND SYSDATE           BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2
;

-- 2b.
SELECT a.*
  FROM sub_typ_soc_channel a
 WHERE a.soc                  IN ('ODB8', 'ODB8B')
   AND a.subscription_type_id IN ('PVJA'||'REG1', 'PVJC'||'REG1', 'PVJD'||'REG1', 'PVJE'||'REG1')
   AND SYSDATE           BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2
;

-- UPDATE
-- 1.
UPDATE spm_service_mapping a
  SET a.sp_code   = 'BAR_DATA_ALL_RESTART_REQUIRED'
WHERE a.sp_code   = 'BAR_DATA_ALL'
  AND a.soc_type  = 'ODB'
  AND a.soc_group = 'ODB8'
;

-- 2a.
UPDATE subscription_types_socs a
   SET a.expiration_date       = TO_DATE('4700-12-31', 'YYYY-MM-DD')
 WHERE a.soc                   = 'ODB8'
   AND SYSDATE                 > NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscription_type_id IN ('PVJA'||'REG1', 'PVJC'||'REG1', 'PVJD'||'REG1', 'PVJE'||'REG1')
;

-- 2b.
UPDATE sub_typ_soc_channel a
   SET a.expiration_date       = TO_DATE('4700-12-31', 'YYYY-MM-DD')
 WHERE a.soc                   = 'ODB8'
   AND SYSDATE                 > NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscription_type_id IN ('PVJA'||'REG1', 'PVJC'||'REG1', 'PVJD'||'REG1', 'PVJE'||'REG1')
;

-- READ
-- 1.
SELECT a.*
  FROM spm_service_mapping a
WHERE a.soc_type   = 'ODB'
  AND a.soc_group IN ('ODB8', 'ODB8B')
ORDER BY 1,2,3
;

-- 1.

SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc || ' (' || sd1.description || ')' AS "SOC", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') || ' (' || sd2.description || ')' AS "PRICE_PLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping     sp
     , subscription_types_socs sts
     , socs                    s
     , socs_descriptions       sd1
     , socs_descriptions       sd2
 WHERE sts.subscription_type_id IN (SELECT a.soc_code || 'REG1'
                                      FROM spm_priceplan_mapping a
                                     WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                  = s.soc
   AND s.soc                    = sd1.soc
   AND sd1.language_code        = 'NO'
   AND sts.add_mode             = 'O'
   AND sts.subscription_type_id = sd2.soc || 'REG1'
   AND sd2.language_code        = 'NO'
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
   AND s.soc IN ('ODB8', 'ODB8B')
ORDER BY sp.sp_code, s.soc, sts.subscription_type_id
;

-- 2a.
SELECT a.*
  FROM subscription_types_socs a
 WHERE a.soc                  IN ('ODB8', 'ODB8B')
   AND a.subscription_type_id IN ('PVJA'||'REG1', 'PVJC'||'REG1', 'PVJD'||'REG1', 'PVJE'||'REG1')
   AND SYSDATE           BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2
;

-- 2b.
SELECT a.*
  FROM sub_typ_soc_channel a
 WHERE a.soc                  IN ('ODB8', 'ODB8B')
   AND a.subscription_type_id IN ('PVJA'||'REG1', 'PVJC'||'REG1', 'PVJD'||'REG1', 'PVJE'||'REG1')
   AND SYSDATE           BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2
;

