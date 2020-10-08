SELECT *
FROM invoice 
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE invoice_line.unit_price > 0.99;

SELECT first_name, last_name, invoice_date, total FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM employee e
JOIN customer c ON c.support_rep_id = e.employee_id;

SELECT al.title, a.name
FROM artist a 
JOIN album al ON al.artist_id = a.artist_id;

SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music'
ORDER BY track_id ASC;

SELECT t.name FROM track t
JOIN playlist_track p ON p.track_id = t.track_id
WHERE p.playlist_id = 5;

SELECT t.name, p.name FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;

SELECT t.name, a.title FROM track t
JOIN album a ON a.album_id = t.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

SELECT * FROM invoice
WHERE invoice_id IN (
  SELECT invoice_id FROM invoice_line
  WHERE unit_price > 0.99
);

SELECT * FROM playlist_track
WHERE playlist_id IN (
SELECT playlist_id FROM playlist
WHERE name ILIKE 'Music'
 );

SELECT name FROM track
WHERE track_id IN (
  SELECT track_id FROM playlist_track
  WHERE playlist_id = 5
);

SELECT * FROM track
WHERE genre_id IN (
	SELECT genre_id FROM genre
  WHERE name = 'Comedy'
);

SELECT * 
FROM track 
WHERE album_id IN 
(SELECT album_id 
 FROM album 
 WHERE title = 'Fireball');

SELECT *
FROM track
WHERE album_id IN (
  SELECT album_id FROM album WHERE artist_id IN (
    SELECT artist_id FROM artist WHERE name = 'Queen'
    )
  );

UPDATE customer
SET fax = null
WHERE fax IS NOT null;

UPDATE customer
SET company = 'Self'
WHERE company IS null;

UPDATE customer 
SET last_name = 'Thompson' 
WHERE first_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
AND composer IS null;

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

SELECT ar.name, COUNT(*)
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

SELECT DISTINCT composer
FROM track;

SELECT DISTINCT billing_postal_code
FROM invoice;

SELECT DISTINCT company
FROM customer;

DELETE 
FROM practice_delete 
WHERE type = 'bronze';

DELETE 
FROM practice_delete 
WHERE type = 'silver';

DELETE 
FROM practice_delete 
WHERE value = 150;

create table users (
	user_id serial primary key,
  name text,
  email varchar(150)
);

create table products (
	product_id serial primary key,
  name text,
  price integer
);

create table orders (
	order_id serial primary key,
  product_id integer references products(product_id)
);

insert into users (
  name,
  email
) values (
	'Branden',
  'branden@email.com'
), (
	'Brad',
  'brad@email.com'
), (
	'Maria',
  'maria@email.com'
);

insert into products (
  name,
  price
) values (
	'orange',
  21
), (
	'bannana',
  22
), (
	'kiwi',
  50
);

insert into orders (
  product_id
) values (
	1
), (
	2
), (
	1
), 
(
  3
);

select * from orders;

select name 
from products
where product_id in (
	select product_id from orders
 	where order_id = 1
);

select sum(price) from products
where product_id IN (
	select product_id from orders
  where order_id = 2
);

alter table orders
add column user_id
integer references users(user_id);

update orders
set user_id = '1'
where order_id = '1';

update orders
set user_id = '1'
where order_id = '2';

update orders
set user_id = '2'
where order_id = '3';

update orders
set user_id = '3'
where order_id = '4';

select * from orders o
join users u on o.user_id = u.user_id
where name = 'Branden';

select count(*), u.name from orders o
join users u on o.user_id = u.user_id
group by u.name;

