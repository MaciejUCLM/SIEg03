USE [SNTBROKERv2]
GO

/****** Object:  Table [dbo].[MERCADOS_V2]    Script Date: 22/02/2021 17:55:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MERCADOS_V3](
	[IdMercado] [char](500) NULL,
	[Mercado] [char](500) NULL,
	[HoraLocalInicio] [char](500) NULL,
	[HoraLocalCierre] [char](500) NULL,
	[HoraEspInicio] [char](500) NULL,
	[HoraEspCierre] [char](500) NULL,
	[HoraLimite] [char](500) NULL,
	[HoraInicioEjec] [char](500) NULL,
	[HoraFinEjec] [char](500) NULL,
	[IntervaloEjec] [char](500) NULL
) ON [PRIMARY]
GO

insert into [dbo].[MERCADOS_V3]
select
