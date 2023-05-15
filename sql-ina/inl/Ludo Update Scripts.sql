select  distinct(a.equipment_no),'047'||a.subscriber_no from inl_ludo_chess_twin_tmp a, physical_device b
where a.equipment_no = b.equipment_no
and b.sw_state_ind = 'Y'

select * from inl_ludo_chess_twin_tmp where subscriber_no='95990447'

select a.*, b.*,c.* from inl_ludo_chess_twin_tmp a, physical_device b, serial_item_inv c
where a.equipment_no = b.equipment_no
--and b.sw_state_ind != 'Y'
and a.equipment_no = c.serial_number
and 'GSM047'||a.twin_no=b.subscriber_no
and c.item_ownership='D'
and sysdate between b.effective_date and b.expiration_date


--update sims for reuse
update serial_item_inv 
set item_ownership ='C',application_id='LUDO', curr_possession='A'
where serial_number in (select distinct(a.equipment_no) from inl_ludo_chess_twin_tmp a, physical_device b, serial_item_inv c
where a.equipment_no = b.equipment_no
and b.sw_state_ind != 'Y'
and a.equipment_no = c.serial_number
and 'GSM047'||a.twin_no=b.subscriber_no);
commit;

--and c.item_ownership='D'
--and sysdate between b.effective_date and b.expiration_date) 
