USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[R_TargetGrupa]    Script Date: 27.06.2018 04:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[R_TargetGrupa]
AS
BEGIN
INSERT INTO TargetGrupa(Nazwa_TG, Nazwa_Skrot)
SELECT * From S_Csv
END