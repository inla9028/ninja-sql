select sd.*
  from system_defaults sd
 where sd.key like 'DSP%'
    or sd.key like 'EPOSTFAKTURA%'
order by 1, 2
;

-- Insert into SYSTEM_DEFAULTS (KEY,VALUE,VALUE_TYPE,DESCRIPTION) values ('','','STRING','');

Insert into SYSTEM_DEFAULTS (KEY,VALUE,VALUE_TYPE,DESCRIPTION) values ('DSP_EXTRACT_QUEUE_THRESHOLD', '0',           'INTEGER', 'The maximum number of waiting DSP-records, until we read more records from Fokus');
Insert into SYSTEM_DEFAULTS (KEY,VALUE,VALUE_TYPE,DESCRIPTION) values ('DSP_EXTRACT_BATCH_SIZE',      '100',         'INTEGER', 'The number of records to perform DSP-lookups for in each iteration');
Insert into SYSTEM_DEFAULTS (KEY,VALUE,VALUE_TYPE,DESCRIPTION) values ('DSP_EXTRACT_TIME_FRAME',      '02:00-02:02', 'STRING',  'The hours during the day when the extract should run. Format: "01:00-02:00,22:15-23:09"');
Insert into SYSTEM_DEFAULTS (KEY,VALUE,VALUE_TYPE,DESCRIPTION) values ('DSP_UPDATE_DSP_ID_ONLY',      'N',           'STRING',  'If "Y", only the DSP ID (aka COMP REG) is updated, otherwise the entire address is updated.');

Insert into SYSTEM_DEFAULTS (KEY,VALUE,VALUE_TYPE,DESCRIPTION) values ('EPOSTFAKTURA_SOC_NETCOM',     'EPOFAK',      'STRING',  'The name of the BAN-level Soc representing the Epost Faktura service for NetCom.');
Insert into SYSTEM_DEFAULTS (KEY,VALUE,VALUE_TYPE,DESCRIPTION) values ('EPOSTFAKTURA_SOC_CHESS',      'CHEPOFAK',    'STRING',  'The name of the BAN-level Soc representing the Epost Faktura service for Chess.');
Insert into SYSTEM_DEFAULTS (KEY,VALUE,VALUE_TYPE,DESCRIPTION) values ('EPOSTFAKTURA_USE_SOC',        'Y',           'STRING',  'If "Y", Ninja should add a BAN-level soc when registering the print-category "Invoice by Email"');

