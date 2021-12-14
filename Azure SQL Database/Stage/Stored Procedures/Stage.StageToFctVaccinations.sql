CREATE PROCEDURE [Stage].[StageToFctVaccinations]
AS

BEGIN

	MERGE INTO [Fct].[Vaccinations] AS TGT
	USING 
		[Stage].[Vaccinations] AS SRC
		ON TGT.[VaccinationsKey] = SRC.[VaccinationsKey]

	WHEN MATCHED THEN
		UPDATE 
		SET
			[VaccinationsKey]					= SRC.[VaccinationsKey],
			[CountryCode]						= SRC.[CountryCode],
			[Date]								= SRC.[Date],
			[TotalVaccinations]					= SRC.[TotalVaccinations],
			[PeopleVaccinated]					= SRC.[PeopleVaccinated],
			[PeopleFullyVaccinated]				= SRC.[PeopleFullyVaccinated],
			[TotalBoosters]						= SRC.[TotalBoosters],
			[DailyVaccinationsRaw]				= SRC.[DailyVaccinationsRaw],
			[DailyVaccinations]					= SRC.[DailyVaccinations],
			[TotalVaccinationsPerHundred]		= SRC.[TotalVaccinationsPerHundred],
			[PeopleVaccinatedPerHundred]		= SRC.[PeopleVaccinatedPerHundred],
			[PeopleFullyVaccinatedPerHundred]	= SRC.[PeopleFullyVaccinatedPerHundred],
			[TotalBustersPerHundred]			= SRC.[TotalBustersPerHundred],
			[DailyVaccinationsPerMillion]		= SRC.[DailyVaccinationsPerMillion],
			[DailyPeopleVaccinated]				= SRC.[DailyPeopleVaccinated],
			[DailyPeopleVaccinatedPerHundred]	= SRC.[DailyPeopleVaccinatedPerHundred],
			[UpdatedDate]						= SYSUTCDATETIME()

	WHEN NOT MATCHED BY TARGET THEN 
		INSERT
			(
				[VaccinationsKey],
				[CountryCode],
				[Date],
				[TotalVaccinations],
				[PeopleVaccinated],
				[PeopleFullyVaccinated],
				[TotalBoosters],
				[DailyVaccinationsRaw],
				[DailyVaccinations],
				[TotalVaccinationsPerHundred],
				[PeopleVaccinatedPerHundred],
				[PeopleFullyVaccinatedPerHundred],
				[TotalBustersPerHundred],
				[DailyVaccinationsPerMillion],
				[DailyPeopleVaccinated],
				[DailyPeopleVaccinatedPerHundred],
				[UpdatedDate]
			)
		VALUES
			(
				SRC.[VaccinationsKey],
				SRC.[CountryCode],
				SRC.[Date],
				SRC.[TotalVaccinations],
				SRC.[PeopleVaccinated],
				SRC.[PeopleFullyVaccinated],
				SRC.[TotalBoosters],
				SRC.[DailyVaccinationsRaw],
				SRC.[DailyVaccinations],
				SRC.[TotalVaccinationsPerHundred],
				SRC.[PeopleVaccinatedPerHundred],
				SRC.[PeopleFullyVaccinatedPerHundred],
				SRC.[TotalBustersPerHundred],
				SRC.[DailyVaccinationsPerMillion],
				SRC.[DailyPeopleVaccinated],
				SRC.[DailyPeopleVaccinatedPerHundred],
				SYSUTCDATETIME()
			);

	SELECT @@ROWCOUNT;

END
