/*
UNION macht distinct auf die Ergebniszeilen

UNION ALL kein Distinct
gleich viele Spalten und kompatible Datentypen
*/

select 100
UNION
select 200

select 100
UNION
select 'A' --Error

select 100 as SP1
UNION ALL
select 200 as SP2 
UNION ALL
select 300 as Sp3 
UNION ALL
select 100 as Sp4

select 100 as SP1, 200
UNION ALL
select 200 as SP2 , NULL
UNION ALL
select 300 as Sp3 , NULL
UNION ALL
select 100 as Sp4, NULL


