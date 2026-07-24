# Online_Bookstore

# Project Overview

**Project Title:** Online Bookstore 
**Database:** `online_bookstore_db`

This project demonstrates SQL skills and techniques used by data analysts to explore, clean, manage, and analyze an online bookstore database. The project uses relational database concepts with multiple tables and SQL queries to generate meaningful business insights from bookstore sales data.

---

# Objectives

1. **Database Setup:** Create an Online Bookstore database and import the provided CSV datasets.
2. **Table Creation:** Design and create relational tables for Books, Customers, and Orders.
3. **Data Cleaning:** Check for missing, duplicate, or inconsistent records before analysis.
4. **Data Analysis:** Perform SQL queries to analyze customer behavior, book sales, and order trends.
5. **Business Insights:** Generate useful insights to help understand sales performance and customer purchasing patterns.
6. **Report Generation:** Create reports using SQL queries for business decision-making.

---

# Project Structure

## 1. Database Setup

The project contains **three CSV datasets**, which were imported into SQL as three relational tables.

### Database Name
`online_bookstore_db`

### Tables Created

### 1. Books
Stores complete information about available books.

Columns include:
- Book_ID
- Title
- Author
- Genre
- Published_Year
- Price
- Stock

---

### 2. Customers
Stores customer details.

Columns include:
- Customer_ID
- Name
- Email
- Phone
- City
- Country

---

### 3. Orders
Stores customer purchase records.

Columns include:
- Order_ID
- Customer_ID
- Book_ID
- Order_Date
- Quantity
- Total_Amount

---

# SQL Analysis Performed

The project includes SQL queries for:

- Database creation
- Table creation
- Data validation
- Data cleaning
- JOIN operations
- Aggregate Functions
- GROUP BY
- ORDER BY
- Filtering using WHERE
- Date-based analysis
- Customer purchase analysis
- Book sales analysis
- Revenue analysis
- Top-selling books
- Customer order history
- Genre-wise sales analysis
- Inventory (Stock) analysis

---

---Create Database
CREATE DATABASE Online_Bookstore;



---Create Tables
CREATE TABLE Books (
   Book_ID SERIAL PRIMARY KEY,
   Title VARCHAR(100),
   Author VARCHAR(100),
   Genre VARCHAR(50),
   Published_Year INT,
   Price NUMERIC(10, 2),
   Stock INT
);


CREATE TABLE Customers (
   Customer_ID SERIAL PRIMARY KEY,
   Name VARCHAR(100),
   Email VARCHAR(100),
   Phone VARCHAR(50),
   City VARCHAR(100),
   Country VARCHAR(100)
);



CREATE TABLE Orders (
   Order_ID SERIAL PRIMARY KEY,
   Customer_ID INT REFERENCES Customers(Customer_ID),
   Book_ID INT REFERENCES Books(Book_ID),
   Order_Date DATE,
   Quantity INT,
   Total_Amount NUMERIC(10, 2)
);



SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Basic Queries
--1) Retrieve all the books in the 'Fiction' genre:

SELECT * FROM Books
WHERE genre='Fiction';

--extra

SELECT * FROM Books
WHERE genre='Mystery';



--2) Find books published after the year 1950

SELECT * FROM Books
WHERE Published_Year>1950;


--if want in ascending order
SELECT * FROM Books
WHERE Published_Year>1950
ORDER BY Published_Year ASC;



--3) List all customers from the Canada

SELECT * FROM Customers
WHERE Country='Canada';



--4) Show orders placed in November 2023

SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';



--5) Retrieve the total stock of books available

SELECT SUM(stock) AS Total_Stock
FROM Books;



--6) Find the details of the most expensive book

SELECT * FROM Books ORDER BY Price DESC
LIMIT 1;



--7) Show all customers who ordered more than 1 quantity of a book

SELECT * FROM Orders
WHERE quantity>1;



--8) Retrieve all orders where the total amount exceeds $20

SELECT * FROM Orders
WHERE total_amount>20;



--9) List all genres available in the books table

SELECT DISTINCT genre FROM Books;


--10) Find the book with the lowest stock

SELECT * FROM Books 
ORDER BY stock
LIMIT 1;


--11) Calculate the total revenue generated from all orders

SELECT SUM(total_amount) AS Revenue 
FROM Orders;



---ADVANCED QUESTIONS

--1) Retrieve the total number of books sold for each genre:

SELECT * FROM Orders;

SELECT b.Genre, SUM(o.Quantity) AS Total_books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;



--2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(price) AS Average_Price 
FROM Books
WHERE Genre = 'Fantasy';



--3) List customers who have placed at least 2 orders:

SELECT Customer_id, COUNT(Order_id) AS Order_Count
FROM Orders
GROUP BY Customer_id
Having COUNT(Order_id) >= 2;

--if we want customer name also then:

SELECT o.Customer_id, c.name, COUNT(o.Order_id) AS Order_Count
FROM Orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name
Having COUNT(Order_id) >= 2;



--4) Find the most frequently ordered book:

SELECT Book_id, COUNT(Order_id) AS ORDER_COUNT
FROM Orders
GROUP BY Book_id
ORDER BY ORDER_COUNT DESC LIMIT 1;


---if we want book name with this

SELECT o.Book_id, b.title, COUNT(o.Order_id) AS ORDER_COUNT
FROM Orders o
JOIN Books b ON o.Book_id = b.Book_id
GROUP BY o.Book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;


--5) Show the top 3 most expensive books of "Fantasy" Genre:

SELECT * FROM Books
WHERE genre='Fantasy'
ORDER BY price DESC 
LIMIT 3;



--6) Retrieve the total quantity of books sold by each author:


SELECT b.author, SUM(o.quantity) AS TOTAL_QUANTITY_BOOKS
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.author;




--7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM Orders o
JOIN Customers c ON c.customer_id = o.customer_id
WHERE o.total_amount > 30;




--8) Find the customer who spent the most on orders:

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_Spent DESC
LIMIT 1;




# Findings

- **Book Inventory:** The bookstore contains a diverse collection of books across multiple genres with different stock levels and pricing.
- **Customer Distribution:** Customers belong to different cities and countries, allowing geographical sales analysis.
- **Sales Performance:** Order data reveals variations in customer purchasing patterns and total sales over different periods.
- **Popular Books:** SQL analysis identifies the best-selling books based on total quantity sold.
- **Revenue Insights:** High-value orders contribute significantly to the overall bookstore revenue.
- **Customer Insights:** Some customers place multiple orders, helping identify loyal and high-value customers.
- **Genre Analysis:** Certain book genres generate higher sales than others, indicating customer preferences.

---

# Reports

### Sales Summary
A comprehensive report showing:
- Total Orders
- Total Revenue
- Total Quantity Sold
- Average Order Value

### Customer Report
Provides:
- Total Customers
- Customers with Multiple Orders
- Top Spending Customers
- Customer Purchase History

### Book Report
Includes:
- Total Books
- Best Selling Books
- Low Stock Books
- Genre-wise Performance

### Revenue Report
Displays:
- Revenue by Book
- Revenue by Genre
- Revenue Trends over Time

### Inventory Report
Shows:
- Current Stock Availability
- Low Inventory Books
- Stock Status for Business Monitoring

---

# Conclusion

This project provides a comprehensive understanding of SQL concepts using a real-world Online Bookstore database. It demonstrates database creation, table relationships, data cleaning, JOIN operations, aggregate functions, and business-oriented SQL queries.

The analysis helps identify sales trends, customer purchasing behavior, top-selling books, revenue performance, and inventory status. These insights can support better inventory management, customer relationship strategies, and overall business decision-making.

Overall, this project showcases practical SQL skills commonly required for Data Analyst and SQL Developer roles.
