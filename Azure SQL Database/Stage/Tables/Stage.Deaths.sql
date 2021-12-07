CREATE TABLE [Stage].[Deaths]
(
	[Key] NVARCHAR(100) NOT NULL PRIMARY KEY,
	[Province/State] VARCHAR(50) NULL,
	[Country/Region] VARCHAR(50) NULL,
	[Latitude] DECIMAL(11,8) NULL,
	[Longitude] DECIMAL(11,8) NULL,
	[Date] DATE NULL,
	[Value] INT NULL,
	[CountryCode] CHAR(3) NULL,
	[RegionCode] INT NULL,
	[SubRegionCode] INT NULL,
	[IntermediateRegionCode] INT NULL,
	[LoadDate] DATETIME NOT NULL CONSTRAINT DF_Stage_Deaths_LoadDate DEFAULT (SYSUTCDATETIME())
)