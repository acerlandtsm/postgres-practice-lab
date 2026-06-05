-- Exercise 1: Return active employees sorted by last name then first name.
-- Exercise 2: Return employees hired after 2022-01-01 with salary >= 65000.
-- Exercise 3: Return employees with department names using a JOIN.
-- Exercise 4: Return top 3 highest salaries.
-- Exercise 5: Return department-level headcount with GROUP BY.




--SELECT *
--FROM employees


SELECT * 
FROM departments


SELECT * 
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;

-- Exercise 1
SELECT 
	e.last_name,
	e.first_name
FROM employees AS e
WHERE is_active = TRUE

-- Exercise 2
SELECT 
	e.first_name,
	e.last_name
FROM employees AS e
WHERE created_at >='2022-01-01' 
AND salary >= 65000;

-- Exercise 3
SELECT 
	e.first_name,
	e.last_name,
	d.department_name
FROM employees AS e
JOIN departments AS d
	ON e.department_id = d.department_id;

-- Exercise 4
SELECT 
	e.salary
FROM employees AS e
ORDER BY e.salary DESC
LIMIT 3;

-- Exercise 5
SELECT
	d.department_name,
	COUNT(e.department_id) AS headcount
FROM employees AS e
JOIN departments AS d
	ON d.department_id = e.department_id
GROUP BY department_name;


