CREATE PROCEDURE [Stage].[StageToFctCases]
AS

BEGIN

	MERGE INTO [Fct].[Cases] AS TGT
	USING (
        SELECT 
            SC.*, 
            DC.[CountryCode] 
        FROM 
            Stage.Cases AS SC
            LEFT JOIN [Dim].[Country] AS DC
                ON SC.[Country] = DC.[Country]
        ) AS SRC
		ON TGT.[CasesKey] = SRC.[CasesKey]

	WHEN MATCHED THEN
		UPDATE 
		SET
			[CasesKey]			= SRC.[CasesKey],
			[CountryCode]		= SRC.[CountryCode],
			[Date]				= SRC.[Date],
			[Value]				= SRC.[Value],
			[UpdatedDate]		= SYSUTCDATETIME()

	WHEN NOT MATCHED BY TARGET THEN 
		INSERT
			(
				[CasesKey],
				[CountryCode],
				[Date],
				[Value],
				[UpdatedDate]
			)
		VALUES
			(
				SRC.[CasesKey],
				SRC.[CountryCode],
				SRC.[Date],
				SRC.[Value],
				SYSUTCDATETIME()
			);

	SELECT @@ROWCOUNT;

END

