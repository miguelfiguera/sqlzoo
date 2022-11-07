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
  AND x.name != y.name);

  --sum & count

  SELECT SUM(population)
FROM world

SELECT DISTINCT continent
FROM world

SELECT SUM(gdp) 
FROM world
WHERE continent = 'Africa';

SELECT COUNT(area)
FROM world
WHERE area >=1000000;

SELECT SUM(population)
FROM world
WHERE name IN('Estonia', 'Latvia', 'Lithuania');

SELECT continent, COUNT(name)
  FROM world
 GROUP BY continent

 SELECT continent, COUNT(name)
FROM world
WHERE population >=10000000
GROUP BY continent;

SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >=100000000

--JOIN OPERATION

SELECT matchid,player FROM goal 
  WHERE teamid= 'GER';

  SELECT DISTINCT id,stadium,team1,team2
 FROM game JOIN goal ON (id=matchid)
WHERE matchid=1012;

SELECT player,teamid,stadium,mdate
FROM game JOIN goal ON (game.id=goal.matchid)
WHERE goal.teamid='GER';

SELECT team1,team2,player
FROM goal JOIN game ON(goal.matchid=game.id)
WHERE player LIKE 'Mario%';

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam on teamid=id
 WHERE gtime<=10

 SELECT mdate, teamname
FROM game JOIN eteam ON (game.team1=eteam.id)
WHERE coach='Fernando Santos' AND eteam.id=game.team1;

SELECT player
FROM goal JOIN game ON (goal.matchid=game.id)
WHERE stadium = 'National Stadium, Warsaw';

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' AND teamid!='GER') OR (team2='GER' AND teamid!='GER');

    SELECT  teamname,COUNT(*)
  FROM eteam JOIN goal ON id=teamid
GROUP BY teamname;
 

 SELECT  stadium,COUNT(*)
  FROM game JOIN goal ON game.id=goal.matchid
GROUP BY stadium;
 

 SELECT matchid,mdate,COUNT(*)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid,mdate;


SELECT matchid,mdate,count(*)
FROM game JOIN goal ON game.id=goal.matchid
WHERE goal.teamid='ger'
GROUP BY matchid,mdate;

SELECT mdate, team1, SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
              team2, SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
  FROM game
LEFT JOIN goal ON id = matchid
GROUP BY mdate, matchid, team1, team2
ORDER BY mdate, matchid, team1, team2;

-- MORE JOIN OPERATIONS --

SELECT id, title
 FROM movie
 WHERE yr=1962

 SELECT yr
from movie
where title = 'Citizen Kane';

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

SELECT id
FROM actor
WHERE name = 'Glenn Close';

SELECT id
FROM movie
WHERE title = 'Casablanca';

SELECT name
FROM    movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE movie.title='Casablanca'
ORDER BY actor.name;

SELECT name
FROM    movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE movie.title='Alien'
ORDER BY actor.name;

SELECT title
FROM    movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE actor.name='Harrison Ford';

SELECT title
FROM    movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE actor.name='Harrison Ford' AND casting.ord != 1;

SELECT title,name
FROM    movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE movie.yr='1962' AND casting.ord = 1;

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1

SELECT movie.title, actor.name
FROM movie JOIN casting ON movie.id = casting.movieid
           JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN (
                    SELECT movieid
                    FROM casting
                    WHERE actorid = (
                                      SELECT id
                                      FROM actor
                                      WHERE name = 'Julie Andrews'
                                    )
)
AND casting.ord = 1;

SELECT actor.name FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE ord=1
GROUP BY actor.name
HAVING COUNT(*) >= 15
ORDER BY name;


SELECT title, COUNT(actorid) as NA FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE yr = '1978'
GROUP BY title
ORDER BY NA DESC,title

SELECT actor.name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid IN (
                            SELECT casting.movieid
                            FROM casting
                            JOIN movie ON casting.movieid = movie.id
                            WHERE casting.actorid = (
                                                      SELECT actor.id
                                                      FROM actor
                                                      WHERE name = 'Art Garfunkel'
                                                    )
                          )
AND actor.name <> 'Art Garfunkel';

-- 