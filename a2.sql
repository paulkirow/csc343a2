-- Add below your SQL statements. 
-- You can create intermediate views (as needed). Remember to drop these views after you have populated the result tables.
-- You can use the "\i a2.sql" command in psql to execute the SQL commands in this file.

-- Query 1 statements
delete from query1;
DROP VIEW IF EXISTS countryWithNeighbors CASCADE;
DROP VIEW IF EXISTS maxNeighbor CASCADE;
DROP VIEW IF EXISTS maxWithCountry CASCADE;
CREATE VIEW countryWithNeighbors AS SELECT n.country, n.neighbor, c.cname, c.height
  FROM neighbour as n
  INNER JOIN country as c
  ON n.neighbor = c.cid;
CREATE VIEW maxNeighbor AS SELECT country, MAX(height) FROM countryWithNeighbors GROUP BY country;
CREATE VIEW maxWithCountry AS SELECT n.country as c1id, c.cname as c1name, n.neighbor as c2id, n.cname as c2name
  FROM countryWithNeighbors as n
  JOIN maxNeighbor as m
  ON n.height = m.max 
  AND n.country = m.country
  JOIN country as c
  ON c.cid = n.country
  ORDER BY c1name ASC;
insert into query1 select * FROM maxWithCountry
DROP VIEW IF EXISTS maxNeighbor CASCADE;
DROP VIEW IF EXISTS maxWithCountry CASCADE;

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


