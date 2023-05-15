--== Re-create the synonym to point towards a local table
CREATE OR REPLACE SYNONYM ninjamaster.gsm_bestilling_test
  FOR ninjadata.gsm_bestilling_test
/

--== Re-create the synonym back to NetWeb...
/*
CREATE OR REPLACE SYNONYM ninjamaster.gsm_bestilling_test
  FOR kontroll.gsm_bestilling_test@netweb
/
*/
