--Getting the variance between modified tables
--Enabling the server for data access
EXECsp_serveroption'ghoniem', 'DATA ACCESS',TRUE


Select * from
account EXCEPT (select *
fromopenquery ([netdev\sql2012], 'Select * from koudjis.dbo.account'))
