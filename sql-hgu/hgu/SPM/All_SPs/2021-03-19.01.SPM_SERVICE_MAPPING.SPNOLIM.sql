/*
** Display the current content...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, a.effective_date,
       a.expiration_date, a.comments
  FROM spm_service_mapping a
WHERE a.sp_code IN ( '5G_200_MBPS', '5G_25_MBPS', '5G_5_MBPS', '5G_75_MBPS', '5G_10_MBPS', '5G_30_MBPS', '5G_300_MBPS', '5G_100_MBPS', '5G_50_MBPS', '5G_40_MBPS', '5G_ENABLED', '5G_UNLIMITED_SPEED' )
ORDER BY 1
;

/*
** Insert records based on the available socs for the priceplan PW30.
** Pro tip: Comment out the "INSERT INTO" row, and modify the query until
** there are no SOC codes displayed as SP_CODE, the uncomment the row and run.
*/
INSERT INTO spm_service_mapping
SELECT UNIQUE * FROM (
SELECT DECODE(s.soc
              --
              -- Missing according to Ninja Rules...
              --
              , 'SP05',      '5G_5_MBPS'
              , 'SP10',      '5G_10_MBPS'
              , 'SP100',     '5G_100_MBPS'
              , 'SP20',      '5G_20_MBPS'
              , 'SP200',     '5G_200_MBPS'
              , 'SP25',      '5G_25_MBPS'
              , 'SP30',      '5G_30_MBPS'
              , 'SP300',     '5G_300_MBPS'
              , 'SP40',      '5G_40_MBPS'
              , 'SP50',      '5G_50_MBPS'
              , 'SP75',      '5G_75_MBPS'
              , 'SP5G',      '5G_ENABLED'
              , 'SPNOLIM',   '5G_UNLIMITED_SPEED'
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, sts.effective_date, sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  IN ( 'PDEFREG1', 'PVEAREG1', 'PVECREG1', 'PVEEREG1', 'PVICREG1', 'PVIDREG1', 'PVJAREG1', 'PVJBREG1', 'PVJCREG1', 'PVJDREG1', 'PVJEREG1', 'PVKAREG1', 'PVSAREG1', 'PVSBREG1', 'PW30REG1' )
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                    = s.soc
   AND sts.soc                   IN ( 'SP05', 'SP10', 'SP25', 'SP30', 'SP40', 'SP50', 'SP75', 'SP100', 'SP200', 'SP300', 'SP5G', 'SPNOLIM' )
   AND sts.add_mode              = 'O'
)
;
