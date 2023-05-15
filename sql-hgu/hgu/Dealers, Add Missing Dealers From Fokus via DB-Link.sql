/*******************************************************************************
****************************** SCHEMA: CONFIG **********************************
*******************************************************************************/

/*
**
** Copy the ninja fokus dealers from Fokus not yet in the current environment,
** but use one dummy-Fokus User Id...
**
*/
INSERT INTO ninja_dealer_fokus_user 
  SELECT RTRIM(a.dealer) AS "DEALER_CODE",
         200900          AS "FOKUS_USER",
         'HGU: Copied from Fokus (NO PT) at ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI') || ': ' || a.dlr_name AS "NINJA_COMMENT", 
         'A'             AS "DEFAULT_SALES_AGENT_CODE"
    FROM dealer_profile@fokus a
   WHERE NOT EXISTS (
     SELECT ' '
       FROM ninja_dealer_fokus_user b
      WHERE b.dealer_code = RTRIM(a.dealer)
      
   )
   ORDER BY 1
;


/*******************************************************************************
****************************** SCHEMA: RULES ***********************************
*******************************************************************************/

/*
**
** Insert dealers into ninjarules.dealers table that are in the table 
** ninjaconfig.ninja_dealer_fokus_user but are not present.
**
*/
INSERT INTO dealers
  SELECT a.dealer_code, 'REGULAR' AS "DEALER_GROUP"
    FROM ninja_dealer_fokus_user a
   WHERE NOT EXISTS (
     SELECT ' '
       FROM dealers b
      WHERE b.dealer_code = a.dealer_code
   )
;

/*
**
** List dealers configured in Ninja but not in Fokus.
**
*/
SELECT a.dealer_code, a.fokus_user_id, a.default_sales_agent_code, a.ninja_comment
  FROM ninja_dealer_fokus_user a
 WHERE NOT EXISTS (
   SELECT ' '
     FROM dealer_profile@fokus b
      WHERE RTRIM(b.dealer) = a.dealer_code 
   )
ORDER BY a.dealer_code
;

/*
**
** List dealers configured in Fokus but not in Ninja.
**
*/
SELECT a.*
    FROM dealer_profile@fokus a
   WHERE NOT EXISTS (
     SELECT ' '
       FROM ninja_dealer_fokus_user b
      WHERE b.dealer_code = RTRIM(a.dealer)
   )
--ORDER BY a.dealer
ORDER BY a.start_date DESC
;
