/*
es gibt immer TX

ins up del  sind bereits TX!

--wenn wir TX steuern wollen dann 
--begin transaction 
--commit oder Rollback

Während einer TX werden Sperren gesetzt

Sperren: 
Zeile
Seite
Block
Partitionen
Tabelle
Schema
Datenbank


Halte TX so kurz wie möglich
Nie in TX Benutzerfragen stellen

IX können das Sperrniveua auf Zeile herunterbrechen
allerdings auch bei Partitionen
..hat man nix davon --> Tabellen Sperre

bei vielen Zeilen --> Seite
viele Seiten--> Block
viele Blöcke--> Tabelle

dann sid aber auch viele DS gesperrt die man gar nicht anfasst




*/

select * into k1 from customers

begin tran
select @@TRANCOUNT
update k1 set city = 'PARIS' where CustomerID = 'ALFKI'
Up Orders
up employees
select * from k1
rollback

USE [master]
GO

ALTER DATABASE [Northwind] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO



Begin tran
select @@TRANCOUNT
		Begin TRan

			Begin tran

			select @@TRANCOUNT

Rollback --> 0 wird alles egal in welcher TX rückgängig machen

COmmit --dagegen muss jede TX committed werden..



GO
ALTER DATABASE [Northwind] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
