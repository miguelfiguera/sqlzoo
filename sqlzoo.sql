-- This is an only page for every exercise. I had some troubles understanding the joins part.
-- But I did enjoy SQL, as a former social media manager / RRSS content writer... The manipulation of data is beautiful to
-- make a choice, I wish I had this before.



--SELECT BASICS

SELECT population FROM world
  WHERE name = 'Germany';

  SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

  SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000;

  -- SELECT Names

  SELECT name FROM world
  WHERE name LIKE 'Y%';

  SELECT name FROM world
  WHERE name LIKE 'y%';

  SELECT name FROM world
  WHERE name LIKE '%x%';

  SELECT name FROM world
  WHERE name LIKE '%land';

  SELECT name FROM world
  WHERE name LIKE 'C%ia';

  SELECT name FROM world
  WHERE name LIKE '%oo%';

  SELECT name FROM world
  WHERE name LIKE '%a%a%a%';

  SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name;

SELECT name FROM world
 WHERE name LIKE '%o__o%'; --LOL a O_O face.

 SELECT name FROM world
 WHERE name LIKE '____';

 SELECT name
  FROM world
 WHERE name = capital;

 SELECT name
FROM world
WHERE capital LIKE concat(name, '%ity');

SELECT capital, name
FROM world
WHERE capital LIKE concat('%',name,'%');

SELECT capital, name
FROM world
WHERE capital LIKE concat(name,'_%');

SELECT capital, name
FROM world
WHERE capital LIKE concat(name,'-','%'); -- I did not understand this last one.

-- Nobel

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;

 SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature';

SELECT yr,subject
FROM nobel
WHERE winner = 'Albert Einstein';

SELECT winner
FROM nobel
WHERE subject = 'peace' AND yr LIKE '20__';

SELECT yr,subject,winner
FROM nobel
WHERE subject = 'literature' AND yr LIKE '198_';

SELECT * FROM nobel 
 WHERE winner IN ('theodore roosevelt',
                  'woodrow wilson',
                  'Jimmy Carter', 'Barack Obama');

                  SELECT winner
FROM nobel
WHERE winner LIKE 'John %';

SELECT *
FROM nobel
WHERE yr='1980' AND subject='physics' OR yr='1984' AND subject='chemistry';

SELECT * FROM nobel
WHERE yr='1980' AND subject NOT IN('medicine','chemistry');

SELECT * FROM nobel
WHERE subject='medicine' AND yr <'1910' OR subject='literature' AND yr>='2004'
ORDER BY yr DESC;

SELECT * FROM nobel
WHERE winner LIKE 'PETER GR%BERG';

SELECT * FROM nobel
WHERE winner LIKE 'EUGENE O_NEILL';


SELECT winner,yr,subject FROM nobel
WHERE winner LIKE 'Sir %'
ORDER BY yr DESC;

--select within select

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

SELECT name FROM world
WHERE gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom') AND continent = 'Europe';

SELECT name,continent FROM world
WHERE continent = (SELECT continent FROM world WHERE name = 'Argentina') OR continent =(SELECT continent FROM world WHERE name = 'Australia')
ORDER BY name;

SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name = 'United Kingdom') AND population < (SELECT population FRom world WHERE name = 'Germany');

SELECT name, CONCAT(ROUND((population/(
  SELECT population
  FROM world
  WHERE name = 'Germany') * 100)), '%') AS percentage
FROM world
WHERE continent = 'Europe';

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0);

SELECT continent, name FROM world x
WHERE name=(SELECT name FROM world y
WHERE x.continent = y.continent
ORDER BY name LIMIT 1);

SELECT name, continent, population
FROM world x
WHERE 25000000 >= ALL(
  SELECT population
  FROM world y
  WHERE x.continent = y.continent);

SELECT name, continent
FROM world x
WHERE population > ALL(
  SELECT population * 3
  FROM world y
  WHERE x.continent = y.continent
  AND x.name <> y.name);

