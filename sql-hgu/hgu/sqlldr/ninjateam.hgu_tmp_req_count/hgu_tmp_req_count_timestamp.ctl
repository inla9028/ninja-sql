load data
into table ninjateam.hgu_tmp_req_count
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  req_name,
  req_date DATE "YYYY-MM-DD HH24:MI",
  req_count
)
