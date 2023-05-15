SELECT a.tree_root_ban, a.ban, a.effective_date, a.sys_creation_date,
       a.sys_update_date, a.operator_id, a.application_id,
       a.dl_service_code, a.dl_update_stamp, a.tree_level, a.parent_ban,
       a.expiration_date
  FROM ntcappo.ban_hierarchy_tree a
  WHERE a.tree_level > 2
    AND a.expiration_date IS NULL

--
SELECT bht.tree_root_ban AS "ROOT_BAN"
  FROM ban_hierarchy_tree bht
  WHERE bht.ban = 906958301
    AND bht.effective_date < SYSDATE
    AND nvl(bht.expiration_date, TO_DATE('47000101', 'YYYYMMDD')) > SYSDATE

-- --> 950978205

--
SELECT a.tree_root_ban, a.ban, a.tree_level, a.parent_ban
  FROM ban_hierarchy_tree a
  WHERE a.tree_root_ban = 950978205
    AND a.effective_date < SYSDATE
    AND nvl(a.expiration_date, TO_DATE('47000101', 'YYYYMMDD')) > SYSDATE
  ORDER BY a.tree_level, a.ban, a.parent_ban



