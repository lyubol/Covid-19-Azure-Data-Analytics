CREATE PROCEDURE [Stage].[StageToFctDeaths]
AS

BEGIN

	MERGE INTO [Fct].[Deaths] AS TGT
	USING (
        SELECT 
            SD.*, 
            DC.[CountryCode] 
        FROM 
            [Stage].[Deaths] AS SD
            LEFT JOIN [Dim].[Country] AS DC
                ON SD.[Country] = DC.[Country]
        ) AS SRC
		ON TGT.[DeathsKey] = SRC.[DeathsKey]

	WHEN MATCHED THEN
		UPDATE 
		SET
			[DeathsKey]			= SRC.[DeathsKey],
			[CountryCode]		= SRC.[CountryCode],
			[Date]				= SRC.[Date],
			[Value]				= SRC.[Value],
			[UpdatedDate]		= SYSUTCDATETIME()

	WHEN NOT MATCHED BY TARGET THEN 
		INSERT
			(
				[DeathsKey],
				[CountryCode],
				[Date],
				[Value],
				[UpdatedDate]
			)
		VALUES
			(
				SRC.[DeathsKey],
				SRC.[CountryCode],
				SRC.[Date],
				SRC.[Value],
				SYSUTCDATETIME()
			);

	SELECT @@ROWCOUNT;

END

