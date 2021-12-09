CREATE VIEW [Fact].[Deaths]
AS 
	
SELECT 
	[DeathsKey],
	[Country/Region],
	[Date],
	[Value],
	[UpdatedDate]
FROM 
	[Fct].[Deaths]
