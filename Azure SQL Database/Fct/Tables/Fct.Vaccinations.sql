CREATE TABLE [Fct].[Vaccinations]
(
	[VaccinationsKey] NVARCHAR(100) NOT NULL,
	[Country] VARCHAR(50) NOT NULL,
	[CountryCode] CHAR(3) NOT NULL,
	[Date] DATETIME NOT NULL,
	[TotalVaccinations] INT NOT NULL,
	[PeopleVaccinated] INT NOT NULL,
	[PeopleFullyVaccinated] INT NOT NULL,
	[TotalBoosters] INT NOT NULL,
	[DailyVaccinationsRaw] INT NOT NULL,
	[DailyVaccinations] INT NOT NULL,
	[TotalVaccinationsPerHundred] DECIMAL(6, 2) NOT NULL,
	[PeopleVaccinatedPerHundred] DECIMAL(6, 2) NOT NULL,
	[PeopleFullyVaccinatedPerHundred] DECIMAL(6, 2) NOT NULL,
	[TotalBustersPerHundred] DECIMAL(6, 2) NOT NULL,
	[DailyVaccinationsPerMillion] INT NOT NULL,
	[DailyPeopleVaccinated] INT NOT NULL,
	[DailyPeopleVaccinatedPerHundred] DECIMAL(4, 3) NOT NULL,
	[UpdatedDate] DATETIME NOT NULL CONSTRAINT DF_Stage_FctVaccinations_UpdatedDate DEFAULT (SYSUTCDATETIME())
)
