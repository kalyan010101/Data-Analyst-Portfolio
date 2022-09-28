/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [NAICS_Industry_Description]
      ,[LookupCodes]
      ,[Sector]
  FROM [PortfolioDB].[dbo].[sba_naics_sector_codes_description]
---------------------------------------------------------------------------
  insert into [dbo].[sba_naics_sector_codes_description]
  values
  ('Sector 31 – 33 – Manufacturing', 32, 'Manufacturing'),
  ('Sector 31 – 33 – Manufacturing', 33, 'Manufacturing'),
  ('Sector 44 – 45 – Manufacturing', 45, 'Manufacturing'),
  ('Sector 48 - 49 – Transportation and Warehousing', 49, 'Transportation and Warehousing')

  --------------------------------------------------------------------------------

update [dbo].[sba_naics_sector_codes_description]
set Sector = 'Manufacturing'
where LookupCodes = 31

----------------------------------------------------------------------------------

SELECT TOP (1000) [NAICS_Industry_Description]
      ,[LookupCodes]
      ,[Sector]
  FROM [PortfolioDB].[dbo].[sba_naics_sector_codes_description]
  order by LookupCodes