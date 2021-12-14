CREATE VIEW [Fact].[Cases]
AS 
	
SELECT 
	[CasesKey],
	[CountryCode],
	[Date],
	[Value],
	[UpdatedDate],
    ROW_NUMBER() OVER(ORDER BY [CountryCode] ASC, [Date] DESC) AS [OrderId]
FROM 
	[Fct].[Cases]
