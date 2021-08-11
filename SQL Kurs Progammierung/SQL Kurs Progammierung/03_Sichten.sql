--Sichten

/*
Sicht ist eine gemerkte Abfrage
Sicht verhält sich wie Tabelle
I U D 

Einsatz von Sichten:
komplexe Abfragen zu vereinfachen

wg Rechten .. Sichten können Rechte haben

*/

--Ist die Sicht schneller oder gleich schnell oder langsamer 
--als das adhoc SQL Statement
--Sicht ident mit SELECT

select * from sicht 
--vs
select .......................................

create view Sichtname
as
select ......


create table slf (id int identity, stadt int, land int)

insert into slf
select 10,100
UNION 
select 20,200
UNION
select 30,300

select * from slf

create view vslf
as
select * from slf;
GO

select * from vslf
select * from slf;

alter table slf add fluss int

update slf set fluss = id *1000

select * from vslf --setzt den * nicht um 


alter table slf drop column stadt
--komplette falsche Ausgabe...

--Zwang: kein * !!!

--schemabindung

drop table slf
drop view vslf

create table slf (id int identity, stadt int, land int)

insert into slf
select 10,100
UNION 
select 20,200
UNION
select 30,300

select * from slf

create view vslf with schemabinding --exaktes Arbeiten kein * und Angabe des Schemas
as
select id, stadt, land from dbo.slf;
GO

alter table slf add fluss int

update slf set fluss = id *1000

select * from vslf

alter table slf drop column Land --geht nicht mehr --Error


--komplexe Statement vereinfachen
create view vKU
as

SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle,
				Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, 
				Orders.ShipName, 
                         Orders.ShipCity, Orders.ShipCountry, Employees.LastName, 
						 Employees.FirstName, Employees.BirthDate, [Order Details].OrderID, 
						 [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, 
                         Products.ProductName, Products.UnitsInStock
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID


select * from vKu

--ich brauche alle Kunden, die weniger als 1 Frachtkosten hatten

select distinct companyname from vKU where Freight <1


select distinct companyname from Customers c inner join orders o on o.CustomerID=c.CustomerID
	where Freight<1 

	--Sicht nicht zweckentfremden.. di eholt wirklich alles was drin steht.. alle Tabellen


--wg Rechten....


dbo   dbo   dbo  dbo  dbo  dbo
--V1-->V2-->v3-->v4-->V5-->Tab

--PROC (SICHTEN und andere Proc)

--Besitzverkettung

--STATS (dbo) ----> dbo(dbo)


create view vempl
as
select lastname, firstname from Employees where Country = 'UK'

--erlaube niemenden (ausser Admin) das Erstellen von Sichten, F() oder Proz
--da sie sonst Objekte gelesen werden können, die einem sogar verweigert..
--Besitzverkettung




