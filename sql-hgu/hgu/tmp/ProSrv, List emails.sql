SELECT a.pro_username, a.pro_msisdn, a.pro_firstname, a.pro_lastname,
       a.pro_created, a.pro_updated, a.pro_pwdupdated, a.pro_clrtxt,
       a.pro_profile
  FROM profile a
  WHERE ROWNUM < 100
    AND NVL(a.pro_lastname,  'N/A') NOT IN (' ', 'Unknown', 'N/A', 'mmslast', 'SUBSCRIBER - CHESS')
    AND NVL(a.pro_firstname, 'N/A') NOT IN (' ', 'Unknown', 'N/A', 'mmsfirst', 'Ukjent')
    AND a.pro_pwdupdated > TO_DATE('2007-01-01', 'YYYY-MM-DD')
    AND a.pro_clrtxt NOT LIKE '74%'
    AND TO_CHAR(a.pro_profile) LIKE '%@hotmail.com</%'
