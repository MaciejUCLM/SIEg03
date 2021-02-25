/*
select * from syscolumns
select * from sys.sql_dependencies
select * from sys.objects a, sys.index_columns b where a.object_id=b.object_id and type='U'
select * from sys.foreign_key_columns

select * 
from 
	(
	select  a.name as Tabla, b.name as Columna, b.xtype as Tipo 
	from sys.sysobjects a, sys.syscolumns b 
	where a.id=b.id and a.type='U' and a.name like '%V3%'
	) a,
	(
	select  a.name as Tabla, b.name as Columna, b.xtype as Tipo 
	from sys.sysobjects a, sys.syscolumns b 
	where a.id=b.id and a.type='U' and a.name like '%V3%'
	) b



select * from Cot_Diarias_V3 a where NOT EXISTS (select * from Nemonicos_v3 b where a.IdCod=b.IdCod)
select * from Cot_Diarias_V3 a where NOT EXISTS (select * from Nemonicos_v3 b where a.IdCod=b.Cod)
select * from Cot_Diarias_V3 a where NOT EXISTS (select * from Nemonicos_v3 b where a.IdCod=b.Nombre)
select * from Cot_Diarias_V3 a where NOT EXISTS (select * from Nemonicos_v3 b where a.IdCod=b.Tipo)

select * from Nemonicos_v3
*/

---------------------------------
---------------------------------
---------------------------------

declare @TablaO varchar(250), @ColumnaO varchar(250), @TipoO int
declare @TablaD varchar(250), @ColumnaD varchar(250), @TipoD int
declare @cadena nvarchar(500), @ParmDefinition nvarchar(500);  
declare @total varchar(30), @Total_RegistrosO varchar(30), @Total_NoExisten varchar(30), @Factor2_Porcentaje_Coincidencia real, @Total_F3_N1 varchar(30), @Total_F3_N2 varchar(30), @Factor3_PorcentajeUsoFK real

Create table #Resultado (TablaO varchar(250), ColumnaO varchar(250), TablaD varchar(250), ColumnaD varchar(250), Factor1_DistanciaCadena real, Total_RegistrosO int, Total_NoExisten int, Factor2_Porcentaje_Coincidencia real, Factor3_PorcentajeUsoFK real)

declare ColumnasOrigen cursor local fast_forward for 
	select  a.name as Tabla, b.name as Columna, b.xtype as Tipo 
	from sys.sysobjects a, sys.syscolumns b 
	where a.id=b.id and a.type='U' -- and a.name like '%V3%'
open ColumnasOrigen
fetch next from ColumnasOrigen into @TablaO, @ColumnaO,@TipoO
while @@fetch_status = 0
begin

	select @cadena='select @total=count(*) from ['+@TablaO+'] a where a.['+@ColumnaO+'] Is Not Null' 
--	select @cadena
	SET @ParmDefinition = N'@total varchar(30) OUTPUT'; 
	exec sp_executesql @cadena, @ParmDefinition, @total OUTPUT
	select @Total_RegistrosO=@total

	declare ColumnasDestino cursor local fast_forward for 
		select  a.name as Tabla, b.name as Columna, b.xtype as Tipo 
		from sys.sysobjects a, sys.syscolumns b 
		where 
			a.id=b.id and a.type='U' -- and a.name like '%V3%' 
			and convert(varchar(250),a.name)<>@TablaO 
			--and b.xtype=@tipoO
			and b.xtype in (select TipoC from TiposCompatibles where TipoO=@tipoO)
	open ColumnasDestino
	fetch next from ColumnasDestino into @TablaD, @ColumnaD,@TipoD
	while @@fetch_status = 0
	begin

		select @cadena='select @total=count(*) from ['+@TablaO+'] a where NOT EXISTS (select * from [' +@TablaD+'] b where a.['+@ColumnaO+']=b.['+@ColumnaD+'] )' 
		SET @ParmDefinition = N'@total varchar(30) OUTPUT'; 
		exec sp_executesql @cadena, @ParmDefinition, @total OUTPUT
		select @Total_NoExisten=@total
		select @Factor2_Porcentaje_Coincidencia = 100-(@Total_NoExisten*100)/@Total_RegistrosO

		select @Factor3_PorcentajeUsoFK = 0
		if @Factor2_Porcentaje_Coincidencia>=75
			begin

				select @cadena='select @total=count(distinct ['+@ColumnaD+']) from ['+@TablaD+']' 
				SET @ParmDefinition = N'@total varchar(30) OUTPUT'; 
				exec sp_executesql @cadena, @ParmDefinition, @total OUTPUT
				select @Total_F3_N1=@total

				select @cadena='select @total=count(distinct ['+@ColumnaD+']) from ['+@TablaD+'] a where EXISTS (select * from [' +@TablaO+'] b where b.['+@ColumnaO+']=a.['+@ColumnaD+'] )' 
				SET @ParmDefinition = N'@total varchar(30) OUTPUT'; 
				exec sp_executesql @cadena, @ParmDefinition, @total OUTPUT
				select @Total_F3_N2=@total
				select @Factor3_PorcentajeUsoFK = (@Total_F3_N2*100)/@Total_F3_N1
--				select @Factor3_PorcentajeUsoFK
			end

		insert into #Resultado
		select 
			@TablaO, @ColumnaO, @TablaD, @ColumnaD, 
			case Difference(@ColumnaO,@ColumnaD) 
				when 0 then 0
				when 1 then 25
				when 2 then 50
				when 3 then 75
				else 100 
			end as Factor1_DistanciaCadena, 
			@Total_RegistrosO, @Total_NoExisten, @Factor2_Porcentaje_Coincidencia,
			@Factor3_PorcentajeUsoFK

		fetch next from ColumnasDestino into @TablaD, @ColumnaD,@TipoD
	end
	close ColumnasDestino
	deallocate ColumnasDestino

	fetch next from ColumnasOrigen into @TablaO, @ColumnaO,@TipoO
end
close ColumnasOrigen
deallocate ColumnasOrigen

select * from #Resultado 
where Factor2_Porcentaje_Coincidencia>=75
and Factor3_PorcentajeUsoFK>=25

--Drop Table #Resultado

/*
-- Creaci�n Tipos Compatibles
Create table TiposCompatibles (TipoO int, TipoC int)

insert into TiposCompatibles
select user_type_id, user_type_id  from sys.types
select * from sys.types



-- Tipos numericos
insert into TiposCompatibles
select 48,52
union
select 48,56
union
select 48,59
union
select 48,62
union
select 48,108
union
select 48,127
union
select 52,48
union
select 52,56
union
select 52,59
union
select 52,62
union
select 52,108
union
select 52,127
union
select 56,48
union
select 56,52
union
select 56,59
union
select 56,62
union
select 56,108
union
select 56,127
union
select 59,48
union
select 59,52
union
select 59,56
union
select 59,62
union
select 59,108
union
select 59,127
union
select 62,48
union
select 62,52
union
select 62,56
union
select 62,59
union
select 62,108
union
select 62,127
union
select 108,48
union
select 108,52
union
select 108,56
union
select 108,59
union
select 108,62
union
select 108,127
union
select 127,48
union
select 127,52
union
select 127,56
union
select 127,59
union
select 127,62
union
select 127,108

-- Tipos cadena
insert into TiposCompatibles
select 35,99
union
select 35,165
union
select 35,167
union
select 35,239
union
select 99,35
union
select 99,165
union
select 99,167
union
select 99,239
union
select 165,35
union
select 165,99
union
select 165,167
union
select 165,239
union
select 167,35
union
select 167,99
union
select 167,165
union
select 167,239
union
select 239,35
union
select 239,99
union
select 239,167
union
select 239,165



--48,52,56,59,62,108,127
--35,99,165,167,239

*/




declare @password varchar(30)

--select @password = 'SIE2019'

select @password = 'X or 1==1'

select 'select count(*) from ta_password where IdPassword='+char(34)+@password+char(34)

