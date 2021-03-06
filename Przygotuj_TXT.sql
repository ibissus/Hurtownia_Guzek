USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[Przygotuj_TXT]    Script Date: 27.06.2018 04:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[Przygotuj_TXT]
AS
DECLARE

@DateChar				nvarchar(max),
@Date					date,
@Channel				nvarchar(max),
@Description			nvarchar(max),
@2ndDescription	nvarchar(max),
@StartTime			nvarchar(max),
@Duration				nvarchar(max),
@VariableTarget		nvarchar(max),
@TotalIndividuals		nvarchar(max),
@Podgrupa				nvarchar(max),
@A1649				nvarchar(max),
@M1649				nvarchar(max),
@A415					nvarchar(max),
@A49					nvarchar(max),

@temp_Date					int,
@temp_Channel				nvarchar(max),
@temp_Description			nvarchar(max),
@temp_2ndDesc			nvarchar(max),
@temp_StartTime				nvarchar(max),
@temp_Duration				nvarchar(max),
@temp_VariableTarget		nvarchar(max),
@temp_Time					nvarchar(max),
@TargetGroup				nvarchar(max),
@TVDate					int,
@DurationTemp				nvarchar(max),
@StartTimeTemp			nvarchar(max)

BEGIN

	CREATE TABLE T_Fakty
	(
	[Date]				int,
	TVDate				int,
	Channel				nvarchar(max),
	[Description]		nvarchar(max),
	[2nd Description]	nvarchar(max),
	StartTime			nvarchar(8),
	Duration		    nvarchar(8),
	VariableTarget		nvarchar(5),
	TotalIndividuals	float,
	Podgrupa			float,
	[A16-49]			float,
	[M16-49]			float,
	[A4-15]				float,
	[A4-9]				float
	)

	CREATE TABLE T_Txt
	(
	[Date]				varchar(max),
	Channel				varchar(max),
	Description			varchar(max),
	[2nd Description]	varchar(max),
	StartTime			varchar(max),
	Duration			varchar(max),
	VariableTarget		varchar(max),
	TotalIndividuals	varchar(max),
	Podgrupa			varchar(max),
	[A16-49]			varchar(max),
	[M16-49]			varchar(max),
	[A4-15]				varchar(max),
	[A4-9]				varchar(max)
	)

	INSERT INTO T_Txt
	select * from S_Txt 

	UPDATE T_Txt SET
	[Date] = replace([Date], '"', ''),
	[Channel] = replace([Channel], '"', ''),
	[Description] = replace([Description], '"', ''),
	[2nd Description] = replace([2nd Description], '"', ''),
	[Duration] = replace([Duration], '"', ''),
	[StartTime] = replace([StartTime], '"', ''),
	[VariableTarget] = replace([VariableTarget], '"', ''),
	[TotalIndividuals] = replace(replace(replace(TotalIndividuals, ',','.'), NCHAR(0x00A0),''), ' %',''),
	[Podgrupa] = replace(replace(replace(Podgrupa, ',','.'), NCHAR(0x00A0),''), ' %',''),
	[A16-49] = replace(replace(replace(replace([A16-49], ',','.'), NCHAR(0x00A0),''), ' %',''), 'n.a.',''),
	[M16-49] = replace(replace(replace(replace([M16-49], ',','.'), NCHAR(0x00A0),''), ' %',''), 'n.a.',''),
	[A4-15] = replace(replace(replace(replace([A4-15], ',','.'), NCHAR(0x00A0),''), ' %',''), 'n.a.',''),
	[A4-9] = replace(replace(replace(replace(replace([A4-9], ',','.'), NCHAR(0x00A0),''), ' %',''), 'n.a.',''), ';','')

	UPDATE T_Txt SET [Channel] = LEFT(Channel, CHARINDEX ('[', Channel) - 2) WHERE CHARINDEX('[', Channel) > 1
	UPDATE T_Txt SET [Description] = LEFT(Description, (CHARINDEX ('/', Description))-1) WHERE CHARINDEX('/', Description) > 1

	SET DATEFORMAT dmy;
	DECLARE kursor CURSOR FOR
	Select * From T_Txt
	
	DECLARE @num int
	SET @num = 0

	OPEN kursor
	FETCH NEXT FROM kursor 
	INTO @DateChar, @Channel, @Description, @2ndDescription, @StartTime, @Duration, @VariableTarget, @TotalIndividuals, @Podgrupa, @A1649, @M1649, @A415, @A49
	
	WHILE @@FETCH_STATUS = 0	
	BEGIN		
	IF(@num % 5 = 0)
	BEGIN

	SET @temp_Description = @Description
	SET @temp_2ndDesc = @2ndDescription
	IF (@temp_2ndDesc = '') SET @temp_2ndDesc = 'BRAK'
	SET @temp_Duration = @Duration

	IF LEN(@DateChar) > 1 
	BEGIN
	SET @Date = CAST(@DateChar as date)
	SET @temp_Date = cast(replace(@Date, '-', '') as int)
	END
		
	IF LEN(@Channel) > 1 SET @temp_Channel = @Channel
				
	SET @temp_Time = SUBSTRING(@StartTime, 1, 2)
	IF(@temp_Time >= 24)
	BEGIN
	IF(@temp_time - 24 = 0) SET @temp_Time = '00'
	ELSE SET @temp_Time = '01'
	SET @StartTime = REPLACE(@StartTime, SUBSTRING(@StartTime, 1, 2), @temp_Time)
	SET @TVDate = CAST(replace(DATEADD(dd, 1, @Date), '-', '') as int)
	END
	ELSE
	SET @TVDate = CAST(replace(@Date, '-', '') as int)
	SET @temp_StartTime = @StartTime
	END

	SET @temp_VariableTarget = LEFT(@VariableTarget, 5)
	SET @num += 1				
			
	INSERT INTO T_Fakty ([Date], TVDate, Channel, [Description], [2nd Description], StartTime, Duration, VariableTarget,TotalIndividuals,Podgrupa,[A16-49],[M16-49],[A4-15],[A4-9])
	VALUES (cast(@temp_date as int), cast(@TVDate as int), @temp_channel, @temp_description, @temp_2ndDesc, @temp_StartTime, @temp_Duration, @temp_VariableTarget, @TotalIndividuals, @Podgrupa, @A1649,@M1649,@A415,@A49)	
			
	FETCH NEXT FROM kursor INTO @DateChar, @Channel, @Description, @2ndDescription, @StartTime, @Duration, @VariableTarget, @TotalIndividuals, @Podgrupa,  @A1649, @M1649, @A415, @A49		
	END 
CLOSE kursor
DEALLOCATE kursor

SELECT [Date],[TVDate],[Channel],[Description],[2nd Description],[StartTime],[Duration],[TargetGroup],[AMR],[AMR %],[SHR %],[RCH %],[RCH] INTO Pivot_Fakty
FROM ( 
	Select [Date],[TVDate],[Channel],[Description],[2nd Description],[StartTime],[Duration],[VariableTarget], [TargetGroup], value
	FROM T_Fakty
	unpivot
	(
	value for [TargetGroup] in ([TotalIndividuals],[Podgrupa], [A16-49], [M16-49], [A4-15], [A4-9])
		) unpiv
	) src
	PIVOT
(max(value) FOR [VariableTarget] IN ([AMR],[AMR %], [SHR %], [RCH %], [RCH]))piv

END