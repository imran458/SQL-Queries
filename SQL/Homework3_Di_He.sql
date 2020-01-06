/*First, set the line size and page size to proper values for the easy readings of the log */
SET linesize 150;
SET pagesize 30;

/*1. give a full list of all employees*/
SELECT * FROM bank.employee;
/*2. how many are there?*/ 
SELECT COUNT(DISTINCT emp_id) AS Answer FROM bank.employee;
/*3. how many different departments do they work in*/
SELECT COUNT(DISTINCT dept_id) AS Answer FROM bank.employee;
/*4. how many accounts have an available balance of no more than $6000*/
SELECT COUNT(DISTINCT account_id) AS Answer FROM bank.account WHERE avail_balance <= 6000;
 /*5. list all the business customer's names*/
SELECT name FROM bank.business;
/*6. make an output of all employess with column headings First Name, and Last Name*/
SELECT fname AS "First Name", lname AS "Last Name" FROM bank.employee;
/*7. which active savings accounts were opened at branch #1*/
SELECT account_id FROM bank.account WHERE product_cd = 'SAV' AND status = 'ACTIVE' AND open_branch_id = 1;
/*8. which is the maximum, average, and minimum account of balances in branch #2*/
SELECT MAX(avail_balance), AVG(avail_balance), MIN(avail_balance) FROM bank.account WHERE open_branch_id=2;
/*9. which branch has an account with the largest account of balance, and what is the amount*/
SELECT open_branch_id, account_id, avail_balance FROM bank.account WHERE avail_balance=(SELECT MAX(avail_balance) FROM bank.account);




