--user is system with password system
-- creating dummy tables according to the assignment 


--Customers Table
create table Customers(
    CustomerID NUMBER PRIMARY KEY,
    FirstName VARCHAR(25),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

--Orders table
create table Orders(
     OrderID  NUMBER PRIMARY KEY,
     CustomerID NUMBER NOT NULL,
     OrderDate date,
     TotalAmount NUMBER(10,2),
     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Products Table
create table Products(
    ProductID NUMBER PRIMARY KEY,
    ProductName VARCHAR(250),
    UnitPrice NUMBER(10, 2)  
);

-- OrderDetails Table
create table OrderDetails(
    OrderDetailID NUMBER PRIMARY KEY,
    OrderID NUMBER,
    ProductID NUMBER,
    Quantity NUMBER,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- inserting data into dummy tables
-- Orders Table
insert into Orders(OrderID,CustomerID, OrderDate, TotalAmount)
values(1,1001,TO_DATE('2020-01-25','YYYY-MM-DD'),5500.00);

insert into Orders(OrderID,CustomerID, OrderDate, TotalAmount)
values(2,1002,TO_DATE('2020-11-14','YYYY-MM-DD'),500.00);

insert into Orders(OrderID,CustomerID, OrderDate, TotalAmount)
values(3,1001,TO_DATE('2020-06-23','YYYY-MM-DD'),4500.00);

insert into Orders(OrderID,CustomerID, OrderDate, TotalAmount)
values(4,1004,TO_DATE('2022-08-15','YYYY-MM-DD'),700.00);

insert into Orders(OrderID,CustomerID, OrderDate, TotalAmount)
values(5,1002,TO_DATE('2022-11-23','YYYY-MM-DD'),4500.00);   
         

--Customers Table
insert into Customers (CustomerID, FirstName, LastName, Email)
values(1001,'Laiba','Shaikh','laibas@gmail.com');

insert into Customers (CustomerID, FirstName, LastName, Email)
values(1002,'Shashank','Tiwari','shahsankt@gmail.com');

insert into Customers (CustomerID, FirstName, LastName, Email)
values(1003,'Chahak','Garg','chahakg@gmail.com');

insert into Customers (CustomerID, FirstName, LastName, Email)
values(1004,'Anam','Irfan','anami@gmail.com');

insert into Customers (CustomerID, FirstName, LastName, Email)
values(1005,'Noorien','Shaikh','nooriens@gmail.com');


--Products Table
insert into Products(ProductID, ProductName, UnitPrice)
values(4000,'light bulb', 500.00);

insert into Products(ProductID, ProductName, UnitPrice)
values(4001,'refrigerator',25000.00);

insert into Products(ProductID, ProductName, UnitPrice)
values(4002,'smartphone',35000.00);

insert into Products(ProductID, ProductName, UnitPrice)
values(4003,'electric fan',5000.00);

insert into Products(ProductID, ProductName, UnitPrice)
values(4004,'air conditioner',45000.00);



-- OrderDetails Table
insert into OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)
values(10,1,4002,2);

insert into OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)
values(20,2,4004,11);

insert into OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)
values(30,3,4003,40);

insert into OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)
values(40,4,4004,12);

insert into OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)
values(50,5,4001,2);


/*task 1
Retrieve a list of customers who have made at least one purchase, along with their total spending.*/

select c.FirstName,c.LastName, SUM(o.TotalAmount) AS TOTALMONEYSPENT
from Customers c
JOIN Orders o on o.CustomerID= c.CustomerID
GROUP BY c.FirstName, c.LastName;


/*task 2
Calculate the total revenue generated from sales in the year 2022. */

select SUM(TotalAmount)as RevenueGeneratedin2022
from Orders
where EXTRACT(YEAR from OrderDate)=2022;



/*task 3
Identify the top 5 products by revenue in descending order.*/

select p.ProductName, p.ProductID, SUM(ord.Quantity* p.UnitPrice)as RevenueGenerated
from Products p
JOIN OrderDetails ord ON p.ProductID=ord.ProductID
ORDER BY RevenueGenerated DESC;


/*task 4
Find the customer with the highest total spending and list their details.*/
select c.FirstName,c.LastName,c.Email, SUM(o.TotalAmount)AS TotalSpending
from Customers c
JOIN Orders o ON c.CustomerId=o.CustomerID
GROUP BY c.FirstName,c.LastName,c.Email, c.CustomerID
ORDER BY TotalSpending DESC;


/*task 5
Determine the average order value (AOV) for each year between 2020 and 2022.*/
select EXTRACT(YEAR FROM OrderDate) AS Year2022/2020, AVG(TotalAmount) AS AverageOrderValue
from Orders
where EXTRACT(YEAR FROM OrderDate) BETWEEN 2020 AND 2022
GROUP BY EXTRACT(YEAR FROM OrderDate);


/* task 6
Calculate the total number of products sold for each product category.*/
SELECT p.ProductID, p.ProductName, SUM(ord.Quantity) AS TotProdQuantitySold
FROM Products p
JOIN OrderDetails ord ON p.ProductID = ord.ProductID
GROUP BY p.ProductID, p.ProductName;     
