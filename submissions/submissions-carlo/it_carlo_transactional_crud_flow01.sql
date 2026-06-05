-- Scenario: onboarding a new employee and creating first transaction note.
-- Task 1: BEGIN transaction.
-- Task 2: INSERT employee row.
-- Task 3: INSERT related employee_transactions row.
-- Task 4: Verify inserted rows with SELECT.
-- Task 5: COMMIT.

-- Scenario: safe deactivation.
-- Task 6: Mark inactive employees by employee_id using UPDATE ... WHERE ...
-- Task 7: Confirm affected rows.

-- Scenario: safe cleanup.
-- Task 8: Delete only inactive transactions older than a selected date (with WHERE).

SELECT * 
FROM employees

-- SELECT * 
-- FROM departments

SELECT * 
FROM employee_transactions


-- Task 1
BEGIN TRANSACTION;
-- Task 2
INSERT INTO employees
VALUES ('7','E-1007', 'Ada', 'Wong','Ada.Wong@gmail.com', '2026-07-13', '95000', '4');
--Task 3
INSERT INTO employee_transactions
VALUES ('6','7', 'EXPENSE REIMBURSEMENT', '1000', '2026-07-15', 'Medical examination');
--Task 4
SELECT 
	e.employee_id,
	e.first_name,
	e.email,
	t.transaction_id,
	t.transaction_type,
	t.amount,
	t.transaction_date,
	t.notes
FROM employees AS e
INNER JOIN employee_transactions AS t
	ON e.employee_id = t.employee_id
WHERE e.employee_id = 7;
--Task 5



COMMIT;
--Task 6
BEGIN TRANSACTION;
UPDATE employees 
SET is_active = 'false'
WHERE employee_id = 6;
--Task 7
SELECT *
FROM employees
WHERE is_active = 'false';
COMMIT;

--Task 8
BEGIN TRANSACTION;
DELETE 
FROM employee_transactions AS t
JOIN employees AS e
	ON e.employee_id = t.employee_id
WHERE e.is_active = 'false';
COMMIT;




-- ROLLBACK;



