SET linesize 150;
SET pagesize 150;


/*1.Which stores have ordered ice cream?*/
select s.store_name
from grocery.store_order o inner join grocery.belongs_to b using (product_id)
inner join grocery.store s using (store_id)
where b.category_name = 'ice cream';
/*
In the grocery database, I needed to join tables in order to get
find out which stores had ice cream. Therefore, I connected the store order
table with belongs_to table using the key that they both shared: prodcut id.
Then I connected the belongs_to table with the store table, as that would tell me what
stores had ordered ice cream via the store_id as it was common with the belongs_to table and category_name table.
I aliased the belongs_to table with a "b" so I used that to search for "ice cream". 
*/
/*/*2. Which salaried employees are over 20 and work at Manhattan 5? */
select e.fname,e.lname
FROM grocery.salaried s inner join grocery.employee e using (essn)
inner join grocery.works_in w using (essn)
inner join grocery.store s using (store_id)
where s.store_name = 'Manhattan 5' and (current_date-bday)/365 > 20;
/*
For this query, I used inner join to connect employees and salaried employees 
via the essn. Next I used inner join to connect the works_in table to find out where
the employee works in. These two tables were joined via the essn as that was common to both tables.
Lastly I inner joined works_in table with the store table to precisely find out what employees are over 20 and work in Manhattan.

/*3. What are the names and telephone numbers of the contacts at the vendors that sell ice cream? */
SELECT DISTINCT vc.contact_name, vc.contact_phone 
FROM grocery.Vendor_contact vc INNER JOIN grocery.Can_supply cs ON cs.vendor_id = vc.vendor_id 
INNER JOIN grocery.Product_Batch pb ON pb.product_id = cs.product_id INNER JOIN grocery.Belongs_to b ON b.product_id = pb.product_id 
WHERE b.category_name = 'ice cream';
/*
For this query I had to refer to the solution provided. 
I had gotten up to the product_batch table and inner joined with the belong_to table via the product id,
however I had trouble with the vendor contact inner join. Now I learned that before I can connect the product batch with the belongs_to table
I needed to to check if the vendors do sell that product using can_supply.


/*4. Has any product yet to arrive? */
SELECT p.name 
FROM grocery.Product_Batch p INNER JOIN grocery.Store_order s1 ON p.product_id=s1.product_id 
WHERE s1.product_id NOT IN (SELECT product_id FROM grocery.Product_Batch_Purchased WHERE actual_arrival_date IS NOT NULL);
/*
In order to complete this query, I had to first find out if the product
was set to arrive. Therefore I was able to come up with the first inner join which would
allow me to get the products which a particular store ordered. However, I was not able to get the last part
of the query. It makes sense now but I was not sure if i could structure my query that way.


/*5. Who works at Manhattan 3? */
SELECT e.fname, e.lname 
FROM grocery.Employee e INNER JOIN grocery.Works_In w ON e.essn = w.essn INNER JOIN grocery.Store s ON w.store_id = s.store_id 
WHERE s.store_name = 'Manhattan 3';
/*
This query was quite simple and straightforward. I had used two inner joins to connect the works_in table with the store table.
Then I put the conditional to specify what store.
*/

/*6. Which employees have both daughter and son? */
SELECT DISTINCT e.fname, e.lname 
FROM grocery.Employee e INNER JOIN grocery.Dependent d ON d.essn=e.essn INNER JOIN grocery.Dependent f ON e.essn=f.essn 
WHERE d.relationship='son' AND f.relationship='daughter';
/*
This was again one of the more simpler queries.  I connected the employee table with
the dependent table to get the children. I then put the conditional to obtain
the number of those who have both a son and daughter
*/ 

