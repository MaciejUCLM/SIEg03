USE [SNTBROKER_SIE_V3]
GO

/****** Object:  Table [dbo].[ALERTAS_V2]    Script Date: 22/02/2021 17:31:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ALERTAS_V3](
	[ALERTA] [nvarchar](110) NOT NULL,
	[FECHA] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO

INSERT INTO [dbo].[ALERTAS_V3]
select
	convert(nvarchar(110),alerta) as alerta,
	convert(smalldatetime,fecha) as fecha
from [SNTBROKER_SIE].[dbo].[ALERTAS_V2];
