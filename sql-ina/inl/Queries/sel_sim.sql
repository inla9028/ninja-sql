SELECT "SERIAL_ITEM_INV"."SERIAL_NUMBER",   
         "SERIAL_ITEM_INV"."LOCATION_ID",   
         "SERIAL_ITEM_INV"."ITEM_ID",   
         "SERIAL_ITEM_INV"."HLR_CD",   
         "SERIAL_ITEM_INV"."SIM_STATUS",   
         "SERIAL_ITEM_INV"."PACKAGE_MSISDN",   
         "SERIAL_ITEM_INV"."IMSI"  
    FROM "SERIAL_ITEM_INV"  
   WHERE ( "SERIAL_ITEM_INV"."ITEM_OWNERSHIP" = 'C' ) AND  
         ( "SERIAL_ITEM_INV"."CURR_POSSESSION" = 'A' ) AND  
         ( "SERIAL_ITEM_INV"."COMITED_TO_POS_IND" = 'N' ) AND  
         ( "SERIAL_ITEM_INV"."MISSING_IND" = 'N' ) AND  
         ( "SERIAL_ITEM_INV"."IN_REPAIR_IND" = 'N' ) AND  
         ( "SERIAL_ITEM_INV"."IN_TRANSIT_IND" = 'N' ) AND  
         ( "SERIAL_ITEM_INV"."COMITED_TO_POS_IND" = 'N' ) AND  
         ( "SERIAL_ITEM_INV"."LOCATION_ID" in ('NCLO') ) AND  
         ( "SERIAL_ITEM_INV"."HLR_CD" in ( '90') ) AND  
         ( "SERIAL_ITEM_INV"."SIM_STATUS" in('R'))   
         and item_id not like 'DUAL%'
