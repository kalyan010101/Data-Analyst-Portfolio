/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  
      [NAICS_Industry_Description]
  FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''


  SELECT  
      [NAICS_Industry_Description],
	  SUBSTRING ([NAICS_Industry_Description], 8, 2) LookupCodes
  FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''

  SELECT  
     [NAICS_Industry_Description],
	 IIF([NAICS_Industry_Description] like '%-%',SUBSTRING ([NAICS_Industry_Description], 8, 2), '') LookupCodes
	FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''

   'Sector 11 – Agriculture, Forestry, Fishing and Hunting'
   
   SELECT  
     [NAICS_Industry_Description],
	 IIF([NAICS_Industry_Description] like '%–%',SUBSTRING ([NAICS_Industry_Description], 8, 2), '') LookupCodes
	FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''

   SELECT  
     [NAICS_Industry_Description],
	 IIF([NAICS_Industry_Description] like '%–%',SUBSTRING ([NAICS_Industry_Description], 8, 2), '') LookupCodes_if,
	 case when [NAICS_Industry_Description] like '%–%' then SUBSTRING ([NAICS_Industry_Description], 8, 2) end LookupCodes_case
	FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''

     
select *
from(
	 SELECT  
     [NAICS_Industry_Description],
	 IIF([NAICS_Industry_Description] like '%–%',SUBSTRING ([NAICS_Industry_Description], 8, 2), '') LookupCodes
	 --case when [NAICS_Industry_Description] like '%–%' then SUBSTRING ([NAICS_Industry_Description], 8, 2) end LookupCodes_case
	FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''
  )main
  where 
		LookupCodes!=''


select *
from(
	 SELECT  
     [NAICS_Industry_Description],
	 IIF([NAICS_Industry_Description] like '%–%',SUBSTRING ([NAICS_Industry_Description], 8, 2), '') LookupCodes,
	 SUBSTRING ([NAICS_Industry_Description], CHARINDEX('–',[NAICS_Industry_Description]) + 1, LEN ([NAICS_Industry_Description])) Sector
	FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''
  )main
  where 
		LookupCodes!=''



	select *
from(
	 SELECT  
     [NAICS_Industry_Description],
	 IIF([NAICS_Industry_Description] like '%–%',SUBSTRING ([NAICS_Industry_Description], 8, 2), '') LookupCodes,
	 IIF([NAICS_Industry_Description] like '%–%',SUBSTRING ([NAICS_Industry_Description], CHARINDEX('–',[NAICS_Industry_Description]) + 1, LEN ([NAICS_Industry_Description])), '') Sector
	FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''
  )main
  where 
		LookupCodes!=''

'Agriculture, Forestry, Fishing and Hunting'

	select *
from(
	 SELECT  
     [NAICS_Industry_Description],
	 IIF([NAICS_Industry_Description] like '%–%',SUBSTRING ([NAICS_Industry_Description], 8, 2), '') LookupCodes,
	 IIF([NAICS_Industry_Description] like '%–%',ltrim(SUBSTRING ([NAICS_Industry_Description], CHARINDEX('–',[NAICS_Industry_Description]) + 1, LEN ([NAICS_Industry_Description]))), '') Sector
	FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''
  )main
  where 
		LookupCodes!=''



select *
	into sba_naics_sector_codes_description
from(
	 SELECT  
     [NAICS_Industry_Description],
	 IIF([NAICS_Industry_Description] like '%–%',SUBSTRING ([NAICS_Industry_Description], 8, 2), '') LookupCodes,
	 IIF([NAICS_Industry_Description] like '%–%',ltrim(SUBSTRING ([NAICS_Industry_Description], CHARINDEX('–',[NAICS_Industry_Description]) + 1, LEN ([NAICS_Industry_Description]))), '') Sector
	FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''
  )main
  where 
		LookupCodes!=''