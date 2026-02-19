-- Problem Source: Page 3 

-- 1. Add an attribute "How would you add an attribute, Class, to the Student table?" 

-- Adds a new column named 'Class' with a variable character limit of 20
ALTER TABLE STUDENT
ADD Class VARCHAR(20);


-- 2. Remove a table "How would you remove the Registration table?" 
-- Deletes the table and its data from the database
DROP TABLE REGISTRATION;

-- 3. Modify a field definition "How would you change the FacultyName field from 25 characters to 40 characters?" 

-- Modifies the existing column to allow for longer names
-- Note: Syntax can vary slightly by SQL dialect (e.g., 'ALTER COLUMN' in SQL Server)
ALTER TABLE FACULTY
MODIFY FacultyName VARCHAR(40);