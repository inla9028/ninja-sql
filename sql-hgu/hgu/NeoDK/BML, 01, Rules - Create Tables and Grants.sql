--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Create Tables...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
CREATE TABLE bml_main_product_mapping
(
  order_type        VARCHAR2 (10 BYTE),
  offering_code     VARCHAR2 (40 BYTE),
  base_code         VARCHAR2 (10 BYTE),
  campaign          VARCHAR2 (10 BYTE),
  promo             VARCHAR2 (10 BYTE),
  billing_system_id INTEGER,
  PRIMARY KEY (order_type, offering_code)
);

CREATE TABLE bml_additional_product_mapping
(
  bundle            VARCHAR2 (40 BYTE),
  offering_code     VARCHAR2 (30 BYTE),
  base_code         VARCHAR2 (10 BYTE),
  promo_code        VARCHAR2 (10 BYTE),
  special_handling  VARCHAR2 (10 BYTE),
  billing_system_id INTEGER,
  PRIMARY KEY (bundle, offering_code, base_code)
);

CREATE TABLE bml_billing_system
(
  id             INTEGER,
  billing_system VARCHAR2 (10 BYTE),
  brand          VARCHAR2 (10 BYTE),
  PRIMARY KEY (id)
);

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Add synonyms...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
grant ALTER on bml_main_product_mapping to ninjamain_dk3;
grant DELETE on bml_main_product_mapping to ninjamain_dk3;
grant INDEX on bml_main_product_mapping to ninjamain_dk3;
grant INSERT on bml_main_product_mapping to ninjamain_dk3;
grant SELECT on bml_main_product_mapping to ninjamain_dk3;
grant UPDATE on bml_main_product_mapping to ninjamain_dk3;
grant REFERENCES on bml_main_product_mapping to ninjamain_dk3;
grant ON COMMIT REFRESH on bml_main_product_mapping to ninjamain_dk3;
grant QUERY REWRITE on bml_main_product_mapping to ninjamain_dk3;
grant DEBUG on bml_main_product_mapping to ninjamain_dk3;
grant FLASHBACK on bml_main_product_mapping to ninjamain_dk3;

grant ALTER on bml_additional_product_mapping to ninjamain_dk3;
grant DELETE on bml_additional_product_mapping to ninjamain_dk3;
grant INDEX on bml_additional_product_mapping to ninjamain_dk3;
grant INSERT on bml_additional_product_mapping to ninjamain_dk3;
grant SELECT on bml_additional_product_mapping to ninjamain_dk3;
grant UPDATE on bml_additional_product_mapping to ninjamain_dk3;
grant REFERENCES on bml_additional_product_mapping to ninjamain_dk3;
grant ON COMMIT REFRESH on bml_additional_product_mapping to ninjamain_dk3;
grant QUERY REWRITE on bml_additional_product_mapping to ninjamain_dk3;
grant DEBUG on bml_additional_product_mapping to ninjamain_dk3;
grant FLASHBACK on bml_additional_product_mapping to ninjamain_dk3;

grant ALTER on bml_billing_system to ninjamain_dk3;
grant DELETE on bml_billing_system to ninjamain_dk3;
grant INDEX on bml_billing_system to ninjamain_dk3;
grant INSERT on bml_billing_system to ninjamain_dk3;
grant SELECT on bml_billing_system to ninjamain_dk3;
grant UPDATE on bml_billing_system to ninjamain_dk3;
grant REFERENCES on bml_billing_system to ninjamain_dk3;
grant ON COMMIT REFRESH on bml_billing_system to ninjamain_dk3;
grant QUERY REWRITE on bml_billing_system to ninjamain_dk3;
grant DEBUG on bml_billing_system to ninjamain_dk3;
grant FLASHBACK on bml_billing_system to ninjamain_dk3;
