SET linesize 150;
SET pagesize 150;

/*1. Which directors have no movie data associated with them? */
SELECT m.FirstName, m.LastName, FROM Films.MoviePerson m
LEFT OUTER JOIN Films.Directs f ON m.MoviePersonID = f.MoviePersonID 
WHERE m.Occupation = 'director' AND f.MovieID IS NULL;
/*
This query was not too complex, however I was having trouble with the last portion.
I selected the first name, last name of the director and used left outer join
to connect the directs and movieperson table. Where I encountered a problem was the 
part where I  had to specify null. Instead of movieid is null, i put =null which gave me 
numerous problems. I looked at the solution and corrected it.
*/

/*2. Generate a table with the names of studios that do not produce any movie. */
SELECT s.Name, m.Title
FROM Films.FilmStudio s LEFT OUTER JOIN Films.Movie m ON s.FilmStudioID = m.FilmStudioID
WHERE m.Title IS NULL;
/*
Similar to the last example, I had completed this query to quite a extent. I used left outer join to 
connect studio and movie tables with the studio_id. However, I once again put title = null, which 
via the boolean operation, is incorrect. Once I changed =null to is null the query worked.
*/

/*3. Which countries have no language recorded for them? */
SELECT co.Name, lang.Language
FROM World.Country co LEFT OUTER JOIN World.CountryLanguage lang ON co.Code=lang.CountryCode
WHERE lang.Language IS NULL;
/*
This query was quite simple after I had learned from my mistakes of the first and second
query. I connected the language table with the country table with a left outer join. 
This is an issue that bugged me before: the foreign key of the language and country are slightly different
but contain the same items. 
*/

/*4. Find the number of products for each store ordered from each vendor in 2010.
Show 0 if a store does not order products from a vendor. The full table includes many rows.
You only need to list  (1) top 10 the most number of products, and (2) write down the total number of rows in the full table. */
SELECT s.store_id, v.vendor_id, CASE
WHEN so2010.num IS NULL THEN 'null'
ELSE so2010.num
END num
FROM grocery.Store s CROSS JOIN grocery.Vendor v
LEFT OUTER JOIN
(SELECT so.store_id, so.vendor_id, COUNT(so.product_id) num
	FROM grocery.Store_order so INNER JOIN grocery.Product_Batch pb ON so.product_id=pb.product_id
	WHERE EXTRACT(YEAR FROM pb.order_date)=2010 GROUP BY so.store_id, so.vendor_id) so2010
ON so2010.vendor_id = v.vendor_id AND so2010.store_id = s.store_id
ORDER BY num DESC;

/*
I was completely confused by this query and I had to rely on the solution. I understood the first part of
the question, which asked me to find the number of products each store ordered from 2010. I was also sure that 
I had to connect the grocery store table with the grocery vendor table. I did not understand, however,
using cross join and left outer join. Much of this query is still quite confusing, however, I am able to understand
the nested query which is necessary for the data extraction. 

