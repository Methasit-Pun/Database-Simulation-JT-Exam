-- Exe 6: (2) Define the View

-- this view represents an Inner Join between STUDENT and REGISTRATION. Because the target view shows students Letersky, Altvater (twice), and Aiken
-- Creates a view listing students for every registration they have
CREATE VIEW Student_Registration_View AS
SELECT S.StudentID, S.StudentName
FROM STUDENT S, REGISTRATION R
WHERE S.StudentID = R.StudentID;