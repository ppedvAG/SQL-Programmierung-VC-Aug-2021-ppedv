Select CustomerID, Country, City, companyname 
into KundenEU
from customers
where
		Country in ('Italy', 'Germany','Greece', 'Austria')


Select CustomerID, Country, City, companyname 
into Kunden
from customers


insert into KundenEU
select 'AAAAA', 'Austria', 'Wien', 'Fa AAAA'

update kunden set City = 'Stuttgart' where CustomerID = 'ALFKI'

--Frage : weleche Datensätz sind identisch und welche unterschiedlich
select * from KundenEU
select * from kunden

--Idee:
	
select * from KundenEU eu inner join kunden k 
	on k.CustomerID=eu.CustomerID
	and
	  k.Country=eu.Country..... --bei 20 Spalten ??

--identische Datensätze.. 
--Achtung das Ergebis der Abfrage wird verglichen
select CustomerID, Country, companyname, city from KundenEU
intersect
select CustomerID, Country, companyname, city  from kunden

--jetzt die Unterschiedlichen
select CustomerID, Country, companyname, city from KundenEU
except
select CustomerID, Country, companyname, city  from kunden


--Achtung--Reihenfolge entscheidend
select CustomerID, Country, companyname, city from Kunden
except
select CustomerID, Country, companyname, city  from KundenEU
intersect..
select
except..
select
intersect