USE [SNTBROKER_SIE_V3]
GO

/****** Object:  Table [dbo].[ALERTAS_V2]    Script Date: 22/02/2021 17:31:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[COTIZACIONES_DIARIAS_TEMP_V3](
 [IDEMPRESA] [smallint] NOT NULL,
 [FECHA] [smalldatetime] NOT NULL,
 [ULT] [float] (10) NOT NULL
) ON [PRIMARY]
GO

INSERT INTO [SNTBROKER_SIE_V3].[dbo].[COTIZACIONES_DIARIAS_TEMP_V3]
select
 convert(smallint, IDEMPRESA) as IDEMPRESA,
 convert(smalldatetime, CONCAT(ANNIO,'-',MES,'-',DIA)) as FECHA,
 convert(float(10), ULT) as ULT
from [SNTBROKER_SIE].[dbo].[COTIZACIONES_DIARIAS_TEMP_V2]