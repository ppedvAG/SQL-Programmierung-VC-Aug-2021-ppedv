--Variablen

/*
lokale Variablen
@variable
Lebensdauer: nur w�hrend des Batches (Laufzeit)  .. Achtung GO = Batchdelimiter
Zugriff: nur die  Session, in der sie erstellt wurde


globale Variablen
@@variable f�r User in der Theorie fast absurd
Lebensdauer: nur w�hrend des Batches  .. Achtung GO = Batchdelimiter
Zugriff auch in anderern Session m�glich
oft Systemvariablen




--Sinn und Einsatz

oben!!

�bersichtlichen Code


Tipp: Definiere flexible Datentypen  mit etwas gr��eren Variablen etwas mehr als Doppelte, vor allem bei order by

char(50).. sch�tzung 50 Zeichen
varchar(50) .. Sch�tzung 50% = 25 

mit Sch�tzung =RAM Bedarf



*/

select @@CONNECTIONS, @@SERVERNAME, @@SPID


--Deklarieren
declare @var1 as int
set @var1=10

select @var1
select * from orders where freight < @var1

--Wert aus SQL Abfragen

declare @Anzahl as int
select @Anzahl=COUNT(*) from customers
select @Anzahl

select * from orders where Freight < @Anzahl

declare @var2 as int = 100 --.. sofortige ZUweisung

--geht nicht..
declare @Anzahl as int
select @Anzahl=COUNT(*), COUNT(*) from customers --ie einer Variablen einen Wert zuweist, darf nicht mit Datenabrufvorg�ngen kombiniert werden.
select @Anzahl

select * from orders where Freight < @Anzahl

declare @var3 as int = 1
set @var3 = 5
GO --vernichtet jede Variable

select @var3 *100

select * from orders --Schnitt der Frachtkosten 
--welche Bestellungen liegen unterhalb des Durchschnitts


declare @schnitt as money
select @schnitt=AVG(freight) from orders
select @schnitt

select * from orders where Freight < @schnitt --589


select * from Orders
	where 
	Freight < (select AVG(Freight) from Orders)


	
declare @varTab as table (id int, sp1 int)


select * from @varTab

insert into @varTab
select 1,10

select * from @vartab
