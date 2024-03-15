-- Week 5 Wednesday Questions

-- 1. List all  customers who live in Texas (use JOINs)

SELECT customer.customer_id, customer.first_name, customer.last_name, district
FROM customer 
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- Texas customers = Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, Ian Still

-- 2. Get all payments above $6.99 with the customers full name

SELECT customer.customer_id, first_name, last_name, amount
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id 
WHERE amount > 6.99
ORDER BY customer_id;

--- Amounts will be shown when the code runs. Too many payments to list. 

-- 3. Show all customers names who have made payments over $175 (use subqueries).

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- No customer made a single payment over $175, but the customers who cumatively made payments that amounted to over $175 were: Rhonda Kennedy, Clara Shaw
-- Eleanor Hunt, Marion Snyder, Peter Menard, Tommy Collazo, and Karl Seal. 

-- 4. List all customers that live in Nepal (use the city table)

SELECT customer.first_name,customer.last_name, country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- Kevin Schuler is the only customer that lives in Nepal

-- 5. Which staff member had the most transactions?

SELECT staff_id, first_name, last_name
FROM staff
WHERE staff_id IN (
	SELECT staff_id
	FROM payment
	GROUP BY staff_id
	ORDER BY count(payment_id) DESC 
);

SELECT staff_id, count(payment_id) FROM payment
GROUP BY staff_id;

-- Answer: John Stephens (Staff_id 2) had the most transactions.

-- 6. How many movies of each rating are there?

SELECT count(rating), rating FROM film
GROUP BY rating;

-- Answer: 210 NC-17, 178 G, 194 PG, 195 R, and 223 PG-13


-- 7. Show all customers who have made a single payment above $6.99 (use subqueries)

SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING count(amount) > 6.99
	ORDER BY count(amount) DESC
);

-- 8. How many free rentals did our stores give away?

SELECT count(amount) FROM payment 
WHERE amount = 0

-- Answer: The stores gave away 24 free rentals.

SELECT payment.rental_id, payment.amount
FROM payment
FULL JOIN rental
ON payment.rental_id = rental.rental_id 
WHERE amount = 0 
