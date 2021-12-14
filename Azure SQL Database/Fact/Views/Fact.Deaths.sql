CREATE VIEW [Fact].[Deaths]
AS 
	
SELECT 
	[DeathsKey],
	[CountryCode],
	[Date],
	[Value],
	[UpdatedDate],
    ROW_NUMBER() OVER(ORDER BY [CountryCode] ASC, [Date] DESC) AS [OrderId]
FROM 
	[Fct].[Deaths]
