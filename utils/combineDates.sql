select top 3 * from COTIZACIONES_DIARIAS_TEMP_V3;
select top 3 * from DIFULT_MATRIZ_INTRADIA_TEMP_V3;
select top 3 * from DISCRETRIZAHORAS_INTRADIA_TEMP_V3;
select top 3 * from VOLDIA_INTRADIA_TEMP_v3;
select top 3 * from ULTDIA_INTRADIA1_HOY_TEMP_v3;
select top 3 * from ULTDIA_INTRADIA_TEMP_V3;

go
select CONCAT(a.ANNIO,'-',a.MES,'-',a.DIA), a.ANNIO, a.MES, a.DIA from VOLDIA_INTRADIA_TEMP_v3 a;

select convert(smalldatetime, CONCAT(a.ANNIO,'-',a.MES,'-',a.DIA)), a.ANNIO, a.MES, a.DIA from VOLDIA_INTRADIA_TEMP_v3 a;
