-- Add below your SQL statements. 
-- You can create intermediate views (as needed). Remember to drop these views after you have populated the result tables.
-- You can use the "\i a2.sql" command in psql to execute the SQL commands in this file.

-- Query 1 statements
DELETE FROM query1;
--DROP VIEW IF EXISTS countryWithNeighbors CASCADE;
--DROP VIEW IF EXISTS maxNeighbor CASCADE;
--DROP VIEW IF EXISTS maxWithCountry CASCADE;
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
DROP VIEW IF EXISTS countryWithNeighbors CASCADE;
DROP VIEW IF EXISTS maxNeighbor CASCADE;
DROP VIEW IF EXISTS maxWithCountry CASCADE;

-- Query 2 statements
DELETE FROM query2;
INSERT INTO query2 (
SELECT country.cid, country.cname 
  FROM country 
  LEFT JOIN oceanAccess 
  ON country.cid=oceanAccess.cid 
  WHERE oid IS NULL);

-- Query 3 statements
DELETE FROM query3;
--DROP VIEW IF EXISTS landLocked CASCADE;
--DROP VIEW IF EXISTS landNeighbors CASCADE;
CREATE VIEW landLocked AS SELECT country.cid, country.cname 
  FROM country 
  LEFT JOIN oceanAccess 
  ON country.cid=oceanAccess.cid 
  WHERE oid IS NULL;
CREATE VIEW landNeighbors AS SELECT l.cid as c1id, l.cname as c1name, n.neighbor as c2id, c.cname as c2name
  FROM neighbour as n 
  JOIN landLocked as l 
  ON l.cid=n.country
  JOIN country as c
  ON c.cid = n.neighbor;
INSERT INTO query3 (
SELECT landNeighbors.c1id, c1name, c2id, c2name 
  FROM landNeighbors 
  JOIN (SELECT c1id FROM landNeighbors GROUP BY c1id HAVING COUNT(c1id)=1) as t 
  ON t.c1id = landNeighbors.c1id
  ORDER BY c1name ASC);
DROP VIEW IF EXISTS landLocked CASCADE;
DROP VIEW IF EXISTS landNeighbors CASCADE;

-- Query 4 statements
DELETE FROM query4;
--DROP VIEW IF EXISTS countriesNeighborsOceans CASCADE;
CREATE VIEW countriesNeighborsOceans AS SELECT c.cname, n.country, n.neighbor, a.oid, o.oname
  FROM country as c
  JOIN neighbour as n
  ON n.country = c.cid
  JOIN oceanAccess as a
  ON c.cid=a.cid
  OR n.neighbor=a.cid
  JOIN ocean as o
  ON o.oid=a.oid;
INSERT INTO query4 (
SELECT DISTINCT(cname), oname 
  FROM countriesNeighbors
  ORDER BY cname ASC, oname DESC);
DROP VIEW IF EXISTS countriesNeighborsOceans CASCADE;

-- Query 5 statements
DELETE FROM query5;
--DROP VIEW IF EXISTS highestHDI5Years CASCADE;
CREATE VIEW highestHDI5Years AS SELECT c.cid, c.cname, SUM(hdi_score)/COUNT(hdi_score) as avghdi
  FROM hdi
  JOIN country as c
  ON c.cid = hdi.cid
  WHERE hdi.year>2008
  AND hdi.year<2014
  GROUP BY c.cid, c.cname;
INSERT INTO query5 (
SELECT * 
  FROM highestHDI5Years
  ORDER BY avghdi DESC
  LIMIT 10);
DROP VIEW IF EXISTS highestHDI5Years CASCADE;

-- Query 6 statements

DELETE FROM query6;
create view increasing as select hdi.cid from hdi full outer join (select h1.cid, h1.year, h1.hdi_score from (hdi as h1 cross join hdi as h2) where h1.year > h2.year AND h2.year <= 2013 and h1.year >= 2009 and h1.year <= 2013 and h1.cid=h2.cid AND h1.hdi_score<h2.hdi_score) as h3 on hdi.cid=h3.cid where h3.cid is null;
INSERT INTO query6 select country.cid, country.cname from country join increasing on country.cid=increasing.cid;
DROP VIEW increasing;

-- Query 7 statements

DELETE FROM query7;
create view totalReligion as select rid, rname, rpercentage * population as totalbelievers from religion join country on religion.cid=country.cid;
insert into query7 select totalReligion.rid, totalReligion.rname, SUM(totalReligion.totalBelievers) from totalReligion cross join totalReligion as r1 where totalReligion.rname=r1.rname group by totalreligion.rid, totalreligion.rname;
drop view totalReligion;

-- Query 8 statements



-- Query 9 statements



-- Query 10 statements


