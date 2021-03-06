USE [BD]
GO
/****** Object:  StoredProcedure [dbo].[Repozytorium]    Script Date: 27.06.2018 04:02:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Repozytorium]
AS
BEGIN

IF (OBJECT_ID('dbo.FK_FAKTY_FK_KALENDAR', 'F') is not null)
    ALTER TABLE Fakty DROP CONSTRAINT FK_FAKTY_FK_KALENDAR

IF (OBJECT_ID('dbo.FK_FAKTY_FKTV_KALENDAR', 'F') is not null)
    ALTER TABLE Fakty DROP CONSTRAINT FK_FAKTY_FKTV_KALENDAR

IF (OBJECT_ID('dbo.FK_FAKTY_FT_TARGETGR', 'F') is not null)
    ALTER TABLE Fakty DROP CONSTRAINT FK_FAKTY_FT_TARGETGR

IF (OBJECT_ID('dbo.FK_FAKTY_FP_PROGRAM', 'F') is not null)
    ALTER TABLE Fakty DROP CONSTRAINT FK_FAKTY_FP_PROGRAM

IF (OBJECT_ID('dbo.FK_FAKTY_FKA_KANAŁ', 'F') is not null)
    ALTER TABLE Fakty DROP CONSTRAINT FK_FAKTY_FKA_KANAŁ

IF (OBJECT_ID('dbo.FK_KANAŁ_KG_GRUPA', 'F') is not null)
    ALTER TABLE Kanał DROP CONSTRAINT FK_KANAŁ_KG_GRUPA

IF (OBJECT_ID('dbo.FK_KANAŁ_KK_KATEGORI', 'F') is not null)
    ALTER TABLE Kanał DROP CONSTRAINT FK_KANAŁ_KK_KATEGORI

IF (OBJECT_ID('dbo.FK_PROGRAM_PG_GODZINA', 'F') is not null)
    ALTER TABLE Program DROP CONSTRAINT FK_PROGRAM_PG_GODZINA

drop index if exists Fakty.FT_FK;

drop index if exists Fakty.FKTV_FK;

drop index if exists Fakty.FP_FK;

drop index if exists Fakty.FKa_FK;

drop index if exists Fakty.FK_FK;

drop index if exists Fakty.Fakty_PK;

drop table if exists Fakty;

drop index if exists Godzina.Godzina_PK;

drop table if exists Godzina;

drop index if exists Grupa.Grupa_PK;

drop table if exists Grupa;

drop index if exists Kalendarz.Kalendarz_PK;

drop table if exists Kalendarz;

drop index if exists Kanał.KG_FK;

drop index if exists Kanał.KK_FK;

drop index if exists Kanał.Kanał_PK;

drop table if exists Kanał;

drop index if exists Kategoria.Kategoria_PK;

drop table if exists Kategoria;

drop index if exists Program.PG_FK;

drop index if exists Program.Program_PK;

drop table if exists Program;

drop index if exists TargetGrupa.TargetGrupa_PK;

drop table if exists TargetGrupa;

/*==============================================================*/
/* Table: Fakty                                                 */
/*==============================================================*/
create table Fakty 
(
   ID_Fakt              integer identity               not null,
   ID_Program           integer                        null,
   ID_Kalendarz         integer                        null,
   ID_TargetGrupa       integer                        null,
   ID_Kanał             integer                        null,
   Kal_ID_Kalendarz     integer                        null,
   RCH                  float(10)                      null,
   AMR                  float(10)                      null,
   "AMR %"              float(10)                      null,
   "SHR %"              float(10)                      null,
   "RCH %"              float(10)                      null,
   constraint PK_FAKTY primary key (ID_Fakt)
);

/*==============================================================*/
/* Index: Fakty_PK                                              */
/*==============================================================*/
create unique index Fakty_PK on Fakty (
ID_Fakt ASC
);

/*==============================================================*/
/* Index: FK_FK                                                 */
/*==============================================================*/
create index FK_FK on Fakty (
Kal_ID_Kalendarz ASC
);

/*==============================================================*/
/* Index: FKa_FK                                                */
/*==============================================================*/
create index FKa_FK on Fakty (
ID_Kanał ASC
);

/*==============================================================*/
/* Index: FP_FK                                                 */
/*==============================================================*/
create index FP_FK on Fakty (
ID_Program ASC
);

/*==============================================================*/
/* Index: FKTV_FK                                               */
/*==============================================================*/
create index FKTV_FK on Fakty (
ID_Kalendarz ASC
);

/*==============================================================*/
/* Index: FT_FK                                                 */
/*==============================================================*/
create index FT_FK on Fakty (
ID_TargetGrupa ASC
);

/*==============================================================*/
/* Table: Godzina                                               */
/*==============================================================*/
create table Godzina 
(
   ID_Godzina           integer identity               not null,
   Godzina              smallint                       null,
   Minuta               smallint                       null,
   [Time]               varchar(8)                     null,
   Sekunda              smallint                       null,
   constraint PK_GODZINA primary key (ID_Godzina)
);

/*==============================================================*/
/* Index: Godzina_PK                                            */
/*==============================================================*/
create unique index Godzina_PK on Godzina (
ID_Godzina ASC
);

/*==============================================================*/
/* Table: Grupa                                                 */
/*==============================================================*/
create table Grupa 
(
   ID_Grupa             integer identity                         not null,
   Nazwa_Grupa          varchar(50)                    null,
   constraint PK_GRUPA primary key (ID_Grupa)
);

/*==============================================================*/
/* Index: Grupa_PK                                              */
/*==============================================================*/
create unique index Grupa_PK on Grupa (
ID_Grupa ASC
);

/*==============================================================*/
/* Table: Kalendarz                                             */
/*==============================================================*/
create table Kalendarz 
(
   ID_Kalendarz         integer                        not null,
   Data                 date                           null,
   Dzień                smallint                       null,
   Miesiąc              smallint                       null,
   Rok                  smallint                       null,
   constraint PK_KALENDARZ primary key (ID_Kalendarz)
);

/*==============================================================*/
/* Index: Kalendarz_PK                                          */
/*==============================================================*/
create unique index Kalendarz_PK on Kalendarz (
ID_Kalendarz ASC
);

/*==============================================================*/
/* Table: Kanał                                                 */
/*==============================================================*/
create table Kanał 
(
   ID_Kanał             integer identity               not null,
   ID_Kategoria         integer                        null,
   ID_Grupa             integer                        null,
   Nazwa_Kanał             varchar(25)                    null,
   constraint PK_KANAŁ primary key (ID_Kanał)
);

/*==============================================================*/
/* Index: Kanał_PK                                              */
/*==============================================================*/
create unique index Kanał_PK on Kanał (
ID_Kanał ASC
);

/*==============================================================*/
/* Index: KK_FK                                                 */
/*==============================================================*/
create index KK_FK on Kanał (
ID_Kategoria ASC
);

/*==============================================================*/
/* Index: KG_FK                                                 */
/*==============================================================*/
create index KG_FK on Kanał (
ID_Grupa ASC
);

/*==============================================================*/
/* Table: Kategoria                                             */
/*==============================================================*/
create table Kategoria 
(
   ID_Kategoria         integer identity                         not null,
   Nazwa_Kategoria      varchar(50)                    null,
   constraint PK_KATEGORIA primary key (ID_Kategoria)
);

/*==============================================================*/
/* Index: Kategoria_PK                                          */
/*==============================================================*/
create unique index Kategoria_PK on Kategoria (
ID_Kategoria ASC
);

/*==============================================================*/
/* Table: Program                                               */
/*==============================================================*/
create table Program 
(
   ID_Program           integer identity                         not null,
   ID_Godzina           integer                        null,
   Program              varchar(200)                   null,
   Opis                 varchar(200)                   null,
   Duration             time                           null,
   constraint PK_PROGRAM primary key (ID_Program)
);

/*==============================================================*/
/* Index: Program_PK                                            */
/*==============================================================*/
create unique index Program_PK on Program (
ID_Program ASC
);

/*==============================================================*/
/* Index: PG_FK                                                 */
/*==============================================================*/
create index PG_FK on Program (
ID_Godzina ASC
);

/*==============================================================*/
/* Table: TargetGrupa                                           */
/*==============================================================*/
create table TargetGrupa 
(
   ID_TargetGrupa       integer identity                         not null,
   Nazwa_TG             varchar(25)                    null,
   Nazwa_Skrot			varchar(25)						null
   constraint PK_TARGETGRUPA primary key (ID_TargetGrupa)
);

/*==============================================================*/
/* Index: TargetGrupa_PK                                        */
/*==============================================================*/
create unique index TargetGrupa_PK on TargetGrupa (
ID_TargetGrupa ASC
);

alter table Fakty
   add constraint FK_FAKTY_FK_KALENDAR foreign key (Kal_ID_Kalendarz)
      references Kalendarz (ID_Kalendarz)


alter table Fakty
   add constraint FK_FAKTY_FKTV_KALENDAR foreign key (ID_Kalendarz)
      references Kalendarz (ID_Kalendarz)


alter table Fakty
   add constraint FK_FAKTY_FKA_KANAŁ foreign key (ID_Kanał)
      references Kanał (ID_Kanał)


alter table Fakty
   add constraint FK_FAKTY_FP_PROGRAM foreign key (ID_Program)
      references Program (ID_Program)

alter table Fakty
   add constraint FK_FAKTY_FT_TARGETGR foreign key (ID_TargetGrupa)
      references TargetGrupa (ID_TargetGrupa)


alter table Kanał
   add constraint FK_KANAŁ_KG_GRUPA foreign key (ID_Grupa)
      references Grupa (ID_Grupa)

alter table Kanał
   add constraint FK_KANAŁ_KK_KATEGORI foreign key (ID_Kategoria)
      references Kategoria (ID_Kategoria)


alter table Program
   add constraint FK_PROGRAM_PG_GODZINA foreign key (ID_Godzina)
      references Godzina (ID_Godzina)
 



END
