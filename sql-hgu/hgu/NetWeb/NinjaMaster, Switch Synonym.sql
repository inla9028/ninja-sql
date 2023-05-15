--== Re-create the synonym to point towards a local table
CREATE OR REPLACE SYNONYM ninjamaster.gsm_bestilling
  FOR ninjadata.gsm_bestilling
/

--== Re-create the synonym back to NetWeb...
/*
CREATE OR REPLACE SYNONYM ninjamaster.gsm_bestilling
  FOR kontroll.gsm_bestilling@netweb
/
*/
