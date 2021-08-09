--DB Design

/*
Normalisierung vs Redundanz (schnell)

temp Tabellen #tab

NF 1 2 3 BC 4  5
NF 1: atomar in einer Zelle nur ein Wert --> Indizes
NF 2: Primärschlüssel
NF 3: alle Werte ausser dem PK dürgen keine Abhängigkeit haben

PK: Zweck: ref Integrität --FK   MUSS: eindeutig sein  1:N



Datentypen:
'otto' ..vorname

char(50)  'otto                           '    50
varchar(50) 'otto'        4
nchar(50) n: unicode  'otto               ' 50 *2   100
nvarchar(50):  'otto'                   4*2
text()!! nicht mehr verwenden .. ebenso image
nvarchar(max)  ..kann bis 2 GB


Regel: immer wenn flexible Länge varchar
.. wenn fixe Länge char


Datum
date Datum
time
datetime  (ms)  ist aber etwas ungenau.. und zwar um ca 2 bis 3 ms
smalldatetime (sek)
datetime2 (ns)
datetimeoffet (ns und Zeitzone)


int 2,1 mrd
smallint  32000
tinyint 255


money (float mit max 8 Nachkommastellen)

decimal(5,2) 5 gesamte Länge, davon 2 Nachkommastellen







ANgID  Vorname  nachname  Geb PLZ ORT  ORTID     


SQL speichert in Seiten a 8 kb

Pro Seiten max 700 Datensätze
ein DS max 8060 bytes
mx 8072 bytes belegbar

Ziel: seiten möglichst ohne Verlust, da Seiten 1:1 in RAM geladen werden








*/



create table t1 (id int identity, sp1 char(4100), sp2 
varchar(4100))

--je weniger Seiten, desto weniger RAM, desto weniger CPU Aufwand


--Muss denn es immer nvarchar sein...?

--Orderdate = datetime auf ms
--Birthdate datetime

--alle aus dem Jahr 1997
--falsch aber schnell
select * from orders
	where 
		OrderDate >= '1.1.1997' and OrderDate <= '31.12.1997 23:59:59.999'

		--korrekt aber langsam
select * from Orders
	where
		DATEPART(yy, OrderDate) = 1997

--korrekt aber langsam
select * from Orders
	where
		year(OrderDate) = 1997


--falsch aber schnell
select * from orders
	where 
		OrderDate between '1.1.1997' and '31.12.1997 23:59:59.999'



create table t1 (id int identity, sp1 char(4100))


insert into t1
select 'XY'
GO 20000


set statistics io, time on ---Dauer in ms, CPU in ms, Anzahl der Seiten

--Tipp: lass nie die Messung perm laufen

select * from t1 --welche Menge: 20000 * 8 Kb

--Messen ob Seiten schlecht ausgelastet

dbcc showcontig('t1')

--- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%




		

