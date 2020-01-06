/*First, set the line size and page size to proper values for the easy readings of the log */
SET linesize 150;
SET pagesize 150;

/*1.Which movies' show times are longer than "I Know What You Did." but shorter than "Wonton Soup"?*/
SELECT title, runningtime FROM films.movie WHERE runningtime < (SELECT runningtime FROM films.movie WHERE title = 'Wonton Soup') AND runningtime > (SELECT runningtime FROM films.movie WHERE title = 'I Know What You Did.');
/*2.What are movie titles that start with letter 'T' and are released between 2000 and 2005?*/
SELECT title, year_ FROM films.movie WHERE title LIKE 'T%' AND year_ BETWEEN 2000 AND 2005;
/*3.How many movie people are not actors?*/
SELECT COUNT(moviepersonid) FROM films.movieperson WHERE occupation IS NOT NULL AND occupation != 'actor';
/*4.How many theatres are in New York or Connecticut?*/
SELECT COUNT(DISTINCT name) FROM films.theatre WHERE locationid IN (SELECT locationid FROM films.location WHERE state = 'NY' OR state='CT');
/*5.Find all actors whose last name contains an 'a' in the second position or first name ends with an 'a'.*/
SELECT * FROM films.movieperson WHERE (lastname LIKE '_a%' OR firstname LIKE '%a') AND occupation = 'actor';
/*6.Find all theatres whose names have the pattern of 'name Theatre' (e.g. 'Worst Theatre' where 'Worst' is the name), and extract the name (e.g. Worst, use SUBSTR). */
SELECT SUBSTR(Name, 1, LENGTH(name) - LENGTH('Theatre') - 1) FROM films.theatre WHERE name LIKE '% Theatre';
/*7.Find all theatres whose names DO NOT contain whitespaces between words? */
SELECT * FROM films.theatre WHERE NOT REGEXP_LIKE(name, '[[:blank:]]');
/*8.Which individual (not business) customer has the maximum available balance in all of his or her accounts, print out his or her full name with column heading "Full Name" (concatenating the first name and last name) */
SELECT CONCAT(fname, concat(' ', lname)) AS "Full Name" FROM bank.individual 
WHERE cust_id  IN (SELECT cust_id 
	FROM (SELECT cust_id, SUM(avail_balance) AS total 
		   FROM bank.account WHERE cust_id IN (SELECT cust_id FROM bank.individual) GROUP BY cust_id) 
	           WHERE total = (SELECT MAX(total) FROM (SELECT cust_id, SUM(avail_balance) AS total FROM bank.account WHERE cust_id IN (SELECT cust_id FROM bank.individual) GROUP BY cust_id)));

/* OR with INNNER JOIN */
 
