CREATE VIEW [Fact].[Deaths]
AS 
	
SELECT 
	[DeathsKey],
	[Country],
	[Date],
	[Value],
	[UpdatedDate],
    ROW_NUMBER() OVER(ORDER BY [Country] ASC, [Date] DESC) AS [OrderId]
FROM 
	[Fct].[Deaths]
