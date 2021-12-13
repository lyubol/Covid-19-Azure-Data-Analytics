CREATE TABLE [Dim].[Country]
(
	[CountryId] INT NOT NULL,
	[Continent] VARCHAR(50) NOT NULL,
	[Country] VARCHAR(50) NOT NULL,
	[CountryCode] CHAR(3) NOT NULL,
	[Population] INT NULL,
	[PopulationDensity] DECIMAL(8, 3) NULL,
	[MedianAge] DECIMAL(3, 1) NULL,
	[HumanDevelopmentIndex] DECIMAL(4, 3) NULL,
	[LifeExpectancy] DECIMAL(4, 2) NULL,
	[Aged65Older] DECIMAL(5, 3) NULL,
	[Aged70Older] DECIMAL(5, 3) NULL,
	CONSTRAINT PK_Dim_Country PRIMARY KEY (CountryCode),
	CONSTRAINT UQ_Dim_Country UNIQUE (Country)
)