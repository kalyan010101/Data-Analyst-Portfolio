select *
	into sba_naics_sector_codes_description
from(
	 SELECT  
     [NAICS_Industry_Description],
	 IIF([NAICS_Industry_Description] like '%�%',SUBSTRING ([NAICS_Industry_Description], 8, 2), '') LookupCodes,
	 IIF([NAICS_Industry_Description] like '%�%',ltrim(SUBSTRING ([NAICS_Industry_Description], CHARINDEX('�',[NAICS_Industry_Description]) + 1, LEN ([NAICS_Industry_Description]))), '') Sector
	FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] = ''
  )main
  where 
		LookupCodes!=''


-------------------------------------------------------------------------------------------------------------------------------

create view ppp_main as

SELECT 
	d.Sector,  
	year(DateApproved) year_approved,
	month(DateApproved) month_Approved,
	OriginatingLender, 	
	BorrowerState,
	Race,
	Gender,
	Ethnicity,

	count(LoanNumber) Number_of_Approved,

	sum(CurrentApprovalAmount) Current_Approved_Amount,
	avg (CurrentApprovalAmount) Current_Average_loan_size,
	sum(ForgivenessAmount) Amount_Forgiven,


	sum(InitialApprovalAmount) Approved_Amount,
	avg (InitialApprovalAmount) Average_loan_size

FROM 
	[PortfolioDB].[dbo].[sba_public_data] p
	inner join [dbo].[sba_naics_sector_codes_description] d
		on left(p.NAICSCode, 2) = d.LookupCodes
group by 
	d.Sector,  
	year(DateApproved),
	month(DateApproved),
	OriginatingLender, 	
	BorrowerState,
	Race,
	Gender,
	Ethnicity