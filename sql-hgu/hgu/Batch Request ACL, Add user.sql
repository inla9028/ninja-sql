/*
** Check...
*/
SELECT a.request_type_id, t.name, a.user_id
  FROM batch_request_acl A, batch_request_types t
 where a.user_id IN ( 'HAGU1198', UPPER('JAB6564') )
   AND a.request_type_id = t.request_type_id
ORDER BY a.user_id, TO_NUMBER(a.request_type_id)
;

/*
** Insert...
**  0: AddDeleteSoc
**  1: ChangePriceplan
**  2: MoveSubscriber
**  3: ChangeSubscriberStatus
**  4: ChangeNameAddress
**  5: ChangePrintCategory
**  6: ChangeAdditionalTitle
**  7: ChangePublishLevel
**  8: AddAdjustment
**  9: ChangeBillDueDays
** 10: ChangePriceplanWithClone
** 11: ReleaseSimNumbers
** 12: BatchNameUpdate
** 13: BatchAddressUpdate
** 14: BatchChargeAddition
*/
INSERT INTO batch_request_acl
SELECT a.request_type_id, UPPER('JAB6564') AS "USER_ID"
  FROM batch_request_types a
-- WHERE a.request_type_id NOT IN (0,1,2,3,4,5,6,7,8,9)
-- WHERE a.request_type_id NOT IN (11)
 WHERE a.request_type_id IN ( 9 )
-- WHERE a.request_type_id IN (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14)
;

/*
** Check who's granted a certain request type.
**  0: AddDeleteSoc
**  1: ChangePriceplan
**  2: MoveSubscriber
**  3: ChangeSubscriberStatus
**  4: ChangeNameAddress
**  5: ChangePrintCategory
**  6: ChangeAdditionalTitle
**  7: ChangePublishLevel
**  8: AddAdjustment
**  9: ChangeBillDueDays
** 10: ChangePriceplanWithClone
** 11: ReleaseSimNumbers
** 12: BatchNameUpdate
** 13: BatchAddressUpdate
** 14: BatchChargeAddition
*/
SELECT a.request_type_id, t.name, a.user_id
  FROM batch_request_acl a, batch_request_types t
 WHERE A.request_type_id = t.request_type_id
   AND A.request_type_id IN ( 12, 13 )
   AND a.user_id         NOT IN ('LANI9166' ) -- Used to copy from, so ignore him. Zlatan.
ORDER BY a.user_id, TO_NUMBER(a.request_type_id)
;

/*
** Revoke a certain access.
*/
DELETE
   FROM batch_request_acl a
  WHERE a.user_id         = UPPER('JAB6564')
    AND a.request_type_id IN ( 8,9,11,12,13,14 )
;

/*
** List available jobs.
*/
SELECT t.request_type_id, t.name
  FROM batch_request_types t
ORDER BY TO_NUMBER(t.request_type_id)
;