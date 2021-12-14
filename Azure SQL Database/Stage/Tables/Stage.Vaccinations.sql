CREATE TABLE [Stage].[Vaccinations]
(
	[VaccinationsId] INT IDENTITY(1, 1) NOT NULL,
	[VaccinationsKey] NVARCHAR(100) NOT NULL,
	[CountryCode] CHAR(3) NULL,
	[Date] DATETIME NULL,
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
	[LoadDate] DATETIME NOT NULL CONSTRAINT DF_Stage_Vaccinations_LoadDate DEFAULT (SYSUTCDATETIME())
)
