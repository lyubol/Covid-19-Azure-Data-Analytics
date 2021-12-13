CREATE TABLE [Fct].[Vaccinations]
(
	[VaccinationsKey] NVARCHAR(100) NOT NULL,
	[Country] VARCHAR(50) NOT NULL,
	[CountryCode] CHAR(3) NOT NULL,
	[Date] DATETIME NOT NULL,
	[TotalVaccinations] INT NULL,
	[PeopleVaccinated] INT NULL,
	[PeopleFullyVaccinated] INT NULL,
	[TotalBoosters] INT NULL,
	[DailyVaccinationsRaw] INT NULL,
	[DailyVaccinations] INT NULL,
	[TotalVaccinationsPerHundred] DECIMAL(7, 3) NULL,
	[PeopleVaccinatedPerHundred] DECIMAL(7, 3) NULL,
	[PeopleFullyVaccinatedPerHundred] DECIMAL(7, 3) NULL,
	[TotalBustersPerHundred] DECIMAL(7, 3) NULL,
	[DailyVaccinationsPerMillion] INT NULL,
	[DailyPeopleVaccinated] INT NULL,
	[DailyPeopleVaccinatedPerHundred] DECIMAL(6, 4) NULL,
	[UpdatedDate] DATETIME NOT NULL CONSTRAINT DF_Stage_FctVaccinations_UpdatedDate DEFAULT (SYSUTCDATETIME())
)
