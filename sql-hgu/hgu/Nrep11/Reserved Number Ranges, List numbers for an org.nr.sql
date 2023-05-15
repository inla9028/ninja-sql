/*
** List the reserved number ranges for an organisation.
*/
select a.*
  from nrres_reserved_numbers a
 where a.foretaksnr = '943049467'
;

/*
** List the reserved number ranges for a company,
** combined with tn_inv...
*/
select a.*, t.*
  from nrres_reserved_numbers a, tn_inv t
 where a.foretaksnr = '943049467'
   and a.ctn = t.ctn
;

/*
** List an overview of the series reserved for an organisation.
*/
select a.foretaksnr, ltrim(a.kundenavn) as "KUNDENAVN"
     , a.nr_series || '-' || a.nr_series_seg2 || '-xxx' as "NR_SERIES"
     , count(1) as "COUNT"
  from nrres_reserved_numbers a
 where a.foretaksnr = '943049467'
group by a.foretaksnr, ltrim(a.kundenavn), a.nr_series || '-' || a.nr_series_seg2 || '-xxx'
order by 1,2, 3
;

/*
** List an overview of the series reserved for an organisation,
** combined with tn_inv to get status, location and groups.
*/
select a.foretaksnr, ltrim(a.kundenavn) as "KUNDENAVN"
     , a.nr_series || '-' || a.nr_series_seg2 || '-xxx' as "NR_SERIES"
     , t.ctn_status, t.nl, t.ngp
     , count(1) as "COUNT"
  from nrres_reserved_numbers a, tn_inv t
 where a.foretaksnr = '943049467'
   and a.ctn        = t.ctn
group by a.foretaksnr, ltrim(a.kundenavn), a.nr_series || '-' || a.nr_series_seg2 || '-xxx', t.ctn_status, t.nl, t.ngp
order by 1,2,3,4,5,6
;

/*
** List ALL reserved number ranges.
** Note! It appears as if old records hasn't been deleted, but rather the org.nr
** has been changed to -1, hence the check...
*/
select a.foretaksnr, ltrim(a.kundenavn) as "KUNDENAVN"
     , a.nr_series || '-' || a.nr_series_seg2 || '-xxx' as "NR_SERIES"
     , count(1) as "COUNT"
  from nrres_reserved_numbers a
 where a.foretaksnr not in ( '-1' )
group by a.foretaksnr, ltrim(a.kundenavn), a.nr_series || '-' || a.nr_series_seg2 || '-xxx'
order by 1,2,3
;
