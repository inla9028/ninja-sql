SELECT a.ban, b.account_type, b.account_sub_type, RTRIM(a.soc) AS "SOC", COUNT(*) AS "COUNT"
  FROM dd.service_agreement a, dd.billing_account b
  WHERE RTRIM(a.soc) = 'DATAVMA'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND a.ban = b.ban(+)
  GROUP BY a.ban, b.account_type, b.account_sub_type, RTRIM(a.soc)
  ORDER BY a.ban, b.account_type, b.account_sub_type, "SOC"
;

SELECT RTRIM(a.soc) AS "SOC", b.account_type, b.account_sub_type, COUNT(*) AS "COUNT"
  FROM dd.service_agreement a, dd.billing_account b
  WHERE RTRIM(a.soc) = 'PSFO'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND a.ban = b.ban(+)
  GROUP BY RTRIM(a.soc), b.account_type, b.account_sub_type
  ORDER BY "SOC", b.account_type, b.account_sub_type
;

--== List an overview of the number of different BAN-types that have these socs...
SELECT RTRIM(a.soc) AS "SOC", b.account_type, b.account_sub_type, COUNT(*) AS "COUNT"
  FROM dd.service_agreement a, dd.billing_account b
  WHERE RTRIM(a.soc) IN ('PPOB', 'PPTB', 'PQPTB')
    AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
    AND a.ban         = b.ban(+)
  GROUP BY RTRIM(a.soc), b.account_type, b.account_sub_type
  ORDER BY "SOC", b.account_type, b.account_sub_type
;
-- IN ('CANADAT96', 'CANAISD96', 'CFRADAT12', 'CFRADAT24', 'CFRADAT96', 'CFRAISD96', 'CFUBDAT96', 'CFUBISD96', 'CNETDAT96', 'CNETISD96', 'CNHEDAT12', 'CNHEDAT24', 'CNHEDAT96', 'CNHEISD96', 'CSKADAT96', 'CSKAISD96', 'CSKBDAT24', 'CSKBDAT96', 'CSKBISD96', 'CSKCDAT12', 'CSKCDAT24', 'CSKCDAT96', 'CSKCISD96', 'CSKEDAT12', 'CSKEDAT96', 'CSKEISD96', 'CSKFDAT96', 'CSKFISD96', 'CSTDDAT12', 'CSTDDAT48', 'CSTDDAT96', 'CSTDISD96', 'CSTODAT24', 'CSTODAT96', 'CSTOISD96', 'CTRMDAT96', 'CTRMISD96', 'DATA01', 'DATA1200', 'DATA2400', 'DATA4800', 'DATAFRA', 'DATAFREE', 'DATAFRI', 'DATAHS', 'DATAHSVS', 'DATAKAN', 'DATANET', 'DATANHE', 'DATASKA', 'DATASKB', 'DATASKC', 'DATASKE', 'DATASKF', 'DATASKT', 'DATASTD', 'DATASTO', 'DATAVAH', 'DATAVAL', 'DATAVAX', 'DATAVBH', 'DATAVCH', 'DATAVCL', 'DATAVCM', 'DATAVDH', 'DATAVEH', 'DATAVFH', 'DATAVFHA', 'DATAVFT', 'DATAVGH', 'DATAVGL', 'DATAVHH', 'DATAVKH', 'DATAVMA', 'DATAVMI', 'DATAVNH', 'DATAVNL', 'DATAVPH', 'DATAVPL', 'DATAVQH', 'DATAVRH', 'DATAVRL', 'DATAVSH', 'DATAVSL', 'DATAVSM', 'DATAVTH', 'DATAVUH', 'DATAVVH', 'DATAVWH', 'DATAVXH', 'DATAVYH', 'DATAVZH', 'DATFRISKB', 'FAX01', 'FAXANA', 'FAXFRA', 'FAXFREE', 'FAXFRI', 'FAXFRISKB', 'FAXFUB', 'FAXNET', 'FAXNHE', 'FAXSFA', 'FAXSKA', 'FAXSKB', 'FAXSKC', 'FAXSKE', 'FAXSKF', 'FAXSTD', 'FAXSTO', 'FAXVAH', 'FAXVAL', 'FAXVAX', 'FAXVBH', 'FAXVCH', 'FAXVCL', 'FAXVCM', 'FAXVDH', 'FAXVEH', 'FAXVFH', 'FAXVGH', 'FAXVGL', 'FAXVHH', 'FAXVJH', 'FAXVKH', 'FAXVNH', 'FAXVNL', 'FAXVPH', 'FAXVPL', 'FAXVQH', 'FAXVRH', 'FAXVRL', 'FAXVSH', 'FAXVSL', 'FAXVSM', 'FAXVTH', 'FAXVUH', 'FAXVVH', 'FAXVWH', 'FAXVXH', 'FAXVYH', 'FAXVZH', 'MCENTHUNT', 'MCENTQUE', 'PFUK', 'PPDA', 'PPDB', 'PPDC', 'PSCA', 'PSCB', 'PSCC', 'PSCD', 'PSCE', 'PSDA', 'PSDB', 'PSDN', 'PSDO', 'PSDP', 'PSDQ', 'PSDR', 'PSDS', 'PSDU', 'PSDX', 'PSUD', 'PTMB', 'PTMC', 'PTMD', 'PVMD', 'PVMS', 'TSIMA', 'TSIMAF', 'TSIMAVS', 'TSIMB', 'TSIMBF', 'TSIMBVS', 'VMBED', 'VMFAST', 'VMFRA', 'VMFRA+', 'VMFREE', 'VMFREE+', 'VMFRO', 'VMKAMP01', 'VMKAMP01+', 'VMKAMP01P', 'VMKON', 'VMORG', 'VMORG+', 'VMORGF', 'VMPOST01', 'VMPOSTF01', 'VMPRIV', 'VMPRIV+', 'VMPRIVF', 'VMPRIVFR', 'VMSDIV', 'VMSDIV+', 'VMSDIV01', 'VMSDIV02', 'VMSDIV03', 'VMSDIVP01', 'VMSP+', 'VMSTD', 'VMSTD+', 'VMSTO', 'VMSTO+', 'VMVS', 'VMVS+', 'VMVSP', 'VMVSP+', 'VMVSVAP', 'VMVSVCP', 'VMVSVFP', 'VMVSVGP', 'VMVSVHG', 'VMVSVHP', 'VMVSVOK', 'VMVSVOP', 'VMVSVSK', 'VMVSVSN', 'VMVSVSP')
