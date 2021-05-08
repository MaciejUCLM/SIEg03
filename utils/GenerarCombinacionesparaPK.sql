USE [SNTBROKER_SIE]
GO

/****** Object:  StoredProcedure [dbo].[CombinacionesPK_GT00_V1]    Script Date: 25/03/2020 9:33:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CombinacionesPK_GT00_V1] (@NombreTabla nvarchar(50))
AS
BEGIN
declare @NColumnas int, @LongActual int
declare @Columnas nvarchar(4000)

create table #ColumnasIniciales (Columnas nvarchar(4000), IdentificadorOriginal int, Longitud int, id int identity(1,1))
create table #ColumnasFinales (Columnas nvarchar(4000), IdentificadorOriginal int, Longitud int, id int identity(1,1))

select @LongActual = 1

select @NColumnas = count(*) 
from sys.tables a, sys.columns b, sys.schemas c 
where 
	a.object_id=b.object_id 
	and a.schema_id=c.schema_id
	and type='U' 
	and a.name not in ('dtproperties','sysdiagrams')
	and a.name = @NombreTabla

insert #ColumnasIniciales 
select '('+b.name+')', b.column_id, @LongActual
from sys.tables a, sys.columns b, sys.schemas c 
where 
	a.object_id=b.object_id 
	and a.schema_id=c.schema_id
	and type='U' 
	and a.name not in ('dtproperties','sysdiagrams')
	and a.name = 'COTIZACIONES_V3'
order by b.column_id asc

insert #ColumnasFinales  (Columnas, IdentificadorOriginal, Longitud) select Columnas, IdentificadorOriginal, Longitud from #ColumnasIniciales

WHILE @LongActual < @NColumnas  
BEGIN  

	insert into #ColumnasFinales
	select a.Columnas+' , '+b.Columnas, a.IdentificadorOriginal, @LongActual+1 from #ColumnasIniciales a, #ColumnasFinales b
	where 
		b.Columnas not like '%'+a.Columnas+'%' 
		and b.Longitud=@LongActual 
		and b.IdentificadorOriginal>a.IdentificadorOriginal
	order by a.id, b.id
	
	Select @LongActual=@LongActual+1
	If (@LongActual > @NColumnas)
		Break
	Else
		Continue
END  

select replace(replace(columnas,'(','['),')',']') as CombinacionesPK from #ColumnasFinales

drop table #ColumnasIniciales
drop table #ColumnasFinales
END
GO

/****** Object:  StoredProcedure [dbo].[CombinacionesPK_GT00_V3]    Script Date: 25/03/2020 9:33:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CombinacionesPK_GT00_V3] (@NombreTabla nvarchar(50))
AS
BEGIN

WITH Columnas AS (
		SELECT convert(nvarchar(4000), '['+b.NAME+']') as Columna, b.column_id
		FROM sys.tables A, sys.columns B 
		where 
		a.object_id = b.object_id
		and a.type = 'U'
		and a.name = 'COTIZACIONES_V3' 
	),
Recur(Columna,Combination, column_id) AS (
	SELECT Columna, Columna, column_id
	FROM Columnas

	UNION ALL
	SELECT c.Columna, r.Combination + ',' + c.Columna, c.column_id
	FROM Recur r
	INNER JOIN Columnas c ON c.column_id > r.column_id
	)

SELECT Combination
FROM Recur

END
GO



