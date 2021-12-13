CREATE PROCEDURE [Stage].[StageToFctCases]
AS

BEGIN

	MERGE INTO [Fct].[Cases] AS TGT
	USING 
		[Stage].[Cases] AS SRC
		ON TGT.[CasesKey] = SRC.[CasesKey]

	WHEN MATCHED THEN
		UPDATE 
		SET
			[CasesKey]			= SRC.[CasesKey],
			[Country]			= SRC.[Country],
			[Date]				= SRC.[Date],
			[Value]				= SRC.[Value]

	WHEN NOT MATCHED BY TARGET THEN 
		INSERT
			(
				[CasesKey],
				[Country],
				[Date],
				[Value]
			)
		VALUES
			(
				SRC.[CasesKey],
				SRC.[Country],
				SRC.[Date],
				SRC.[Value]
			);

	SELECT @@ROWCOUNT;

END
