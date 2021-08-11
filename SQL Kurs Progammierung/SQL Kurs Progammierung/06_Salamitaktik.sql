/*

Salamitaktik

Tab A 10 Zeilen
Tab B 100000000000000000000000000000000000000000000 Zeilen

absolut identisch

welche ist schneller, wenn eine Abfrage immer 10 Zeilen ausgeben würde

kleinere sind schneller.. SCAN 


Problem: Die Tabelle Umsatz wird immer größer

Idee: 

Splitten von einer Tabellen auf viele kleinere

Statt Umsatz --> u2021  u2020 u2019 u 2018

Software: select * from umsatz ??? -- das muss wieder gehen


*/

create table u2021 (id int identity, jahr int, spx int)
create table u2020 (id int identity, jahr int, spx int)
create table u2019 (id int identity, jahr int, spx int)
create table u2018 (id int identity, jahr int, spx int)

select * from umsatz



create view Umsatz
as
select * from u2021
UNION ALL
select * from u2020
UNION ALL
select * from u2019
UNION ALL
select * from u2018
GO

select * from umsatz -- Sicht verhält sich aber wie Tabelle


select * from Umsatz where jahr = 2019 --bis hier nix gewonnen-- Garantie = Check Contrain

ALTER TABLE dbo.u2021 ADD CONSTRAINT CK_u2021 CHECK (jahr=2021)
ALTER TABLE dbo.u2020 ADD CONSTRAINT CK_u2020 CHECK (jahr=2020)
ALTER TABLE dbo.u2018 ADD CONSTRAINT CK_u2018 CHECK (jahr=2018)
ALTER TABLE dbo.u2019 ADD CONSTRAINT CK_u2019 CHECK (jahr=2019)

--andere Settings die Regeln haben wir " darf nicht sein"

--NOT NULL.. eine Suche nach NULL dauert 0 

--Aber: diese Sicht kann auch INS UP DEL
--aber nur wenn: kein identity vorhanden ist
-- und der PK muss eindeutig über die Sicht sein zb durch ID + Jahr als PK

--APP geht nicht mehr!!

--Alternative: in die Tabellen schreiben... Proz


--Einsatzgebiet: historische Daten, Archiv, die keinen INS UP DEL brauchen

--das alles passiert auf der logischen Ebene

--Oder per pyhsikalischer Ebene


create table t2 (id int) ON [PRIMARY] --mdf 

USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwindhotdata', FILENAME = N'D:\_SQLDB\nwindhotdata.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [HOT]
GO


---
create table test3 (id int) on HOT --das ist alles


--Partitionierung

--Part Funktion kann int, money, datetime, varchar...
--es sind 15000 Bereiche möglich

-------------100]---------------------200]-------------------------------5000----
--   1                     2                                   3                4

--f(117)--2

--Idee: CASE

create partition function fzahl(int)
as
RANGE LEFT FOR VALUES (100,200) --auch RANGE RIGHT
 
select $partition.fzahl(117) --> 2


--Part Schema
--Dgruppen für die Bereiche (bis100, bis200, bis5000, rest)


USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'n100', FILENAME = N'D:\_SQLDB\n100.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'n200', FILENAME = N'D:\_SQLDB\n200.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'n5000', FILENAME = N'D:\_SQLDB\n5000.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [rest]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nrest', FILENAME = N'D:\_SQLDB\nrest.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [rest]
GO

create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
---                 1        2     3 --Reihenfolge entscheidet
--

create table ptab
	(id int identity, nummer int, spx char(4100)) on schZahl(nummer)



declare @i as int = 1

while @i <= 20000
	begin
		insert into ptab values(@i, 'XY')
		set @i=@i+1
	end

--Randerscheinung
--der GO 20000 der dasselbe macht dauerte 29 Sek ..jetzt 16 Sek

set statistics io, time on --und Plan
select * from ptab where nummer = 117 --100 Seiten

---Idee.. statt einem Riesenscan einen kleineren SCAN (HEAP SCAN)

select * from ptab where id =117 --20000

--Im Plan sollte ein SEEK da sein



---Neue Grenze 5000
select * from ptab where nummer = 1117
 
 ----------100-----------200---------------5000---------------

--Tab F() Schema, DGruppen

--F() zuerst  f(6100)--> 4
--Schema ? was ist 4 
--Tabelle ..nie

--1.Schema
--2. F()

--1. Schema
alter partition scheme schZahl next used bis5000

--2 F()
alter partition function fZahl() split range (5000)

select * from ptab where nummer = 1117 --4800

--;-)


--Grenze entfernen: 100 muss raus

----100----------------200------5000-----------

--f() tab scheme Dgruppen

--1: f()
alter partition function fzahl() merge range (100)

select * from ptab where nummer = 117 --200



--Ideen
create partition function fzahl(datetime) --Jahresweise..Fluch auf Datetime
as
RANGE LEFT FOR VALUES ('31.12.2020 23.59:59.999','','') --auch 


--A bis M  N bis R  S bis Z
create partition function fzahl(varchar(50)) --Jahresweise..Fluch auf Datetime
as
RANGE LEFT FOR VALUES ('MZZZZZ','S') --auch 


----------!-------------------!---------------


--mit Primary machbar.. aund sogar sinnvoll
create partition scheme schZahl
as
partition fzahl to ([PRIMARY],[PRIMARY],[PRIMARY])




























