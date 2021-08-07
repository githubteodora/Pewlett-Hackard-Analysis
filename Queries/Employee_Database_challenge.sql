-- PT. 1:
-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp.emp_no,
	emp.first_name,
	emp.last_name,
-- Retrieve the title, from_date, and to_date columns from the Titles table.
	ttl.title,
	ttl.from_date,
	ttl.to_date
-- Create a new table using the INTO clause.
INTO Retirement_titles
-- Join both tables on the primary key.
FROM employees as emp
    INNER JOIN titles as ttl
	ON (emp.emp_no = ttl.emp_no)
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- Then, order by the employee number.
ORDER BY emp.emp_no;

SELECT * FROM Retirement_titles LIMIT 10;

-- Note: There are duplicate entries for some employees because they have switched titles over the years.
--  steps to remove these duplicates and keep only the most recent title of each employee:
-- Use Dictinct with Orderby to remove duplicate rows
-- Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.

SELECT DISTINCT ON (rttls.emp_no) rttls.emp_no,
-- Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
rttls.first_name,
rttls.last_name,
rttls.title
-- Create a Unique Titles table using the INTO clause.
INTO retirement_titles_clean
FROM retirement_titles as rttls
-- Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e. to_date) of the most recent title.
ORDER BY rttls.emp_no, rttls.to_date DESC;

SELECT * FROM retirement_titles_clean LIMIT 10;

-- Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
-- First, retrieve the number of titles from the Unique Titles table.

SELECT COUNT(rclean.emp_no), rclean.title
-- Then, create a Retiring Titles table to hold the required information.
INTO retiring_titles
FROM retirement_titles_clean as rclean
-- Group the table by title, then sort the count column in descending order.
GROUP BY rclean.title
ORDER BY COUNT (rclean.emp_no) DESC;

SELECT * FROm retiring_titles LIMIT 10;

-- =========================================================================================================================================

-- PT. 2: 
-- Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
SELECT DISTINCT ON (emp.emp_no) emp.emp_no,
    emp.first_name,
    emp.last_name,
    emp.birth_date,
-- Retrieve the from_date and to_date columns from the Department Employee table.
    dptemp.from_date,
    dptemp.to_date,
-- Retrieve the title column from the Titles table.
	titles.title
-- Create a new table using the INTO clause
INTO mentorship_eligible
-- Join the Employees and the Department Employee tables on the primary key.
FROM employees as emp
    LEFT JOIN dept_emp as dptemp
    ON (emp.emp_no = dptemp.emp_no)
-- Join the Employees and the Titles tables on the primary key.
	LEFT JOIN titles
	ON (eMP.emp_no = titles.emp_no)	
-- Filter the data on the to_date column to all the current employees, 
-- then filter the data on the birth_date columns to get all the employees whose birth dates are 
-- between January 1, 1965 and December 31, 1965.
WHERE (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (dptemp.to_date = '9999-01-01')
-- Order the table by the employee number.
ORDER BY emp.emp_no;

SELECT * FROM mentorship_eligible LIMIT 10;
	
	

