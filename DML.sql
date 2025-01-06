SET search_path TO Elkhodari_Books;

--PROMPT insertPublishers.sql

INSERT INTO Publishers (Publisher_Name, Contact_Email, Phone, Pub_Street_Address, Pub_Zip) VALUES 
('Publisher 1', 'contact1@example.com', '12345678901', '123 Publisher St', '1001Zip'),
('Publisher 2', 'contact2@example.com', '12345678902', '123 Publisher St', '1002Zip'),
('Publisher 3', 'contact3@example.com', '12345678903', '123 Publisher St', '1003Zip'),
('Publisher 4', 'contact4@example.com', '12345678904', '123 Publisher St', '1004Zip'),
('Publisher 5', 'contact5@example.com', '12345678905', '123 Publisher St', '1005Zip'),
('Publisher 6', 'contact6@example.com', '12345678906', '123 Publisher St', '1005Zip'),
('Publisher 7', 'contact7@example.com', '12345678907', '123 Publisher St', '1006Zip'),
('Publisher 8', 'contact8@example.com', '12345678908', '123 Publisher St', '1007Zip'),
('Publisher 9', 'contact9@example.com', '12345678909', '123 Publisher St', '1008Zip'),
('Publisher 10', 'contact10@example.com', '12345678900', '123 Publisher St', '1009Zip');



--PROMPT insertBooks.sql

INSERT INTO Books(Title, Author_F_Name, Author_L_Name, Price, Genre, Publication_Date, ISBN, Publisher_ID) 
VALUES 
('A Brief History of Time', 'Stephen', 'Hawking', 18.99, 'Science', '1988-03-01', '9780553380163','Publisher_ID_1'),
('The Hobbit', 'J.R.R.', 'Tolkien', 14.95, 'Fantasy', '1937-09-21', '9780547928227', 'Publisher_ID_2'),
('Harry Potter and the half blood prince','J. K.','Rowling',14.10,'Fantasy','2005-07-18','0747581088','Publisher_ID_3'),
('To Kill a Mockingbird','Harper','Lee',15.99,'Fiction','1960-07-11','9780061120084', 'Publisher_ID_4'),
('The God of Small Things', 'Arundhati', 'Roy', 499.00, 'Fiction', '1997-04-04', '9780143028574', 'Publisher_ID_5'),
('The Immortals of Meluha', 'Amish', 'Tripathi', 350.00, 'Mythological Fiction', '2010-02-01', '9789380658742', 'Publisher_ID_6'),
('The White Tiger','Aravind', 'Adiga', 399.00, 'Fiction', '2008-10-01', '9788172238476', 'Publisher_ID_7'),
('The Last Mughal','William','Dalrymple', 599.00, 'History', '2006-11-01', '9781408800929', 'Publisher_ID_8'),
('Becoming','Michelle', 'Obama', 20.99, 'Memoir', '2018-11-13','9781524763138', 'Publisher_ID_9'),
('Educated', 'Tara', 'Westover', 16.99, 'Biography', '2018-02-20', '9780399590504','Publisher_ID_10');

--PROMPT insertCustomers.sql

INSERT INTO Customers (Cust_F_Name, Cust_L_Name, Email, Phone, Cust_Street_Address, Cust_Zip) VALUES 
('FirstName 1', 'LastName 1', 'customer1@example.com', '98765432101', '456 Customer St', '2001Zip'),
('FirstName 2', 'LastName 2', 'customer2@example.com', '98765432102', '456 Customer St', '2002Zip'),
('FirstName 3', 'LastName 3', 'customer3@example.com', '98765432103', '456 Customer St', '2003Zip'),
('FirstName 4', 'LastName 4', 'customer4@example.com', '98765432104', '456 Customer St', '2004Zip'),
('FirstName 5', 'LastName 5', 'customer5@example.com', '98765432105', '456 Customer St', '2005Zip'),
('FirstName 6', 'LastName 6', 'customer6@example.com', '98765432106', '456 Customer St', '2001Zip'),
('FirstName 7', 'LastName 7', 'customer7@example.com', '98765432107', '456 Customer St', '2002Zip'),
('FirstName 8', 'LastName 8', 'customer8@example.com', '98765432108', '456 Customer St', '2003Zip'),
('FirstName 9', 'LastName 9', 'customer9@example.com', '98765432109', '456 Customer St', '2004Zip'),
('FirstName 10', 'LastName 10', 'customer10@example.com','98765432100', '456 Customer St','2005Zip');


--insertOrders.sql

INSERT INTO Orders (Order_Date, Customer_ID, Order_Status, Sales_Tax) VALUES 
('2021-01-01','Customer_ID_1','Pending' ,.08),
('2021-01-02','Customer_ID_2','Pending' ,.08),
('2021-01-03','Customer_ID_3','Pending' ,.08),
('2021-01-04','Customer_ID_4','Pending' ,.08),
('2021-01-05','Customer_ID_5','Pending' ,.08),
('2021-01-06','Customer_ID_1','Pending' ,.08),
('2021-01-07','Customer_ID_2','Pending' ,.08),
('2021-01-08','Customer_ID_3','Pending' ,.08),
('2021-01-09','Customer_ID_4','Pending' ,.08),
('2021-01-05','Customer_ID_5','Pending' ,.08);


--insertOrder_Items.sql

INSERT INTO Order_Items (Order_ID, Book_ID, Quantity) VALUES 
('Order_ID_1','Book_ID_1' ,1),
('Order_ID_1','Book_ID_2' ,3),
('Order_ID_1','Book_ID_3' ,3),
('Order_ID_2','Book_ID_2' ,2),
('Order_ID_3','Book_ID_3' ,3),
('Order_ID_4','Book_ID_4' ,4),
('Order_ID_5','Book_ID_5' ,5),
('Order_ID_6','Book_ID_1' ,1),
('Order_ID_7','Book_ID_2' ,3),
('Order_ID_8','Book_ID_3' ,3),
('Order_ID_9','Book_ID_10' ,10),
('Order_ID_10','Book_ID_7' ,2);

--InsertInventory.sql

INSERT INTO Inventory (Book_ID, Quantity, Last_Restocked_Date, Reorder_Threshold) VALUES 
('Book_ID_1', 44, CURRENT_DATE, 13),
('Book_ID_2', 45, CURRENT_DATE, 10),
('Book_ID_3', 42, CURRENT_DATE, 10),
('Book_ID_4', 38, CURRENT_DATE, 18),
('Book_ID_5', 15, CURRENT_DATE, 20),
('Book_ID_6', 2, CURRENT_DATE, 5),
('Book_ID_7', 32, CURRENT_DATE, 14),
('Book_ID_8', 20, CURRENT_DATE, 20),
('Book_ID_9', 3, CURRENT_DATE, 12),
('Book_ID_10', 7, CURRENT_DATE, 11);




