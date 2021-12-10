CREATE VIEW [Fact].[Cases]
AS 
	
SELECT 
	[CasesKey],
	[Country/Region],
	[Date],
	[Value],
	[UpdatedDate],
    ROW_NUMBER() OVER(ORDER BY [Country/Region] ASC, [Date] DESC) AS [OrderId]
FROM 
	[Fct].[Cases]
