/*
** This is the exact query used by Ninja in method...
**  SIMCard.isAvailableInInventory(String simCardNumber)
** ...which is invoked via NSL's... 
**  EquipmentEndpoint.validateSimcardNumber(...)
*/
SELECT SERIAL_NUMBER
  FROM SERIAL_ITEM_INV
 WHERE SERIAL_NUMBER       = '08947080050501232146' -- Check if the SIM is available in inventory
   AND (ITEM_OWNERSHIP     = 'C')
   AND (CURR_POSSESSION    = 'A')
   AND (COMITED_TO_POS_IND = 'N')
   AND (MISSING_IND        = 'N')
   AND (IN_REPAIR_IND      = 'N' )
   AND (IN_TRANSIT_IND     = 'N')
   AND (LOCATION_ID        = 'NCLO')
   AND (SIM_STATUS         = ('R'))
   AND (PACKAGE_MSISDN     IS NULL)
;

/*
** If there were no match, try and pin-point which value was "off"...
*/
SELECT serial_number, item_ownership, curr_possession, comited_to_pos_ind,
       missing_ind, in_repair_ind, in_transit_ind, location_id, sim_status,
       package_msisdn
  FROM serial_item_inv
 WHERE serial_number = '08947080050505087884'
;

/*
** List all values...
*/
SELECT *
  FROM serial_item_inv
 WHERE serial_number = '08947080050505087884'
;
