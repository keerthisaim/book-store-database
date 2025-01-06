-- Set up schema and tables in the new database
CREATE SCHEMA IF NOT EXISTS Elkhodari_Books;

SET search_path TO Elkhodari_Books;

-- Drop triggers if they exists

DROP TRIGGER IF EXISTS set_subtotal ON Order_Items;
DROP TRIGGER IF EXISTS update_order_amount ON Order_Items;

-- Drop functions if they exists

DROP FUNCTION IF EXISTS calculate_subtotal;
DROP FUNCTION IF EXISTS calculate_order_amount;

-- Drop default dependencies on sequences before dropping them

ALTER TABLE IF EXISTS Books ALTER COLUMN Book_ID DROP DEFAULT;
ALTER TABLE IF EXISTS Customers ALTER COLUMN Customer_ID DROP DEFAULT;
ALTER TABLE IF EXISTS Publishers ALTER COLUMN Publisher_ID DROP DEFAULT;
ALTER TABLE IF EXISTS Orders ALTER COLUMN Order_ID DROP DEFAULT;

-- Drop sequences

DROP SEQUENCE IF EXISTS Book_ID_seq;
DROP SEQUENCE IF EXISTS Customer_id_seq;
DROP SEQUENCE IF EXISTS Publisher_ID_seq;
DROP SEQUENCE IF EXISTS Order_ID_seq;

-- Drop tables

DROP TABLE IF EXISTS Order_Items CASCADE;
DROP TABLE IF EXISTS Inventory CASCADE;
DROP TABLE IF EXISTS Books CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS Publishers CASCADE;
DROP TABLE IF EXISTS Customers CASCADE;

--Create separate sequences for each parent table

CREATE SEQUENCE book_id_seq START 1 INCREMENT 1;
CREATE SEQUENCE customer_id_seq START 1 INCREMENT 1;
CREATE SEQUENCE publisher_id_seq START 1 INCREMENT 1;
CREATE SEQUENCE order_id_seq START 1 INCREMENT 1;

-- Creating Publishers Table

CREATE TABLE Publishers (
    Publisher_ID VARCHAR(50) PRIMARY KEY DEFAULT 'Publisher_ID_' || nextval('publisher_id_seq'),
    Publisher_Name VARCHAR(50) NOT NULL,
    Contact_Email VARCHAR(50) NOT NULL UNIQUE,
    Phone VARCHAR(15) NOT NULL,---UNIQUE
    Pub_Street_Address VARCHAR(255) NOT NULL,
    Pub_Zip VARCHAR(10) NOT NULL
);

-- Creating Books Table

CREATE TABLE Books (
    Book_ID VARCHAR(50) PRIMARY KEY DEFAULT 'Book_ID_' || nextval('book_id_seq'),
    Title VARCHAR(100),
    Author_F_Name VARCHAR(50),
    Author_L_Name VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price >= 0),
    Genre VARCHAR(30),
    Publication_Date DATE,
    ISBN CHAR(13),
    Publisher_ID VARCHAR(50),
    FOREIGN KEY (Publisher_ID) REFERENCES Publishers(Publisher_ID) ON UPDATE CASCADE 
);

--Creating Inventory Table

CREATE TABLE Inventory (
    Book_ID VARCHAR(50) PRIMARY KEY REFERENCES Books(Book_ID) ON UPDATE CASCADE, 
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    Last_Restocked_Date DATE,
    Reorder_Threshold INT NOT NULL CHECK (Reorder_Threshold >= 0)
);

-- Create Table Customers

CREATE TABLE Customers (
    Customer_ID VARCHAR(50) PRIMARY KEY DEFAULT 'Customer_ID_' || nextval('customer_id_seq'),
    Cust_F_Name VARCHAR(50) NOT NULL,
    Cust_L_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    Cust_Street_Address VARCHAR(255) NOT NULL,
    Cust_Zip VARCHAR(10) NOT NULL
);
-- Creating Orders Table

CREATE TABLE Orders (
    Order_ID VARCHAR(50) PRIMARY KEY DEFAULT 'Order_ID_' || nextval('order_id_seq'),
    Order_Date DATE NOT NULL DEFAULT CURRENT_DATE,
    Customer_ID VARCHAR(50) NOT NULL REFERENCES Customers(Customer_ID) ON UPDATE CASCADE,
    Order_Status VARCHAR(20) NOT NULL,
    Sales_Tax NUMERIC(5, 2) NOT NULL CHECK (Sales_Tax >= 0),
    Total_Amount NUMERIC(10, 2) CHECK (Total_Amount >= 0)
);

--create Order_Items table with NOT NULL contraints and cascading behavior based on entities--

Create TABLE Order_Items(
	Order_ID VARCHAR(50) NOT NULL REFERENCES Orders(Order_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	Book_ID VARCHAR(50) NOT NULL REFERENCES Books(Book_ID) ON UPDATE CASCADE,
	Quantity INT NOT NULL CHECK (Quantity > 0),
	Subtotal NUMERIC(10, 2) NOT NULL CHECK (Subtotal >= 0),
	PRIMARY KEY (Order_ID, Book_ID)
);

-- Create a function to calculate Subtotal in Order_Items

CREATE OR REPLACE FUNCTION calculate_subtotal()
RETURNS TRIGGER AS $$
BEGIN
-- Calculate Subtotal as Price from Books * Quantity in Order_Items
	
    SELECT Price INTO NEW.Subtotal
    FROM Books
    WHERE Books.Book_ID = NEW.Book_ID;

    NEW.Subtotal := NEW.Subtotal * NEW.Quantity;
    RETURN NEW;
END;
$$
 LANGUAGE plpgsql;

-- Create a trigger to execute the function before insert or update on Order_Items

CREATE TRIGGER set_subtotal
BEFORE INSERT OR UPDATE ON Order_Items
FOR EACH ROW
EXECUTE FUNCTION calculate_subtotal();

-- Create a function to calculate and update Total_Amount in Orders table

CREATE OR REPLACE FUNCTION calculate_order_amount()
RETURNS TRIGGER AS $$
DECLARE
    total_subtotals NUMERIC(10,2);
BEGIN
-- Sum all subtotals for the given Order_ID in Order_Items table

    SELECT SUM(Subtotal)
    INTO total_subtotals
    FROM Order_Items
    WHERE Order_Items.Order_ID = NEW.Order_ID;

    -- Update Total_Amount in Orders table: (Sales_Tax + 1) * total_subtotals
	
    UPDATE Orders
    SET Total_Amount = (Sales_Tax + 1) * total_subtotals
    WHERE Orders.Order_ID = NEW.Order_ID;

    RETURN NEW;
END;
$$
 LANGUAGE plpgsql;

-- Create a trigger to execute the function after insert or update on Order_Items

CREATE TRIGGER update_order_amount
AFTER INSERT OR UPDATE ON Order_Items
FOR EACH ROW
EXECUTE FUNCTION calculate_order_amount();

