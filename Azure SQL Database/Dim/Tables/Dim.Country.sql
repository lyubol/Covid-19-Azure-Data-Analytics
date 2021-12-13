CREATE TABLE [Dim].[Country]
(
	[CountryId] INT NOT NULL,
	[Continent] VARCHAR(50) NULL,
	[Country] VARCHAR(50) NULL,
	[CountryCode] CHAR(3) NULL,
	[Population] INT NULL,
	[PopulationDensity] DECIMAL(8, 3) NULL,
	[MedianAge] DECIMAL(3, 1) NULL,
	[HumanDevelopmentIndex] DECIMAL(4, 3) NULL,
	[LifeExpectancy] DECIMAL(4, 2) NULL,
	[Aged65Older] DECIMAL(5, 3) NULL,
	[Aged70Older] DECIMAL(5, 3) NULL,
)