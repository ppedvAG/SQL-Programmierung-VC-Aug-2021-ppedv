--ab bier ein KOmmentar
select * from test -- Kommentar

/*
select 


*/


select 
	customerid,companyname,city ,Region

from customers


--WHERE GROUP JOIN
--% steht für beliebig viele Zeichen
select * from Customers
	where companyname like 'A%'

--vorletzte Buchstabe ein a ist


-- _ steht für genau ein Zeichen
select * from Customers
	where companyname like '%A__'


update Customers 
		set CompanyName = ' Alfreds % Kiste'
		where CustomerID = 'ALFKI'

--Suche nach % Zeichen

select * from Customers 
	where companyname like '%%%' --= %

select * from [Order Details]

select [Kd-Nr] from tabelle

select * from Customers
	where CompanyName like '%[%]%'

--[ ] definieren einen Wertebereich
--steht für ein Zeichen genau

--Wir suchen alle Kunden die mit 
-- A-D beginnen
--Companyname

select * from Customers
	where CompanyName >= 'A'
		and
		CompanyName <'E'

select * from Customers
	where CompanyName like '[a-d]%'


--Suche nach allen die mit A c e oder h beginnen

select * from Customers
	where CompanyName like '[aceh]%'


--Suche nach falschen PINS   1234  [0-9][0-9][0-9][0-9]
--ae34

select * from girokonto	
	where PIN not like '[0-9][0-9][0-9][0-9]'
	-- 0065


--  '
-- Suche nach allen Firmen die ein ' im Namen haben


select * from Customers
	where 
		CompanyName like '%['']%'



exec msdb..sp_send_dbmail @query='select where '''


--Wir suchen alle die mit a bis c beginnen oder mit s-z
--^ verneint den Wertebereich



select * from Customers 
where CompanyName like '[^a-c|s-z]%A_'



--where sp = (Select ...) --die Uabfrage darf nur eine Zeile und Zeile ausgeben

--where sp IN (Select ..) --die UAbfrage darf mehr Zeilen habern aber nur eine Spalte

select * from Customers 
	where Country in (Select Country from Suppliers)


--JOIN
--nicht mehr gültig
select * from tabelle, tabelle2, tabelle3 where 


select * from Customers c, orders o
	where c.CustomerID=o.CustomerID


-- INNER LEFT RIGHT CROSS

select * from 
	Customers c	left join orders o ON c.CustomerID=o.CustomerID
			inner join [Order Details] od on od.OrderID=o.OrderID
			inner join Products p on p.ProductID=od.ProductID
			inner join Employees e on e.EmployeeID=o.EmployeeID


--LEFT und RIGHT JOIN
--Welche Kunden haben nichts gekauft?

select customerid from Customers c --91

select distinct customerid from orders --89


select c.customerid , o.CustomerID
from 
	Customers c left join orders o ON c.CustomerID=o.CustomerID
	where o.CustomerID is NULL


--als Right Join
select c.customerid , o.CustomerID
from 
	 orders o right join Customers c ON c.CustomerID=o.CustomerID
	where 
			o.CustomerID is NULL


--Alternative
select customerid from customers
where customerid not in (
select customerid from orders)

select customerid from customers
except
select customerid from orders



--Select * from employees

--Liste der Ang (Lastname Firstanme und dessen Vertreter

--Laura Seattle  Seattle Nancy
--Nancy Seattle  Seattle Laura


select e1.LastName, e1.City, e2.City,e2.LastName
	from 
		Employees e1 inner join Employees e2
			ON e1.City=e2.city
		where
			e1.LastName != e2.LastName
order by e1.City, e1.LastName


--CROSS.. 
--Dauer dieser Abfrage..30min.. 162 Mio 
select * from Customers, Orders, [Order Details]

select * from Customers cross join orders

--Wofür..? ????
--Tabelle Getränke  Tabelle Speisen



---GROUP BY

--AGG
select AVG(freight), MAX(freight),
	AVG(freight)- MAX(freight)  from orders


select 
	Shipcountry,
	AVG(freight), MAX(freight),
	AVG(freight)- MAX(freight)  from orders
	group by shipcountry

select 
	Shipcountry,Shipcity,
	AVG(freight), MAX(freight),
	AVG(freight)- MAX(freight)  from orders
	group by 	Shipcountry,Shipcity


-- AVG und SUM der Frachtkosten pro Kunde und Land in Orders
--Land, Kunde, AVG, SUM 

select 
	Shipcountry, Customerid ,
	SUM(freight) as Summe, AVG(freight) as Schnitt
from Orders
	group by ShipCountry, Customerid
	Order by 1,2

--aber nur die , die vom Ang Nr 3 und 4 betreut wurden

select 
	Shipcountry, Customerid ,
	SUM(freight) as Summe, AVG(freight) as Schnitt
from Orders
	where EmployeeID IN (3,4)
	group by ShipCountry, Customerid
	Order by 1,2

--aber nnur die, wo die Sumem > 2000 ist

select 
	Shipcountry, Customerid ,
	SUM(freight) as Summe, AVG(freight) as Schnitt
from Orders
	where EmployeeID IN (3,4)
	group by ShipCountry, Customerid
	Order by 1,2

--

select 
	Shipcountry, Customerid ,
	SUM(freight) as Summe, AVG(freight) as Schnitt
from Orders
	where EmployeeID IN (3,4)
	group by ShipCountry, Customerid having SUM(freight) > 2000
	Order by 1,2

--Das Having ist nur für das Filtern der agg Werte da
-- Tu niemals etwas mit Having filtern, was ein Where liefern 
--im Having sollten nur AGG sein

select 
	Shipcountry, Shipcity,
	SUM(freight) as Summe, AVG(freight) as Schnitt
from Orders	
	group by ShipCountry, shipcity
	Order by 1,2


--with cube with rollup

select 
	Shipcountry, Shipcity,
	SUM(freight) as Summe, AVG(freight) as Schnitt
from Orders	
	group by ShipCountry, shipcity
	with rollup
	Order by 1,2


select 
	Shipcountry, Shipcity,
	SUM(freight) as Summe, AVG(freight) as Schnitt
from Orders	
	group by ShipCountry, shipcity
	with cube
	Order by 1,2

-- Cube und Rollup machen Zwischenaggregate
--Was ist der Unterschied zwischen Rollup und Cube
--Rollup.. macht hierarchisch

--Annahme die Ergebnismenge ist sehr groß
--Faktentabelle

select * into ku10 from ku1

set statistics io, time on
select country, SUM(freight) from ku1
where EmployeeID in (3,4)
group by country


select country, SUM(freight) from ku10
where ShipCity = 'Berlin'
group by country

--KU10 nur 3,7 MB ..KU1 insg 500MB
-- stimmt oder stimmt nicht
--sie ist 3,7 MB.. und das auch im RAM....











	





