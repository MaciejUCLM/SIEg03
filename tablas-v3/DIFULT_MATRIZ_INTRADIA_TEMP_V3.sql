USE [SNTBROKER_SIE_V3]
GO

/****** Object:  Table [dbo].[DIFULT_MATRIZ_INTRADIA_TEMP_V2]    Script Date: 26/02/2021 12:47:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DIFULT_MATRIZ_INTRADIA_TEMP_V3](
	[IDMERCADO] [smallint] NOT NULL,
	[IDEMPRESA] [smallint] NOT NULL,
	[CLAVE] [nvarchar](10) NOT NULL,
	[FECHA] [smalldatetime] NOT NULL,
	[MATRIZ1] [nvarchar](80) NOT NULL,
	[MATRIZ2] [nvarchar](70) NOT NULL
) ON [PRIMARY]
GO

INSERT INTO [SNTBROKER_SIE_V3].[dbo].[DIFULT_MATRIZ_INTRADIA_TEMP_V3]
select
 convert(smallint, IDMERCADO) as IDMERCADO,
 convert(smallint, IDEMPRESA)  as IDEMPRESA,
 convert(nvarchar(10), CLAVE)  as CLAVE,
 convert(smalldatetime, CONCAT(ANNIO,'-',MES,'-',DIA)) as FECHA,
 convert(nvarchar(80), MATRIZ1) as MATRIZ1,
 convert(nvarchar(70), MATRIZ2)  as MATRIZ2
from [SNTBROKER_SIE].[dbo].[DIFULT_MATRIZ_INTRADIA_TEMP_V2]