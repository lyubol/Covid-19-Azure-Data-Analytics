CREATE PROCEDURE [Stage].[StageToFctDeaths]
AS

BEGIN

	MERGE INTO [Fct].[Deaths] AS TGT
	USING 
		[Stage].[StageToFctDeaths] AS SRC
		ON TGT.[DeathsKey] = SRC.[DeathsKey]

	WHEN MATCHED THEN
		UPDATE 
		SET
			[DeathsKey]			= SRC.[DeathsKey],
			[Country/Region]	= SRC.[Country/Region],
			[Date]				= SRC.[Date],
			[Value]				= SRC.[Value],
			[UpdatedDate]		= SYSUTCDATETIME()

	WHEN NOT MATCHED BY TARGET THEN 
		INSERT
			(
				[DeathsKey],
				[Country/Region],
				[Date],
				[Value],
				[UpdatedDate]
			)
		VALUES
			(
				SRC.[DeathsKey],
				SRC.[Country/Region],
				SRC.[Date],
				SRC.[Value],
				SYSUTCDATETIME()
			);

	SELECT @@ROWCOUNT;

END
