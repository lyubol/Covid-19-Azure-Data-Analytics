CREATE TABLE [Stage].[Vaccinations]
(
	[VaccinationsId] INT IDENTITY(1, 1) NOT NULL,
	[VaccinationsKey] NVARCHAR(100) NOT NULL,
	[Country] VARCHAR(50) NULL,
	[CountryCode] CHAR(3) NULL,
	[Date] DATETIME NULL,
	[TotalVaccinations] INT NULL,
	[PeopleVaccinated] INT NULL,
	[PeopleFullyVaccinated] INT NULL,
	[TotalBoosters] INT NULL,
	[DailyVaccinationsRaw] INT NULL,
	[DailyVaccinations] INT NULL,
	[TotalVaccinationsPerHundred] DECIMAL(6, 2) NULL,
	[PeopleVaccinatedPerHundred] DECIMAL(6, 2) NULL,
	[PeopleFullyVaccinatedPerHundred] DECIMAL(6, 2) NULL,
	[TotalBustersPerHundred] DECIMAL(6, 2) NULL,
	[DailyVaccinationsPerMillion] INT NULL,
	[DailyPeopleVaccinated] INT NULL,
	[DailyPeopleVaccinatedPerHundred] DECIMAL(4, 3) NULL,
	[LoadDate] DATETIME NOT NULL CONSTRAINT DF_Stage_Vaccinations_LoadDate DEFAULT (SYSUTCDATETIME())
)
