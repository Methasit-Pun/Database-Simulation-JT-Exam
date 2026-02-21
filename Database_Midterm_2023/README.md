# Database Midterm 2023 Solutions

## Query Solutions Summary

| Problem | Description | Key Concepts | Status |
|---------|-------------|--------------|--------|
| **4a** | Films related to 'China' or 'India' | LIKE pattern matching with OR | Complete |
| **4b** | Films with zero inventory | LEFT JOIN, NULL filtering | Complete |
| **4c** | Film categories starting with 'A' | Multiple JOINs, RANK() window function | Complete |
| **4d** | Top 5 customers per store by rentals | Window function with PARTITION BY | Complete |
| **4e** | Rental length vs average comparison | Window functions, AGE(), CASE statement | Complete |

## Problem Details

### 4a: Films Related to China or India
**Output Columns:** film_id, title, description  
**Technique:** String pattern matching using LIKE with OR operator  
**Key Tables:** film

### 4b: Films with Zero Inventory
**Output Columns:** film_id, title, total_inventory  
**Technique:** LEFT JOIN to find films with no matching inventory records  
**Key Tables:** film, inventory

### 4c: Film Categories Starting with 'A'
**Output Columns:** category_id, category_name, film_id, title, rank  
**Technique:** Multiple table joins, RANK() window function for ordering  
**Key Tables:** film, film_category, category

### 4d: Top 5 Customers by Store
**Output Columns:** store_id, customer_id, first_name, last_name, num_of_rental  
**Technique:** Window functions with PARTITION BY to rank customers within each store  
**Key Tables:** customer, rental, store

### 4e: Rental Length Comparison
**Output Columns:** film_title, inventory_id, rental_id, rental_length, avg_length, rental_length_diff, type  
**Technique:** Window functions with PARTITION BY, AGE() for date calculations, CASE for categorization  
**Key Tables:** film, inventory, rental

## Database Information

**Database:** dvdrental (PostgreSQL)  
**Notebook:** `Database_Midterm_2023/database_midterm_2023_sql.ipynb`  
**Connection:** Uses SQL magic commands (%sql, %%sql) for direct query execution

## Contributing

Contributions are welcome! Here's how you can contribute:

### Ways to Contribute

1. **Improve Queries** - Optimize existing solutions or provide alternative approaches
2. **Add Solutions** - Complete problem 4d or add new exercise solutions
3. **Fix Issues** - Correct errors or improve query performance
4. **Documentation** - Enhance explanations or add comments to complex queries
5. **Share Practice** - Upload your own SQL homework or practice files

### How to Contribute

1. Fork this repository
2. Create a new branch for your changes
3. Make your improvements:
   - Add new `.sql` files to relevant folders (hw3, hw4, hw5, etc.)
   - Update notebook files with new queries or improvements
   - Document your changes in comments
4. Test your queries against the dvdrental database
5. Submit a pull request with a clear description of your changes

### Contribution Guidelines

- Ensure queries are tested and produce correct results
- Use clear naming conventions for files and variables
- Add comments explaining complex query logic
- Follow PostgreSQL best practices
- Include output column names in problem descriptions

Feel free to open issues for questions or suggestions. All contributions help make this a better learning resource for everyone studying databases and SQL. Issue me or Pr me 
