SELECT a.subscription_type_id, a.soc, a.ninja_default_soc,
       b.soc_type, b.soc_group
  FROM subscription_types_socs a, socs b
  WHERE a.subscription_type_id IN ('PKOFREG1', 'PKOGREG1')
    AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
    AND a.soc                  = b.soc
    AND a.soc            LIKE 'FL_X'
    AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
  ORDER BY a.subscription_type_id, a.soc, b.soc_type, b.soc_group
