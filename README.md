# Bookstore Database Design and Implementation  

## Problem Statement  
The project aims to design and implement a comprehensive sales and inventory database tailored for a small "mom-and-pop" bookstore. The focus was on creating a scalable yet simplified solution to efficiently manage core operations such as customer management, inventory tracking, and order processing. This database ensures data integrity and supports the daily transactional needs of a small bookstore.  

## Objectives  
- To design a relational database schema that adheres to Third Normal Form (3NF), minimizing redundancy and ensuring data consistency.  
- To implement the database in PostgreSQL, covering all essential operations through DDL, DML, constraints, and triggers.  
- To provide a robust query set for data retrieval and analysis, including advanced queries for revenue and customer insights.  

## Assumptions  
- **Target Business Size**: The database is designed for a small-scale bookstore with limited inventory stored on-site, avoiding the complexities of multi-warehouse or multi-store setups.  
- **Schema Simplicity**: While larger-scale features, such as warehouse management or detailed tax calculations, could be integrated, the design focuses on meeting the essential needs of a small client within a 5-6 table schema.  
- **Scope Limitation**: Attributes such as employee management were excluded to align with project constraints and the specific business requirements of a small shop.  

## Features  

### Database Design  
- **Entities**:  
  - **Customers**: Captures customer details like name, address, and contact information.  
  - **Books**: Tracks books with attributes like title, author, price, genre, and publisher.  
  - **Orders**: Represents customer transactions, including status and tax.  
  - **Order_Items**: Handles multi-item orders with quantity and subtotal calculations.  
  - **Publishers**: Maintains publisher information for books.  
  - **Inventory**: Tracks stock availability and restocking needs.  

### Functionalities  
1. **Normalization**:  
   - Adheres to 3NF, eliminating transitive dependencies and ensuring efficient data organization.  
   - Attributes such as city and state were omitted to maintain schema simplicity and comply with normalization principles.  

2. **Triggers and Functions**:  
   - A trigger calculates the subtotal for each book in an order based on its price and quantity.  
   - A second trigger updates the total order amount, including tax, whenever an order is modified.  

3. **Advanced Query Capabilities**:  
   - Analyze customer spending patterns, including unique books purchased and buyer categorization.  
   - Calculate genre-specific revenue and identify top-performing publishers.  

4. **Sample Data and Queries**:  
   - Populated tables with realistic data for testing and demonstration.  
   - SQL scripts include basic operations (e.g., selects, joins, filtering) and advanced analytics.  

## Tools and Technologies  
- **Database Management System**: PostgreSQL  
- **Language**: SQL (DDL, DML, Constraints, Triggers, Views)  
- **Environment**: Local PostgreSQL instance for development and testing  

## How to Use  
### Prerequisites  
- PostgreSQL installed on your local machine or accessible via a server.  
- A SQL client tool like pgAdmin or psql. 

### DDL.sql: 
Defines the database schema, including table creation, constraints, and sequences.
### DML.sql:
Inserts sample data into the database for testing and demonstration.
### Queries.sql: 
Contains both basic and advanced SQL queries to showcase database functionalities.

## Challenges and Solutions
### Normalization: 
Ensuring the schema adheres to 3NF while balancing simplicity and functionality.
### Triggers and Functions:
Developing and testing complex triggers to maintain data consistency during order modifications.
### Query Optimization: 
Designing advanced queries to derive meaningful insights without compromising performance.
