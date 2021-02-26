USE [SNTBROKER_SIE_V3]
GO

/****** Object:  Table [dbo].[COTIZACIONES_V2]    Script Date: 26/02/2021 12:11:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[COTIZACIONES_V3](
	[FECHA_MUESTRA] [smalldatetime] NOT NULL,
	[IdEmpresa] [smallint] NOT NULL,
	[FECHA] [nvarchar](5) NOT NULL, --valores no concluyentes? fechas tipo 27/03 y horas tipo 13:45 mezcladas
	[ULTIMO] [float](15) NOT NULL,
	[DIFERENCIA] [float](15) NOT NULL,
	[PORCDIF] [float](15) NOT NULL,
	[MAXIMO] [float](15) NOT NULL,
	[MINIMO] [float](15) NOT NULL,
	[VOLUMEN] [int] NOT NULL
) ON [PRIMARY]
GO

INSERT INTO [SNTBROKER_SIE_V3].[dbo].[COTIZACIONES_V3]
select
 convert(smalldatetime, FECHA_MUESTRA) as FECHA_MUESTRA,
 convert(smallint, IdEmpresa)  as IdEmpresa,
 convert(nvarchar(5), FECHA)  as FECHA,
 convert(float(15), ULTIMO) as ULTIMO,
 convert(float(15), DIFERENCIA) as DIFERENCIA,
 convert(float(15), PORCDIF) as PORCDIF,
 convert(float(15), MAXIMO)  as MAXIMO,
 convert(float(15), MINIMO)  as MINIMO,
 convert(int, VOLUMEN) as VOLUMEN
from [SNTBROKER_SIE].[dbo].[COTIZACIONES_V2]

-- SELECT * FROM COTIZACIONES_V3
