# Pewlett-Hackard-Analysis
# Project Overview
The purpose of this analysis is to help an imaginary company surface the number of employees by their most recent job title who are about to retire, and create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship programme. The schema for the project consisted of 10+ tables, comples SQL queries were ised (joins, filtering, finding distinct values, grouping, sorting) were used to achieve the desired structure of the outputs.

# Software used
 - ProstgresSQL v11.12
 - pgAdmin v4

# Results
Deliverable 1: number of employees by their most recent job title, who are about to retire: 
 - Download: [(csv)](https://github.com/githubteodora/Pewlett-Hackard-Analysis/blob/main/Data/retirement_titles.csv)
 - Image:\
 ![img](https://github.com/githubteodora/Pewlett-Hackard-Analysis/blob/main/retiring%20titles.PNG)

Deliverable 2: Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship programme
 - Download: [(csv)](https://github.com/githubteodora/Pewlett-Hackard-Analysis/blob/main/Data/mentorship_eligibilty.csv)
 - Image (first 10 lines):\
 ![img](https://github.com/githubteodora/Pewlett-Hackard-Analysis/blob/main/mentorship%20eligible.PNG)
 
 # Summary
 
 - The analysis uncovered that more than 90k employees will be retiring soon. This poses a major challenge for the company, as it will have to fill 45k engineering positions, 45k other positions of various seniority levels. 
 - The company came up with the idea of deplying a mentorship programme, and thus encourage some of the future retirees to serve part-time as mentors to fresh team members, but only 1,5k of the list of retiring employees seem to be eligible to join the programme. 
\
Additional analysis needs to take place in order to determine if 1,5k mentors will be enough to efficiently mentor new employees. The company should consider updating the mentorship eligibility criteria and adjusting the following query to explore the results:

```
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
```
