# Q1. find how much amount spent by eact customer on artist? Write a query to return customer name, 
-- artist name and total spent.
with cte_1 as (select artist.artist_id as artist_id,artist.name as artist_name,customer.first_name as customer_name,
customer.last_name as last_name,customer.customer_id as custome_id,(invoice_line.unit_price*invoice_line.quantity)as total_spent from artist
join album2 on artist.artist_id = album2.artist_id
join track on album2.album_id = track.album_id
join invoice_line on track.track_id = invoice_line.track_id
join invoice on invoice_line.invoice_id = invoice.invoice_id
join customer on invoice.customer_id = customer.customer_id
)

select artist_id,artist_name,customer_name,last_name,sum(total_spent)as spent from cte_1
group by artist_id,artist_name,customer_name,last_name
order by spent desc;

# Q2.  We want to find out the most popular music Genre for each country. 
-- We determine the most popular genre as the genre with the highest amount of purchases. 
-- Write a query that returns each country along with the top Genre. 
-- For countries where the maximum number of purchases is shared return all Genres;

with cte_1 as (select invoice.billing_country as country,genre.name as genre_name,count(genre.name)as total_count,
row_number()over(partition by invoice.billing_country order by count(genre.name) desc)as _row_number from genre
join track on genre.genre_id = track.genre_id
join invoice_line on track.track_id = invoice_line.track_id
join invoice on invoice_line.invoice_id = invoice.invoice_id
group by invoice.billing_country,genre.name
order by country,total_count desc)

select country,genre_name,total_count,_row_number from cte_1
where _row_number;

with cte_1 as (select invoice.billing_country as country,genre.name as genre_name,count(genre.name)as total_count,
row_number()over(partition by invoice.billing_country order by count(genre.name) desc)as _row_number from genre
join track on genre.genre_id = track.genre_id
join invoice_line on track.track_id = invoice_line.track_id
join invoice on invoice_line.invoice_id = invoice.invoice_id
group by invoice.billing_country,genre.name
order by country,total_count desc)

select genre_name,sum(total_count) as total_amount_of_purchase from cte_1
group by genre_name;

# 3. Write a query that determines the customer that has spent the most on music for each country. 
-- Write a query that returns the country along with the top customer and how much they spent. 
-- For countries where the top amount spent is shared, provide all customers who spent this amount;

select customer.country as country,customer.first_name as customer_name,
customer.last_name as last_name,sum(invoice.total)as total_spent from customer 
join invoice on customer.customer_id = invoice.customer_id
group by 1,2,3
order by 4 desc;

with cte_1 as(select customer.country as country,customer.first_name as customer_name,
customer.last_name as last_name,sum(invoice.total)as total_spent,
row_number()over(partition by customer.country order by sum(invoice.total) desc )as _row_number  from customer 
join invoice on customer.customer_id = invoice.customer_id
group by 1,2,3
order by 4 desc)

select country, customer_name,last_name,total_spent,_row_number from cte_1
where _row_number = 1;
