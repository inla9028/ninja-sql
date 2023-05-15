select a.*
  from additional_products a, order_items i
 where a.action = 'ADD'
 --  and a.effective_date between TRUNC(SYSDATE - 2) and TRUNC(SYSDATE)
   and a.product_code LIKE 'VOICEMAIL%'
   and a.processed = 0
   and a.order_item_id = i.order_item_id
   and i.created_date between TRUNC(SYSDATE - 2) and TRUNC(SYSDATE)
;

select count(1) as "COUNT"
  from additional_products a
 where a.product_code like 'VOICEMAIL%'
   and a.action = 'ADD'
   and a.processed = 0
;

select count(1) as "COUNT"
  from additional_products a, order_items i
 where a.action = 'ADD'
   and a.product_code LIKE 'VOICEMAIL%'
   and a.processed = 0
   and a.order_item_id = i.order_item_id
   and i.created_date between TRUNC(SYSDATE - 2) and TRUNC(SYSDATE)
;

select a.product_code, o.agr_code_for_search, count(1) as "COUNT"
  from additional_products a, order_items i, orders o
 where a.action = 'ADD'
   and a.product_code IN (
      'VOICEMAIL_MBN',
      'VOICEMAIL_FREE',
      'BEDRIFTSVAR',
      'VOICEMAIL',
      'VOICEMAIL_KON_FREE',
      'VOICEMAIL_MINI',
      'VOICEMAIL_PLUS',
      'VOICEMAIL_POST'
   )
   and a.processed = 0
   and a.order_item_id = i.order_item_id
   and i.created_date between TRUNC(SYSDATE - 2) and TRUNC(SYSDATE)
   and i.order_id = o.order_id
group by a.product_code, o.agr_code_for_search
order by 1, 2
;

SELECT agr_code_for_search, product_code, suggested_new_code, COUNT(1) AS "COUNT"
FROM (
  SELECT o.agr_code_for_search
       , a.product_code
       , DECODE(a.product_code,
          'VOICEMAIL',          'VOICEMAIL_B2C_POS',
          'VOICEMAIL_FREE',     'VOICEMAIL_B2B',
          'VOICEMAIL_KON_FREE', 'VOICEMAIL_B2C_PRE',
          'VOICEMAIL_MINI',     DECODE(o.agr_code_for_search,
              'PRIVATE.REGULAR',    'VOICEMAIL_B2C_POS',
              'PRIVATE.REGULAR.TF', 'VOICEMAIL_B2C_POS',
              'VOICEMAIL_B2B'
          ),
          'WAS_DA_FÜCK'
        ) AS "SUGGESTED_NEW_CODE"
    FROM additional_products a, order_items i, orders o
   WHERE a.action = 'ADD'
     AND a.product_code IN (
        'VOICEMAIL_FREE',
        'VOICEMAIL',
        'VOICEMAIL_KON_FREE',
        'VOICEMAIL_MINI'
     )
     AND a.processed = 0
     AND a.order_item_id = i.order_item_id
     AND i.created_date BETWEEN TRUNC(SYSDATE - 2) AND TRUNC(SYSDATE)
     AND i.order_id = o.order_id
)
GROUP BY agr_code_for_search, product_code, suggested_new_code
ORDER BY 1,2,3
;




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
          AND i.order_id      = o.order_id
)
;


SELECT o.agr_code_for_search
     , a.product_code
     , DECODE(a.product_code,
        'VOICEMAIL',          'VOICEMAIL_B2C_POS',
        'VOICEMAIL_FREE',     'VOICEMAIL_B2B',
        'VOICEMAIL_KON_FREE', 'VOICEMAIL_B2C_PRE',
        'VOICEMAIL_MINI',     DECODE(o.agr_code_for_search,
            'PRIVATE.REGULAR',    'VOICEMAIL_B2C_POS',
            'PRIVATE.REGULAR.TF', 'VOICEMAIL_B2C_POS',
            'VOICEMAIL_B2B'
        ),
        'WAS_DA_FÜCK'
      ) AS "SUGGESTED_NEW_CODE"
  FROM additional_products a, order_items i, orders o
 WHERE a.action = 'ADD'
   AND a.product_code IN (
      'VOICEMAIL_FREE',
      'VOICEMAIL',
      'VOICEMAIL_KON_FREE',
      'VOICEMAIL_MINI'
   )
   AND a.processed = 0
   AND a.order_item_id = i.order_item_id
   AND i.created_date BETWEEN TRUNC(SYSDATE - 2) AND TRUNC(SYSDATE)
   AND i.order_id = o.order_id
ORDER BY 1, 2, 3
;



