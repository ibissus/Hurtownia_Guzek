USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[R_Programy]    Script Date: 27.06.2018 04:02:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   procedure [dbo].[R_Programy]
as

begin

INSERT INTO Program (ID_Godzina, Program, Opis, Duration)
SELECT DISTINCT G.ID_Godzina, [Description], [2nd Description], Duration
FROM Pivot_Fakty P
LEFT JOIN Godzina G ON P.StartTime = G.Time

end