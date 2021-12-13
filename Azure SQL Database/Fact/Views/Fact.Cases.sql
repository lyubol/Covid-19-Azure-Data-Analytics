CREATE VIEW [Fact].[Cases]
AS 
	
SELECT 
	[CasesKey],
	[Country],
	[Date],
	[Value],
	[UpdatedDate],
    ROW_NUMBER() OVER(ORDER BY [Country] ASC, [Date] DESC) AS [OrderId]
FROM 
	[Fct].[Cases]
