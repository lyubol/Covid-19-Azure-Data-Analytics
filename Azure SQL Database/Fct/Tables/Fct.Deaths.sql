﻿CREATE TABLE [Fct].[Deaths]
(
	[DeathsKey]	NVARCHAR(100) NOT NULL,
	[Country/Region] VARCHAR(50) NOT NULL,
	[Date] DATE NOT NULL,
	[Value] INT NOT NULL,
	[UpdatedDate] DATETIME NOT NULL CONSTRAINT DF_Stage_FctDeaths_UpdatedDate DEFAULT (SYSUTCDATETIME())
)
