/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     21.06.2018 16:51:23                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_FAKTY_FK_KALENDAR') then
    alter table Fakty
       delete foreign key FK_FAKTY_FK_KALENDAR
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_FAKTY_FKTV_KALENDAR') then
    alter table Fakty
       delete foreign key FK_FAKTY_FKTV_KALENDAR
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_FAKTY_FKA_KANA£') then
    alter table Fakty
       delete foreign key FK_FAKTY_FKA_KANA£
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_FAKTY_FP_PROGRAM') then
    alter table Fakty
       delete foreign key FK_FAKTY_FP_PROGRAM
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_FAKTY_FT_TARGETGR') then
    alter table Fakty
       delete foreign key FK_FAKTY_FT_TARGETGR
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KANA£_KG_GRUPA') then
    alter table Kana³
       delete foreign key FK_KANA£_KG_GRUPA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KANA£_KK_KATEGORI') then
    alter table Kana³
       delete foreign key FK_KANA£_KK_KATEGORI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PROGRAM_PG_GODZINA') then
    alter table Program
       delete foreign key FK_PROGRAM_PG_GODZINA
end if;

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

drop index if exists Kana³.KG_FK;

drop index if exists Kana³.KK_FK;

drop index if exists Kana³.Kana³_PK;

drop table if exists Kana³;

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
   ID_Fakt              integer                        not null,
   ID_Program           integer                        null,
   ID_Kalendarz         integer                        null,
   ID_TargetGrupa       integer                        null,
   ID_Kana³             integer                        null,
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
ID_Kana³ ASC
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
   ID_Godzina           integer                        not null,
   Godzina              smallint                       null,
   Minuta               smallint                       null,
   "Time"               varchar(8)                     null,
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
   ID_Grupa             integer                        not null,
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
   Dzieñ                smallint                       null,
   Miesi¹c              smallint                       null,
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
/* Table: Kana³                                                 */
/*==============================================================*/
create table Kana³ 
(
   ID_Kana³             integer                        not null,
   ID_Kategoria         integer                        null,
   ID_Grupa             integer                        null,
   Nazwa_TG             varchar(25)                    null,
   constraint PK_KANA£ primary key (ID_Kana³)
);

/*==============================================================*/
/* Index: Kana³_PK                                              */
/*==============================================================*/
create unique index Kana³_PK on Kana³ (
ID_Kana³ ASC
);

/*==============================================================*/
/* Index: KK_FK                                                 */
/*==============================================================*/
create index KK_FK on Kana³ (
ID_Kategoria ASC
);

/*==============================================================*/
/* Index: KG_FK                                                 */
/*==============================================================*/
create index KG_FK on Kana³ (
ID_Grupa ASC
);

/*==============================================================*/
/* Table: Kategoria                                             */
/*==============================================================*/
create table Kategoria 
(
   ID_Kategoria         integer                        not null,
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
   ID_Program           integer                        not null,
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
   ID_TargetGrupa       integer                        not null,
   Nazwa_TG             varchar(25)                    null,
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
      on update restrict
      on delete restrict;

alter table Fakty
   add constraint FK_FAKTY_FKTV_KALENDAR foreign key (ID_Kalendarz)
      references Kalendarz (ID_Kalendarz)
      on update restrict
      on delete restrict;

alter table Fakty
   add constraint FK_FAKTY_FKA_KANA£ foreign key (ID_Kana³)
      references Kana³ (ID_Kana³)
      on update restrict
      on delete restrict;

alter table Fakty
   add constraint FK_FAKTY_FP_PROGRAM foreign key (ID_Program)
      references Program (ID_Program)
      on update restrict
      on delete restrict;

alter table Fakty
   add constraint FK_FAKTY_FT_TARGETGR foreign key (ID_TargetGrupa)
      references TargetGrupa (ID_TargetGrupa)
      on update restrict
      on delete restrict;

alter table Kana³
   add constraint FK_KANA£_KG_GRUPA foreign key (ID_Grupa)
      references Grupa (ID_Grupa)
      on update restrict
      on delete restrict;

alter table Kana³
   add constraint FK_KANA£_KK_KATEGORI foreign key (ID_Kategoria)
      references Kategoria (ID_Kategoria)
      on update restrict
      on delete restrict;

alter table Program
   add constraint FK_PROGRAM_PG_GODZINA foreign key (ID_Godzina)
      references Godzina (ID_Godzina)
      on update restrict
      on delete restrict;

