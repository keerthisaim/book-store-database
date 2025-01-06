SET search_path TO Elkhodari_Books;

---Query 1: Select all columns and all rows from one table

SELECT * 
FROM Customers;

---Query 2: Select five columns and all rows from one table

SELECT Customer_ID, Cust_F_Name, Cust_L_Name, Email, Phone 
FROM Customers;

---Query 3: Select all columns from all rows from one view

CREATE VIEW CustomerOrders AS
SELECT 
    Customers.Customer_ID,
    Customers.Cust_F_Name,
    Customers.Cust_L_Name,
    Customers.Email,
    Customers.Phone,
    Customers.Cust_Street_Address,
    Customers.Cust_Zip,
    Orders.Order_ID,
    Orders.Order_Date,
    Orders.Order_Status,
    Orders.Sales_Tax,
    Orders.Total_Amount
FROM 
    Customers
JOIN 
    Orders ON Customers.Customer_ID = Orders.Customer_ID;

SELECT * 
FROM CustomerOrders;

---Query 4: Using a join on 2 tables, select all columns and all rows without a Cartesian product

SELECT * 
FROM Orders
JOIN Customers ON Orders.Customer_ID = Customers.Customer_ID;

---Query 5: Select and order data retrieved from one table

SELECT * 
FROM Books 
ORDER BY Price DESC;

---Query 6: Using a join on 3 tables, select 5 columns, and limit output to 3 rows

SELECT Orders.Order_ID, Customers.Cust_F_Name, Books.Title, Order_Items.Quantity, Order_Items.Subtotal
FROM Orders
JOIN Customers ON Orders.Customer_ID = Customers.Customer_ID
JOIN Order_Items ON Orders.Order_ID = Order_Items.Order_ID
JOIN Books ON Order_Items.Book_ID = Books.Book_ID
LIMIT 3;

---Query 7: Select distinct rows using joins on 3 tables

SELECT DISTINCT Customers.Customer_ID, Customers.Cust_F_Name, Books.Title, Orders.Order_Date
FROM Orders
JOIN Customers ON Orders.Customer_ID = Customers.Customer_ID
JOIN Order_Items ON Orders.Order_ID = Order_Items.Order_ID
JOIN Books ON Order_Items.Book_ID = Books.Book_ID;

---Query 8: Use GROUP BY and HAVING in a select statement

SELECT Genre, Round(AVG(Price),2) AS Average_Price
FROM Books
GROUP BY Genre
HAVING Round(AVG(Price),2)> 20;

---Query 9: Use IN clause to select data from one or more tables

SELECT * 
FROM Books 
WHERE Publisher_ID IN ('Publisher_ID_1', 'Publisher_ID_2', 'Publisher_ID_3');

---Query 10: Select the length of one column from one table

SELECT LENGTH(Title) AS Title_Length 
FROM Books;

/*
Query 11
Delete one record from one table. Use select statements to demonstrate the table contents before and after the DELETE statement.
Make sure you use ROLLBACK afterwards so that the data will not be physically removed 
*/

BEGIN;

SET search_path TO Elkhodari_Books;

-- View all records in the Customers table before deletion

SELECT * FROM Customers;

-- Delete a specific record from the Customers table

DELETE FROM Customers
WHERE Cust_F_Name = 'FirstName 10' AND Cust_L_Name = 'LastName 10';

-- View all records in the Customers table after deletion


SELECT * FROM Customers;

-- Rollback to undo the DELETE operation

ROLLBACK;

-- Verify that the Customers table remains unchanged

SELECT * FROM Customers;

/*
Query 12: 
Update one record from one table. Use select statements to demonstrate the table contents before and after the UPDATE statement. 
Make sure you use ROLLBACK afterwards so that the data will not be physically removed 
*/

BEGIN;

SET search_path TO Elkhodari_Books;
-- Display the record before the update

SELECT * FROM Publishers WHERE Publisher_ID = 'Publisher_ID_3';

-- Update the record

UPDATE Publishers
SET Publisher_Name = 'Updated Publisher 3', Contact_Email = 'updated_contact3@example.com', phone = '99999999990'
WHERE Publisher_ID = 'Publisher_ID_3';

-- Display the record after the update

SELECT * FROM Publishers WHERE Publisher_ID = 'Publisher_ID_3';

-- Rollback the transaction to undo the changes

ROLLBACK;

-- Verify that the changes have been reverted

SELECT * FROM Publishers WHERE Publisher_ID = 'Publisher_ID_3';

SELECT * FROM Publishers;

--------------------------------------------------------------------------------------------------------------------------


--Advanced Query 1:
/*
Description: Write a query to identify the top 5 customers based on their total spending, along with 
the number of unique books they purchased, their average spending per book and categorise them based on the number of unique books purchased
*/

/* SQL CODE */

SELECT 
    C.Cust_F_Name || ' ' || C.Cust_L_Name AS Customer_Name,
    Total_Spending,
    Unique_Books_Purchased,
    CASE 
        WHEN Unique_Books_Purchased > 10 THEN 'High Volume Buyer'
        WHEN Unique_Books_Purchased BETWEEN 5 AND 10 THEN 'Moderate Buyer'
        ELSE 'Low Volume Buyer'
    END AS Buyer_Category,
    ROUND(Total_Spending / Unique_Books_Purchased, 2) AS Avg_Spending_Per_Book
FROM (
    SELECT 
        O.Customer_ID,
        SUM(OI.Quantity * B.Price) AS Total_Spending,
        COUNT(DISTINCT OI.Book_ID) AS Unique_Books_Purchased
    FROM 
        Orders O
    INNER JOIN 
        Order_Items OI
    ON 
        O.Order_ID = OI.Order_ID
    INNER JOIN 
        Books B
    ON 
        OI.Book_ID = B.Book_ID
    GROUP BY 
        O.Customer_ID
) SpendingData
INNER JOIN 
    Customers C
ON 
    SpendingData.Customer_ID = C.Customer_ID
ORDER BY 
    Total_Spending DESC
LIMIT 5;



/*Advanced Query 2
Description: Write a SQL query to calculate the total revenue generated by each genre and identify the publisher with the highest revenue for each genre 
HINT: (Using Subqueries)
*/

/*SQL CODE*/
SELECT 
    Genre,
    Publisher_Name,
    Total_Revenue
FROM (
    SELECT 
        B.Genre,
        P.Publisher_Name,
        SUM(OI.Quantity * B.Price) AS Total_Revenue,
        RANK() OVER (PARTITION BY B.Genre ORDER BY SUM(OI.Quantity * B.Price) DESC) AS Rank
    FROM 
        Books B
    INNER JOIN 
        Publishers P
    ON 
        B.Publisher_ID = P.Publisher_ID
    INNER JOIN 
        Order_Items OI
    ON 
        B.Book_ID = OI.Book_ID
    GROUP BY 
        B.Genre, P.Publisher_ID, P.Publisher_Name
) GenreRevenue
WHERE 
    Rank = 1
ORDER BY
  Total_Revenue DESC;
