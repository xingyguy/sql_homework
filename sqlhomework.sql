USE sakila
;

#1a
SELECT first_name, last_name FROM actor
;

#1b
ALTER TABLE actor
ADD COLUMN actor_name varchar(30)
;
UPDATE actor
SET actor_name = concat((first_name), " ", last_name)
;

#2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe'
;

#2b
SELECT first_name, last_name FROM actor WHERE last_name like '%GEN%'
;

#2c
SELECT first_name, last_name FROM actor 
WHERE last_name LIKE '%LI%' 
ORDER BY last_name, first_name
;

#2d
SELECT country_id, country FROM country 
WHERE country IN ('Afghanistan', 'Bangladesh', 'China')
;

#3a
ALTER TABLE actor
ADD COLUMN description BLOB
;

#3b
ALTER TABLE actor
DROP COLUMN description
;

#4a
SELECT COUNT(last_name), last_name FROM actor
GROUP BY last_name
;

#4b
SELECT COUNT(last_name), last_name FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2
;

#4c
UPDATE actor SET first_name = 'HARPO' WHERE actor_id = 172
;

#4d
UPDATE actor SET first_name = 'GROUCHO' WHERE actor_id = 172
;

#5a
SHOW CREATE TABLE address
;

#6a
SELECT address.address_id, address.address, staff.first_name, staff.last_name
FROM address
INNER JOIN staff ON
staff.address_id = address.address_id
;

#6b
SELECT payment.staff_id, SUM(payment.amount), staff.first_name, staff.last_name
FROM payment
INNER JOIN staff on staff.staff_id = payment.staff_id
WHERE payment_date LIKE '2005-08%'
GROUP BY staff_id

#6c
SELECT title,
COUNT(DISTINCT actor_id) FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY 1
;

#6d
SELECT COUNT(inventory_id) FROM inventory
INNER JOIN film ON inventory.film_id = film.film_id
WHERE title = 'Hunchback Impossible'
;

#6e
SELECT first_name, last_name,
SUM(amount) AS "Total Amount Paid" FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY 1,2
ORDER BY last_name ASC
;

#7a
SELECT title FROM film
INNER JOIN language ON film.language_id = language.language_id
WHERE title LIKE 'K%' OR title LIKE 'Q%' AND name = 'English'
;

#7b
SELECT actor_name FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE title = 'Alone Trip'
;

#7c
SELECT first_name, last_name, email, country FROM customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
WHERE country = 'Canada'
;

#7d
SELECT title FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE name = 'Family'
;

#7e
SELECT title, COUNT(rental_id) AS times_rented FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY times_rented DESC
;

#7f
SELECT store.store_id, SUM(amount) AS revenue FROM store
INNER JOIN customer ON store.store_id = customer.store_id
INNER JOIN payment ON customer.customer_id = payment.payment_id
GROUP BY store_id
;

#7g
SELECT store.store_id, city, country FROM store
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
;

#7h
SELECT name AS genre, SUM(amount) AS gross_revenue FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN inventory ON film_category.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY genre
ORDER BY gross_revenue DESC
LIMIT 5
;

#8a
CREATE VIEW top_5_genres AS
SELECT name AS genre, SUM(amount) AS gross_revenue FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN inventory ON film_category.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY genre
ORDER BY gross_revenue DESC
LIMIT 5
;

#8b
SELECT * FROM top_5_genres
;

#8c
DROP VIEW top_5_genres
;