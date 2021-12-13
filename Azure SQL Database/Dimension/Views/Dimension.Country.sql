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
		[GdpPerCapita],
		[HumanDevelopmentIndex],
		[LifeExpectancy],
		[Aged65Older],
		[Aged70Older]
	FROM 
		[Dim].[Country]

