
/* Q1: Who is the senior most employee based on job title? */

SELECT title, last_name, first_name 
FROM employee
ORDER BY levels DESC
LIMIT 1


/* Q2: Which countries have the most Invoices? */

SELECT COUNT(*) AS c, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY c DESC


/* Q3: What are top 3 values of total invoice? */

SELECT total 
FROM invoice
ORDER BY total DESC


/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

SELECT billing_city,SUM(total) AS InvoiceTotal
FROM invoice
GROUP BY billing_city
ORDER BY InvoiceTotal DESC
LIMIT 1;


/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

SELECT customer.customer_id, first_name, last_name, SUM(total) AS total_spending
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total_spending DESC
LIMIT 1;


/* Q6: List all tracks along with their genres */

SELECT t.name AS track_name, g.name AS genre_name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id;


/* Q7: Find the total sales amount for a specific customer */

SELECT c.first_name, c.last_name, SUM(il.unit_price * il.quantity) AS total_sales
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
WHERE c.customer_id = 9
GROUP BY c.first_name, c.last_name;


/* Q8: Find the average length of tracks in each media type */

SELECT mt.name AS media_type, AVG(t.milliseconds) AS average_length
FROM media_type mt
JOIN track t ON mt.media_type_id = t.media_type_id
GROUP BY mt.name;


/* Q9: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoiceline ON invoiceline.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoiceline.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;


/* Q10: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;


/* Q11: Retrieve the total number of tracks in each playlist */

SELECT pl.name AS playlist_name, COUNT(pt.track_id) AS total_tracks
FROM playlist pl
LEFT JOIN playlist_track pt ON pl.playlist_id = pt.playlist_id
GROUP BY pl.name;


/* Q12: Find the top-selling artists by total sales amount */

SELECT ar.name, SUM(il.unit_price * il.quantity) AS total_sales
FROM artist ar
JOIN album a ON ar.artist_id = a.artist_id
JOIN track t ON a.album_id = t.album_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY ar.name
ORDER BY total_sales DESC
LIMIT 10;


/* Q13: Retrieve the number of invoices per country */

SELECT billing_country, COUNT(*) AS total_invoices
FROM invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;


/* Q14: Find the total sales amount for each genre per country */

SELECT g.name AS genre_name, i.billing_country, SUM(il.unit_price * il.quantity) AS total_sales
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
JOIN invoice_line il ON t.track_id = il.track_id
JOIN invoice i ON il.invoice_id = i.invoice_id
GROUP BY g.name, i.billing_country;


/* Q15: Retrieve the total number of tracks in each album */

SELECT a.title AS album_title, COUNT(t.track_id) AS total_tracks
FROM album a
JOIN track t ON a.album_id = t.album_id
GROUP BY a.title;



