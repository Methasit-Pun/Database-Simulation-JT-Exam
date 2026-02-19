SELECT c_id, count(stud_id) as num_of_A
from grade_t
WHERE grade = 'A'
GROUP BY c_id
ORDER BY num_of_A