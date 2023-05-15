SELECT *
  FROM (SELECT *
          FROM (SELECT sii.serial_number AS "SIM"
                  FROM serial_item_inv sii
                 WHERE sii.item_ownership     = 'C'
                   AND sii.curr_possession    = 'A'
                   AND sii.comited_to_pos_ind = 'N'
                   AND sii.missing_ind        = 'N'
                   AND sii.in_repair_ind      = 'N'
                   AND sii.in_transit_ind     = 'N'
                   AND sii.location_id        = 'NCLO'
                   AND sii.sim_status         = 'R'
                   AND sii.package_msisdn     IS NULL
                   AND sii.sim_type           IN ('410')
                   AND ROWNUM                 < 101)
        ORDER BY DBMS_RANDOM.VALUE)
 WHERE ROWNUM < 11
 ;
 
SELECT sii.serial_number AS "SIM"
  FROM serial_item_inv sii
 WHERE sii.item_ownership     = 'C'
   AND sii.curr_possession    = 'A'
   AND sii.comited_to_pos_ind = 'N'
   AND sii.missing_ind        = 'N'
   AND sii.in_repair_ind      = 'N'
   AND sii.in_transit_ind     = 'N'
   AND sii.location_id        = 'NCLO'
   AND sii.sim_status         = 'R'
   AND sii.hlr_cd             = '01'
   AND sii.item_id            NOT LIKE 'DUAL%'
   AND sii.package_msisdn     IS NULL
   AND sii.sim_type           IN ('410')
   AND ROWNUM                 < 11
;

SELECT serial_number
  FROM serial_item_inv
 WHERE item_ownership     = 'S'      -- S = Subscriber (indexed)
   AND curr_possession    = 'A'      -- A = Available (not indexed)
   AND sim_type           IN ('410') -- SIM-types for eSIM (indexed)
   AND location_id        = 'NCLO'   -- (indexed)
   AND package_msisdn     IS NULL    --(indexed)
   AND ROWNUM             < 11
;

--== A thought... Since we're looking specifically for eSIMs,
--== and the eSIM type we're looking for is configured, we don't need all columns!
--== We can assume the configuration is valid, and simply look if it's in use or not.. :)
SELECT serial_number
  FROM serial_item_inv
 WHERE curr_possession = 'A'      -- A = Available (not indexed)
   AND sim_type        IN ('410') -- SIM-types for eSIM (indexed)
   AND ROWNUM          < 11
;

-- Slooooooow
SELECT sii.*
  FROM serial_item_inv sii
 WHERE sii.curr_possession = 'A'      -- A = Available (not indexed)
   AND sii.location_id     = 'NCLO'    -- (indexed)
   AND sii.sim_type        IN ('410') -- SIM-types for eSIM (indexed)
   AND ROWNUM              < 11
;

-- 2. Sloooow.
SELECT sii.*
  FROM serial_item_inv sii
 WHERE sii.sim_type        IN ('410') -- SIM-types for eSIM (indexed)
   AND sii.location_id     = 'NCLO'    -- (indexed)
   AND sii.curr_possession = 'A'      -- A = Available (not indexed)
   AND ROWNUM              < 11
;

-- 2. Sloooow.
SELECT sii.*
  FROM serial_item_inv sii
 WHERE sii.sim_type        IN ('410') -- SIM-types for eSIM (indexed)
--   AND sii.location_id     = 'NCLO'    -- (indexed)
   AND sii.curr_possession = 'A'      -- A = Available (not indexed)
   AND ROWNUM              < 11
;






SELECT pd.*
  FROM physical_device pd
 WHERE pd.subscriber_no = 'GSM047' || '92653600'
   AND ROWNUM < 21
ORDER BY pd.effective_date, pd.expiration_date, pd.equipment_level
;

-- 08947080034009537263
SELECT sii.*
  FROM serial_item_inv sii
 WHERE sii.serial_number = '08947080034009537263'
   AND ROWNUM          < 11
;
