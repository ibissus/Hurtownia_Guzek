USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[R_Fakty]    Script Date: 27.06.2018 04:01:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   procedure [dbo].[R_Fakty]
as
begin

INSERT INTO TargetGrupa (Nazwa_TG, T.Nazwa_Skrot)
  SELECT DISTINCT P.TargetGroup, P.TargetGroup
  FROM Pivot_Fakty P
  LEFT JOIN TargetGrupa T ON T.Nazwa_Skrot = P.TargetGroup
  WHERE T.Nazwa_Skrot is null

INSERT INTO Fakty(ID_Program, ID_Kalendarz, Kal_ID_Kalendarz, ID_TargetGrupa, ID_Kanał, AMR, [AMR %], [SHR %], [RCH %], RCH)
SELECT P.ID_Program, K.ID_Kalendarz,Ka.ID_Kalendarz,G.ID_TargetGrupa,Kan.ID_Kanał,AMR, [AMR %], [SHR %], [RCH %], RCH
FROM Pivot_Fakty PF
LEFT JOIN Kanał Kan ON PF.Channel = Kan.[Nazwa_Kanał]
LEFT JOIN TargetGrupa G ON PF.TargetGroup = G.Nazwa_Skrot
LEFT JOIN Kalendarz K ON PF.Date = K.ID_Kalendarz
LEFT JOIN Kalendarz Ka ON PF.TVDate = Ka.ID_Kalendarz
LEFT JOIN Program P ON PF.[Description] = P.Program AND PF.[2nd Description] = P.Opis AND PF.Duration = P.Duration
LEFT JOIN Godzina Go ON PF.StartTime = Go.Time
WHERE P.ID_Godzina = Go.ID_Godzina

Update Fakty SET ID_Kanał = (SELECT ID_Kanał FROM Kanał WHERE Nazwa_Kanał = 'UNKNOWN') WHERE ID_Kanał is null
end