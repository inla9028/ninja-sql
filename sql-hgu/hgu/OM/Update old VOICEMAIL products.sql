/*
** List all order_item_id's _prior_ to update.
*/
SELECT a.order_item_id
  FROM additional_products a, order_items i, orders o
 WHERE a.action        = 'ADD'
   AND a.product_code  IN (
      'VOICEMAIL_FREE',
      'VOICEMAIL',
      'VOICEMAIL_KON_FREE',
      'VOICEMAIL_MINI'
   )
   AND a.processed     = 0
   AND a.order_item_id = i.order_item_id
   AND i.created_date  BETWEEN TRUNC(SYSDATE - 2) AND TRUNC(SYSDATE)
   AND i.order_id      = o.order_id
ORDER BY 1
;

/*
** List all the VOICEMAIL products _prior_ to update.
*/
SELECT a.*
  FROM additional_products a
 WHERE a.product_code  LIKE 'VOICEMAIL%'
   AND a.action        = 'ADD'
   AND a.order_item_id IN (
    21360711, 21360720, 21360734, 21360737, 21360763, 21360778, 21360839, 21360962, 21360975, 21361066,
    21361186, 21361278, 21361301, 21361355, 21361396, 21361408, 21361434, 21361450, 21361500, 21361554,
    21361594, 21361748, 21361778, 21361827, 21361855, 21361861, 21361878, 21361892, 21361910, 21361996,
    21362083, 21362092, 21362127, 21362264, 21362304, 21362332, 21362354, 21362360, 21362432, 21362436,
    21362461, 21362483, 21362503, 21362506, 21362539, 21362588, 21362617, 21362676, 21362690, 21362770,
    21362813, 21362815, 21362846, 21362873, 21362888, 21362950, 21362966, 21362969, 21363053, 21363205,
    21363225, 21363237, 21363275, 21363291, 21363330, 21363340, 21363369, 21363475, 21363525, 21363554,
    21363705, 21363847, 21363867
  );

/*
** Update - 73 rows!
*/
UPDATE additional_products a
   SET a.product_code = (
       SELECT DECODE(a.product_code,
                  'VOICEMAIL',          'VOICEMAIL_B2C_POS',
                  'VOICEMAIL_FREE',     'VOICEMAIL_B2B',
                  'VOICEMAIL_KON_FREE', 'VOICEMAIL_B2C_PRE',
                  'VOICEMAIL_MINI',     DECODE(o.agr_code_for_search,
                      'PRIVATE.REGULAR',    'VOICEMAIL_B2C_POS',
                      'PRIVATE.REGULAR.TF', 'VOICEMAIL_B2C_POS',
                      'VOICEMAIL_B2B'
                  ),
                  'WAS_DA_FÜCK'
              )
         FROM order_items i, orders o
        WHERE a.action        = 'ADD'
          AND a.product_code  IN (
                'VOICEMAIL_FREE',
                'VOICEMAIL',
                'VOICEMAIL_KON_FREE',
                'VOICEMAIL_MINI'
          )
          AND a.processed     = 0
          AND a.order_item_id = i.order_item_id
          AND i.created_date  BETWEEN TRUNC(SYSDATE - 2) AND TRUNC(SYSDATE)
          AND i.order_id      = o.order_id)
 WHERE a.action        = 'ADD'
   AND a.product_code  IN (
         'VOICEMAIL_FREE',
         'VOICEMAIL',
         'VOICEMAIL_KON_FREE',
         'VOICEMAIL_MINI'
   )
   AND a.processed     = 0
   AND a.order_item_id IN (
       SELECT i.order_item_id
         FROM order_items i, orders o
        WHERE i.created_date  BETWEEN TRUNC(SYSDATE - 2) AND TRUNC(SYSDATE)
          AND i.order_id      = o.order_id)
;

/*
** List all the VOICEMAIL products _post_ update.
*/
SELECT a.*
  FROM additional_products a
 WHERE a.product_code  LIKE 'VOICEMAIL%'
   AND a.action        = 'ADD'
   AND a.order_item_id IN (
    21360711, 21360720, 21360734, 21360737, 21360763, 21360778, 21360839, 21360962, 21360975, 21361066,
    21361186, 21361278, 21361301, 21361355, 21361396, 21361408, 21361434, 21361450, 21361500, 21361554,
    21361594, 21361748, 21361778, 21361827, 21361855, 21361861, 21361878, 21361892, 21361910, 21361996,
    21362083, 21362092, 21362127, 21362264, 21362304, 21362332, 21362354, 21362360, 21362432, 21362436,
    21362461, 21362483, 21362503, 21362506, 21362539, 21362588, 21362617, 21362676, 21362690, 21362770,
    21362813, 21362815, 21362846, 21362873, 21362888, 21362950, 21362966, 21362969, 21363053, 21363205,
    21363225, 21363237, 21363275, 21363291, 21363330, 21363340, 21363369, 21363475, 21363525, 21363554,
    21363705, 21363847, 21363867
  );

/*
** Commit...?
*/
-- COMMIT WORK;
