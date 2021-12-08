CREATE TABLE [Dim].[Country]
(
	[CountryId] INT NOT NULL PRIMARY KEY,
    [CountryCode] CHAR(3) NOT NULL, 
    [Country/Region] VARCHAR(50) NOT NULL,
    [RegionCode] INT NOT NULL,
    [SubRegionCode] INT NOT NULL,
    [IntermediateRegionCode] INT NOT NULL
)
