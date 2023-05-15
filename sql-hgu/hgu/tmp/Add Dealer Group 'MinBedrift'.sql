-- 1) Add the new dealer group
INSERT INTO dealer_groups (dealer_group,description) values ('MinBedrift','Min Bedrift dealer group');

-- 2) Make use of the dealer group for the user NETL
UPDATE dealers SET dealer_group = 'MinBedrift' WHERE dealer_code = 'NETL';


SELECT a.dealer_code, a.dealer_group, b.description
  FROM ninjarules.dealers a, ninjarules.dealer_groups b
  WHERE a.dealer_code = 'NETL'
    AND a.dealer_group = b.dealer_group
