﻿CREATE TABLE [Stage].[Cases]
(
	[CasesId] INT IDENTITY(1,1) NOT NULL,
	[CasesKey] NVARCHAR(100) NOT NULL,
	[Country/Region] VARCHAR(50) NULL,
	[Date] DATE NULL,
	[Value] INT NULL,
	[LoadDate] DATETIME NOT NULL CONSTRAINT DF_Stage_CountryDetailed_LoadDate DEFAULT (SYSUTCDATETIME())
)