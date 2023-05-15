load data
into table hgu_tmp_subs_add_title
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 subscriber_no,
 additional_title
)
