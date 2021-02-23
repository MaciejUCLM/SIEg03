USE [SNTBROKER_SIE_V3]
GO

/****** Object:  Table [dbo].[ACCIONESEEUU_V2]    Script Date: 22/02/2021 17:57:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ACCIONESEEUU_V3](
	[Sector] [nvarchar] (30) NOT NULL,
	[Simbolo] [nvarchar](10) NOT NULL,
	[Nombre] [nvarchar](20) NOT NULL
) ON [PRIMARY]
GO

insert into [dbo].[ACCIONESEEUU_V3]
select
	convert(nvarchar(30),Sector) as Sector,
	convert(nvarchar(10),Simbolo) as Simbolo,
	convert(nvarchar(20), Nombre) as Nombre
from [SNTBROKER_SIE].[dbo].[ACCIONESEEUU_V2];