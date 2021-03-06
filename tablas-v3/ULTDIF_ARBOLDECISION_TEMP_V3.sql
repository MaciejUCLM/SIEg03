USE [SNTBROKER_SIE_V3]
GO

/****** Object:  Table [dbo].[ULTDIF_ARBOLDECISION_TEMP_v2]    Script Date: 24/02/2021 21:40:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ULTDIF_ARBOLDECISION_TEMP_v3](
	[IDEMPRESA] [smallint] NOT NULL,
	[CLAVE] [varchar](5) NOT NULL,
	[IDPATRON] [varchar](15) NOT NULL,
	[NUMERO] [smallint] NOT NULL
) ON [PRIMARY]
GO

INSERT INTO [dbo].[ULTDIF_ARBOLDECISION_TEMP_v3]
select
	convert(smallint, IDEMPRESA) AS IDEMPRESA,
	convert(varchar(5), CLAVE) AS CLAVE,
	convert(varchar(15), IDPATRON) AS IDPATRON,
	convert(smallint, convert(real, NUMERO)) AS NUMERO
from [SNTBROKER_SIE].[dbo].[ULTDIF_ARBOLDECISION_TEMP_v2]


