USE [SNTBROKERv2]
GO

/****** Object:  Table [dbo].[EMPRESAS_V2]    Script Date: 22/02/2021 17:55:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EMPRESAS_V3](
	[IdEmpresa] [int] NOT NULL PRIMARY KEY,
	[Clave] [nvarchar](18) NOT NULL,
	[Isin] [char](12) NOT NULL,
	[Nombre] [nvarchar](35) NOT NULL,
	[IdMercado] [char](3) NOT NULL,
	[IdSector] [int] NULL,
	[FechaInsercion] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
-- IdSector FOREIGN KEY

set language spanish;
INSERT INTO [dbo].[EMPRESAS_V3]
select
	convert(int,IdEmpresa) as IdEmpresa,
	convert(nvarchar(18),Clave) as Clave,
	convert(char(12),Isin) as Isin,
	convert(nvarchar(35),Nombre) as Nombre,
	convert(char(3),IdMercado) as IdMercado,
	convert(int,IdSector) as IdSector,
	convert(smalldatetime,FechaInsercion) as FechaInsercion
from [SNTBROKER_SIE].[dbo].[EMPRESAS_V2];
