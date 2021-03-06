USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[Stage]    Script Date: 27.06.2018 04:02:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[Stage] AS
BEGIN

if exists(select * from sys.objects where name='S_Csv') TRUNCATE TABLE dbo.S_Csv
else 
CREATE TABLE S_Csv 
(
NazwaTG		varchar(max)	null,
NazwaSkrot	varchar(max)	null
)

if exists(select * from sys.objects where name='S_Grupa') TRUNCATE TABLE dbo.S_Grupa
else
CREATE TABLE S_Grupa
(
Grupa	nvarchar(max)  null,
Program		nvarchar(max) null
)

if exists(select * from sys.objects where name='S_Kategoria') TRUNCATE TABLE dbo.S_Kategoria
else
CREATE TABLE S_Kategoria
(
Kanał		nvarchar(max)  null,
Kategoria	nvarchar(max)  null
)
	
if exists(select * from sys.objects where name='S_Txt') TRUNCATE TABLE dbo.S_Txt
else
CREATE TABLE S_Txt
(
Date				varchar(max),
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

END