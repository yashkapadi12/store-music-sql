select  * from album

--who is the senior most employee based on job title?--
select * from employee
order by levels desc limit 1


-- which countries have the most Invoices?--
select * from invoice


select count(*) as c,billing_country
from invoice
group by billing_country
order by c desc


--What are top 3 values of total invoice--

select total from invoice
order by total desc limit 3


-- Which city has the best customers? We Would like to--
--promotional Music festival in the city we made the most money.
--Write a query that returns one city that has  the highest  sum of invoice totals.--
--Return both the city name & sum of all invoice totals

select * from invoice
select sum(total) as total_invoice,billing_city as city from invoice
group by billing_city
order by total_invoice desc limit 1


--- who is the best customer?
--- The customer who has spent the most money
---will be declared the best customer.
--- Write a query that return the person
-- who has spent the most money.

select * from customer
select  customer.customer_id ,customer.first_name,customer.last_name,sum(invoice.total) as total from customer
join 
	invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc limit 1

---Write query to return the email,first name,last name
---& Genre of all Rock Music listeners.
---Return your list ordered alphabetically 
--- by emails starting with A


select * from genre

select * from customer

select * from invoice

select * from invoice_line
select *from track

select distinct email,first_name,last_name from customer

join invoice on invoice.customer_id = customer.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id IN(
	select track_id from track join genre on track.genre_id = genre.genre_id
where genre.name like 'ROCK'	)
order by email


select distinct email as Email,first_name as FirstName,last_name as LastName,
genre.name as Name
from customer
join invoice on invoice.customer_id = customer.customer_id
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
order by email;


	


---Let's invite the artists who have written the most rock music in our dataset. Write a
--query that returns the Artist name and total track count of the top 10 rock bands

select * from artist

select * from album

select * from track

select artist.artist_id,artist.name,count(artist.artist_id)
 as number_of_songs

from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'ROCK'
group by artist.artist_id
order by number_of_songs desc
limit 10


---. Return all the track names that have a song length longer than the average song length.
---Return the Name and Milliseconds for each track. Order by the song length with the
---longest songs listed first

select name,milliseconds from track
where milliseconds > (
	SELECT AVG(milliseconds) as avg_track_length
	from track
)
order by milliseconds desc;


---Find how much amount spent by each customer on artists? Write a query to return
---customer name, artist name and total spent
---CT is a Temporary Table


WITH best_selling_artist AS(
	SELECT artist.artist_id AS artist_id,artist.name AS artist_name,
	SUM(invoice_line.unit_price*invoice_line.quantity)AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1 
	ORDER BY total_sales DESC
	LIMIT 1
)



