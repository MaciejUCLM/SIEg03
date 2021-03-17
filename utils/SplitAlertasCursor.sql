Declare @alerta nvarchar(110), @clave varchar(10), @idempresa int, @hora varchar(10), @porc int, @volmedio int, @volumen int

DECLARE alertas_cursor CURSOR FOR SELECT ALERTA FROM ALERTAS_V3
OPEN alertas_cursor
FETCH NEXT FROM alertas_cursor INTO @alerta  
WHILE @@FETCH_STATUS = 0  
BEGIN  
	-- CLAVE=SCON/ IDEMPRESA=5951/ HORA DISCRETIZADA=18:40/ PORC DESFASE=1362/ VOL MEDIO=8786/ VOLUMEN=119712
	SELECT @clave = SUBSTRING(@alerta, 7, PATINDEX('%/%',@alerta)-7)

	SELECT @alerta = SUBSTRING(@alerta, PATINDEX('%/%',@alerta)+2, LEN(@alerta))
	SELECT @idempresa = convert(int, SUBSTRING(@alerta, 11, PATINDEX('%/%',@alerta)-11))

	SELECT @alerta = SUBSTRING(@alerta, PATINDEX('%/%',@alerta)+2, LEN(@alerta))
	SELECT @hora = SUBSTRING(@alerta, 19, PATINDEX('%/%',@alerta)-19)

	SELECT @alerta = SUBSTRING(@alerta, PATINDEX('%/%',@alerta)+2, LEN(@alerta))
	SELECT @porc = convert(int, SUBSTRING(@alerta, 14, PATINDEX('%/%',@alerta)-14))

	SELECT @alerta = SUBSTRING(@alerta, PATINDEX('%/%',@alerta)+2, LEN(@alerta))
	SELECT @volmedio = convert(int, SUBSTRING(@alerta, 11, PATINDEX('%/%',@alerta)-11))

	SELECT @alerta = SUBSTRING(@alerta, PATINDEX('%/%',@alerta)+2, LEN(@alerta))
	SELECT @volumen = convert(int, SUBSTRING(@alerta, 9, LEN(@alerta)-8))

    --INSERT INTO ? VALUES (@)
	--SELECT @clave, @idempresa, @hora, @porc, @volmedio, @volumen
	FETCH NEXT FROM alertas_cursor INTO @alerta
END   
CLOSE alertas_cursor;  
DEALLOCATE alertas_cursor;
