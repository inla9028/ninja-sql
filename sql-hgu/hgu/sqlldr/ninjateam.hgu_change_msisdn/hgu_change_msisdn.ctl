load data
into table hgu_change_msisdn
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
	subscriber_no,
	dealer_code,
	num_loc,
	num_group,
	num_length,
	physical_hlr,
	ctn
)
