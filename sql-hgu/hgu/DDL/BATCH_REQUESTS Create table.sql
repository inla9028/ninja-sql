CREATE TABLE batch_requests
    (request_id                    VARCHAR2(38 CHAR) NOT NULL,
    description                    VARCHAR2(500 CHAR),
    request_date                   DATE DEFAULT SYSDATE NOT NULL,
    file_name                      VARCHAR2(200 CHAR) NOT NULL,
    request_type                   VARCHAR2(50 CHAR) NOT NULL,
    user_id                        VARCHAR2(20 CHAR) NOT NULL,
    record_count                   NUMBER,
    status                         VARCHAR2(20 CHAR))
/

CREATE INDEX batch_requests_idx1 ON batch_requests
  (
    request_id                      ASC
  )
/

CREATE INDEX batch_requests_idx2 ON batch_requests
  (
    user_id                         ASC
  )
/

