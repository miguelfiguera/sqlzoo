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

--  NULL INNER JOIN RIGHT JOIN LEFT JOIN --

SELECT name FROM teacher WHERE dept is NULL;

SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name FROM teacher LEFT JOIN dept ON (dept.id=teacher.dept)

SELECT teacher.name, dept.name FROM teacher RIGHT JOIN dept ON (dept.id=teacher.dept)

SELECT name,COALESCE(mobile,'07986 444 2266') FROM teacher

SELECT teacher.name,COALESCE(dept.name,'none')
FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id);

SELECT COUNT(teacher.name) as nteacher, COUNT(teacher.mobile) as nphones FROM teacher

SELECT dept.name,count(teacher.dept) FROM teacher
RIGHT JOIN dept ON (teacher.dept = dept.id)
GROUP BY dept.name;


  SELECT name, CASE
WHEN dept IN ('1','2') THEN 'Sci'
ELSE 'Art'
END
 FROM teacher;


SELECT name, CASE
WHEN dept IN ('1','2') THEN 'Sci'
WHEN dept IN ('3') THEN 'Art'
ELSE 'none'
END
 FROM teacher;


--NSS TUTORIAL--

SELECT (A_STRONGLY_AGREE/(A_STRONGLY_AGREE + A_AGREE + A_NEUTRAL + A_DISAGREE + A_STRONGLY_DISAGREE)) * 100
FROM nss
WHERE question='Q01'
AND institution='Edinburgh Napier University'
AND subject='(8) Computer Science';


SELECT institution,subject
  FROM nss
 WHERE score >= '100' 
AND question = 'Q15'

SELECT institution,score
  FROM nss
 WHERE question='Q15'
   AND subject='(8) Computer Science'
AND SCORE < '50';


SELECT subject, SUM(response)
FROM nss
WHERE question='Q22'
AND (subject='(8) Computer Science'
OR subject='(H) Creative Arts and Design')
GROUP BY subject;

SELECT subject, SUM(A_STRONGLY_AGREE*response/100)
FROM nss
WHERE question='Q22'
AND (subject='(8) Computer Science'
OR subject='(H) Creative Arts and Design')
GROUP BY subject;

SELECT subject,ROUND(SUM((response*A_STRONGLY_AGREE)/100) / SUM(response) * 100, 0)
FROM nss
WHERE question='Q22'
AND (subject='(8) Computer Science'
OR subject='(H) Creative Arts and Design')
GROUP BY subject;

SELECT institution,ROUND(SUM((response*score)/100) / SUM(response) * 100, 0)
FROM nss
WHERE question='Q22'
AND (institution LIKE '%Manchester%')
GROUP BY institution;

SELECT institution,SUM(sample),(SELECT sample FROM nss AS y
                                WHERE subject = '(8) Computer Science'
                                AND x.institution = y.institution
                                AND question='Q01'
                               )
FROM nss AS x
WHERE question='Q01'
AND (institution LIKE '%Manchester%')
GROUP BY institution;



-- SELF JOIN = Unir con una copia de la misma tabla para contrastar la informacion presente.
SELECT COUNT(*) FROM stops

SELECT id FROM stops
WHERE name = 'Craiglockhart'

SELECT stops.id, stops.name
FROM stops
JOIN route ON stops.id = route.stop
WHERE company = 'LRT'
AND num = 4
ORDER BY pos;

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*)=2;

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
WHERE a.stop='53'
AND b.stop = '149';

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road';

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road';

SELECT DISTINCT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name='Leith';


SELECT DISTINCT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross';


-- covid table --
SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'spain'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn

SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn


SELECT name, DAY(whn), confirmed-
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn


SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), tw.confirmed - lw.confirmed
FROM covid tw
LEFT JOIN covid lw ON DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn AND tw.name=lw.name
WHERE tw.name = 'Italy'
AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;


--window functions--

SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC

SELECT party, votes, RANK() OVER (ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party;


