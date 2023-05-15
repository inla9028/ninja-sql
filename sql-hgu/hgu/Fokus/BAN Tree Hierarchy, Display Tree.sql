SELECT b.*
  FROM ban_hierarchy_tree b
 WHERE b.tree_root_ban = (SELECT c.tree_root_ban c
                            FROM ban_hierarchy_tree c
                           WHERE c.ban = 399635416
                         )
   AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
ORDER BY b.tree_level, b.parent_ban, b.ban
;

SELECT COUNT(1) AS "BAN_COUNT"
  FROM ban_hierarchy_tree b
 WHERE b.tree_root_ban = (SELECT c.tree_root_ban c
                            FROM ban_hierarchy_tree c
                           WHERE c.ban = 399635416
                         )
   AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
;

/*
** Only list the BAN(s) with root and parent.
*/
SELECT a.tree_root_ban, a.parent_ban, a.ban
  FROM ban_hierarchy_tree a
 WHERE a.ban IN ( 386018311,486018310,196018311,396018319,796018315,207018318,707018313,807018312,837018316,217018316,517018313,817018310,781218318,337018311 )
ORDER BY 3,1,2
;


--== List all BANs in tree, with the number of subscriptions underneath.
SELECT tree_root_ban, tree_level, parent_ban, ban, effective_date, who, COUNT(1) AS "SUBSCRIBER_COUNT"
  FROM (
SELECT bht.tree_root_ban, bht.tree_level, bht.parent_ban, bht.ban, bht.effective_date
     , DECODE(bht.ban, 399635416, 'ME', '') AS "WHO", s.subscriber_no
  FROM ban_hierarchy_tree bht, subscriber s
 WHERE bht.tree_root_ban = (SELECT c.tree_root_ban c
                              FROM ban_hierarchy_tree c
                             WHERE c.ban = 399635416)
   AND SYSDATE BETWEEN bht.effective_date AND NVL(bht.expiration_date, SYSDATE + 1)
   AND bht.ban = s.customer_id
   AND s.sub_status = 'A'
)
GROUP BY tree_root_ban, tree_level, parent_ban, ban, effective_date, who
ORDER BY tree_level, parent_ban, ban
;

/*
** Via DB-Link...
*/
SELECT b.*
  FROM ban_hierarchy_tree@fokus b
 WHERE b.tree_root_ban = (SELECT c.tree_root_ban c
                            FROM ban_hierarchy_tree@fokus c
                           WHERE c.ban = 593235310
                         )
   AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
ORDER BY b.tree_level, b.parent_ban, b.ban
;

SELECT COUNT(1) AS "BAN_COUNT"
  FROM ban_hierarchy_tree@fokus b
 WHERE b.tree_root_ban = (SELECT c.tree_root_ban c
                            FROM ban_hierarchy_tree@fokus c
                           WHERE c.ban = 763548211
                         )
   AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
;


--== List all BANs in tree, with the number of subscriptions underneath.
SELECT tree_root_ban, tree_level, parent_ban, ban, effective_date, who, COUNT(1) AS "subscriber@fokus_COUNT"
  FROM (
SELECT bht.tree_root_ban, bht.tree_level, bht.parent_ban, bht.ban, bht.effective_date
     , DECODE(bht.ban, 399635416, 'ME', '') AS "WHO", s.subscriber_no
  FROM ban_hierarchy_tree@fokus bht, subscriber@fokus s
 WHERE bht.tree_root_ban = (SELECT c.tree_root_ban c
                              FROM ban_hierarchy_tree@fokus c
                             WHERE c.ban = 763548211)
   AND SYSDATE BETWEEN bht.effective_date AND NVL(bht.expiration_date, SYSDATE + 1)
   AND bht.ban = s.customer_id
   AND s.sub_status = 'A'
)
GROUP BY tree_root_ban, tree_level, parent_ban, ban, effective_date, who
ORDER BY tree_level, parent_ban, ban
;



