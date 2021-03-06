USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[R_Grupa]    Script Date: 27.06.2018 04:02:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[R_Grupa]
AS
DECLARE
@grupa nvarchar(max),
@kanał nvarchar(max)
BEGIN
DECLARE kursor2 CURSOR FOR
SELECT * FROM dbo.Temp_Grupa
OPEN kursor2
FETCH NEXT FROM kursor2 INTO @grupa, @kanał
WHILE @@FETCH_STATUS = 0
BEGIN
IF not exists (Select * FROM Grupa WHERE Nazwa_Grupa = @grupa)	
INSERT INTO Grupa(Nazwa_Grupa) VALUES (@grupa)
FETCH NEXT FROM kursor2 INTO @grupa, @kanał
END
END