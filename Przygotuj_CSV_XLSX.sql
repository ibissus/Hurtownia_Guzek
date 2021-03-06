USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[Przygotuj_CSV_XLSX]    Script Date: 27.06.2018 04:01:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Przygotuj_CSV_XLSX]
AS
DECLARE
@grupa		 varchar(max),
@kanał		 varchar(max),
@temp_kategoria	 varchar(max),
@s_kanał		nvarchar(max),
@s_kategoria	nvarchar(max),
@s_grupa		nvarchar(max),
@s_id			nvarchar(max),
@s_name			nvarchar(max)
BEGIN

create table Temp_Kategoria
(
Kanał		nvarchar(max)  not null,
Kategoria	nvarchar(max)  not null
)

CREATE TABLE Temp_Grupa
(
Grupa	nvarchar(max)  not null,
Program	nvarchar(max)  not null
)

DECLARE	kursor CURSOR FOR 
SELECT * FROM S_Kategoria

OPEN kursor	
FETCH NEXT FROM kursor INTO @s_kanał, @s_kategoria
WHILE @@FETCH_STATUS = 0
BEGIN 

if CHARINDEX('[', @s_kanał) > 1
BEGIN
	SET @s_kanał = LEFT(@s_kanał, CHARINDEX('[', @s_kanał))
	SET @s_kanał = REPLACE(@s_kanał, '[', '')
END

SET @s_kategoria = LEFT(@s_kategoria, CHARINDEX(' ', @s_kategoria))
		
IF(@s_kanał is null OR @s_kategoria is null)
BEGIN
	FETCH NEXT FROM kursor INTO @s_kanał, @s_kategoria
	CONTINUE
END
ELSE
BEGIN
	INSERT INTO Temp_Kategoria VALUES (@s_kanał, @s_kategoria)
	FETCH NEXT FROM kursor INTO @s_kanał, @s_kategoria
END
END
CLOSE kursor
DEALLOCATE kursor

DECLARE	kursor CURSOR FOR 
SELECT * FROM S_Grupa

OPEN kursor
FETCH NEXT FROM kursor INTO @s_id, @s_name
WHILE @@FETCH_STATUS = 0
BEGIN
IF(@s_id is null AND @s_name is null)
BEGIN 
	FETCH NEXT FROM kursor INTO @s_id, @s_name
	CONTINUE
END
ELSE IF(@s_id is null AND @s_name is not null)
BEGIN
	SET @s_grupa = @s_name
	SET @s_grupa = LEFT(@s_grupa, CHARINDEX('(', @s_grupa))
	SET @s_grupa = REPLACE(@s_grupa, '(', '')
END
ELSE
BEGIN
	INSERT INTO Temp_Grupa VALUES (@s_grupa, @s_name)
END
FETCH NEXT FROM kursor INTO @s_id, @s_name
END
CLOSE kursor
DEALLOCATE kursor
END
