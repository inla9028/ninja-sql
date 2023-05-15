SELECT count(*)
                                  FROM billing_account@fokus ba,
                                       subscriber@fokus su, 
                                       address_name_link@fokus adl, 
                                       name_data@fokus nd 
                                  WHERE ba.account_type  != 'S'
                                    AND ba.ban=su.customer_id and su.sub_status in ('S','A') 
                                    AND ba.ban=adl.customer_id and su.subscriber_no=adl.subscriber_no and adl.expiration_date is null 
                                    AND adl.name_id=nd.name_id and nd.tpid is null 
                                    AND adl.link_type ='U'
                                    order by nd.sys_creation_date
                                  UNION
                                  select count(*)
                                    FROM billing_account@fokus ba,
                                       address_name_link@fokus adl, 
                                       name_data@fokus nd 
                                  WHERE ba.account_type  not in ('S','P') 
                                    AND ba.ban=adl.customer_id and '0000000000'=adl.subscriber_no and adl.expiration_date is null 
                                    AND adl.name_id=nd.name_id and nd.tpid is null 
                                    AND adl.link_type in ('B','L')
                                    and exists (select ' ' from subscriber@fokus s 
                                                where ba.ban=s.customer_id and s.sub_status in ('A','S'))                                    
