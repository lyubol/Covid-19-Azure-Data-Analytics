CREATE VIEW [Fact].[Vaccinations]
	AS 

	SELECT
		[VaccinationsKey],
		[Country],
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
	FROM
		[Fct].[Vaccinations]