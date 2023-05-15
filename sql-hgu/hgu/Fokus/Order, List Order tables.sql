/*
** Order header ...
*/
SELECT /*+ driving_site(a)*/ a.*
  FROM order_header@fokus a
 WHERE a.order_number = 1017
ORDER BY a.order_number ASC
;

/*
** Order details aka Order Lines...
*/
SELECT /*+ driving_site(a)*/ a.*
  FROM order_details@fokus a
 WHERE a.order_number = 1017
ORDER BY a.order_number ASC
;

/*
** Order additional info...
*/
SELECT /*+ driving_site(a)*/ a.*
  FROM order_add_info@fokus a
 WHERE a.order_number = 1017
ORDER BY a.order_number ASC, a.field_name
;

/*
** Order lines' additional info...
*/
SELECT /*+ driving_site(a)*/ a.*
  FROM order_lines_add_info@fokus a
 WHERE a.order_number = 1017
ORDER BY a.order_number ASC, a.order_line_no
;

/*
** Manual note request...
*/
SELECT /*+ driving_site(a)*/ a.*
  FROM manual_note_request@fokus a
 WHERE a.order_number = 1017
;

/*
** Order lines additional info...
*/
SELECT /*+ driving_site(a)*/ a.*
  FROM order_lines_add_info@fokus a
-- WHERE a.order_number = 1017
ORDER BY a.order_number ASC, a.order_line_no
;


