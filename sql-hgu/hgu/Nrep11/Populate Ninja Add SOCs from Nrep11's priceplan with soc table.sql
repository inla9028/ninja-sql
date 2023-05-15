--
-- Populate Ninja to add a certain SOC to subscriptions missing it.
--
insert into batch_socs (ban, subscriber_no, chk_priceplan, add_socs, dealer_code, memo_text, request_id, process_status)
with my_filter as (
  select /*+ driving_site(a1)*/ unique a1.subscriber_no, a1.ban, a1.sub_status, a1.price_plan
    from tmp_msisdns_w_status_pp_soc@nrep11 a1
)
select mf.ban
     , mf.subscriber_no
     , mf.price_plan         AS "CHK_PRICEPLAN"
     , 'ODBWSMS'             AS "ADD_SOCS"
     , 'NWCO'                AS "DEALER_CODE"
     , 'Adding ODBWSMS to all PW20/21/22 (aka FWA) subscriptions to avoid issues with retrieval of roaming prices. Ref Svein Knudsen and Olav Ranes.' AS "MEMO_TEXT"
     , 'hagu1198 2022-06-02' AS "REQUEST_ID"
     , 'ON_HOLD'             AS "PROCESS_STATUS"
  from my_filter mf
 where 0      = (select /*+ driving_site(a2)*/ COUNT(1)
                   from tmp_msisdns_w_status_pp_soc@nrep11 a2
                  where a2.subscriber_no = mf.subscriber_no
                    and a2.soc          IN ( 'ODBWSMS' ))
order by mf.subscriber_no
;
