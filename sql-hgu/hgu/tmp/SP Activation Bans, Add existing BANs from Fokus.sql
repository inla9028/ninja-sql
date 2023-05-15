/*
SELECT * FROM ninjaconfig.sp_activation_bans a WHERE a.service_provider_code = 'Chess2'
*/

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Insert new Activation BANs for the specified SP and MAN, where there exist
--== available BANs in Fokus.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjaconfig.sp_activation_bans
  SELECT 'Chess2', a.ban, ''
  FROM ban_hierarchy_tree@prod.world a
  WHERE a.tree_root_ban  = 157231606
    AND a.parent_ban     = 157231606
    AND a.tree_root_ban != a.ban
    AND a.ban NOT IN (
      SELECT b.ban FROM ninjaconfig.sp_activation_bans b
      WHERE b.service_provider_code = 'Chess2'
    )

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the available BAN's in Fokus that isn't in the Activation BAN List
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.tree_root_ban, a.parent_ban, a.ban
  FROM ban_hierarchy_tree@prod.world a
  WHERE a.tree_root_ban  = 157231606
    AND a.parent_ban     = 157231606
    AND a.tree_root_ban != a.ban
    AND a.ban NOT IN (
      SELECT b.ban FROM ninjaconfig.sp_activation_bans b
      WHERE b.service_provider_code = 'Chess2'
    )
  ORDER BY a.tree_root_ban, a.parent_ban, a.ban


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Simply display the number of BAN's per SP.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.service_provider_code, COUNT(*) AS "COUNT"
  FROM ninjaconfig.sp_activation_bans a
  GROUP BY a.service_provider_code
  ORDER BY a.service_provider_code
