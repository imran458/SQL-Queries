SET linesize 500;
SET pagesize 500;

/*1. What is the pending balance in all non-business customers’ checking accounts? */
SELECT pending_balance FROM bank.account 
WHERE product_cd = 'CHK' && cust_id NOT IN (SELECT cust_id FROM bank.business);
/*
This query was initially simple however I found the subquery portion quite challenging.
I selected the pending balance from the bank account and specified checking, however I found it 
difficult to get all non-business customers. From the solution, I understood that I could use an and operator
to specify the customer id who were not in bank.business. I had forgotten that cust_id also belonged to
non-business individuals
*/

/*2. What are the full names of all vendors who can supply more than one item or are based in Illinois? */
SELECT v.name 
FROM grocery.Vendor v INNER JOIN grocery.Vendor_address va ON v.vendor_id = va.vendor_id WHERE va.state_territory_province = 'Illinois' 
OR v.vendor_id IN (SELECT vendor_id FROM grocery.Can_supply GROUP BY vendor_id HAVING COUNT(product_id) > 1);
/*
For this query, I once again had problems with the subqery portion. I connected the vendor table with 
the vendor address table using the vendor id. This is because the vendor address contains the state. I also was able to 
specify the province via a simple where condition. I had to refer to the solution in order to grasp the subquery.
It makes sense now as I use an or to specify the vendors whose product_cd is greater than 1.
*/

/*3. What is the minimum available balance in all accounts for each customer and overall for all customers? */
SELECT tmp.name, MIN(tmp.bal) FROM 
(SELECT CONCAT(i.fname, CONCAT(' ', i.lname)) name, a.avail_balance bal FROM bank.account a INNER JOIN bank.individual i 
ON i.cust_id = a.cust_id
UNION
SELECT b.name, a.avail_balance FROM bank.account a INNER JOIN bank.business b ON b.cust_id=a.cust_id) tmp 
GROUP BY ROLLUP (tmp.name);

/*
I had a lot of issues with this query. I directly referred to the solution in order to answer this.
I see that in the solution, tmp is an alias for all the available balances created. That alias is used 
to obtain the name and minimum balance. The first select does the first half of the question: it obtains
the minimum balance in all accounts for each customer and the next query joins that for the overall for all 
customers. 
*/

/*4. What is the full name of the countries that have more than 3 official languages, and how many does each one have? */
SELECT c.name, lang.num_ol 
FROM world.country c 
INNER JOIN 
(SELECT ol.CountryCode code, COUNT(of.Language) num_ol 
FROM 
(SELECT CountryCode, Language FROM world.CountryLanguage WHERE IsOfficial = 'T') of GROUP BY of.CountryCode HAVING COUNT(of.Language) > 3) lang
ON c.code = lang.code;
/*
For this query, I was able to figure out 75%. I created an alias, named of, to specify the official langauage.
I was able to figure out how the query which selected the name of the country that had more than three
languages. However, I was not able to complete the inner join because of the nested subquery.
*/ 

/*5. Display the number of countries that speak 1 official language, 2 official languages, and so on.  */
SELECT ol_two.lang, COUNT(ol_two.cc) 
FROM(SELECT ol.CountryCode cc, COUNT(ol.Language) lang FROM (SELECT CountryCode, Language FROM world.CountryLanguage WHERE IsOfficial = 'T') ol GROUP BY ol.CountryCode) ol_two 
GROUP BY ol_two.lang;
/*
This query was not too difficult as I was able to navigate through most of it. Where I did have problem was the subquery
where I had to select if the language is indeed their official language. Furthermore, I was confused with the group by function
and did not understand how i should order languages through code
*/

/*6. Which cities of over three million people are in countries where English is an official language? */
SELECT ci.Name, oe.Language, oe.IsOfficial 
FROM world.City ci 
INNER JOIN 
(SELECT * FROM world.CountryLanguage WHERE IsOfficial = 'T' AND Language = 'English') oe 
ON ci.CountryCode = oe.CountryCode 
WHERE c.Population > 3000000;
/*
This query was not too trivial but not too complicated. I knew that I had to use inner join to connct the city table with 
country table using the country code. The where conditon was also quite simple. I initially just did selected language 
from the country language table but via the solution I changed it to select *, meaning all of the cities that have english as their
first language.
*/

/*7. What is the number of large cities on each continent such that the total large city population on the continent is at least 25 million?  */
SELECT c.Continent, COUNT(lc.ID) 
FROM world.Country c 
INNER JOIN 
(SELECT ID, CountryCode, Population FROM world.City WHERE Population>3000000) lc 
ON c.Code = lc.CountryCode 
GROUP BY c.Continent 
HAVING SUM(lc.Population)>25000000;
/*
This query took me a while to complete. My initial reaction was to obtain the ids and code of the cities whose population was 
greater than 25000000. I aliased that as lc, meaning large city. I used inner join to connect the country table and the large
city which I created. I then had to refer to the solutions to understand how to use the group by and having. Iunderstand now because the cities 
must share a continent thus they must have the continent in which the cities are greater than 25000000.
*/


/*8. Which large cities are in countries with no more than 2 languages spoken? */
SELECT lc.Name 
FROM(SELECT CountryCode, COUNT(Language) FROM world.CountryLanguage GROUP BY CountryCode HAVING COUNT(Language)<=2) lang 
INNER JOIN
(SELECT Name, CountryCode, Population FROM world.City WHERE Population>3000000) lc 
ON lang.CountryCode = lc.CountryCode; 
/*
This query was not too trivial once I got the answer to the previous question. At this point,
I had a working knowledge of the group by and having clause to have answered this question. The only issue I had was
with the second nested query in which I had to select the country code whose population was 30000000.
*/

/*9. In order of number of languages, what are the names of the countries where 10 or more languages are spoken and how many languages are spoken in each? Use a single query. */
SELECT c.Name, lang.num 
FROM world.Country c 
INNER JOIN
(SELECT CountryCode, COUNT(Language) num FROM world.CountryLanguage GROUP BY CountryCode HAVING COUNT(Language)>=10 ORDER BY num) lang 
ON c.Code=lang.CountryCode;
/*
I had figured out the join part of this query but was unable to figure out the nested subquery because I was having
trouble with the agregate functions.Via the solution, I see why this query works as I aliased the countries whose 
languages were 10 or more. I then had to refer to the solution to figure out the rest.
*/ 



/*10. Which countries have average city populations for the cities recorded in the database of at least 3 million but no more than 7 million? */
SELECT co.Name, c.avg_pol 
FROM world.Country co 
INNER JOIN
(SELECT CountryCode, AVG(Population) avg_pol FROM world.City GROUP BY CountryCode HAVING AVG(Population) BETWEEN 3000000 AND 7000000) c ON c.CountryCode = co.Code; 
/*
This query was not complicated at all, in fact I got it in one go. I had to select the countries name and 
specify the cities whose average  population was between 30000000 and 70000000. I aliased that table with a c. Because it was 
an inner join, I connected the country table with the city table via the country code. 
*/ 
