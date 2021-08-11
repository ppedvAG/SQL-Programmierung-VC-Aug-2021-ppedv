/*

Prozeduren

wie Batchdateien

in Proc können irgendwelche zahlreichen Statements enthalten sein..

--Vorteil von Prozeduren...
--komplexerer Logik .. Business Logik
--schneller als das eigtl SQL Statement das dahinter steckt

--der Plan wird einmal festgelegt und ist nach Neustart auch gleich vorhanden
--es findet keine Analyse und Kompilierzeit mehr statt... nur einmal beim ersten Aufruf
--aber wenn der Plan nicht opmitmal ist, dann wird dennoch kein anderer gesucht
--SCAN statt seek oder Seek statt scan

--weniger anfällig für SQL Injection 'or 1=1







*/

create proc gp_Demo
as
select GETDATE()
select 100
select 100*200
--ins up del
--exec proc

exec gp_demo


ALTER proc gp_Demo @par1 int, @par2 int
as
select @par1*@par2

exec gp_Demo 12, 20 --240

set statistics io, time on
select * from orders where ShipName like 'B%'


--Suche nach best Kunden

select * from customers --customerid nchar(5)


exec gpKdSuche 'ALFKI' --1 Treffer
exec gpKdSuche 'A' --4 Treffer
exec gpKdSuche '%' --alle Treffer


--Proc
create proc gpname @par Datentyp, @par2 Datentyp


create proc gpKdSuche @kdId nchar(5)
as
select * from Customers where CustomerID like @kdId

exec gpKdSuche 'ALFK'


exec gpKdSuche 'A' --sollte eigtl gehen .. aber tuts nicht


alter proc gpKdSuche @kdId nchar(5) --so stehts in der Tabelle
as
select * from Customers where CustomerID like @kdId + '%' -- 'A....%


alter proc gpKdSuche @kdId nvarchar(5) --so stehts in der Tabelle
as
select * from Customers where CustomerID like @kdId + '%' -- 'A....%


exec gpKdSuche 


alter proc gpKdSuche @kdId nvarchar(5)='%' --jetzt mit default Parameter
as
select * from Customers where CustomerID like @kdId + '%' -- 'A....%

--ku1.. ID

select * into ku1 from ku

alter table ku1 add id int identity



create proc gpID @id int
as
select * from ku1 where ID < @id


set statistics io, time on
--NIX_ID
select * from ku1 where ID<2 --Plan: IX_SEEK mit Lookup

exec gpID 4


select * from ku1 where ID<14000 --von IX Wechsel zu SCAN --60577 CPU-Zeit = 283 ms, verstrichene Zeit = 397 ms.

select * from ku1 where ID<10000000 --von IX Wechsel zu SCAN --60577 

exec gpID 10000000--kein Planwechsel, weil Proz einmal den Plan festlegt und dabei bleibt!!
			--krasse logische Lesevorgänge: 1118975 , CPU-Zeit = 4328 ms, verstrichene Zeit = 26306 ms.



exec gpID 12000 --..ok  seek
exec gpID über 12000 --.. wäre SCAN besser

--besser im SCAN oder besser immer SEEK

--besser SCAN, wenn die Mehrheit der Abfragen über 12000 liegen
--besser SEEK , wenn die Mehrheit unter 12000 liegt


exec gpID 1000000

exec gpID 2

--wie bekomme ich einen neuen PLAN

--Plan löschen

dbcc freeproccache --alle Pläne weg.. vorsicht

exec gpID 1000000 -- ab jetzt immer Table scan

exec gpID 2


--Tipp für Proz:
--.schreibe Proz niemals benutzerfreundlich  A% ALFKI ALF einer oder alle
-- am bestebn so, dass immer der gleiche Plan optimal ist

create proc gpid2 @par int
as
if @par < 12000
exec gpidseek @par --macht immer Seek weil gpidseek 5 
else
exec gpidscan @par  --macht immer scan weil gpidscan 14000

--schlecht
create proc gpdemo2 @par1 int
as
if @par1 < 10 --wird zuerst mit 5 die Proc aufgerufen, wird die Proc für orders optimiert
select * from orders where OrderID < @par1
else
select * from products where UnitPrice < @par1 --und die hier grob geschätzt
















select * from Customers where CustomerID like '%'