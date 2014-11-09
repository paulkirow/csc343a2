-- Add below your SQL statements. 
-- You can create intermediate views (as needed). Remember to drop these views after you have populated the result tables.
-- You can use the "\i a2.sql" command in psql to execute the SQL commands in this file.

-- Query 1 statements
delete from query1;
create view notHighest as select neighbour.country, neighbour.neighbor from (((select cid, height from country) as c1 join neighbour on cid=neighbor) cross join ((select cid, height from country) as c2 join neighbour as n2 on cid=neighbor)) where neighbour.country=n2.country AND c1.height < c2.height;
create view highest as select neighbour.country, neighbour.neighbor from neighbour full outer join notHighest on notHighest.country=neighbour.country and notHighest.neighbor=neighbour.neighbor where notHighest.neighbor IS NULL;
insert into query1 select c1.cid as c1id, c1.cname as c1name, c2.cid as c2id, c2.cname as c2name from (country as c1 join highest as h1 on country=cid) join (country as c2 join highest as h2 on neighbor=cid) on h2.country=h1.country;
drop view nothighest CASCADE;

-- Query 2 statements

delete from query2;
insert into query2 (select country.cid, country.cname from (country left join oceanAccess on country.cid=oceanAccess.cid) where oid IS NULL);

-- Query 3 statements

create view landLocked as select country.cid, country.cname from (country left join oceanAccess on country.cid=oceanAccess.cid) where oid IS NULL;
create view landNeighbours as select * from neighbour join (select cid from landlocked) as l on l.cid=neighbour.country;
create view notOneNeighbour as select l1.country from landNeighbours as l1 cross join landNeighbours as l2 where l1.cid=l2.cid and l2.neighbor!=l1.neighbor;
create view landlockedOne as select cid, cname from (landlocked full outer join notOneNeighbour on landLocked.cid=notOneNeighbour.country) where notOneNeighbour.country IS NULL;
select c1id, c1name, c2id, c2name from (select neighbour.country, country.cid as c1id, country.cname as c1name from country join (landlockedOne join neighbour on cid=country) on neighbour.country=country.cid) as c1 join (select neighbour.country, country.cid as c2id, country.cname as c2name from country join (landlockedOne join neighbour on cid=country) on neighbour.neighbor=country.cid) as c2 on c1.country=c2.country;
drop view landlocked CASCADE;

-- Query 4 statements



-- Query 5 statements



-- Query 6 statements



-- Query 7 statements



-- Query 8 statements



-- Query 9 statements



-- Query 10 statements


