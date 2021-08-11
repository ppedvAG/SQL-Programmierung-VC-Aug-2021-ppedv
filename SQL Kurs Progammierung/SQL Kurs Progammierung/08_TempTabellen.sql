--Temp Tabellen

--beste Kunde und schlechteste Kunde
--gemessen an Summe Frachtkosten

select * from orders

--liste mal den besten Kunden nach Summe Fracht auf


select top 1 customerid, SUM(freight) as SummeFracht from orders
group by customerid
order by SummeFracht asc

--der schlechteste
select top 1 customerid, SUM(freight) as SummeFracht from orders
group by customerid
order by SummeFracht desc


---Aufgabe aber.. in einer einzigen Ausgabe


select top 1 customerid, SUM(freight) as SummeFracht from orders
group by customerid
--order by SummeFracht asc--der hier ist falsch .. nur ein Order by pro Select
UNION ALL
select top 1 customerid, SUM(freight) as SummeFracht from orders
group by customerid
order by SummeFracht desc -- der bezieht sich auf den gesamten UNION


--Dilemma Alternative
--es dürfen in den SELECT die mit UNION 
--verbunden werden keine Order by verwendet werden
select * from 
(
	select top 1 customerid, SUM(freight) as SummeFracht from orders
	group by customerid 
	order by SummeFracht asc
) t1
UNION ALL
select * from 
(
	select top 1 customerid, SUM(freight) as SummeFracht from orders
	group by customerid
	order by SummeFracht desc) t2


--Idee für Alternative: statt alles in ein Statement zu packen
--lieber Schritt für Schritt


/*
lokale temp Tabellen
#tabelle
Lebensdauer: gilt für die gesamt Sessionzeit, 
--bis sie in der Session gelöscht wird oder die Session geschlossen wird
Zugriff nur innerhlab der ErstellerSession


globale temp Tabellen
##tabelle
Zugriff: jeder auch ausserhalb der Session
Lebensdauer: bis sie in der Session gelöscht wird 
oder die Session geschlossen wird
allerdings werden laufende Abfragen nicht unterbrochen

Einsatz:
um komplexen Code zu vereinfachen


*/

select * into #t from orders
GO
select * into ##t from orders
GO


select * from #t









select top 1 customerid, SUM(freight) as SummeFracht 
into #goodCust
from orders
group by customerid
order by SummeFracht asc 
--order by SummeFracht asc--der hier ist falsch .. nur ein Order by pro Select

select top 1 customerid, SUM(freight) as SummeFracht 
into #badCust
from orders
group by customerid
order by SummeFracht desc -- der bezieht sich auf den gesamten UNION


select * from #badCust
UNION all
select * from #goodCust

--Ziel: Ausgabe CustID Summe Fracht TXT guter Kunde / schlechter Kunde
--als eine einzige Ergebnistabelle mit einer einzigen #tabelle
drop table if exists  #result

select top 1 customerid, SUM(freight) as SummeFracht , 'bad Cust' as KundenTyp
into #result
from orders
group by customerid
order by SummeFracht desc

insert into #result
select top 1 customerid, SUM(freight) as SummeFracht, 'good guy' 
from orders
group by customerid
order by SummeFracht asc

select * from #result


--Alternative: fixe Tabellen.. müssen gepflegt werden