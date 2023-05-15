delete
  from tmp_msisdns_w_status_pp_soc_fp
;

--CREATE TABLE tmp_msisdns_w_status_pp_soc_fp
--AS
INSERT INTO tmp_msisdns_w_status_pp_soc_fp
SELECT s.subscriber_no
     , s.customer_id          AS "BAN"
     , s.sub_status
     , 'N/A'                  AS "SIM_NUMBER"
     , 'N/A'                  AS "IMSI"
     , RTRIM(a1.soc)          AS "PRICE_PLAN"
     , RTRIM(a2.soc)          AS "SOC"
     , a2.soc_seq_no
     , a2.effective_date
     , 'N/A'                  AS "FEATURE_CODE"
     , 'N/A'                  AS "FTR_ADD_SW_PRM"
  FROM subscriber s, service_agreement a1, service_agreement a2
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   --
--   AND RTRIM(a1.soc)   IN ( 'PW20' )
  AND a1.service_type   = 'P'
  --
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   --
   AND a2.service_type  = 'R' -- G = Flex lease
   AND a2.soc        LIKE 'HPTSP01%'
   --
--   AND ROWNUM < 101
;

COMMIT WORK
;

/*
** SIM
*/
ALTER TABLE tmp_msisdns_w_status_pp_soc_fp
  MODIFY sim_number VARCHAR2(20)
;

ALTER TABLE tmp_msisdns_w_status_pp_soc_fp
  MODIFY imsi VARCHAR2(15)
;

UPDATE tmp_msisdns_w_status_pp_soc_fp a
   SET a.sim_number     = (SELECT pd.equipment_no
                             FROM physical_device pd
                            WHERE a.subscriber_no    = pd.subscriber_no
                              AND a.ban              = pd.ban
                              AND pd.expiration_date IS NULL
                              and pd.equipment_level = 1)
;

UPDATE tmp_msisdns_w_status_pp_soc_fp a
   SET a.imsi           = (SELECT pd.imsi
                             FROM physical_device pd
                            WHERE a.subscriber_no    = pd.subscriber_no
                              AND a.ban              = pd.ban
                              AND pd.expiration_date IS NULL
                              and pd.equipment_level = 1)
;

COMMIT WORK;

/*
** Feature parameters
*/
ALTER TABLE tmp_msisdns_w_status_pp_soc_fp
  MODIFY feature_code VARCHAR2(6)
;

ALTER TABLE tmp_msisdns_w_status_pp_soc_fp
  MODIFY ftr_add_sw_prm VARCHAR2(2000)
;

UPDATE tmp_msisdns_w_status_pp_soc_fp a
   SET a.feature_code   = (SELECT RTRIM(sf.feature_code)
                             FROM service_feature sf
                            WHERE a.subscriber_no = sf.subscriber_no
                              AND a.ban           = sf.ban
                              AND a.soc           = RTRIM(sf.soc)
                              AND a.soc_seq_no    = sf.soc_seq_no
                              AND a.feature_code  = 'N/A'
                              AND SYSDATE   BETWEEN sf.ftr_effective_date AND NVL(sf.ftr_expiration_date, SYSDATE + 1)
                              AND NVL(RTRIM(sf.ftr_add_sw_prm), 'N/A') != 'N/A'
                              AND 1               = (SELECT COUNT(1)
                                                       FROM service_feature sf2
                                                      WHERE sf2.subscriber_no = sf.subscriber_no
                                                        AND sf2.ban           = sf.ban
                                                        AND sf2.soc           = sf.soc
                                                        AND NVL(RTRIM(sf2.ftr_add_sw_prm), 'N/A') != 'N/A'))
;

/*
UPDATE tmp_msisdns_w_status_pp_soc_fp a
   SET a.ftr_add_sw_prm = (SELECT sf.ftr_add_sw_prm
                             FROM service_feature sf
                            WHERE a.subscriber_no = sf.subscriber_no
                              AND a.ban           = sf.ban
                              AND a.soc           = RTRIM(sf.soc)
                              AND a.feature_code  = RTRIM(sf.feature_code)
                              AND SYSDATE   BETWEEN sf.ftr_effective_date AND NVL(sf.ftr_expiration_date, SYSDATE + 1)
                              AND NVL(RTRIM(sf.ftr_add_sw_prm), 'N/A') != 'N/A')
;
*/

COMMIT WORK
;

/*
** Handle M2MAPNW... :/
*/

UPDATE tmp_msisdns_w_status_pp_soc_fp a
   SET a.feature_code   = (SELECT sf.feature_code
                             FROM service_feature sf
                            WHERE a.subscriber_no = sf.subscriber_no
                              AND a.ban           = sf.ban
                              AND a.soc           = 'M2MAPNW'
                              AND a.soc           = RTRIM(sf.soc)
                              AND a.feature_code  IS NULL
                              AND SYSDATE   BETWEEN sf.ftr_effective_date AND NVL(sf.ftr_expiration_date, SYSDATE + 1)
                              AND sf.feature_code = 'S-M2A2'
                              AND NVL(RTRIM(sf.ftr_add_sw_prm), 'N/A') != 'N/A')
  WHERE a.soc           = 'M2MAPNW'
;

--
-- Handle MPODxxx and the 'D-T%' feature codes.
UPDATE tmp_msisdns_w_status_pp_soc_fp A
   SET A.feature_code   = (SELECT sf.feature_code
                             FROM service_feature sf
                            WHERE A.subscriber_no = sf.subscriber_no
                              AND A.price_plan LIKE 'PVJ%'
                              AND A.ban           = sf.ban
--                              AND a.soc        LIKE 'MPOD%'
                              AND a.soc           = RTRIM(sf.soc)
                              AND A.feature_code  = 'N/A'
                              AND trunc(SYSDATE)  BETWEEN sf.ftr_effective_date AND nvl(sf.ftr_expiration_date, SYSDATE + 1)
                              AND sf.feature_code LIKE 'D-T13%')
  WHERE A.soc        LIKE 'MPOD%'
    AND a.price_plan LIKE 'PVJ%'
;

INSERT INTO tmp_msisdns_w_status_pp_soc_fp
SELECT a.subscriber_no
     , a.ban
     , a.sub_status
     , a.sim_number
     , a.imsi
     , a.price_plan
     , a.soc
     , a.effective_date
     , RTRIM(sf.feature_code) AS "FEATURE_CODE"
     , sf.ftr_add_sw_prm
  FROM tmp_msisdns_w_status_pp_soc_fp a, service_feature sf
 WHERE a.soc                  = 'M2MAPNW'
   AND a.subscriber_no        = sf.subscriber_no
   AND a.ban                  = sf.ban
   AND a.soc                  = RTRIM(sf.soc)
   AND RTRIM(sf.feature_code) = 'S-M2A3'
   AND SYSDATE   BETWEEN sf.ftr_effective_date AND NVL(sf.ftr_expiration_date, SYSDATE + 1)
   AND NVL(RTRIM(sf.ftr_add_sw_prm), 'N/A') != 'N/A'
;

COMMIT WORK;

/*
** Finaly update the feature parameters...
*/
UPDATE tmp_msisdns_w_status_pp_soc_fp a
   SET a.ftr_add_sw_prm = (SELECT RTRIM(sf.ftr_add_sw_prm)
                             FROM service_feature sf
                            WHERE a.subscriber_no = sf.subscriber_no
                              AND a.ban           = sf.ban
                              AND a.soc           = RTRIM(sf.soc)
                              AND a.soc_seq_no    = sf.soc_seq_no
                              AND a.feature_code IS NOT NULL
                              AND a.feature_code  = RTRIM(sf.feature_code)
                              AND SYSDATE   BETWEEN sf.ftr_effective_date AND NVL(sf.ftr_expiration_date, SYSDATE + 1)
                              AND NVL(RTRIM(sf.ftr_add_sw_prm), 'N/A') != 'N/A')
;

COMMIT WORK;



/*
** Display result...
*/

UPDATE tmp_msisdns_w_status_pp_soc_fp a
   SET a.ftr_add_sw_prm = NULL
 WHERE a.ftr_add_sw_prm = 'N/A'
;

COMMIT WORK
;


SELECT COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc_fp a
;

SELECT a.price_plan
     , a.soc
     , COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc_fp a
GROUP BY a.price_plan, a.soc
ORDER BY 1, 2
;

SELECT a.price_plan
     , a.soc
     , DECODE(a.ftr_add_sw_prm, NULL, 'N/A', 'VALUE') AS "FTR_ADD_SW_PRM"
     , COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc_fp a
GROUP BY a.price_plan, a.soc, DECODE(a.ftr_add_sw_prm, NULL, 'N/A', 'VALUE')
ORDER BY 1, 2, 3
;


  