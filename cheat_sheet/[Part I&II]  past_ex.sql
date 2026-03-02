-- ========================================================================================================
-- PAST EXAM QUESTIONS - ORGANIZED BY TOPICS
-- ========================================================================================================


-- ========================================================================================================
-- SECTION 1: NORMALIZATION & DATABASE THEORY
-- ========================================================================================================

-- Q1: Which of the following is TRUE?
-- A: If a relation satisfies 3NF, then it must satisfies 2NF and 1NF.
-- Why: In database normalization, meeting a higher normal form inherently requires satisfying all the lower normal forms.

-- Q17: Consider a relation R(A,B,C,D,E), in which (A,B) is the Primary key. It has the following functional dependencies: A,B-->C,D,F; A-->C. Which of the following is TRUE?
-- A: R is not in 2NF
-- Why: The functional dependency A-->C represents a partial dependency (an attribute depends on only a portion of the composite primary key), which directly violates the rules of Second Normal Form (2NF).


-- ========================================================================================================
-- SECTION 2: ER/EER MODELING & ENTITY-RELATIONSHIP DIAGRAMS
-- ========================================================================================================

-- Q4: In order to avoid a person to be dependent for multiple tax payers, it is better to model the dependent as in ER.
-- A: Weak Entity
-- Why: A weak entity cannot be uniquely identified by its own attributes alone and relies on a relationship with a strong entity (the taxpayer) to exist.

-- Q10: How many tables and # of columns in each table in rational model is required for the following entity?
-- Employee: emp_id, emp_name (first_name, last_name), entry_date, [year_of_experience], {car_id}
-- A: 2 tables; one table with 4 columns and the other one with 2 columns
-- Why: Table 1 (Employee) takes the simple attributes: emp_id (PK), first_name, last_name, entry_date (4 columns). Derived attribute [year_of_experience] is not stored. Multivalued attribute {car_id} requires a separate 2nd table: emp_id (FK), car_id (2 columns).

-- Q16: For a clinic database, there is a SUPERTYPE People... All its instances belong to 2 SUBTYPES: Patient... and Staff... A staff can be a patient as well. Which of the following is TRUE?
-- A: Overlap with total specialization
-- Why: "All instances belong to 2 subtypes" means Total Specialization. "A staff can be a patient as well" means Overlap (not disjoint).

-- Q20: Which of the following is TRUE about the ER diagram below?
-- A: A Member can borrow 3 books in maximum
-- Why: The relationship line connecting 'Member' to 'borrow' shows a cardinality indicator of "(0..3)", capping the max relationship instances at 3.

-- Q23: Subtypes Patient and Staff. A staff can be a patient as well. How many columns need to be added in the People table to present the discriminator?
-- A: 2
-- Why: Because the subtypes overlap (an entity can be both), you cannot use a single categorical discriminator column. You need two boolean/flag columns (e.g., is_patient, is_staff).

-- Q25: Which of the following in ER or EER should be shown as a table in Rational Model? (1) Derived Attribute (2) Multivalued Attribute (3) 1:N Unary Relationship (4) M:N Binary Relationship (5) Subtype entity (6) Relationships between Subtype and Supertype
-- A: (2),(4),(5)
-- Why: Multivalued attributes, Many-to-Many relationships, and Subtype entities all require physical table instantiation in a relational schema. (Derived attributes are calculated on the fly; 1:N and supertype relationships are handled via foreign keys).


-- ========================================================================================================
-- SECTION 3: DATABASE KEYS & CONSTRAINTS
-- ========================================================================================================

-- Q11: Which of the following SQL is CORRECT to create a table LIST with a composite primary key, and user_id is a Foreign key referring to user_id in the Table USER?
-- A: Create Table LIST (list_id serial, user_id int, Primary key (list_id, user_id), Foreign key (user_id) references USER(user_id))
-- Why: A composite primary key must be defined at the table level (Primary key (col1, col2)), not inline with a single column.

-- Q14: What of the following is TRUE?
-- A: A foreign key may refer to the Primary key in the same table OR Foreign key accepts NULL values but Primary key does not.
-- Why: An FK referencing its own table is a standard recursive relationship (e.g., an employee's manager_id referencing the employee_id). Furthermore, PKs enforce entity integrity (no NULLs), while FKs do not have that strict requirement.

-- Q24: What is the common used data type of a PRIMARY KEY in PostgreSQL?
-- A: Serial
-- Why: 'Serial' automatically creates an auto-incrementing integer sequence, which is ideal for surrogate primary keys.


-- ========================================================================================================
-- SECTION 4: SQL COMMANDS - DDL & DML
-- ========================================================================================================

-- Q2: Which are DML statements?
-- A: DELETE and SELECT
-- Why: Data Manipulation Language (DML) manages data within schema objects. DELETE modifies data, and SELECT queries it. (DROP, ALTER, CREATE are DDL).

-- Q6: The Commend to REMOVE all rows from a table SALES
-- A: Delete from SALES
-- Why: The DELETE command removes rows from a table. (DROP removes the entire table structure).

-- Q21: The command to CHANGE the column NAME in STUDENT from char(20) to varchar(20)
-- A: Alter table STUDENT alter column NAME type varchar(20)
-- Why: This is the standard PostgreSQL syntax for changing the data type of an existing column.


-- ========================================================================================================
-- SECTION 5: SQL QUERIES - BASIC SELECT & FILTERING
-- ========================================================================================================

-- Q3: The command to find all distinct values in the column NAME from STUDENT starts with a or b.
-- A: Select Distinct NAME from STUDENT where NAME likes 'a%' or NAME likes 'b%'
-- Why: The wildcard '%' represents any sequence of characters. (Note: The syntactically correct SQL keyword is 'LIKE', but this option most closely represents the intended logic).

-- Q8: Given a table LIST with 100 records and 65 with the Column A>0, how many records or rows will return via " Select * from LIST having A>0 limit 10 offset 2"
-- A: 10
-- Why: 'LIMIT 10' explicitly restricts the final result set to exactly 10 rows, regardless of how many rows remain after the 'OFFSET' skips the first 2.

-- Q13: Given a table USER create via " Create Table USER (USERNAME varchar(20) primary key, PASSWORD varchar(10) not null)", which of the following returns the same result as "Select * from USER"?
-- A: Select USERNAME, PASSWORD from USER
-- Why: The table only has two columns explicitly defined. Specifying both columns by name yields the exact same projection as the '*' wildcard.

-- Q18: Which of the following query returns the current date?
-- A: Select current_date OR Select now()::date
-- Why: Both are valid in PostgreSQL to return strictly the date portion without the timestamp. 


-- ========================================================================================================
-- SECTION 6: SQL QUERIES - ADVANCED (JOINS, AGGREGATES, WINDOW FUNCTIONS)
-- ========================================================================================================

-- Q7: What of the following is TRUE?
-- A: A row in a table is a tuple. OR Having clause performs after Group By clause, while where clause performs before Group By clause in SQL.
-- Why: Both are fundamental relational database and SQL execution truths. WHERE filters individual rows before grouping, and HAVING filters aggregates after grouping.

-- Q9: How many tables may be included with a JOIN in PostgreSQL?
-- A: All of the menthioned
-- Why: Relational databases like PostgreSQL allow you to join an arbitrary number of tables together in a single query (1, 2, 3, or more).

-- Q15: Which function is used for the order column?
-- A: Rank()
-- Why: Looking at the provided data, tied values receive the same rank (e.g., 2, 2) and the next sequence skips a number (jumping to 4). This gap-producing behavior is the signature of the RANK() window function.

-- Q19: The command to find all STUDENT ID and NAME in the table STUDENT that has no GRADE in the table STU_GRADE using STUDENT_ID
-- A: Select STUDENT_ID, NAME from STUDENT left join STU_GRADE using STUDENT_ID where GRADE is NULL
-- Why: A LEFT JOIN includes all students. Adding 'WHERE GRADE IS NULL' filters the results to ONLY those students who did not find a matching record in the grades table.

-- Q27: The command to calculate the AGE in year of all students in the table STUDENT based on the column BIRTHDAY
-- A: Select STUDENT_ID, NAME, extract (year from age (now(), BIRTHDAY)) as AGE from STUDENT
-- Why: The `age()` function returns an interval. `extract(year from...)` safely pulls just the integer year out of that interval.


-- ========================================================================================================
-- SECTION 7: POSTGRESQL DATABASE CONCEPTS
-- ========================================================================================================

-- Q26: A named collection of tables is called in PostgreSQL?
-- A: Schema
-- Why: In PostgreSQL, schemas are namespaces used to organize logically related database objects like tables, views, and functions.


-- ========================================================================================================
-- SECTION 8: DATA WAREHOUSE & BUSINESS INTELLIGENCE
-- ========================================================================================================

-- Q5: What of the following is FALSE?
-- A: Both database and data warehouse needed to be normalized.
-- Why: While relational databases are heavily normalized to reduce redundancy, data warehouses intentionally denormalize data (like in a star schema) to optimize for fast analytical read queries.

-- Q29: Match the rows and columns in the scenario of data warehouse
-- A: Sales and # of Employees are Facts. Store and Time are Dimensions.
-- Why: Facts represent quantitative, measurable business metrics (sales amount, headcount). Dimensions represent descriptive attributes (time, store locations) you slice and dice the facts by.

-- Q30/31: What of the following is TRUE?
-- A: Data Mart is small in size and designed to meet the demands of a specific group of users. OR Database Management System is a software system that enable user to define, create and maintain the database.
-- Why: Both are universally accepted standard definitions in database architecture.


-- ========================================================================================================
-- SECTION 9: BIG DATA & PYSPARK
-- ========================================================================================================

-- Q12: What of the following is FALSE about PySpark?
-- A: Spark is developed in Python
-- Why: Apache Spark's core is written in Scala, not Python. PySpark is just the Python API wrapper for it.

-- Q28: What of the following is the result of the following code? (df.coalesce(6); df.rdd.getNumPartitions())
-- A: 4
-- Why: The cluster was initiated with `.master("local[4]")`, meaning 4 initial partitions. `coalesce()` can only decrease or keep partition counts the same; it avoids full shuffles and therefore cannot increase partitions to 6. It remains 4.

