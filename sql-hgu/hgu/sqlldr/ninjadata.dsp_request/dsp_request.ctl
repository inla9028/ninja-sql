load data
into table ninjadata.dsp_request
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  request_id,
  customer_id,
  adr_first_name,
  adr_last_name,
  adr_birth_date DATE "YYYY-MM-DD",
  adr_zip,
  record_creation_date DATE "YYYY-MM-DD HH24:MI",
  process_status,
  request_user_id,
  process_time DATE "YYYY-MM-DD HH24:MI",
  status_desc
)
