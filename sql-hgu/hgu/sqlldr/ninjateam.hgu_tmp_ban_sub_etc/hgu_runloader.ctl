load data
CHARACTERSET UTF8
into table ninjateam.hgu_tmp_ban_sub_etc
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  ban,
  subscriber_no,
  link_type,
  customer_telno,
  process_status
)
