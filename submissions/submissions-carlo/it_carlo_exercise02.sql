-- Exercise 1 (INSERT): Add a new employee in Engineering.
-- Exercise 2 (UPDATE): Move an employee to a different department safely.
-- Exercise 3 (DELETE): Remove a transaction record by transaction_id safely.
-- Exercise 4 (JOIN): List employees and total transaction amount (include employees with no transactions).
-- Exercise 5 (REPORT): Build monthly transaction summary by type.
-- Exercise 6 (VIEW): Query vw_department_headcount and explain output columns.
-- Exercise 7 (FUNCTION): Run fn_department_headcount() and fn_employee_transaction_total(2).
-- Exercise 8 (PARAMETERIZED): Write a parameterized query for employee lookup by email.

-- For testing
-- SELECT * 
-- FROM employees

-- SELECT * 
-- FROM employee_transactions

-- SELECT *
-- FROM report_runs

-- Exercise 1
INSERT INTO employees
VALUES ('6','E-1006', 'Leon', 'Kennedy','leon.kennedy@gmail.com', '2026-04-13', '70000', '1');

-- Exercise 2
UPDATE employees
SET department_id = 2
WHERE employee_id = 6;

--Exercise 3
DELETE 
FROM employee_transactions
WHERE transaction_id = 3;

--Exercise 4
SELECT
	e.first_name AS employee,
	 COALESCE(SUM(tr.amount), 0) AS total 
FROM employees AS e
LEFT JOIN employee_transactions AS tr
	ON e.employee_id = tr.employee_id
GROUP BY 
	first_name;

--Exercise 5
SELECT
	transaction_date AS date_month,
	transaction_type AS category,
	COUNT (transaction_id) AS total_orders,
	SUM(amount) AS total_amount
FROM employee_transactions
GROUP BY 
	transaction_date,
	transaction_type
ORDER BY 
	transaction_date DESC;
	transaction_type DESC;

--Exercise 6
--Refer to views/01_reporting_views.sql
SELECT *
FROM vw_department_headcount
--The view is the same as every instantiated sql lines. 
--In my own understanding, this is like a reusable class that you can call to perform specific tasks


--Exercise 7
--Refer to functions/01_reporting_functions.sql
SELECT *
FROM fn_department_headcount AS headcount

SELECT *
FROM fn_employee_transaction_total(2)


--Exercise 8
PREPARE vlookupMail (text) AS
SELECT 
	employee_number,
	first_name,
	last_name
FROM employees
WHERE email = $1;

EXECUTE vlookupMail('ava.stone@example.com');
DEALLOCATE vlookupMail;

