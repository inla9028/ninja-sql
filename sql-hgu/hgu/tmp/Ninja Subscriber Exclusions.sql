--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== PVXH is the only priceplan for Axiti, therefore, diable all entries that
--== has other priceplans.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.effective_date, a.expiration_date,
       a.exclusion_text, b.soc --, c.channel_code
  FROM ninjaconfig.ninja_subscriber_exclusions a, service_agreement@prod.world b --, ninjarules.sub_typ_soc_channel c
  WHERE a.subscriber_no = b.subscriber_no
    AND b.service_type    = 'P'
    AND b.expiration_date > SYSDATE
    AND b.soc IN ('PVXH')

--== Expire...
UPDATE ninjaconfig.ninja_subscriber_exclusions a
  SET a.expiration_date = TRUNC(SYSDATE) - 1
  WHERE a.expiration_date > SYSDATE


