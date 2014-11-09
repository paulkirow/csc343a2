-- Add below your SQL statements. 
-- You can create intermediate views (as needed). Remember to drop these views after you have populated the result tables.
-- You can use the "\i a2.sql" command in psql to execute the SQL commands in this file.

-- Query 1 statements
DELETE FROM query1;
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
DROP VIEW IF EXISTS landLocked CASCADE;
DROP VIEW IF EXISTS landNeighbors CASCADE;
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



-- Query 5 statements



-- Query 6 statements



-- Query 7 statements



-- Query 8 statements



-- Query 9 statements



-- Query 10 statements


