USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[R_Godzina]    Script Date: 27.06.2018 04:01:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
ALTER   PROCEDURE [dbo].[R_Godzina]
AS
DECLARE
@godz		smallint,
@min		smallint,
@sec		smallint,
@startTime	time,
@endTime	time,
@time		time,
@id			int
BEGIN
SET @startTime = '00:00:00'
SET @endTime = '23:59:59'
SET @time = @startTime
SET @id = 0

if (SELECT count(*) FROM Godzina) = 0
BEGIN
WHILE @id < 86400
BEGIN
	SET @godz = DATEPART(hh, @time)
	SET @min = DATEPART(mi, @time)
	SET @sec = DATEPART(ss, @time)

	INSERT INTO Godzina([Time], Godzina, Minuta, Sekunda) 
	VALUES ( @time, @godz, @min, @sec)
	SET @id+=1
	SET @time = DATEADD(SECOND, 1, @time)
END
END
END