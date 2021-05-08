select top 3 * from VOLDIA_INTRADIA_TEMP_v3

go
select top 5 * from ALERTAS_V3_P

go
select CONCAT(a.ANNIO,'-',a.MES,'-',a.DIA), a.ANNIO, a.MES, a.DIA from VOLDIA_INTRADIA_TEMP_v3 a;

select convert(smalldatetime, CONCAT(a.ANNIO,'-',a.MES,'-',a.DIA)), a.ANNIO, a.MES, a.DIA from VOLDIA_INTRADIA_TEMP_v3 a;
