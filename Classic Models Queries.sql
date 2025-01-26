#1a Fetch the employee number, first name and last name of those employees who are working as Sales Rep reporting to 
#employee with employeenumber 1102 (Refer employee table)

select employeeNumber, firstname, lastName
from employees
where jobTitle="Sales Rep" and reportsTo=1102;

#1b Show the unique productline values containing the word cars at the end from the products table.

select distinct productLine 
from products
where productLine like "%Cars";


#2 Using a CASE statement, segment customers into three categories based on their country:(Refer Customers table)
#                        "North America" for customers from USA or Canada
#                        "Europe" for customers from UK, France, or Germany
#                        "Other" for all remaining countries
#    Select the customerNumber, customerName, and the assigned region as "CustomerSegment".

select customerNumber, customerName,
case when country = "USA" or country = "Canada" then "North America"
     when country ="UK" or country ="France"  or country ="Germany" then "Europe"
     else "others"
     end as CustomerSegemnt
     from customers;
     
     
#3a Using the OrderDetails table, identify the top 10 products (by productCode) with the highest total order quantity across all orders.

select productCode, sum(quantityOrdered) as total_ordered
from OrderDetails
group by productCode
order by total_ordered desc
limit 10;


#3b Company wants to analyse payment frequency by month. Extract the month name from the payment date to count the total number of payments for each month and include only those months with a payment count exceeding 20. Sort the results by total number of payments in descending order. (Refer Payments table). 

select monthname(paymentDate) as payment_month, count(amount) as num_payments
from payments
group by payment_month 
having num_payments >20
order by num_payments desc;


#4a Create a table named Customers to store customer information. Include the following columns:

# customer_id: This should be an integer set as the PRIMARY KEY and AUTO_INCREMENT.
# first_name: This should be a VARCHAR(50) to store the customer's first name.
# last_name: This should be a VARCHAR(50) to store the customer's last name.
# email: This should be a VARCHAR(255) set as UNIQUE to ensure no duplicate email addresses exist.
# phone_number: This can be a VARCHAR(20) to allow for different phone number formats.

# Add a NOT NULL constraint to the first_name and last_name columns to ensure they always have a value.

create table Customers(customer_id int primary key auto_increment,
                       first_name varchar(50) not null, 
                       last_name varchar(50) not null,
                       email varchar(255) unique,
                       phone_number varchar(20));
                       
                       
#4b Create a table named Orders to store information about customer orders. Include the following columns:

# order_id: This should be an integer set as the PRIMARY KEY and AUTO_INCREMENT.
# customer_id: This should be an integer referencing the customer_id in the Customers table  (FOREIGN KEY).
# order_date: This should be a DATE data type to store the order date.
#total_amount: This should be a DECIMAL(10,2) to store the total order amount.
     	
# Constraints:
# a)	Set a FOREIGN KEY constraint on customer_id to reference the Customers table.
# b)	Add a CHECK constraint to ensure the total_amount is always a positive value.

Create table Orders(order_id int primary key auto_increment,
					CONSTRAINT foreign key customer_id  references Customers(customer_id),
                    order_date date,
                    total_amount decimal(10,2));
                    
                    
#5 List the top 5 countries (by order count) that Classic Models ships to. (Use the Customers and Orders tables)

select country, count(orderNumber) as order_count
from customers join orders on customers.customerNumber=orders.customerNumber
group by country
order by order_count desc
limit 5;


#6 Create a table project with below fields.
# ●	EmployeeID : integer set as the PRIMARY KEY and AUTO_INCREMENT.
# ●	FullName: varchar(50) with no null values
# ●	Gender : Values should be only ‘Male’  or ‘Female’
# ●	ManagerID: integer 

# Find out the names of employees and their related managers.

create table project(EmployeeID int primary key auto_increment,
                     FullName varchar(50) not null,
                     Gender varchar(50) CHECK(Gender="Male"or Gender="Female"),
                     ManagerID int);

insert into project values(1,"Pranaya", "Male", 3), (2,"Priyanka","Female",1),
						  (3,"Preety","Female",null), (4,"Anurag","Male",1),
                          (5,"Sambit","Male",1), (6,"Rajesh","Male",3),
                          (7,"Heena","Female",3);
                          
SELECT project.EmployeeID,project.FullName,project.Gender,project.ManagerID
FROM project AS EMP JOIN project AS MGR
ON project.ManagerID=MGR.EmployeeID;


#7 Create table facility. Add the below fields into it.
# ●	Facility_ID
# ●	Name
# ●	State
# ●	Country

# i) Alter the table by adding the primary key and auto increment to Facility_ID column.
# ii) Add a new column city after name with data type as varchar which should not accept any null values.

create table facility(Facility_ID int, Name varchar(100), City varchar(100), State varchar(100), Country varchar(100));

alter table facility 
modify Facility_ID int auto_increment,
add primary key(Facility_ID);

alter table facility 
add City varchar(100) not null
after Name;

desc facility;


#8 Create a view named product_category_sales that provides insights into sales performance by product category. This view should include the following information:
# productLine: The category name of the product (from the ProductLines table).
# total_sales: The total revenue generated by products within that category (calculated by summing the orderDetails.quantity * orderDetails.priceEach for each product in the category).
#number_of_orders: The total number of orders containing products from that category.

create view product_category_sales as 
			select p.productline as ProductLine, 
					sum(od.quantityOrdered * od.priceEach) as Total_sales, 
                    count(distinct o.orderNumber) as Num_of_orders from orderdetails od 
																	join products p on od.productCode=p.productCode 
                                                                    join orders o on od.orderNumber=o.orderNumber 
                                                                    group by productline;


#9 Find out how many product lines are there for which the buy price value is greater than the average of buy price value. Show the output as product line and its count.

select productLine, buyPrice from products as p where buyPrice >
(select avg(buyPrice) from products where productLine =p.productLine);



                     




