-- CONSEGUIR INFORMACI�N YAHOO FINANZAS - FASE1.1 A 1.3

-- FASE 1 - Conseguir todas las letras.
CREATE TABLE LETRAS (LETRA char(1))

DECLARE @CONTADOR INT = 48

WHILE @CONTADOR<123
BEGIN
	IF (@CONTADOR>=48 AND @CONTADOR<=57) OR (@CONTADOR>=97 AND @CONTADOR<=122)
		BEGIN
			INSERT INTO LETRAS VALUES (CHAR(@CONTADOR))
		END
    SELECT @CONTADOR = @CONTADOR+1
END


SELECT A.LETRA+B.LETRA AS LETRAS FROM LETRAS A, LETRAS B ORDER BY LETRAS

SELECT A.LETRA+B.LETRA+C.LETRA AS LETRAS 
FROM LETRAS A, LETRAS B, LETRAS C 
ORDER BY LETRAS


-- FASE 2 - Obtenemos las cadenas
Create table CADENAS (letras2 char(2), cadena varchar(200))

Declare @cadena varchar(200), @letras2 varchar(2)
  
DECLARE tikets_cursor CURSOR FOR SELECT A.LETRA+B.LETRA AS LETRAS2 FROM LETRAS A, LETRAS B ORDER BY LETRAS2
OPEN tikets_cursor  
FETCH NEXT FROM tikets_cursor INTO @letras2  
WHILE @@FETCH_STATUS = 0  
BEGIN  
    Select @cadena = 'curl -GET '+char(34)+'https://es.finance.yahoo.com/lookup/all?s='+@letras2+'&t=A&b=1&c=9999'+char(34)
	INSERT INTO CADENAS VALUES (@letras2, @cadena)
	FETCH NEXT FROM tikets_cursor INTO @letras2  
END   
CLOSE tikets_cursor;  
DEALLOCATE tikets_cursor;  

--select * from CADENAS where letras2='ac'

-- FASE 3 - Obtenemos las cadenas
DROP TABLE TIKETS_NP
CREATE TABLE TIKETS_NP (Id int IDENTITY(1,1), letras char(2), cadena varchar(8000)) 

Declare @cadena varchar(200), @letras2 varchar(2)

DECLARE tikets_cursor CURSOR FOR SELECT LETRAS2, CADENA FROM CADENAS ORDER BY LETRAS2
OPEN tikets_cursor  
FETCH NEXT FROM tikets_cursor INTO @letras2, @cadena
WHILE @@FETCH_STATUS = 0  
BEGIN 
	CREATE TABLE #cmdshell(a VARCHAR(8000))
	INSERT #cmdshell exec xp_cmdshell @cadena
	INSERT TIKETS_NP (letras, cadena) SELECT @LETRAS2, A from #cmdshell
	FETCH NEXT FROM tikets_cursor INTO @letras2, @cadena 
	DROP TABLE #cmdshell
END   
CLOSE tikets_cursor;  
DEALLOCATE tikets_cursor;  

select * from CADENAS