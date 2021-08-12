/*
IF

WHILE 

CASE


*/


--IF

IF 1=0 
select 'A'
select 100 --die 100 kommt...

IF 1=0
	BEGIN
		select 'A'
		select 100
	END


IF 1=0
	BEGIN
		select 100
	END

IF 1=0 select 100

select 2000


If 1=0
	BEGIN
		select 100
	END
ELSE
	BEGIN
		select 200
	END


IF (select COUNT(*) from customers) > 100
	begin
		select 'über 100'
	end
ELSE
	begin
		select 'unter 100'
	end

IF (select customerid, city from Customers) > 100-- Blödsinn


IF
	BEGIN
		IF
	END


select * into o1 from orders


--Freight: Schnitt Frachtkosten 78,2442

--Wenn der Schnitt über 70 liegt dann Reduzierung der Frachtkosten um 10%
--sonst erhöhe um 10%
--versuche festzustellen, was geschehen ist
IF (select COUNT(*) from customers) > 100
	begin
		select 'über 100'
	end
ELSE
	begin
		select 'unter 100'
	end



select avg(freight) from o1


IF (select avg(freight) from o1) > 70
	BEGIN
		update o1 set Freight = Freight /1.1
		print 'Frachtkosten wurde gesenkt'
		select avg(freight) from o1
	END
ELSE
	BEGIN
		update o1 set Freight = Freight * 1.1
		print 'Frachtkosten wurde erhöht'
		select avg(freight) from o1
	END

IF (SELECT ..) > 100 AND (Select ...) < 200  --möglich



--WHILE Schleife 

WHILE (1=1)
	BEGIN
		select 100
	END

WHILE (Select COUNT(*) from Customers) > 100
	BEGIN
		select 100
	END


declare @i as int --NULL

while @i <= 10
	BEGIN
		select @i
	END

declare @i as int = 0--NULL

while @i <= 10
	BEGIN
		select @i
		set @i+=1 -- set @i= @i+1 bloß nicht: set @i=+1... set @i=1
	END

--Jede math Operation NULL ergibt NULL oder auch ein Vergleich


declare @i as int = 0--NULL

while @i <= 10
	BEGIN
		select @i
		set @i+=1 -- set @i= @i+1 bloß nicht: set @i=+1... set @i=1
		IF @i = 5 BREAK --unterbricht die Schleife sofort
		IF @i=3 CONTINUE --spring zum Schleifeneinstieg
		select @i
	END


Select SUM(freight), MAX(freight) from o1
--schnitt: ca 54000     max: ca 830 


--Erhöhe die Frachtkosten um 10%
--bis gilt:
--die Summe sollte 100000 nicht übersteigen
--und der Max Frachtkosten Wert, der darf nicht 1500 übersteigen

begin tran
select MAX(freight), SUM(freight) from o1

While		(select MAX(freight) from o1) <1500 
		and 
			(select SUM(freight) from o1) < 100000
	Begin
		IF 
			(select MAX(freight)*1.1 from o1) <1500 
		and 
			(select SUM(freight)*1.1 from o1) < 100000
		update o1 set Freight = Freight * 1.1
		ELSE
			BREAK
	end

select MAX(freight), SUM(freight) from o1
--COMMIT   ROLLBACK

declare @maxfreight as money, @summefracht money
select @maxfreight=MAX(freight), @summefracht=SUM(freight) from o1


begin tran
select MAX(freight), SUM(freight) from o1

While		@maxfreight< 1500 and @summefracht< 100000
	Begin
			update o1 set Freight = Freight * 1.1
			select @maxfreight=MAX(freight), @summefracht=SUM(freight) from o1
			IF @maxfreight*1.1 > 1500 BREAK
		
		
	end




--Vorsicht bei I U D
update tabelle set sp = Wert .--. ach ohne where alle!!!
	where SP = 10


begin tran
update o1 set Freight = Freight * 1.1
select * from o1
rollback-- commit








begin tran
select MAX(freight), SUM(freight) from o1

While		(select MAX(freight) from o1) <1500 /1.1
		and 
			(select SUM(freight)*1.1 from o1) < 100000
	Begin
	
		update o1 set Freight = Freight * 1.1

		
	end

	rollback



begin tran

ROLLBACK--macht sofort TX rückgängig auch wenn sie verschachtelt waren

COMMIT --bestätigt jede einzelen TX auch bei verschachtelten


begin tran
update Customers set City = 'PARIS'
select * from customers


---CASE WHEN 
--unter 10  A Kunde
--über 500  C Kunde
--Rest      B


--Ausgabe : Customerid, freight, A Kunde / B-Kunde  / C-Kunde

select customerid, freight , 'AKunde'
from o1 
where freight < 10
UNION ALL
select customerid, freight , 'CKunde'
from o1 
where freight > 500
UNION ALL
select customerid, freight , 'BKunde'
from o1 
where freight between 10 and 500


select 
	 CASE
		WHEN BEDING then 100
	 END


select customerid , freight, 
		CASE
				when freight < 10 then 'A Kunde'
				when freight > 500 then 'C Kunde'
				else 'B Kunde'
		END as KundenType
from o1 order by Kundentype desc

--auch möglich wie ein where mit Like
-- CASE WHEN freight between 1 and 10
--         when country like 'A%'


--kleines Beispiel


Liste aus der Tabelle Customers alls Kunden auf
--aber mit Merkmal EU NON EU

--Italy, Austria, Germany  
--Ausgabe Customerid, Companyname, Country, EUNOTEU

select customerid, companyname, country,
		CASE
			WHEN country IN ('Italy', 'Germany', 'Austria') then 'EU'
			ELSE 'NOT EU'
		END as EUNOTEU
from Customers

select Freight, 
	freight *1.1,
	case 
		when Country= 'AUSTRIA' then Freight *1.1
	end
from o1


			
from o1




---Morgen--

--WHERE: Wildcards

--alle die mit A beginnen
--vorletzter Buchstabe muss ein a    _
--zwischen a bis d und alle mit g bis m beginnend

[0-9]   [a-m]  [abcd]  [acfh]

Suche nach % ??
Suche nach '

Suche nach PINs die nicht korrekt
between 0 and 9999
___9
0009


TX-->Sperren--> IX 

CTE

select * from employees



--Rangvergabe
--beste Kunde pro Land

LAND KUNDE UMSATZ

Window Functions


TOP 10  order by.. es müssen aber 11 rauskommen weil der 10. und 11 densleben Wert haben





