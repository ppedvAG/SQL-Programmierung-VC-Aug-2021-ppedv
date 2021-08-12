/*

Tool für DB Design

Designregeln:

- verwende nur die Datentyoen, die du wirklich braucht...
	--kein nvarchar statt varchar
	--kein char wenn varchar (fixe Länge vs var Länge)
	--kein datetime , wenn nicht notwendig  (GebTag)
-- Normalisierung ist ok (bis Grad 3)
-- gezielt Redundanz
-- PK als CL IX oft zweifelhaft verutlich besser als NON CL eindeutig
-- Lege immer zuerst fest: cl IX auf die entspr Spalten fest



-- Auswirkung: weniger Volumen , dann mehr Datensätze in Seiten--> weniger Seiten--> weniger  RAM
					Seiten 1:1 in RAM
						--->4:707:02
						-- Datei:Seite:Slot


DB hat eine ldf Datei (Logfile). mdf Datei (master Data File) Daten, weitere Dateien  .ndf

CL IX
	pro Tabelle nur einmal möglich, weil CL IX =  Tabelle
	Datensätze werden Spalten sortiert abgelegt
	Bes gut geeignet für Bereichsabfragen, aber nat auch für Abfragen mit eindeutigen Ergebnissen

NON CL
	pro Tabelle ca 1000 (auch bei 3 Spalten)
	sehr gut bei Abfragen, die rel geringe Ergebnismenge erzeugen
	erzeugt Kopien von Spaltenwerten


eindeutigen : (PK) Schlüsselspalten sind und belieben eindeutig
gefilterten: nur ein Teil der Daten sind im IX vertreten
zusammengestzten IX: wenn der IX und IX Baum aus mehr Spalten besteht.. gugg auf das where (AND OR)
mit eingeschloss Spalten: zusätzliche Spaltenwerte am Ende des Baums (Blatt) , belastet nicht den Baum




*/


select * from Products



select top 3 * from ku1 --HEAP
select top 3 * from ku1 --CL IX (fängt immer beim Wurzelknoten an)

--NIX_SC_PI_i_CNCYFRUS
select companyname, country, AVG(freight),SUM(unitsinstock)
from ku1
	where 
		Shipcountry = 'Canada' and Productid < 5
group by companyname, country


--STRG SHIFT + R.. akt den Intellisense Cash.. keine roten Unterstreichungen mehr

--Im Plan sollte immer was zu sehen sein, wenn ein where vorkommt: 
--SEEK und am besten kein Lookup
--wenn schon ein SCAN, dann ein IX SCAN

---Prozeduren:

/*
wird mit exec ausgeführt (kein Select  exec proc)
beinhaltet alles möglich an TSQL und beliebig viele Anweisungen
gilt als schneller, weil der Plan beim ersten Aufruf erstellt wird und kompiliert hinterlegt wird
sollten nicht benutzerfreundlichen A% oder A oder nix angeben
Proz enthalten oft Businesslogik

exec gPProc 127, '1.1.1997' --kürzer und schneller

select * from sicht where kundenummer = 127 and Datum = '1.1.1997'

Sicht ist dann ganz gut, wenn du mit anderen Sichten und Tabellen joinen musst

*/


--Löschen eines Kunden

select * from customers

delete from Customers where CustomerID = 'ALFKI'
delete from orders where CustomerID = 'ALFKI'
delete from [Order Details] where 

exec gpKundenDel 'ALFKI'





create proc gpTest2
as
select 
GETDATE()
GO-- trennt die Anweisungen von einander


exec 
					gptest














