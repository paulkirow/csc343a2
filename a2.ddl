DROP SCHEMA IF EXISTS A2 CASCADE;
CREATE SCHEMA A2;
SET search_path TO A2;

DROP TABLE IF EXISTS country CASCADE;
DROP TABLE IF EXISTS language CASCADE;
DROP TABLE IF EXISTS religion CASCADE;
DROP TABLE IF EXISTS hdi CASCADE;
DROP TABLE IF EXISTS ocean CASCADE;
DROP TABLE IF EXISTS neighbour CASCADE;
DROP TABLE IF EXISTS oceanAccess CASCADE;
DROP TABLE IF EXISTS Query1 CASCADE;
DROP TABLE IF EXISTS Query2 CASCADE;
DROP TABLE IF EXISTS Query3 CASCADE;
DROP TABLE IF EXISTS Query4 CASCADE;
DROP TABLE IF EXISTS Query5 CASCADE;
DROP TABLE IF EXISTS Query6 CASCADE;
DROP TABLE IF EXISTS Query7 CASCADE;
DROP TABLE IF EXISTS Query8 CASCADE;
DROP TABLE IF EXISTS Query9 CASCADE;
DROP TABLE IF EXISTS Query10 CASCADE;


-- The country table contains all the countries in the world and their facts.
-- 'cid' is the id of the country.
-- 'name' is the name of the country.
-- 'height' is the highest elevation point of the country.
-- 'population' is the population of the country.
CREATE TABLE country (
    cid 		INTEGER 	PRIMARY KEY,
    cname 		VARCHAR(20)	NOT NULL,
    height 		INTEGER 	NOT NULL,
    population	INTEGER 	NOT NULL);
    
    INSERT INTO country VALUES (001, 'Canada', 5000, 35000000), (002, 'USA', 6000, 350000000), (003, 'United Kingdom', 3000, 60000000), (004, 'Mexico', 2030, 150000000), (005, 'France', 4000, 50000000), (006, 'landlockia', 9000, 10), (007, 'makeupia', 5030, 100503), (008, 'zimnoway', 2405, 501294);
    
    -- (006, 'Denmark', 1000, 9000000), (007, 'Paraguay', 1240, 15000000), (008, --'Australia', 4013, 22000000), (009, 'Lesotho', 2304, 5000000), (010, 'South --Africa' 2506, 20000000);
    
-- The language table contains information about the languages and the percentage of the speakers of the language for each country.
-- 'cid' is the id of the country.
-- 'lid' is the id of the language.
-- 'lname' is the name of the language.
-- 'lpercentage' is the percentage of the population in the country who speak the language.
CREATE TABLE language (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    lid 		INTEGER 	NOT NULL,
    lname 		VARCHAR(20) NOT NULL,
    lpercentage	REAL 		NOT NULL,
	PRIMARY KEY(cid, lid));
	
    INSERT INTO language VALUES (001, 001, 'English', 70.5), (002, 001, 'English', 95.4), (003, 001, 'English', 99.5), (005, 001, 'English', 2), (001, 002, 'French', 25.5), (002, 002, 'French', 0.5), (003, 002, 'French', 0.5), (005, 002, 'French', 98), (001, 003, 'Spanish', 4), (002, 003, 'Spanish', 5.1), (004, 003, 'Spanish', 100), (006, 001, 'English', 100), (007, 002, 'French', 90), (007, 003, 'Spanish', 10), (008, 001, 'English', 60), (008, 003, 'Spanish', 40) ;
    
-- The religion table contains information about the religions and the percentage of the population in each country that follow the religion.
-- 'cid' is the id of the country.
-- 'rid' is the id of the religion.
-- 'rname' is the name of the religion.
-- 'rpercentage' is the percentage of the population in the country who follows the religion.
CREATE TABLE religion (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    rid 		INTEGER 	NOT NULL,
    rname 		VARCHAR(20) NOT NULL,
    rpercentage	REAL 		NOT NULL,
	PRIMARY KEY(cid, rid));
	
	INSERT INTO religion VALUES (001, 001, 'Christianity', 69.4), (001, 002, 'Islam', 20.5), (001, 003, 'Judaism', 10.1), (002, 001, 'Christianity', 90.1), (002, 002, 'Islam', 4.8), (002, 003, 'Judaism', 5.1), (003, 001, 'Christianity', 80), (003, 002, 'Islam', 15.1), (003, 003, 'Judaism', 4.9), (004, 001, 'Christianity', 98), (004, 002, 'Islam', 1.3), (004, 003, 'Judaism', .7), (005, 001, 'Christianity', 80), (005, 002, 'Islam', 12.3), (005, 003, 'Judaism', 7.7), (006, 003, 'Judaism', 100), (007, 002, 'Islam', 100), (008, 003, 'Judaism', 100);

-- The hdi table contains the human development index of each country per year. (http://en.wikipedia.org/wiki/Human_Development_Index)
-- 'cid' is the id of the country.
-- 'year' is the year when the hdi score has been estimated.
-- 'hdi_score' is the Human Development Index score of the country that year. It takes values [0, 1] with a larger number representing a higher HDI.
CREATE TABLE hdi (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    year 		INTEGER 	NOT NULL,
    hdi_score 	REAL 		NOT NULL,
	PRIMARY KEY(cid, year));
	
	INSERT INTO hdi VALUES (001, 2014, .99), (001, 2008, .98), (001, 2010, .97), (002, 2006, .95), (002, 2010, .97), (002, 2014, .96), (003, 2010, .98), (003, 2008, .97), (003, 2012, .98), (004, 2012, .72), (004, 2014, .71), (005, 2008, .96), (005, 2012, .97), (005, 2006, .94), (006, 2014, .98), (006, 2006, .99), (007, 2008, .7), (007, 2014, .99), (008, 2006, .89), (008, 2010, .90), (008, 2014, .92);

-- The ocean table contains information about oceans on the earth.
-- 'oid' is the id of the ocean.
-- 'oname' is the name of the ocean.
-- 'depth' is the depth of the deepest part of the ocean
CREATE TABLE ocean (
    oid 		INTEGER 	PRIMARY KEY,
    oname 		VARCHAR(20) NOT NULL,
    depth 		INTEGER 	NOT NULL);

	INSERT INTO ocean VALUES (001, 'Atlantic', 6004), (002, 'Pacific', 5560), (003, 'Arctic', 4302);

-- The neighbour table provides information about the countries and their neighbours.
-- 'country' refers to the cid of the first country.
-- 'neighbor' refers to the cid of a country that is neighbouring the first country.
-- 'length' is the length of the border between the two neighbouring countries.
-- Note that if A and B are neighbours, then there two tuples are stored in the table to represent that information (A, B) and (B, A). 
CREATE TABLE neighbour (
    country 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    neighbor 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT, 
    length 		INTEGER 	NOT NULL,
	PRIMARY KEY(country, neighbor));
	
	

	INSERT INTO neighbour VALUES (001, 002, 20000), (002, 001, 20000), (002, 004, 17000), (004, 002, 17000), (003, 005, 800), (005, 003, 800), (006, 005, 1), (005, 006, 1), (001, 008, 400), (008, 001, 400), (003, 007, 983), (007, 003, 983), (002, 007, 660), (007, 002, 660);

-- The oceanAccess table provides information about the countries which have a border with an ocean.
-- 'cid' refers to the cid of the country.
-- 'oid' refers to the oid of the ocean.
CREATE TABLE oceanAccess (
    cid 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    oid 	INTEGER 	REFERENCES ocean(oid) ON DELETE RESTRICT, 
    PRIMARY KEY(cid, oid));

	INSERT INTO oceanAccess VALUES (001, 001), (001, 002), (001, 003), (002, 001), (002, 002), (002, 003), (003, 001), (003, 003), (004, 001), (004, 002), (005, 001);

-- The following tables will be used to store the results of your queries. 
-- Each of them should be populated by your last SQL statement that looks like:
-- "INSERT INTO QueryX (SELECT ...<complete your SQL query here> ... )"

CREATE TABLE Query1(
	c1id	INTEGER,
    c1name	VARCHAR(20),
	c2id	INTEGER,
    c2name	VARCHAR(20)
);

CREATE TABLE Query2(
	cid		INTEGER,
    cname	VARCHAR(20)
);

CREATE TABLE Query3(
	c1id	INTEGER,
    c1name	VARCHAR(20),
	c2id	INTEGER,
    c2name	VARCHAR(20)
);

CREATE TABLE Query4(
	cname	VARCHAR(20),
    oname	VARCHAR(20)
);

CREATE TABLE Query5(
	cid		INTEGER,
    cname	VARCHAR(20),
	avghdi	REAL
);

CREATE TABLE Query6(
	cid		INTEGER,
    cname	VARCHAR(20)
);

CREATE TABLE Query7(
	rid			INTEGER,
    rname		VARCHAR(20),
	followers	INTEGER
);

CREATE TABLE Query8(
	c1name	VARCHAR(20),
    c2name	VARCHAR(20),
	lname	VARCHAR(20)
);

CREATE TABLE Query9(
    cname		VARCHAR(20),
	totalspan	INTEGER
);

CREATE TABLE Query10(
    cname			VARCHAR(20),
	borderslength	INTEGER
);
