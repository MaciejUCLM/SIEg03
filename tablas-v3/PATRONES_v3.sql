USE [SNTBROKERv2]
GO

/****** Object:  Table [dbo].[PATRONES_v2]    Script Date: 22/02/2021 17:57:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PATRONES_v3](
	[IdPatron] [nvarchar](15) NOT NULL
) ON [PRIMARY]
GO

insert into [dbo].[PATRONES_v3]
select
	convert(nvarchar(15),IdPatron) as IdPatron
from [SNTBROKER_SIE].[dbo].[PATRONES_v2];
