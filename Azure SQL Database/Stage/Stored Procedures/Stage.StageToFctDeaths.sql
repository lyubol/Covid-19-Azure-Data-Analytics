CREATE PROCEDURE [Stage].[StageToFctDeaths]
AS

BEGIN

	MERGE INTO [Fct].[Deaths] AS TGT
	USING 
		[Stage].[Deaths] AS SRC
		ON TGT.[DeathsKey] = SRC.[DeathsKey]

	WHEN MATCHED THEN
		UPDATE 
		SET
			[DeathsKey]			= SRC.[DeathsKey],
			[Country]			= SRC.[Country],
			[Date]				= SRC.[Date],
			[Value]				= SRC.[Value],
			[UpdatedDate]		= SYSUTCDATETIME()

	WHEN NOT MATCHED BY TARGET THEN 
		INSERT
			(
				[DeathsKey],
				[Country],
				[Date],
				[Value],
				[UpdatedDate]
			)
		VALUES
			(
				SRC.[DeathsKey],
				SRC.[Country],
				SRC.[Date],
				SRC.[Value],
				SYSUTCDATETIME()
			);

	SELECT @@ROWCOUNT;

END
