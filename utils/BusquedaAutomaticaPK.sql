select count(*) from ACCIONESEEUU_V3

select * from sys.columns

-- Fase 1: Detectar las PKs potenciales.
select count(*) from (
select DIFERENCIA, count(*) numero from COTIZACIONES_V3 group by DIFERENCIA having count(*)>1
) A

-- Fase 2: Listar todas las columnas de todas las tablas.
select 'select count(*) from (select '+b.name+', count(*) numero from '+a.name+' group by '+b.name+' having count(*)>1) A' 
from sys.tables a, sys.columns b 
where a.object_id=b.object_id 
and type='U' and a.name not in ('dtpropierties','sysdiagrams')

-- Fase 3: 
declare @TablaO nvarchar(250)
declare @ParmDefinition nvarchar(500) 
declare @totalOUT nvarchar(30), @Total_RegistrosO int

--Create table #Resultado (ColumnaPK varchar(250))

declare ColumnasOrigen cursor local fast_forward for 
		select 'select @total=count(*) from (select ['+b.name+'], count(*) numero from ['+c.name+'].['+a.name+'] group by ['+b.name+'] having count(*)>1) A' 
		from sys.tables a, sys.columns b, sys.schemas c 
		where 
			a.object_id=b.object_id 
			and a.schema_id=c.schema_id
			and type='U' 
			and a.name not in ('dtproperties','sysdiagrams')
--			and a.name not like ('%V2%')
open ColumnasOrigen
fetch next from ColumnasOrigen into @TablaO
while @@fetch_status = 0
begin

	SET @ParmDefinition = N'@total nvarchar(30) OUTPUT'; 
	exec sp_executesql @TablaO, @ParmDefinition, @total=@totalOUT OUTPUT
	
	if @totalOUT=0
	begin
		select @totalOUT, @TablaO
	end

	fetch next from ColumnasOrigen into @TablaO
end
close ColumnasOrigen
deallocate ColumnasOrigen

--select * from sys.tables
--select * from sys.schemas
--select @TablaO
/*
--	select @cadena='select @total=convert(nvarchar(30),count(*)) from ['+@TablaO+'] a where a.['+@ColumnaO+'] Is Not Null' 
--	select @cadena
	SET @ParmDefinition = N'@total nvarchar(30) OUTPUT'; 
--	select @TablaO
	exec sp_executesql @TablaO, @ParmDefinition, @total=@totalOUT OUTPUT
--	select @Total_RegistrosO=convert(int,@totalOUT)
--	select @totalOUT

	if @totalOUT='0' 
		begin
			insert into #Resultado values (@TablaO)
		end
	fetch next from ColumnasOrigen into @TablaO
end
close ColumnasOrigen
deallocate ColumnasOrigen
*/