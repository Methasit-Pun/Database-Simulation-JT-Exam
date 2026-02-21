# 📚 Database Exam Preparation Guide

comprehensive database exam study guide! This repository contains everything you need for your database midterm exam.

---

## 📁 What's Inside the `cheat_sheet` Folder?

### 1. **[Part I&II] past_ex.sql** - Past Exam Questions (Multiple Choice & True/False)
   - **What it contains:** 31 past exam questions organized by 9 topics
   - **Best for:** Understanding question patterns and testing your knowledge
   - **Topics covered:**
     - Normalization & Database Theory
     - ER/EER Modeling & Entity-Relationship Diagrams
     - Database Keys & Constraints
     - SQL Commands (DDL & DML)
     - SQL Queries (Basic & Advanced)
     - PostgreSQL Database Concepts
     - Data Warehouse & Business Intelligence
     - Big Data & PySpark

### 2. **[Part I&II] note_written_part.sql** - Theory & Concepts
   - **What it contains:** Comprehensive notes on database fundamentals and theory
   - **Best for:** Understanding concepts for written/theory questions
   - **Topics covered:**
     - Database Fundamentals (Data vs Information, Metadata, DBMS)
     - Entity-Relationship (ER) Modeling
     - Enhanced ER (EER) Modeling
     - The Relational Model
     - Normalization
     - SQL Basics

### 3. **[Part III] mock_exam.sql** - SQL Practice Problems
   - **What it contains:** Hands-on SQL queries organized by database tables
   - **Best for:** Practicing SQL coding for Part III of the exam
   - **How it's organized:** 
     1. Customer Table queries
     2. Payment Table queries
     3. Actor Table queries
     4. Inventory & Rental Table queries
     5. Category Table queries
     6. Film Table queries
     7. Store & Staff Table queries

### 4. **dvd_rental_erd.png** - Database Diagram
   - **What it contains:** Entity-Relationship Diagram of the DVD rental database
   - **Best for:** Understanding table relationships and foreign keys

---

## 🎯 How to Prepare for Your Exam


#### Step 1: Study Theory Notes
1. Open **`[Part I&II] note_written_part.sql`**
2. Read through all sections systematically
3. Take notes on concepts you find challenging
4. Focus on:
   - Differences between entity types (Strong vs Weak vs Associative)
   - Normalization rules (1NF, 2NF, 3NF, BCNF)
   - EER concepts (Specialization, Generalization, Overlap, Disjoint)
   - Key constraints (Primary Key, Foreign Key rules)

#### Step 2: Test Your Knowledge with Past Questions
1. Open **`[Part I&II] past_ex.sql`**
2. Go through each topic section one by one
3. Try to answer questions BEFORE looking at the answer
4. Read the "Why" explanations carefully - they reinforce concepts
5. Keep track of questions you got wrong
6. Review those topics again in the theory notes


---

#### Step 3: Understand the Database Structure
1. Open **`dvd_rental_erd.png`**
2. Study how tables are connected
3. Identify primary keys (marked in diagrams)
4. Trace foreign key relationships
5. Understand which tables you need to JOIN for different queries

#### Step 4: Practice SQL Queries
1. Open **`[Part III] mock_exam.sql`**
2. **How to use this file:**
   ```
   ┌─────────────────────────────────────────────┐
   │ Step 1: Read the problem carefully          │
   │ Step 2: Identify which tables are involved  │
   │ Step 3: Use Ctrl+F to find similar examples │
   │ Step 4: Try coding it yourself first        │
   │ Step 5: Compare with the provided solution  │
   └─────────────────────────────────────────────┘
   ```
3. **Practice in order:**
   - Start with Customer table queries (easier)
   - Progress to multi-table JOINs
   - Master window functions (RANK, LEAD, FIRST_VALUE)
   - Practice aggregations (COUNT, SUM, AVG)

#### Step 5: Focus on Common SQL Patterns
The mock exam file teaches you these essential patterns:
- ✅ **Basic SELECT with WHERE** - Filtering rows
- ✅ **JOINs** - Combining multiple tables
- ✅ **GROUP BY with HAVING** - Aggregating data
- ✅ **Window Functions** - RANK(), LEAD(), LAG(), FIRST_VALUE()
- ✅ **Subqueries** - Nested SELECT statements
- ✅ **Date/Time Functions** - EXTRACT(), age(), current_date
- ✅ **String Functions** - LIKE, wildcards (%)

---

## 📋 Exam Day Checklist

### For Part I & II (Theory/Multiple Choice):
- [ ] Can you explain the difference between 2NF and 3NF?
- [ ] Do you know when to use Weak Entity vs Associative Entity?
- [ ] Can you identify Total vs Partial Specialization?
- [ ] Do you understand Overlap vs Disjoint constraints?
- [ ] Can you name DML vs DDL statements?
- [ ] Do you know the difference between WHERE and HAVING?
- [ ] Can you explain Facts vs Dimensions in data warehousing?

### For Part III (SQL Coding):
- [ ] Can you write a basic SELECT with WHERE clause?
- [ ] Can you JOIN 2 or more tables correctly?
- [ ] Can you use GROUP BY with aggregate functions?
- [ ] Can you write subqueries?
- [ ] Do you know how to use RANK() and window functions?
- [ ] Can you use date functions (EXTRACT, age)?
- [ ] Do you know the difference between LEFT JOIN and INNER JOIN?

---


## 🎓 Final Words

**Remember:** 
- Understanding > Memorization
- Practice makes perfect
- Review the "Why" explanations - they contain gold!
- Don't panic if you don't know everything - focus on core concepts

**You've got this! 💪**

Good luck on your exam! 🍀

---

*Last Updated: February 2026*
