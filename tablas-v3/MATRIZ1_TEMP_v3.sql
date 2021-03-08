USE [SNTBROKER_SIE_V3]
GO

/****** Object:  Table [dbo].[MATRIZ1_TEMP_v2]    Script Date: 22/02/2021 17:55:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MATRIZ1_TEMP_v3](
	[MATRIZ1] [char](78) NOT NULL
) ON [PRIMARY]
GO

insert into [dbo].[MATRIZ1_TEMP_v3]
select
	convert(char(78),MATRIZ1) as MATRIZ1
from [SNTBROKER_SIE].[dbo].[MATRIZ1_TEMP_v2]
