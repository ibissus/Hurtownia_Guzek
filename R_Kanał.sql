USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[R_Kanał]    Script Date: 27.06.2018 04:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[R_Kanał]
AS
BEGIN

SELECT DISTINCT ID_Grupa, ID_Kategoria, Program INTO Temp
FROM Temp_Grupa TG
LEFT JOIN Grupa G ON TG.Grupa = G.Nazwa_Grupa 
LEFT JOIN Temp_Kategoria TK ON TG.Program = TK.Kanał
LEFT JOIN Kategoria K ON TK.Kategoria = K.Nazwa_Kategoria
UPDATE Temp SET ID_Kategoria = (SELECT ID_Kategoria FROM Kategoria WHERE Nazwa_Kategoria = 'UNKNOWN') WHERE ID_Kategoria is null

INSERT INTO Kanał(ID_Grupa, ID_Kategoria, Nazwa_Kanał)
SELECT * FROM Temp

DECLARE @temp_kat	int
DECLARE @temp_grupa int
SELECT @temp_kat = ID_Kategoria, @temp_grupa = ID_Grupa FROM Kategoria, Grupa WHERE Nazwa_Kategoria = 'UNKNOWN' AND Nazwa_Grupa = 'UNKNOWN'
INSERT INTO Kanał(ID_Grupa, ID_Kategoria, Nazwa_Kanał) VALUES (@temp_grupa, @temp_kat, 'UNKNOWN')

DROP TABLE Temp
END