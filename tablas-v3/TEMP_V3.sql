USE [SNTBROKER_SIE_V3]
GO

/****** Object:  Table [dbo].[TEMP_V2]    Script Date: 24/02/2021 20:42:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TEMP_V3](
	[MATRIZ1] [char](78) NOT NULL
) ON [PRIMARY]
GO


INSERT INTO [dbo].[TEMP_V3]
select
	convert(char(78), MATRIZ1) as MATRIZ1
from [SNTBROKER_SIE].[dbo].[TEMP_V2]