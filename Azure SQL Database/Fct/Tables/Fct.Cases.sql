﻿CREATE TABLE [Fct].[Cases]
(
	[CasesKey]	NVARCHAR(100) NOT NULL,
	[CountryCode] CHAR(3) NOT NULL,
	[Date] DATE NOT NULL,
	[Value] INT NOT NULL,
	[UpdatedDate] DATETIME NOT NULL CONSTRAINT DF_Stage_FctCases_UpdatedDate DEFAULT (SYSUTCDATETIME())
)