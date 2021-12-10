CREATE VIEW [Fact].[Deaths]
AS 
	
SELECT 
	[DeathsKey],
	[Country/Region],
	[Date],
	[Value],
	[UpdatedDate],
    ROW_NUMBER() OVER(ORDER BY [Country/Region] ASC, [Date] DESC) AS [OrderId]
FROM 
	[Fct].[Deaths]
