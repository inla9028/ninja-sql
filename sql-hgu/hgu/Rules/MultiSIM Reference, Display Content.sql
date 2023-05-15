--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the data retrieved from MultiSimSocReferenceTable to identify
--== socs available to bundle/identify with an additional SIM card.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc_code, a.feature_code, a.msisdn_parameter_code,
       a.imsi_parameter_code, a.hlr_parameter_code, a.ki_parameter_code,
       a.cloning_parameter_code, a.k4id_parameter_code,
       a.encr_alg_parameter_code, a.sim_parameter_code
  FROM ninjarules.multisim_reference a
ORDER BY a.soc_code;


