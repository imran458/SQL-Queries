SET linesize 300;
SET pagesize 300;


/*1. For each US state on record in the world database, how many cities are recorded and what is their total population? Characterize them as a few (0 to 2), several (anything from 3 to 5), or lots (6 or more). You may not assume that you "know" the code for the US. */
SELECT c.District, COUNT(c.Name), SUM(c.Population),
CASE
WHEN COUNT(c.Name) <= 2 THEN 'few'
WHEN COUNT(c.Name) >= 3 AND <= 5 THEN 'several'
else  'lots'
END rec
FROM world.City c INNER JOIN world.Country co ON c.CountryCode = co.Code WHERE co.Name ='United States'
GROUP BY c.District;
/*
This query was not too difficult. Where I had a slight problem was in my logic. For the lots portion of the query,
I put else when count is greater than and =6. However, my syntax was incorrect therefore, I was getting an error generating
the query. Other than that, it was not too complicated.
*/

/*2. Characterize each African country as rural (city population < 25% of total), urban (city population > 75%) or mixed. */
SELECT co.Name,
CASE
WHEN c.pop/co.Population < 0.25 THEN 'rural'
WHEN c.pop/co.Population BETWEEN 0.25 AND 0.75 THEN 'mixed'
ELSE 'urban'
END cat
FROM world.Country co INNER JOIN
(SELECT CountryCode, SUM(Population) pop FROM world.City GROUP BY CountryCode) c
ON co.Code = c.CountryCode
WHERE co.Continent = 'Africa';

/*

I had a slight problem with this query in that I did not know how to set up the conditional. I understood
how to charactertize each population with the given proportions, but was unaware as to how I should 
set them up. Via the solution, I saw that I could essentially divide the city population by the entire population
, however i did not know how to translate that into SQL. I also had a little issue with extracting the population. I grouped by the 
country code as indicated via the solution and used inner join to connect the country and city table. I was not, however,able
to select the population by myself. I had to refer to the query. It makes sense as the select portion proceeding the inner join
is essentially selecting the code to join with the cities' code and summing the population.

*/

/*3. List the forms of government that are used in more than two countries, in descending order by the number of countries in which they are used. */
SELECT GovernmentForm, COUNT(Code) c
FROM world.Country
GROUP BY GovernmentForm
HAVING COUNT(Code) > 2
ORDER BY c DESC;
/*
This query was not too difficult but i was having a little troubleusing the group by function.  I knew
that I had to use group by in order to get the forms of government used in more than two countries but was
unaware as to how to go about it. From the solution it made sense that I should use having and then count 
code which was greater than 2.
*/

/*4. Categorize contigs by the average number of ORFs they contain: a few (less than 10), many (over 50), or typical. */
SELECT gc.mol_name,
CASE
WHEN COUNT(o.orf_id) < 10 THEN 'few'
WHEN COUNT(o.orf_id) > 50 THEN 'many'
ELSE 'typical'
END avg_orf
FROM genome.contig gc INNER JOIN genome.orf o ON gc.mol_id = o.mol_id
GROUP BY gc.mol_name;
/*
This query was not too difficult but due to the the nature of this table I was a little unsettled. 
I understood the case when portion of this query, however, made a mistake in that I did not follow that 
correct case when syntax. Furthermore, I had a little issue with the group by function but my initial answer was correct
after I looked at the solution.
*/

/*5. For each contig, report how many ORFs are of each length: 1-299, 300-599,  600-899, or longer. */
SELECT gc.mol_name,
SUM(CASE WHEN (orf_end_coord-orf_begin_coord+1) BETWEEN 1 AND 299 THEN 1 ELSE 0 END) "1-299",
SUM(CASE WHEN (orf_end_coord-orf_begin_coord+1) BETWEEN 300 AND 599 THEN 1 ELSE 0 END) "300-599",
SUM(CASE WHEN (orf_end_coord-orf_begin_coord+1) BETWEEN 600 AND 899 THEN 1 ELSE 0 END) "600-899",
SUM(CASE WHEN (orf_end_coord-orf_begin_coord+1) > 900 THEN 1 ELSE 0 END) longer
FROM genome.contig gc INNER JOIN genome.orf o ON gc.mol_id = o.mol_id
GROUP BY gc.mol_name;
/*
I was completely confused by the orf coordinate lengh. I had set up the the conditionals correctly. 
I knew that if I used case when, I had to use an else and end. Therefore, I used the slides to figure out
that I had to put 1 after the then 0  after else. I did not know that I had to sum the orf length. Furthermore, I was
not aware that a case when condition could be put inside of a sum function. I did, however, correctly join the two tables
via a simple inner join and connected the table via the mol_id. 
*/

/*6. Use conditional logic to output a crosstab table for total amount of available balance for each branch and each product type. If it is null, output 0.*/
SELECT a.open_branch_id,
SUM(CASE WHEN p.product_type_cd = 'ACCOUNT' THEN a.avail_balance ELSE 0 END) acc,
SUM(CASE WHEN p.product_type_cd = 'LOAN' THEN a.avail_balance ELSE 0 END) loan
FROM bank.account a INNER JOIN bank.product p ON a.product_cd = p.product_cd
GROUP BY a.open_branch_id
HAVING a.open_branch_id IS NOT NULL;
/*
I was a little perplexed by the crosstab table. I understood that there were two product types: account and loan. Furthermore,
I knew that I had to print out the available balance. I now understand that we are dealing with sums. I correctly connected the
two tables: product and account with the common foreign key product_cd. I then went to group the rows by the branch id.
I messed up with is not null because I instead put the logical operator != null, which gave me an error. When I saw the solution,
the error quickly went away.
*/ 