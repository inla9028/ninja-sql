CREATE VIEW dsp_info
AS
    SELECT *
      FROM dr_info@nrep11 di
     WHERE NOT EXISTS
                   (SELECT ''
                      FROM dsp_request req
                     WHERE req.customer_id          = di.ban
                       AND req.record_creation_date > SYSDATE
                       -- AND req.process_status = 'WAITING'
                   )
/
