-- Q1.  Write query to return the email, first name, last name, & Genre of all Rock Music listeneres. 
-- REtuReturn your list ordered alphabetically by email starting with A.
select * from genre;
select customer.email,customer.first_name,customer.last_name,genre.name from genre
join track on genre.genre_id = track.genre_id
join invoice_line on track.track_id = invoice_line.track_id
join invoice on invoice_line.invoice_id = invoice.invoice_id
join customer on invoice.customer_id = customer.customer_id
where genre.name = "Rock"
order by customer.email asc;

-- Q2. Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.

select artist.name,genre.name,count(genre.name)as new_count from artist 
join album2 on artist.artist_id = album2.artist_id
join track on album2.album_id = track.album_id
join genre on track.genre_id = genre.genre_id
where genre.name = "Rock"
group by artist.name,genre.name
order by new_count desc;

-- Q3. Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
select * from track;
select name,milliseconds from track
where milliseconds>(select avg(milliseconds) from track)
order by milliseconds desc;

select avg(milliseconds)from track;