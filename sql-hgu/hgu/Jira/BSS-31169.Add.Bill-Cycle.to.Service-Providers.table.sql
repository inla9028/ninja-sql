ALTER TABLE service_providers
  ADD bill_cycle NUMBER(2,0)
;

COMMENT ON COLUMN service_providers.bill_cycle
  IS 'Bill-cycle to apply when cloning BAN, NULL means keep cloned value'
;

update service_providers sp
   set sp.bill_cycle = 9
 where sp.service_provider_code = 'Chess2'
;
