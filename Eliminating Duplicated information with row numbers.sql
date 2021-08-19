-- Due to NDAs signed I can't put the exact code up
-- ill be replacing table names and such with aliases
-- This stored proc was used to insurance providers names from a HIPAA compliant system.
-- Use case: client asked for insurance providers with duped bin, pcn, and group values to be removed
-- from the UI.

;with cte_insurance_providers (BIN, PCN, [GROUP], locID, insruanceProviderID) as (
	SELECT  NULLIF(LTRIM(RTRIM(BIN)),'') BIN, 
			NULLIF(LTRIM(RTRIM(PCN)),'') PCN, 
			NULLIF(LTRIM(RTRIM([GROUP])),'') [GROUP],
			locID, 
			insruanceProviderID
	FROM dbo.InsuranceProviders	IP 
			LEFT OUTER JOIN InsuranceProviderTypes AS IPT ON IP.insruanceProviderTypeID = IPT.insruanceProviderTypeID
),
cte_partitioning_insurance_providers_by_info (BIN, PCN, [GROUP], locID, insruanceProviderID, row_num) as (
	SELECT 		
		BIN, 
		PCN, 
		[Group], 
		locID,
		insruanceProviderID,
		-- calling row_number on any rows that have the same bin pcn and group
		-- so that we can select the top row_num for later
		ROW_NUMBER() OVER (PARTITION BY BIN, PCN, [GROUP] ORDER BY BIN, PCN, [GROUP])
	FROM cte_insurance_providers
	WHERE 
		-- this coalesce will remove any rows that are completely null without having to use a case when
		COALESCE (BIN, PCN, [Group]) IS NOT NULL
)

SELECT 
	DISTINCT 
	BIN, 
	PCN, 
	[Group],
	row_num,
	insruanceProviderID
FROM cte_partitioning_insurance_providers_by_info
WHERE row_num = 1
GROUP BY 
	BIN, PCN, [Group], insruanceProviderID, row_num
ORDER BY 
	BIN, PCN, [Group], row_num, insruanceProviderID
