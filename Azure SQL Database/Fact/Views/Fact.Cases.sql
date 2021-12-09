CREATE VIEW [Fact].[Cases]
AS 
	
SELECT 
	[CasesKey],
	[Country/Region],
	[Date],
	[Value],
	[UpdatedDate]
FROM 
	[Fct].[Cases]
