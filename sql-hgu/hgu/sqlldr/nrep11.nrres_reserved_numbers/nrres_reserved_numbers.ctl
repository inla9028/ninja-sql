load data
CHARACTERSET UTF8
into table nrres_reserved_numbers
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
	NR_SERIES,
	NR_SERIES_SEG2,
	NR_SERIES_SEG3, 
	RESERVATION_ID,
	STATUS,
	BAN,
	DEALER,
	SALES_REP,
	FORETAKSNR,
	ACTIVATION_CODE,
	KUNDENAVN,
	MAN,
	CTN
)
