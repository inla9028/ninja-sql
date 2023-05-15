/*
** Display the current content...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, a.effective_date,
       a.expiration_date, a.comments
  FROM spm_service_mapping a
ORDER BY 1
;

/*
-------  ----------------------------  -------------------------  ----------  ------  -------------------
SOC      SOC_DESCRIPTION               DESC_TEXT SALE_            EFF_DATE    RC_FTR  SPM
-------  ----------------------------  -------------------------  ----------  ------  -------------------
SPVOC38  SP NextGenTel FWA 75 Mbit/s   NextGenTel FWA 75 Mbit/s   2021-03-16  SPPWM   DATA_NGT_75MBPS
SPVOC39  SP NextGenTel FWA 100 Mbit/s  NextGenTel FWA 100 Mbit/s  2021-03-16  SPPWN   DATA_NGT_100MBPS
SPVOC40  SP NextGenTel FWA 200 Mbit/s  NextGenTel FWA 200 Mbit/s  2021-03-16  SPPWO   DATA_NGT_200MBPS
SPVOC41  SP NextGenTel FWA 300 Mbit/s  NextGenTel FWA 300 Mbit/s  2021-03-16  SPPWP   DATA_NGT_300MBPS
SPVOC42  SP Bitpro FWA 75 Mbit/s       Bitpro FWA 75 Mbit/s       2021-03-16  SPPWQ   DATA_BITPRO_75MBPS
SPVOC43  SP Bitpro FWA 100 Mbit/s      Bitpro FWA 100 Mbit/s      2021-03-16  SPPWR   DATA_BITPRO_100MBPS
SPVOC44  SP Bitpro FWA 200 Mbit/s      Bitpro FWA 200 Mbit/s      2021-03-16  SPPWS   DATA_BITPRO_200MBPS
SPVOC45  SP Bitpro FWA 300 Mbit/s      Bitpro FWA 300 Mbit/s      2021-03-16  SPPWT   DATA_BITPRO_300MBPS
-------  ----------------------------  -------------------------  ----------  ------  -------------------
*/

/*
** Update the soc-type of SPVOC19-30, SP10,SP100,SP200,SP300,SPNOLIM
*/
UPDATE spm_service_mapping sm
   SET sm.soc_type = 'SP_SPEED_LIM'
 WHERE (sm.soc_group BETWEEN 'SPVOC19' AND 'SPVOC30'
     OR sm.soc_group IN    ( 'SP10', 'SP100', 'SP200', 'SP300', 'SPNOLIM' ))
   AND sm.soc_type   IN    ( 'SP5G_SPEED_LIM', 'SPVOC' )
;

--
-- Make 5G_ENABLED (SOC: SP5G) effective again.
--
UPDATE spm_service_mapping sm
   SET sm.effective_date  = trunc(SYSDATE)
     , sm.expiration_date = to_date('4700-12-31', 'YYYY-MM-DD')
 WHERE sm.sp_code        IN    ( '5G_ENABLED' )
   AND sm.expiration_date < SYSDATE 
;


/*
** Insert records based on the available socs for the priceplan PW30.
** Pro tip: Comment out the "INSERT INTO" row, and modify the query until
** there are no SOC codes displayed as SP_CODE, the uncomment the row and run.
*/
INSERT INTO spm_service_mapping
SELECT * FROM (
SELECT DECODE(s.soc
              --
              -- Missing according to Ninja Rules...
              --
              , 'SPVOC38',   'DATA_NGT_75MBPS'
              , 'SPVOC39',   'DATA_NGT_100MBPS'
              , 'SPVOC40',   'DATA_NGT_200MBPS'
              , 'SPVOC41',   'DATA_NGT_300MBPS'
              , 'SPVOC42',   'DATA_BITPRO_75MBPS'
              , 'SPVOC43',   'DATA_BITPRO_100MBPS'
              , 'SPVOC44',   'DATA_BITPRO_200MBPS'
              , 'SPVOC45',   'DATA_BITPRO_300MBPS'
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, sts.effective_date, sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  IN ( 'PW30' || 'REG1' )
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND sts.subscription_type_id != s.soc || 'REG1'
   AND 0                         = (SELECT COUNT(1)
                                      FROM spm_service_mapping a
                                     WHERE a.soc_type    = s.soc_type
                                       AND a.soc_group   = s.soc_group
                                       AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
   AND s.soc_type               != 'WAP'
)
--WHERE sp_code NOT IN (SELECT b.sp_code
--                        FROM spm_service_mapping b
--                       WHERE SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1))
;

/*
** List socs we were unable to add above...
*/
SELECT REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN"
     , s.soc, s.soc_type, s.soc_group, sd.description
  FROM subscription_types_socs sts, socs s, socs_descriptions sd
 WHERE sts.subscription_type_id  IN ( 'PW30' || 'REG1' )
   AND sts.subscription_type_id != sts.soc || 'REG1'
   AND SYSDATE             BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND s.soc                     = sd.soc
   AND sd.language_code          = 'NO'
   AND 0                         = (SELECT COUNT(1)
                                      FROM spm_service_mapping a
                                     WHERE a.soc_type    = s.soc_type
                                       AND a.soc_group   = s.soc_group
                                       AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
ORDER BY 1,2
;



--update spm_service_mapping a
--   set a.sp_code = replace(a.sp_code, 'PROXIMO', 'NGT')
--     , a.comments = 'Renamed from ''' || a.sp_code || ''' per request from Tor Olav Mattsson'
-- where a.sp_code LIKE 'DATA_PROXIMO%'
--;

/*
** List the SP-codes and products available for a certain priceplan.
** NB! This does not check towards channel-access!
*/
SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, d.description AS "AKA", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping sp, subscription_types_socs sts, socs s, socs_descriptions d
 WHERE sts.subscription_type_id IN ( 'PW30' || 'REG1' )
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.add_mode             = 'O'
   AND sts.soc                  = s.soc
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
   AND s.soc                    = d.soc
   AND d.language_code          = 'NO'
ORDER BY 1
;
