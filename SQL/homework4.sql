/*
Imran Sabur Homework 4
*/
SET linesize 150;
SET pagesize 30;

/*1.Which movies’ show times are longer than “I Know What You Did.” but shorter than “Wonton Soup”? */
select TITLE from films.movie WHERE (runningtime > 114 AND runningtime <213);
/*2.What are movie titles that start with letter ‘T’ and are released between 2000 and 2005? */
select TITLE from films.movie where TILTE LIKE 'T%' AND (YEAR_>= 2000 AND YEAR <= 2005);
/*3.How many movie people are not actors?*/
select COUNT(occupation) from films.movieperson WHERE occupation != 'actor';
/*4. How many theatres are in New York or Connecticut? */
select COUNT(Name) from films.theatre IN (select state from films.location WHERE state = 'NY' AND state = 'CT')
/*5. Find all actors whose last name contains an ‘a’ in the second position or first name ends with an ‘a’.*/
select firstname, lastname FROM films.movieperson WHERE (occupation = 'actor') AND (lastname LIKE '_a%') OR (firstname LIKE '%a');
/*6. Find all theatres whose names have the pattern of ‘name Theatre’ (e.g. ‘Worst Theatre’ where ‘Worst’ is the name), and extract the name (e.g. Worst, use SUBSTR). */
select Name FROM films.theatre WHERE INSTR(Name, 'Theatre') > 0;
/*7. Find all theatres whose names DO NOT contain whitespaces between words? */
select Name from films.theatre WHERE name NOT LIKE  '% %';
