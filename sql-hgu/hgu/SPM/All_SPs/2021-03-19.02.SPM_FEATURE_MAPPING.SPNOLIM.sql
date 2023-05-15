select a.*
  from spm_feature_mapping a
 where a.sp_service_code IN ( '5G_200_MBPS', '5G_25_MBPS', '5G_5_MBPS', '5G_75_MBPS', '5G_10_MBPS', '5G_30_MBPS', '5G_300_MBPS', '5G_100_MBPS', '5G_50_MBPS', '5G_40_MBPS', '5G_ENABLED', '5G_UNLIMITED_SPEED' )
order by 1,2
;

INSERT INTO spm_feature_mapping
SELECT * FROM (
SELECT DECODE(a.soc
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
              , a.soc) AS "SP_CODE"
     , DECODE(SUBSTR(A.feature_code, 1, 2)
              , 'H1',        'APN1'
              , 'H2',        'APN2'
              , A.feature_code) AS "SP_PARAM_CODE"
     , A.parameter_code         AS "NINJA_PARAMETER_CODE"
     , A.mandatory              AS "MANDATORY_IND"
     , A.feature_code           AS "NINJA_FEATURE_CODE"
  FROM feature_parameters a
 WHERE A.soc            IN ( 'SP05', 'SP10', 'SP25', 'SP30', 'SP40', 'SP50', 'SP75', 'SP100', 'SP200', 'SP300', 'SPNOLIM' )
   AND A.parameter_code  = 'NAME'
)
;
