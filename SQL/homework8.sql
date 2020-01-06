SET linesize 200;
SET pagesize 200;


/*1. How many California cities are on record? */
SELECT COUNT(DISTINCT id) FROM world.City  WHERE District = 'California';
/*
This query was quite simple. I simply counted the id's of the cities from the world database which contained the district of California.
*/

/*2. Which East Coast cities (Maine, New Hampshire, Massachusetts, Rhode Island, Connecticut, New York, New Jersey, Delaware, Maryland, Virginia, North Carolina, South Carolina, Georgia, AND Florida) have less than a million people? */
SELECT Name FROM world.City 
WHERE Population < 1000000 AND District IN ('Maine' ,'New Hampshire' ,'Massachusetts' ,'Rhode Island' ,'Connecticut' ,'New York' ,'New Jersey' , 'Delaware' ,'Maryland' ,'Virginia' ,'North Carolina' ,'South Carolina' ,'Georgia' ,'Florida');
/*
This query was again quite trivial as it asked to specify which cities from the east coast
had fewer than 1 million people.
*/

/*3. Which Asian cities have more than 8 million people AND are in a COUNTry WHERE the life expectancy is under 65? */
SELECT c.name FROM world.City c INNER JOIN world.country co ON c.countryCode = co.Code WHERE co.Continent = 'Asia' AND c.Population > 8000000 AND co.LifeExpectancy < 65;
/*
For this query, I used inner join to connect the city table and the country table with the code key. 
Then I specified the continent using where and joined two ands to specify 8 million people and life expectency.
*/

/*4. How many Countries outside Europe have French as their official language? */
SELECT COUNT(DISTINCT c.code) 
FROM world.country c INNER JOIN world.countrylanguage cl ON c.code = cl.countrycode 
WHERE (cl.IsOfficial = 'T' AND cl.Language = 'French') AND c.Continent != 'Europe';
/*
For this query I directly reffered to the solutions provided. I connected country and country language table
to obtain the list of countries

*5. Which cities of at least 75 0,000 but no more than a million people are in COUNTries WHERE Spanish is the official language?  */
SELECT ci.name
FROM world.City ci INNER JOIN world.CountryLanguage co ON ci.CountryCode = co.CountryCode 
WHERE ci.Population >= 750000 AND ci.Population <= 1000000 AND co.Language = 'Spanish' AND co.IsOfficial = 'T' ;

/*6. How many COUNTries are in the continent of North America?*/
SELECT COUNT(DISTINCT Code) 
FROM world.Country 
WHERE Continent = 'North America';
/*
This query was quite simple as I had to simply look for one table which was world.country and specify 
the continent. However, one thing that got me slightly confused as I initially counted the countries 
instead of the code. After looking at the solution, I felt as if that was the better option.
*/

/*7. What are the names AND capitals of the COUNTries in Oceania? */
SELECT c.Name, ci.Name 
FROM world.Country c INNER JOIN world.City ci ON c.Capital = ci.ID 
WHERE c.Continent = 'Oceania';
/*
This query was quite self explanatory, however I got stuck on the inner join portion of this question.
As usual, the inner join usually takes a key that is common to both tables, however, as given by the solutions,
it connects countries' capital to cities' id. I am still a little confused from this portion but I 
understand the conditional.
*/ 

/*8. What different forms of government are there in South America? */
SELECT DISTINCT GovernmentForm 
FROM world.Country 
WHERE Continent = 'South America';
/*
This query was quite simple. I selected the distinct government forms from the country table 
and specified the continent using a where condition.
*/

/*9. What COUNTry has the smallest GNP AND how small is it? */
SELECT Name, GNP 
FROM world.Country 
WHERE GNP=(SELECT MIN(GNP) FROM world.Country); 
/*
I had to refer to the solutions for this query because I had trouble with subqueries. I had selected the name
and gnp from world.country but had completely forgot about the subquery portion. It makes
sense now as the min function was used on the gnp from the world.country table.
*/ 

