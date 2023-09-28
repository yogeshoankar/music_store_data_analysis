-- Q1. who is the senior most employee based on job title?
select * from employee;
select employee_id,first_name,last_name from employee
order by levels desc
limit 1;

-- Q2. Which countries have the most invoices?
select * from invoice;
select billing_country,count(billing_country)as total_invoice from invoice
group by billing_country
order by total_invoice desc
limit 1;

-- Q3. What are top 3 values of total invoice?
select * from invoice;
select *from invoice
order by total desc;

-- Q4. Which city has the best customers? We would like to throw a promotional Music Fesiaval in the city we made the most money.
-- Write a query that returns one city that has the highest sum of invoice totals. Rerutn both the city name & sum of all invoice totals.
select billing_city, sum(total)as total from invoice
group by billing_city
order by total desc
limit 1;

-- Q5. Who is the best customer? the customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money?
select * from customer;
select * from invoice;
select cs.first_name,cs.last_name,sum(ins.total)as new_total from customer as cs inner join invoice as ins
on cs.customer_id = ins.customer_id
group by cs.first_name,cs.last_name
order by new_total desc
limit 1;