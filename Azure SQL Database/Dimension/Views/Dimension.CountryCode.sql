CREATE VIEW [Dimension].[CountryCode]
AS

SELECT
	[CountryId],
    [CountryCode],
    [Country/Region],
    [RegionCode],
    [SubRegionCode],
    [IntermediateRegionCode]
FROM
    [Dim].[CountryCode]