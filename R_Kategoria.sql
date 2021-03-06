USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[R_Kategoria]    Script Date: 27.06.2018 04:02:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[R_Kategoria]
AS
DECLARE
@kategoria nvarchar(max)
BEGIN

DECLARE kursor1 CURSOR FOR 
SELECT Kategoria FROM dbo.Temp_Kategoria

OPEN kursor1
FETCH NEXT FROM kursor1 INTO @kategoria
WHILE @@FETCH_STATUS = 0
BEGIN
IF NOT EXISTS (SELECT @kategoria FROM Kategoria WHERE Nazwa_Kategoria = @kategoria) 
INSERT INTO Kategoria(Nazwa_Kategoria) VALUES (@kategoria)
FETCH NEXT FROM kursor1 INTO @kategoria
END
INSERT INTO Kategoria(Nazwa_Kategoria) VALUES ('UNKNOWN')

END