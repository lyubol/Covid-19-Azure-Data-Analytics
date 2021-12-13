CREATE VIEW [Dimension].[Country]
	AS 

	SELECT 
		[CountryId],
		[Continent],
		[Country],
		[CountryCode],
		[Population],
		[PopulationDensity],
		[MedianAge],
		[HumanDevelopmentIndex],
		[LifeExpectancy],
		[Aged65Older],
		[Aged70Older]
	FROM 
		[Dim].[Country]

