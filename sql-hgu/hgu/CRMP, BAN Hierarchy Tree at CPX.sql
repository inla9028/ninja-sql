--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== 906958301 - 209 BAN
--== 907156202 - Transportavtalen. Huuuuge...
--== 194254405 - IBM
--== 161899208 - Utdaningsforbundet
--== 783757206 - Schibsted
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT tree_root_ban, parent_ban, ban, effective_date, sys_creation_date,
       sys_update_date, expiration_date, sys_changed_date
  from ban_hierarchy_tree@cpx
  where tree_root_ban = 907156202
     and nvl(expiration_date, SYSDATE + 1) > SYSDATE
  ORDER BY tree_root_ban, sys_creation_date, parent_ban, ban

