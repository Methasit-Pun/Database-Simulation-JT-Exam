-- 1. Sort Data "List all students in alphabetical order by StudentName." 
-- Selects all columns from Student and sorts them A-Z by name
SELECT *
FROM STUDENT
ORDER BY StudentName;


-- 2. Filter by ID "Which students have an ID number that is less than 50000?" 
-- Filters the result set for IDs strictly lower than 50,000
SELECT *
FROM STUDENT
WHERE StudentID < 50000;



-- 3. Aggregate Minimum "What is the smallest section number used in the first semester of 2008?" 

-- Finds the minimum value in the SectionNo column for the specified semester
-- Note: The data in uses '1-2008' for most entries.
SELECT MIN(SectionNo)
FROM SECTION
WHERE Semester = '1-2008';



-- 4. Count Records "How many students are enrolled in Section 2714 in the first semester of 2008?" 
-- Counts the number of rows matching both the section and semester criteria
SELECT COUNT(*)
FROM REGISTRATION
WHERE SectionNo = 2714 AND Semester = '1-2008';