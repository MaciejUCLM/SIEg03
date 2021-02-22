USE [SNTBROKERv2]
GO

/****** Object:  Table [dbo].[SECTORES_v2]    Script Date: 22/02/2021 17:57:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SECTORES_v3](
	[IdSector] [int] NOT NULL PRIMARY KEY,
	[Sector] [nvarchar](40) NOT NULL
) ON [PRIMARY]
GO

insert into [dbo].[SECTORES_v3]
select
	convert(int,IdSector) as IdSector,
	convert(nvarchar(40),Sector) as Sector
from [SNTBROKER_SIE].[dbo].[SECTORES_v2];
