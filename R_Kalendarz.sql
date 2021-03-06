USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[R_Kalendarz]    Script Date: 27.06.2018 04:02:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   PROCEDURE [dbo].[R_Kalendarz]
AS
BEGIN

IF(SELECT count(*) FROM Kalendarz) = 0
BEGIN
DECLARE @StartDate DATE = '20150101', @NumberOfYears INT = 1;

SET DATEFIRST 1;
SET DATEFORMAT ydm;
SET LANGUAGE Polish;

DECLARE @CutoffDate DATE = DATEADD(YEAR, @NumberOfYears, @StartDate);

CREATE TABLE #temp
(
  [data]       DATE PRIMARY KEY, 
  dzień        AS DATEPART(DAY,      [data]),
  miesiąc      AS DATEPART(MONTH,    [data]),
  rok			AS DATEPART(YEAR,     [data]),
  [format]     AS CONVERT(CHAR(8),   [data], 112),
);

INSERT #temp([data]) 
SELECT d
FROM
(
  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
  FROM 
  (
    SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) 
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    ORDER BY s1.[object_id]
  ) AS x
) AS y;


INSERT Kalendarz WITH (TABLOCKX)
SELECT
  ID_Kalendarz  = CONVERT(INT, [format]),
  [Data]        = [data],
  Dzień         = CONVERT(TINYINT, dzień),
  Miesiąc       = CONVERT(TINYINT, miesiąc),
  Rok			= [rok]
FROM #temp
END
END
