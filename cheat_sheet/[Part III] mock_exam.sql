
/*
Order Table
1. Customer Table
2. Payment Table
3. Actor Table
4. Inventory & Rental Table
5. Category Table
6. Film Table
7. Store & Staff Table

How to use
step 1: Read the question carefully and identify which table(s) are involved.
step 2: Control F the table name(s) in the SQL file to find the relevant section.
step 3: Check if the question similar to the problems If not, try to modify the existing code to fit the new question.
 */


/* ----------------------------------------------------------------------------
   1. Customer table
   ---------------------------------------------------------------------------- */

-- Problem 1
-- Show all customers who live in 'Japan' or 'Brazil'.
-- The output must contain 4 columns: customer_id, first_name, last_name, and country.
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    co.country
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country IN ('Japan', 'Brazil');

-- Problem 2
-- Show the top 3 customers in each active status group (active = 1 or 0) based on the total number of rentals.
-- The output must contain 6 columns: active, customer_id, first_name, last_name, num_of_rental, and rank.
SELECT 
    active, 
    customer_id, 
    first_name, 
    last_name, 
    num_of_rental, 
    rank
FROM (
    SELECT 
        active,
        customer_id,
        first_name,
        last_name,
        num_of_rental,
        RANK() OVER(PARTITION BY active ORDER BY num_of_rental DESC) as rank
    FROM (
        SELECT 
            c.active,
            c.customer_id,
            c.first_name,
            c.last_name,
            COUNT(r.rental_id) AS num_of_rental
        FROM customer c
        JOIN rental r ON c.customer_id = r.customer_id
        GROUP BY c.active, c.customer_id, c.first_name, c.last_name
    ) AS CustomerRentals
) AS ranked_customers
WHERE rank <= 3;


-- Problem 26
-- For customer_id = 10, show the rental date and the date of their very next rental using LEAD. Calculate the days between them.
-- The output must contain 4 columns: rental_id, rental_date, next_rental_date, and days_between.
SELECT 
    rental_id,
    rental_date,
    next_rental_date,
    EXTRACT(DAY FROM (next_rental_date - rental_date)) AS days_between
FROM (
    SELECT 
        rental_id,
        rental_date,
        LEAD(rental_date) OVER(ORDER BY rental_date) AS next_rental_date
    FROM rental
    WHERE customer_id = 10
) AS CustomerRentalGaps
WHERE next_rental_date IS NOT NULL;

-- Problem 27
-- Find the title of the very first film ever rented by EACH customer using FIRST_VALUE.
-- The output must contain 4 columns: customer_id, first_name, last_name, and first_rented_film.
SELECT DISTINCT
    customer_id,
    first_name,
    last_name,
    first_rented_film
FROM (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        FIRST_VALUE(f.title) OVER(PARTITION BY c.customer_id ORDER BY r.rental_date) AS first_rented_film
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
) AS CustomerFirstRents;



-- Problem 15
-- Rank customers by their total amount spent across all stores. Show only the top 5 highest spenders overall.
-- The output must contain 5 columns: customer_id, first_name, last_name, total_spent, and spending_rank.
SELECT 
    customer_id, 
    first_name, 
    last_name, 
    total_spent, 
    spending_rank
FROM (
    SELECT 
        customer_id,
        first_name,
        last_name,
        total_spent,
        RANK() OVER(ORDER BY total_spent DESC) AS spending_rank
    FROM (
        SELECT 
            c.customer_id,
            c.first_name,
            c.last_name,
            SUM(p.amount) AS total_spent
        FROM customer c
        JOIN payment p ON c.customer_id = p.customer_id
        GROUP BY c.customer_id, c.first_name, c.last_name
    ) AS CustomerTotals
) AS RankedCustomers
WHERE spending_rank <= 5;

-- Problem 16
-- Show customers whose last name ends with the letter 'S' and who are registered to store 1.
-- The output must contain 4 columns: customer_id, first_name, last_name, and store_id.
SELECT 
    customer_id,
    first_name,
    last_name,
    store_id
FROM customer
WHERE last_name LIKE '%S' AND store_id = 1;


/* ----------------------------------------------------------------------------
   2. Payment table
   ---------------------------------------------------------------------------- */

-- Problem 3
-- Show payments where the transaction amount is strictly greater than the average payment amount made by that specific customer.
-- The output must contain 4 columns: payment_id, customer_id, amount, and avg_customer_amount.
SELECT 
    payment_id, 
    customer_id, 
    amount, 
    avg_customer_amount
FROM (
    SELECT 
        payment_id,
        customer_id,
        amount,
        AVG(amount) OVER(PARTITION BY customer_id) AS avg_customer_amount
    FROM payment
) AS CustomerAverages
WHERE amount > avg_customer_amount;

-- Problem 4
-- Show the total revenue generated by each store based on the staff who processed the payment.
-- The output must contain 2 columns: store_id and total_revenue.
SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.store_id;





/* ----------------------------------------------------------------------------
   2.1 Payment table (DATE_TRUNC, LAG, & LEAD)
   ---------------------------------------------------------------------------- */

-- Problem 23
-- Show the weekly total revenue. Use DATE_TRUNC to group the payments by week.
-- The output must contain 2 columns: payment_week and total_revenue.
SELECT 
    DATE_TRUNC('week', payment_date) AS payment_week,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY DATE_TRUNC('week', payment_date)
ORDER BY payment_week;

-- Problem 24
-- For customer_id = 1, show each payment amount and the amount of their immediately preceding payment using LAG.
-- The output must contain 5 columns: payment_id, payment_date, amount, previous_amount, and amount_diff.
SELECT 
    payment_id,
    payment_date,
    amount,
    previous_amount,
    (amount - previous_amount) AS amount_diff
FROM (
    SELECT 
        payment_id,
        payment_date,
        amount,
        LAG(amount) OVER(ORDER BY payment_date) AS previous_amount
    FROM payment
    WHERE customer_id = 1
) AS CustomerPayments;

-- Problem 25
-- Show the month-over-month revenue comparison. Find the total revenue for each month and the revenue of the previous month.
-- The output must contain 3 columns: payment_month, current_revenue, and previous_revenue.
SELECT 
    payment_month,
    current_revenue,
    previous_revenue
FROM (
    SELECT 
        payment_month,
        current_revenue,
        LAG(current_revenue) OVER(ORDER BY payment_month) AS previous_revenue
    FROM (
        SELECT 
            DATE_TRUNC('month', payment_date) AS payment_month,
            SUM(amount) AS current_revenue
        FROM payment
        GROUP BY DATE_TRUNC('month', payment_date)
    ) AS MonthlyTotals
) AS RevenueComparison;








/* ----------------------------------------------------------------------------
   3. Actor table
   ---------------------------------------------------------------------------- */

-- Problem 5
-- Show all actors whose first name starts with 'E'.
-- The output must contain 3 columns: actor_id, first_name, and last_name.
SELECT 
    actor_id,
    first_name,
    last_name
FROM actor
WHERE first_name LIKE 'E%';

-- Problem 6
-- Show actors who have NEVER acted in a film with a 'G' rating.
-- The output must contain 3 columns: actor_id, first_name, and last_name.
SELECT 
    actor_id,
    first_name,
    last_name
FROM actor
WHERE actor_id NOT IN (
    SELECT fa.actor_id 
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.rating = 'G'
);

-- Problem 17
-- Show all actors who have acted in exactly 20 to 25 films.
-- The output must contain 4 columns: actor_id, first_name, last_name, and total_films.
SELECT 
    actor_id, 
    first_name, 
    last_name, 
    total_films
FROM (
    SELECT 
        a.actor_id,
        a.first_name,
        a.last_name,
        COUNT(fa.film_id) AS total_films
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
) AS ActorFilmCounts
WHERE total_films BETWEEN 20 AND 25;








/* ----------------------------------------------------------------------------
   4. Inventory & Rental table
   ---------------------------------------------------------------------------- */

-- Problem 7
-- Show all inventory items that have never been rented.
-- The output must contain 3 columns: inventory_id, film_id, and store_id.
SELECT 
    i.inventory_id,
    i.film_id,
    i.store_id
FROM inventory i
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

-- Problem 8
-- Determine if a rental was returned 'Late', 'Early', or 'On Time' compared to the film's allowed rental_duration.
-- The output must contain 5 columns: rental_id, film_title, actual_duration_days, allowed_duration_days, and duration_status.
SELECT 
    r.rental_id,
    f.title AS film_title,
    EXTRACT(DAY FROM (r.return_date - r.rental_date)) AS actual_duration_days,
    f.rental_duration AS allowed_duration_days,
    CASE 
        WHEN EXTRACT(DAY FROM (r.return_date - r.rental_date)) > f.rental_duration THEN 'Late'
        WHEN EXTRACT(DAY FROM (r.return_date - r.rental_date)) < f.rental_duration THEN 'Early'
        ELSE 'On Time'
    END AS duration_status
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL;



-- Problem 18
-- Show rentals processed by a staff member who has the first name 'Mike'.
-- The output must contain 4 columns: rental_id, rental_date, staff_first_name, and staff_last_name.
SELECT 
    r.rental_id,
    r.rental_date,
    s.first_name AS staff_first_name,
    s.last_name AS staff_last_name
FROM rental r
JOIN staff s ON r.staff_id = s.staff_id
WHERE s.first_name = 'Mike';

-- Problem 19
-- Show the top 2 most rented films overall (based on the total number of times they were rented).
-- The output must contain 4 columns: film_id, film_title, total_rentals, and rank.
SELECT 
    film_id, 
    film_title, 
    total_rentals, 
    rank
FROM (
    SELECT 
        film_id,
        film_title,
        total_rentals,
        RANK() OVER(ORDER BY total_rentals DESC) AS rank
    FROM (
        SELECT 
            f.film_id,
            f.title AS film_title,
            COUNT(r.rental_id) AS total_rentals
        FROM film f
        JOIN inventory i ON f.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
        GROUP BY f.film_id, f.title
    ) AS FilmRentalCounts
) AS RankedFilms
WHERE rank <= 2;




/* ----------------------------------------------------------------------------
   4.1 Rental table (Dates & EXTRACT)
   ---------------------------------------------------------------------------- */

-- Problem 21
-- Show the total number of rentals broken down by month and year.
-- The output must contain 3 columns: rental_year, rental_month, and total_rentals.
SELECT 
    EXTRACT(YEAR FROM rental_date) AS rental_year,
    EXTRACT(MONTH FROM rental_date) AS rental_month,
    COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY 
    EXTRACT(YEAR FROM rental_date), 
    EXTRACT(MONTH FROM rental_date)
ORDER BY rental_year, rental_month;


-- Problem 22
-- Show all rentals that occurred on a weekend (assuming 0 = Sunday, 6 = Saturday in standard SQL EXTRACT).
-- The output must contain 3 columns: rental_id, rental_date, and day_of_week.
SELECT 
    rental_id,
    rental_date,
    EXTRACT(DOW FROM rental_date) AS day_of_week
FROM rental
WHERE EXTRACT(DOW FROM rental_date) IN (0, 6);








/* ----------------------------------------------------------------------------
   5.Category table
   ---------------------------------------------------------------------------- */

-- Problem 9
-- Show the top 3 most rented film categories across all stores.
-- The output must contain 3 columns: category_name, total_rentals, and rank.
SELECT 
    category_name, 
    total_rentals, 
    rank
FROM (
    SELECT 
        category_name,
        total_rentals,
        RANK() OVER(ORDER BY total_rentals DESC) as rank
    FROM (
        SELECT 
            c.name AS category_name,
            COUNT(r.rental_id) AS total_rentals
        FROM category c
        JOIN film_category fc ON c.category_id = fc.category_id
        JOIN inventory i ON fc.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
        GROUP BY c.name
    ) AS CategoryRentals
) AS ranked_categories
WHERE rank <= 3;

-- Problem 10
-- Show all films that feature the actor with the last name 'CHASE'.
-- The output must contain 4 columns: film_id, film_title, actor_first_name, and actor_last_name.
SELECT 
    f.film_id,
    f.title AS film_title,
    a.first_name AS actor_first_name,
    a.last_name AS actor_last_name
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.last_name = 'CHASE';

-- Problem 20
-- Show categories where the average film rental rate is strictly greater than $3.00.
-- The output must contain 2 columns: category_name and avg_rental_rate.
SELECT 
    category_name, 
    avg_rental_rate
FROM (
    SELECT 
        c.name AS category_name,
        AVG(f.rental_rate) AS avg_rental_rate
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    GROUP BY c.name
) AS CategoryAverages
WHERE avg_rental_rate > 3.00;








/* ----------------------------------------------------------------------------
   6.Film table
   ---------------------------------------------------------------------------- */

-- Problem 11
-- Show films where the replacement cost is strictly greater than the overall average replacement cost of all films.
-- The output must contain 4 columns: film_id, title, replacement_cost, and avg_replacement_cost.
SELECT 
    film_id, 
    title, 
    replacement_cost, 
    avg_replacement_cost
FROM (
    SELECT 
        film_id, 
        title, 
        replacement_cost, 
        AVG(replacement_cost) OVER() AS avg_replacement_cost
    FROM film
) AS FilmAverages
WHERE replacement_cost > avg_replacement_cost;

-- Problem 12
-- Show the length category of films that belong to the 'Action' or 'Comedy' category. 
-- Length rules: 'Short' (<90 mins), 'Medium' (90-120 mins), 'Long' (>120 mins).
-- The output must contain 4 columns: film_title, category_name, length, and length_category.
SELECT 
    f.title AS film_title,
    c.name AS category_name,
    f.length,
    CASE 
        WHEN f.length < 90 THEN 'Short'
        WHEN f.length BETWEEN 90 AND 120 THEN 'Medium'
        ELSE 'Long'
    END AS length_category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name IN ('Action', 'Comedy');

-- Problem 13
-- Show all films that include the word 'Boat' anywhere in their description.
-- The output must contain 3 columns: film_id, title, and description.
SELECT 
    film_id,
    title,
    description
FROM film
WHERE description LIKE '%Boat%';



/* ----------------------------------------------------------------------------
   6.1 Film table (PERCENT_RANK & NTILE)
   ---------------------------------------------------------------------------- */

-- Problem 28
-- Find films that are in the top 5% of longest films using PERCENT_RANK.
-- The output must contain 4 columns: film_id, title, length, and length_percentile.
SELECT 
    film_id,
    title,
    length,
    length_percentile
FROM (
    SELECT 
        film_id,
        title,
        length,
        PERCENT_RANK() OVER(ORDER BY length) AS length_percentile
    FROM film
) AS RankedFilms
WHERE length_percentile >= 0.95;

-- Problem 29
-- Divide all films into 4 length quartiles using NTILE (1 being the shortest quartile, 4 being the longest). Show only films in Quartile 4.
-- The output must contain 4 columns: film_id, title, length, and length_quartile.
SELECT 
    film_id,
    title,
    length,
    length_quartile
FROM (
    SELECT 
        film_id,
        title,
        length,
        NTILE(4) OVER(ORDER BY length) AS length_quartile
    FROM film
) AS QuartileFilms
WHERE length_quartile = 4;

-- Problem 30
-- Divide the replacement costs of films into 10 deciles using NTILE. Show the average replacement cost for each decile.
-- The output must contain 2 columns: cost_decile and avg_cost.
SELECT 
    cost_decile,
    AVG(replacement_cost) AS avg_cost
FROM (
    SELECT 
        replacement_cost,
        NTILE(10) OVER(ORDER BY replacement_cost) AS cost_decile
    FROM film
) AS DecileCosts
GROUP BY cost_decile
ORDER BY cost_decile;







/* ----------------------------------------------------------------------------
   7.Store & Staff table
   ---------------------------------------------------------------------------- */

-- Problem 14
-- Show the store manager's full name and the city where their store is located.
-- The output must contain 4 columns: store_id, manager_first_name, manager_last_name, and city.
SELECT 
    s.store_id,
    st.first_name AS manager_first_name,
    st.last_name AS manager_last_name,
    ci.city
FROM store s
JOIN staff st ON s.manager_staff_id = st.staff_id
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id;



