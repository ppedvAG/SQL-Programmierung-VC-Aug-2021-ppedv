begin try
--code
end try
begin catch
--Feherlroutine 
end catch

begin try
select 1/0
end try
begin catch
select ERROR_MESSAGE(), ERROR_SEVERITY(), ERROR_NUMBER(), ERROR_PROCEDURE()
select APP_NAME(), HOST_NAME(), GETDATE(), SUSER_NAME()
end catch

--Ebene 15,16 DAU
--Ebene 14 unzureichende Rechte
--Ebene 17 und höher... 25
--



--Erstelle einer Feherroutine
--für eine Abfrage, die ein ungültiges Objekt aufruft

--es kommt wieder Eerwarten die Fehlermeldung, weil Objekt nicht existiert
begin try
select * from tab7
end try
begin catch
select ERROR_MESSAGE(), ERROR_SEVERITY()
end catch



create proc gpdemo100
as
select * from tab7

declare @var varchar(1000)
set @var= 'Select * from '
set @var= @var+ ' Customers'
select @var
exec (@var)

exec gpdemo100


begin try
exec gpdemo100
end try
begin catch
select ERROR_MESSAGE(), ERROR_SEVERITY(), ERROR_PROCEDURE()
end catch


--Schreibe einen INS der in Customers einen neuen DS einfügt
--aber übergebe nur den Companyname
--das ganze in einer Fehlerroutine
--ergänze nun das ganze um eine Transaktion
--und gib den @@TRancount aus
--in Fehlerbahndlung muss ROllback stattfinden
--ansonsten commit

begin tran
select @@TRANCOUNT
begin try

	insert into Customers (CompanyName) values ('ppkdhfskdfh')
	commit
end try
begin catch
	select ERROR_MESSAGE()
	ROLLBACK
	select @@TRANCOUNT
end catch
--commit
select @@TRANCOUNT



RAISERROR('Der Wert ist ungültig oder Unsinn',
			16,
			1)


select 1/0
select * from orders

--Gibts denn Kieferkosten in höhe von 10000 Euro.. never!!!!
begin tran
select @@TRANCOUNT
declare @var2 as varchar(1000)
set @var2= 'ppedv'
begin try
	if @var2='ppedv' RAISERROR('ppedv darf nicht rein', 15, 0)
	insert into Customers (CompanyName) values (@var2)
	SELECT 1000
	commit
end try
begin catch
	select ERROR_MESSAGE()
	select 5000
	ROLLBACK
	select @@TRANCOUNT
end catch
--commit
select @@TRANCOUNT


