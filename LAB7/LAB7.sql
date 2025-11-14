create database Supplier1;
use Supplier1;
create table Supplier(
					sid int primary key,
                    sname varchar(20),
                    city varchar(20)
                    );
create table Parts(
				pid int primary key,
                pname varchar(30),
                color varchar(30)
                );
create table Catalog(
			sid int references Supplier(sid),
            pid int references Parts(pid),
            cost int
            );
insert into Supplier values(10001,'Acme Widget','Banglore'),(10002,'Johns','Kolkata'),(10003,'Vimal','Mumbai'),(10004,'Reliance','Delhi');
insert into Parts values(20001,'Book','Red'),(20002,'Pen','Red'),(20003,'Pencil','Green'),(20004,'Mobile','Green'),(20005,'Charger','Black');
insert into Catalog values(10001,20001,10),(10001,20002,10),(10001,20003,30),(10001,20004,10),(10001,20005,10),(10002,20001,10),(10002,20002,20),(10003,20003,30),(10004,20003,40);
-- 1)
select pname from parts where pid in (select pid from catalog);
-- 2)
select sname from supplier where sid in (select sid from catalog group by sid having count(distinct pid) = (select count(pid) from parts) );
-- 3)
select sname from supplier where sid in(select sid from catalog where pid in (select pid from parts where color = 'Red'));
-- 4)
SELECT p.pname
FROM parts p
JOIN catalog c ON p.pid = c.pid
JOIN supplier s ON s.sid = c.sid
WHERE s.sname = 'Acme Widget'
  AND p.pid NOT IN (
        SELECT c2.pid
        FROM catalog c2
        JOIN supplier s2 ON s2.sid = c2.sid
        WHERE s2.sname != 'Acme Widget'
    );
-- 5)
select c.sid from catalog c WHERE c.cost > (select avg(c2.cost) from catalog c2 where c2.pid = c.pid);
select s.sname,c.pid from supplier s join catalog c on s.sid = c.sid where c.cost = (select max(c2.cost) from catalog c2 where c2.pid = c.pid);