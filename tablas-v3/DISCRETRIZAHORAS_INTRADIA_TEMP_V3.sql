USE [SNTBROKER_SIE_V3]
GO

/****** Object:  Table [dbo].[DISCRETRIZAHORAS_INTRADIA_TEMP_v2]    Script Date: 26/02/2021 12:47:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DISCRETRIZAHORAS_INTRADIA_TEMP_V3](
	[IDMERCADO] [smallint] NOT NULL,
	[IDEMPRESA] [smallint] NOT NULL,
	[CLAVE] [nvarchar](10) NOT NULL,

	[ANNIO] [smallint] NOT NULL,
	[MES] [tinyint] NOT NULL,
	[DIA] [tinyint] NOT NULL,
	[HORA] [nvarchar](5) NOT NULL,

	[ULT] [float](15) NOT NULL,
	[DIF] [float](15) NOT NULL,
	[PDIF] [float](15) NOT NULL,

	[MAXIMO] [float](15) NOT NULL,
	[MINIMO] [float](15) NOT NULL,
	[VOL] [int] NOT NULL
) ON [PRIMARY]
GO

INSERT INTO [SNTBROKER_SIE_V3].[dbo].[DISCRETRIZAHORAS_INTRADIA_TEMP_V3]
select
 convert(smallint, IDMERCADO) as IDMERCADO,
 convert(smallint, IDEMPRESA)  as IDEMPRESA,
 convert(nvarchar(10), CLAVE)  as CLAVE,

 convert(smallint, ANNIO) as ANNIO,
 convert(tinyint, MES)  as MES,
 convert(tinyint, DIA)  as DIA,
 convert(nvarchar(5), HORA) as HORA,

 convert(float(15), ULT)  as ULT,
 convert(float(15), DIF)  as DIF,
 convert(float(15), PDIF) as PDIF,

 convert(float(15), MAXIMO)  as MAXIMO,
 convert(float(15), MINIMO)  as MINIMO,
 convert(int, VOL) as VOL
from [SNTBROKER_SIE].[dbo].[DISCRETRIZAHORAS_INTRADIA_TEMP_v2]

