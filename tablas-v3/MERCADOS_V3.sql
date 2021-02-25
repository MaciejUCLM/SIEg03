USE [SNTBROKERv2]
GO

/****** Object:  Table [dbo].[MERCADOS_V2]    Script Date: 22/02/2021 17:55:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MERCADOS_V3](
	[IdMercado] [varchar](6) NOT NULL,
	[Mercado] [nvarchar](40) NOT NULL,
	[HoraLocalInicio] [varchar](5) NOT NULL,
	[HoraLocalCierre] [varchar](5) NOT NULL,
	[HoraEspInicio] [varchar](5) NOT NULL,
	[HoraEspCierre] [varchar](5) NOT NULL,
	[HoraLimite] [varchar](5) NOT NULL,
	[HoraInicioEjec] [varchar](5) NOT NULL,
	[HoraFinEjec] [varchar](5) NOT NULL,
	[IntervaloEjec] [int] NOT NULL
) ON [PRIMARY]
GO

insert into [dbo].[MERCADOS_V3]
select
	convert(varchar(6),IdMercado) as IdMercado,
	convert(nvarchar(40),Mercado) as Mercado,
	convert(varchar(5),HoraLocalInicio) as HoraLocalInicio,
	convert(varchar(5),HoraLocalCierre) as HoraLocalCierre,
	convert(varchar(5),HoraEspInicio) as HoraEspInicio,
	convert(varchar(5),HoraEspCierre) as HoraEspCierre,
	convert(varchar(5),HoraLimite) as HoraLimite,
	convert(varchar(5),HoraInicioEjec) as HoraInicioEjec,
	convert(varchar(5),HoraFinEjec) as HoraFinEjec,
	convert(int,IntervaloEjec) as IntervaloEjec
from [SNTBROKER_SIE].[dbo].[MERCADOS_V2];
