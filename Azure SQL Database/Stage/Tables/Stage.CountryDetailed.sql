CREATE TABLE [Stage].[CountryDetailed]
(
	[CountryId] INT IDENTITY(1,1) NOT NULL,
	[Continent] VARCHAR(50) NULL,
	[Country] VARCHAR(50) NULL,
	[CountryCode] CHAR(3) NULL,
	[Population] INT NULL,
	[PopulationDensity] DECIMAL(10, 4) NULL,
	[MedianAge] DECIMAL(4, 2) NULL,
	[GdpPerCapita] DECIMAL(12, 4) NULL,
	[HumanDevelopmentIndex] DECIMAL(4, 3) NULL,
	[LifeExpectancy] DECIMAL(4, 2) NULL,
	[Aged65Older] DECIMAL(4, 3) NULL,
	[Aged70Older] DECIMAL(5, 3) NULL,
	[LoadDate] DATETIME NOT NULL CONSTRAINT DF_Stage_Cases_LoadDate DEFAULT (SYSUTCDATETIME())
)
