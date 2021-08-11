/*
Indizes


in Plänen sollte immer ein Seek auftauchen, wenn ein where steht

grupp. IX = Tabelle in physik sortierter Form
..gibts pro Tab nur 1 mal
..besonders gut bei Bereichsabfragen
..aber at. auch sehr gut bei rel geringen Ergebnismengen
-- typisch: PLZ, Datumsfelder


nicht grupp. IX zusätzliche Menge an Daten in sort Form
..kann es auch 1000mal pro Tabelle
..gut wenn rel wenig rauskommt (1% - 80%) evtl kein Seek mehr
--typisch für: ID spalten PK


ausschlaggebend: was steht im where
	> < = between like != like

vermeide Lookups..!!


-------------------------
zusammengesetzten IX best aus mehr Spalten
Baum besteht aus mehr Spalten
kann nur maax 16 Spalten enthalten; max 900byte max Schlüssellänge

IX mit eingeschl Spalten 
zusätzliche SPalten des SELECT, die den Baum nicht belasten

gefilterten IX
..nicht alle Datensätze der Tabelle 
--lohnt sich nur , wenn es weniger Ebenen werden


abdeckenden IX  der perfekte IX für die Abfrage
part IX
ind Sicht
eindeutiger IX  Spalten ergeben Eindeutigkeit
realer hypothetischer IX
--------------------------
Columnstore IX

*/



select * into kunden from customers

select * from kunden

insert into Customers (CustomerID, CompanyName)
	values
					('ppedv', 'Fa ppedv')


insert into kunden (CustomerID, CompanyName)
	values
					('ppedv', 'Fa ppedv')
select * from orders where CustomerID  like 'ALFKI%'

select * from customers
select * from kunden



--SEEK od SCAN

select * from best --TAB SCAN  od CL IX SCAN
--CL IX wg PK...
--eindeutig kann durch CL IX aber auch durch NON CL IX gemacht werden

--Der CL IX wurde auf dié ID verschwendet
--über Entwurfsansicht kann der CL IX auf NON CLUstered gesetzt werden
--PK bleibt als NICHT GR eindeutig


SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipName, 
                         Orders.ShipCity, Orders.ShipCountry, Employees.LastName, Employees.FirstName, Employees.BirthDate, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, 
                         Products.ProductName, Products.UnitsInStock
INTO KU
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID


insert into KU
select * from ku
--solange bis 1 Mio ca


select * into ku1 from ku

set statistics io, time on

alter table ku1 add id int identity

select id from ku1 where id = 100 --Plan:ohne IX SCAN.. TABLE SCAN
--60000 Seiten 250ms CPU 35ms Dauer

--besser: 
--zuerst CL IX festlegen welche Abfragen scannen häufig Bereiche
--CL IX auf OrderDate resviert

--NIX_ID
select id from ku1 where id = 100 --PLAN: SEEK auf NIX_ID
--jetzt 3 Seiten Dauer: 0 ms....

select ID, freight from ku1 where ID= 100 --NIX_ID SEEK.. aber anrufen
--LOOKUP .. 4 Seiten ....

select ID, freight from ku1 where ID< 100
--der Lookup wird immer teurer, ab etwas über 12000 Table scan

--besser ohne Lookup

--NIX_ID_FR.. reiner Seek
select ID, freight from ku1 where ID< 100


--besser mit IX und eingeschloss.. Spalten
--NIX_ID_i_FR
select ID, freight from ku1 where ID< 100
--AGGREGATE

--IX: NIX_CY_i_UPQU
select companyname, SUM(unitprice*quantity) as Umsatz
from ku1
where 
	Country = 'Germany'
group by 
		companyname

--NIX_CY_EID_i_CNUPQU
select companyname, SUM(unitprice*quantity) as Umsatz
from ku1
where 
	Country = 'Germany' and EmployeeID = 2
group by 
		companyname

--NIX_ ..kein Vorschlag mehr
--NIX_CY_..   NIX_EID_....
select companyname, SUM(unitprice*quantity) as Umsatz
from ku1
where 
	Country = 'Germany' or EmployeeID = 2
group by 

--Selektive Spalte zuerst
--NIX_CICY_i_frEid
select freight, employeeid
from ku1
where City = 'Berlin' and Country='Germany'
		


