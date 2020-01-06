/*
Imran Sabur
CSCI 232
Homework 5
*/

SET linesize 150;
SET pagesize 150;



/*1.How many vendors are in New York state? */
select count(DISTINCT NAME) from grocery.vendor where vendor_id IN (select vendor_id from grocery.vendor_address where state_territory_province = 'New York');
/*2. What baked goods were ordered before the current date? */
select a.name from grocery.product_batch a INNER JOIN grocery.belongs_to b ON a.product_id = b.product_id WHERE a.order_date < CURRENT_DATE
/*3.Which employee(s) (outputting their full names in one single column) have son(s)?*/
select fname,lname from grocery.employee where ESSN IN (select ESSN from grocery.dependent where RELATIONSHIP = 'son');
/*4. Which vendors have contact phone numbers with area code 234?*/
select name from grocery.vendor where vendor_id IN (select vendor_id from grocery.vendor_contact where (contact_phone LIKE '%234%'))
/*5.Which salaried employees have a phone number with area code 333?*/
select fname,lname from grocery.employee where ESSN IN(select ESSN from grocery.salaried) AND IN (select ESSN from grocery.employee where (PHONE1 LIKE '%333%'));
/*6.What is the product name that is not expired and whose in-store price per item is less than $5.00? (If
 there is no expired date, the product will be considered to last forever) */
select NAME,EXPIRATION_DATE from grocery.product_batch WHERE EXPIRATION_DATE > CURRENT_DATE AND POTENTIAL_ORDER_PRICE_PER_ITEM < '5.00';
