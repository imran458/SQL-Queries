/*First, set the line size and page size to proper values for the easy readings of the log */
SET linesize 200;
SET pagesize 200;

/*1. Which stores have ordered ice cream? */
SELECT s.store_name, b.category_name 
FROM grocery.Store s INNER JOIN grocery.Store_order o on s.store_id = o.store_id INNER JOIN grocery.Belongs_To b on o.product_id = b.product_id 
WHERE b.category_name = 'ice cream';
/*2. Which salaried employees are over 20 and work at Manhattan 5? */
SELECT e.fname, e.lname 
FROM grocery.Employee e INNER JOIN grocery.Salaried sa ON e.essn = sa.essn INNER JOIN grocery.Works_In w on sa.essn = w.essn INNER JOIN grocery.Store st ON w.store_id = st.store_id 
WHERE ((sysdate-e.bday)/365.25 > 20) AND st.store_name='Manhattan 5';
/*3. What are the names and telephone numbers of the contacts at the vendors that sell ice cream? */
SELECT DISTINCT vc.contact_name, vc.contact_phone 
FROM grocery.Vendor_contact vc INNER JOIN grocery.Can_supply cs ON cs.vendor_id = vc.vendor_id INNER JOIN grocery.Product_Batch pb ON pb.product_id = cs.product_id INNER JOIN grocery.Belongs_to b ON b.product_id = pb.product_id 
WHERE b.category_name = 'ice cream';
/*4. Has any product yet to arrive? */
SELECT p.name 
FROM grocery.Product_Batch p INNER JOIN grocery.Store_order s1 ON p.product_id=s1.product_id 
WHERE s1.product_id NOT IN (SELECT product_id FROM grocery.Product_Batch_Purchased WHERE actual_arrival_date IS NOT NULL);
/*5. Who works at Manhattan 3? */
SELECT e.fname, e.lname 
FROM grocery.Employee e INNER JOIN grocery.Works_In w ON e.essn = w.essn INNER JOIN grocery.Store s ON w.store_id = s.store_id 
WHERE s.store_name = 'Manhattan 3';
/*6. Which employees have both daughter and son? */
SELECT DISTINCT e.fname, e.lname 
FROM grocery.Employee e INNER JOIN grocery.Dependent d ON d.essn=e.essn INNER JOIN grocery.Dependent f ON e.essn=f.essn 
WHERE d.relationship='son' AND f.relationship='daughter';