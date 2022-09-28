/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [LoanNumber]
      ,[DateApproved]
      ,[SBAOfficeCode]
      ,[ProcessingMethod]
      ,[BorrowerName]
      ,[BorrowerAddress]
      ,[BorrowerCity]
      ,[BorrowerState]
      ,[BorrowerZip]
      ,[LoanStatusDate]
      ,[LoanStatus]
      ,[Term]
      ,[SBAGuarantyPercentage]
      ,[InitialApprovalAmount]
      ,[CurrentApprovalAmount]
      ,[UndisbursedAmount]
      ,[FranchiseName]
      ,[ServicingLenderLocationID]
      ,[ServicingLenderName]
      ,[ServicingLenderAddress]
      ,[ServicingLenderCity]
      ,[ServicingLenderState]
      ,[ServicingLenderZip]
      ,[RuralUrbanIndicator]
      ,[HubzoneIndicator]
      ,[LMIIndicator]
      ,[BusinessAgeDescription]
      ,[ProjectCity]
      ,[ProjectCountyName]
      ,[ProjectState]
      ,[ProjectZip]
      ,[CD]
      ,[JobsReported]
      ,[NAICSCode]
      ,[Race]
      ,[Ethnicity]
      ,[UTILITIES_PROCEED]
      ,[PAYROLL_PROCEED]
      ,[MORTGAGE_INTEREST_PROCEED]
      ,[RENT_PROCEED]
      ,[REFINANCE_EIDL_PROCEED]
      ,[HEALTH_CARE_PROCEED]
      ,[DEBT_INTEREST_PROCEED]
      ,[BusinessType]
      ,[OriginatingLenderLocationID]
      ,[OriginatingLender]
      ,[OriginatingLenderCity]
      ,[OriginatingLenderState]
      ,[Gender]
      ,[Veteran]
      ,[NonProfit]
      ,[ForgivenessAmount]
      ,[ForgivenessDate]
      ,[FileName]
  FROM [PortfolioDB].[dbo].[sba_public_data]



  ----What is the summary of all approved PPP Loans

select 
	count(LoanNumber) Number_of_Approved, 
	sum(InitialApprovalAmount) Approved_Amount,  -------------------------- Data Type Error Showing 
	avg(InitialApprovalAmount) Average_loan_size
	FROM [PortfolioDB].[dbo].[sba_public_data]

ALTER TABLE [dbo].[sba_public_data]
ALTER COLUMN [InitialApprovalAmount] FLOAT  --------------------------------- Alter the Data type
---------------------------------------------------------------------------
select 
	year(DateApproved) year_approved,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
where 
	year(DateApproved) = 2020
group by
	year(DateApproved)

union

select 
	year(DateApproved) year_approved,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
where 
	year(DateApproved) = 2021
group by
	year(DateApproved)

----------------------------------------------------------------------

select 
	count(distinct OriginatingLender) OriginatingLender,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
where 
	year(DateApproved) = 2020

union

select 
	count(distinct OriginatingLender) OriginatingLender,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
where 
	year(DateApproved) = 2021

---------------------------------------------------------------------------
select 
	count(distinct OriginatingLender) OriginatingLender,
	year(DateApproved) year_approved,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
where 
	year(DateApproved) = 2020
group by
	year(DateApproved)

union

select 
	count(distinct OriginatingLender) OriginatingLender,
	year(DateApproved) year_approved,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
where 
	year(DateApproved) = 2021
group by
	year(DateApproved)

------- Top 15 Originating  Lendes by loan count, total amount and average in 2020 abd 2021

select top 15
	OriginatingLender,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
where 
	year(DateApproved) = 2021
group by
	OriginatingLender
order by 3 desc
---------------------------
select top 15
	OriginatingLender,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
where 
	year(DateApproved) = 2020
group by
	OriginatingLender
order by 3 desc


------------ Top 20 Industries that received the PPP Loans in 2021 and 2020

select top 20 d.Sector,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data] p
	inner join [dbo].[sba_naics_sector_codes_description] d
	on left(p.NAICSCode, 2) = d.LookupCodes
where 
	year(DateApproved) = 2020
group by
	d.Sector
order by 3 desc

---------------------------------
select top 20 d.Sector,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data] p
	inner join [dbo].[sba_naics_sector_codes_description] d
	on left(p.NAICSCode, 2) = d.LookupCodes
where 
	year(DateApproved) = 2021
group by
	d.Sector
order by 3 desc

----------------------------------------
with cte as
(
select top 20 d.Sector,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data] p
	inner join [dbo].[sba_naics_sector_codes_description] d
	on left(p.NAICSCode, 2) = d.LookupCodes
where 
	year(DateApproved) = 2021
group by
	d.Sector
)
select Sector, Number_of_Approved, Approved_Amount, Average_loan_size,
Approved_Amount/sum(Approved_Amount) over() * 100 Percent_by_amount
from cte
order by Approved_Amount desc

----------------------------------------
with cte as
(
select top 20 d.Sector,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Approved_Amount,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data] p
	inner join [dbo].[sba_naics_sector_codes_description] d
	on left(p.NAICSCode, 2) = d.LookupCodes
where 
	year(DateApproved) = 2020
group by
	d.Sector
)
select Sector, Number_of_Approved, Approved_Amount, Average_loan_size,
Approved_Amount/sum(Approved_Amount) over() * 100 Percent_by_amount
from cte
order by Approved_Amount desc

------ How much of the PPP Loans  of 2021 have been fully forgiven
select
	count(LoanNumber) Number_of_Approved,
	sum(CurrentApprovalAmount) Current_Approval_Amount,
	avg(CurrentApprovalAmount) Current_Average_loan_size,
	sum(ForgivenessAmount) Amount_Forgiven,
	sum(ForgivenessAmount)/sum (CurrentApprovalAmount) * 100 as percent_Forgiven
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
where 
	year(DateApproved) = 2020
order by 3 desc
------------------------------------
select
	count(LoanNumber) Number_of_Approved,
	sum(CurrentApprovalAmount) Current_Approval_Amount,
	avg(CurrentApprovalAmount) Current_Average_loan_size,
	sum(ForgivenessAmount) Amount_Forgiven,
	sum(ForgivenessAmount)/sum (CurrentApprovalAmount) * 100 as percent_Forgiven
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
where 
	year(DateApproved) = 2021
order by 3 desc

------------------------------------------------

select
	count(LoanNumber) Number_of_Approved,
	sum(CurrentApprovalAmount) Current_Approval_Amount,
	avg(CurrentApprovalAmount) Current_Average_loan_size,
	sum(ForgivenessAmount) Amount_Forgiven,
	sum(ForgivenessAmount)/sum (CurrentApprovalAmount) * 100 as percent_Forgiven
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
----------------------------------------------------------------------------
ALTER TABLE [dbo].[sba_public_data]
ALTER COLUMN [CurrentApprovalAmount] FLOAT

ALTER TABLE [dbo].[sba_public_data]
ALTER COLUMN [ForgivenessAmount] FLOAT
-----------------------------------------------------------------------------

------ Year, Month with highest PPP loans apporved
select 
	year(DateApproved) Year_approved,
	month(DateApproved) Month_approved,
	count(LoanNumber) Number_of_Approved,
	sum(InitialApprovalAmount) Total_Net_Dollars,
	avg(InitialApprovalAmount) Average_loan_size
FROM 
	[PortfolioDB].[dbo].[sba_public_data]
group by
	year(DateApproved),
	month(DateApproved)
order by
	4 desc


------------------- Final OutCome----------------

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