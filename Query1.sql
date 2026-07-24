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






 


