create table numbers (id int identity, sp1 int)
GO 

insert into numbers
select 100
GO 30000


create table T11(
		id int identity not null primary key,
		x decimal(8,2) not null default 0,
		spalten char(100) not null default '#'
		)
go
--select * from t1
--select abs(checksum(NEWID()))*0.01%20000
insert T11(x)
	select 	0.01 *ABS(checksum(newid()) %20000) from Numbers
		where id<= 20000

select abs(checksum(NEWID()))

select checksum(NEWID())


select * from t11

--Ausgabe
--ID  fldSumme
--1     111,51
--2     210
--3     343


select T11.id, SUM(t2.x) as rt
from T11
	inner join T11 t2 on t2.id<=T11.id
	group by T11.id
	order by id
--dauert 2 min

--Variante
select T11.id, 
		(select SUM(t2.x) from T11 as t2 where t2.id<= T11.id) as rt
from T11 order by id

--dauert länger
--ich bin für zeilenweise vorgehen da
--Cursor...


/*
1 Deklarieren ähnlich wie Variable
2 ein SELECT stellt den Cursor ("Markiere best Daten")
3. fetch next
4 für jeden DAtensatz 

--Wann brauch ich das.. 

SP1  SP2
A	100
B   200
A   100
--Löoschen über SSMS ergibt Fehler
delete from tabelle where sp1= A and Sp2 = 100



*/
drop table #t

create table #t(id int not null primary key, s decimal(16,2) not null)

declare @id int, @x decimal(8,2), @s decimal (16,2)
set @s=0 --sonst NULL

declare #c cursor fast_forward for
		select id, x from T11 order by id

open #c
	while (1=1) --Begin  end break: bricht sofort die Schleife ab  continue springt zum schleifeneinstieg
		begin 
			fetch next from #c into @id, @x
			if (@@FETCH_STATUS !=0) break
			set @s=@s+@x

			if @@TRANCOUNT=0
				begin tran
				insert into #t values (@id, @s)

			if (@id %1000)=0
				commit
		end

if @@trancount >0
	commit
	close #c
	deallocate #c

select * from #t order by 1


select ID, SUM(x) over (order by id rows unbounded preceding) summe 
from t11

--Window Function

RANK()
Row_number()
dense_Rank()
Ntile(4)--- 


select 
	orderid, employeeid, customerid, freight,
	ROW_NUMBER() over (order by freight desc) as RANG
from orders
order by 2


select 
	orderid, employeeid, customerid, freight,
	ROW_NUMBER() over (
						partition by employeeid
						order by freight desc) as RANG
from orders
order by 2

--RANK überspringt einen RANG bei gleichem Wert
select 
	orderid, employeeid, customerid, freight,
	RANK() over (
						partition by employeeid
						order by freight desc) as RANG
from orders
order by 2


select freight, shipcountry, shipcity from Orders

--welche Stadt in welchem Land hatte die höchsten Frachtkosten

;with cte
as
(
select 
	shipcountry, shipcity, freight,
	RANK() over
				(
				partition by shipcountry, shipcity --Block bilden
				order by freight desc) as Rang --innerhlab des Blocks Rang
from orders
)
select * from cte where Rang = 1



select orderid, freight,
		NTILE(830) over (order by freight asc)
		from orders




