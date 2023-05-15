load data
into table hgu_tmp_subs_bans_status
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 ban,
 acc_type,
 acc_sub_type,
 subscriber_no,
 sub_status,
 dealer_code
)
