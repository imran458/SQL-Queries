SET linesize 150;
SET pagesize 150;



/* 1. How many contigs have a name that begins with the letters lp? */
select count(distinct mol_name || mol_id)  from genome.contig where mol_name LIKE 'lp%';
/*
This query was quite self explanatory. However, one thing that I did not was specify the specfic contigs which begin with LP.
With the homework solution, I added distinct to ensure I get the most accurate results from the query.
/*

/* 2. How many contigs are not plasmids? */ 
select count(distinct mol_name || mol_id) from genome.contig where mol_name NOT LIKE '%plasmid%';
/*
Like the previous query, the answer to this was quite simple. However, I made the mistake of not spcifying
the distint contigs or mol_id which are not plasmids. 
*/ 

/* 3. What is the longest contig?*/
select mol_name, length(dna_sequence) from genome.contig where length(dna_sequence)
=(select(max(length(dna_sequence)) from genome.contig);
/*
I had made a mistake with the bracing portion of this query.
Instead of select(max) I had "selectmax."
This makes sense as I was very confused as to why I got this question incorrect but
it worked locally on SQL. 
*/

/* 4. How many ORFs begin after the first 150 positions of their contig?*/
select count(distinct orf_id || mol_id || genome_id) from genome.orf where orf_begin_coord>150;
/*
I had the same problem for this query as I did for the first couple questions. 
i did not include distinct as well the or conditional to indicate the different type of contigs. 
The other parts of the query were fine.

*/

/*5. Which ORFs occupy at least 10% of the LENGTH of their contig? */
SELECT DISTINCT o.orf_id, o.annotation FROM genome.orf o INNER JOIN genome.contig c using (mol_id) WHERE (o.orf_end_coord - o.orf_begin_coord + 1) * 10 >= LENGTH(c.dna_sequence);
/*
I had got half of this query correct however I was confused about the conditional.
I connected the two tables using the mol_id but was lost in specifying which orfs occupy atleast
10% of the length of the contig.
*/

/*6. Which ORFs begin with a TC followed by 3 nucleotides and then followed by a TG? */
SELECT DISTINCT o.orf_id, o.annotation FROM genome.orf o INNER JOIN genome.contig c using (mol_id) 
WHERE SUBSTR(c.dna_sequence, o.orf_begin_coord, o.orf_end_coord - o.orf_begin_coord + 1) LIKE 'TC___TG%';
/*
I connected the orf table with the contig table via the mol_id. Where I had trouble with
was with the subtring function. I did not think of subtracting the end coord with the beginning 
coord. 
*/

/*7. What are the names of the contigs that contain ORFs that begin with 2 C’s separated FROM each other by 2 nucleotides and then followed by a G?*/
SELECT DISTINCT c.mol_id, c.mol_name FROM genome.orf o INNER JOIN genome.contig c using (mol_id) 
WHERE SUBSTR(c.dna_sequence, o.orf_begin_coord, o.orf_end_coord- o.orf_begin_coord + 1) LIKE 'C__CG%';
/*
For this query, I had joined the orf table and contig table with the mol_id as foreign key
to obtin the names of the molecules. I followed a similar pattern for this as I did with the
previous query. 
*/


/*8. Which contigs contain ORFs that end in a T and C with one nucleotide between them?*/
SELECT DISTINCT c.mol_id, c.mol_name FROM genome.orf o INNER JOIN genome.contig c using (mol_id) 
WHERE SUBSTR(c.dna_sequence, o.orf_begin_coord, o.orf_end_coord- o.orf_begin_coord + 1) LIKE '%T_C';

/*
For this query, I joined the orf table with contig table in order to obtain the specific
mol_id and name. I followed a similar pattern for the substring function but changed the 
specifications of the wildcard
*/ 

/*9. How many ORFs contain at least 4 A’s followed immediately by at least 3 C? */
SELECT COUNT(DISTINCT o.genome_id || o.mol_id || o.orf_id) Ans9 FROM genome.orf o INNER JOIN genome.contig c using (mol_id)
WHERE REGEXP_LIKE(SUBSTR(c.dna_sequence,  o.orf_begin_coord, o.orf_end_coord - o.orf_begin_coord + 1) , 'A{4,}C{3,}');

/*
For this query, I connected the orf table with the contig table in order to obtain the distinct
id of the orfs which have atleast 4 A's followed by 3 C's. I did have a lot of trouble with the 
substring function and had to refer to the answer provided.
*/ 



