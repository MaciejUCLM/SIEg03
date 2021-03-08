USE [SNTBROKER_SIE_V3]
GO

/****** Object:  Table [dbo].[FiestasMercados_v2]    Script Date: 22/02/2021 17:55:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FiestasMercados_v3](
	[IdMercado] [varchar](6) NOT NULL,
	[Fecha] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO

set language spanish;
insert into [dbo].[FiestasMercados_v3]
select
	convert(varchar(6),IdMercado) as IdMercado,
	convert(smalldatetime,Fecha) as Fecha
from [SNTBROKER_SIE].[dbo].[FiestasMercados_v2]
