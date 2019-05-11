DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles; 

CREATE TABLE employees (
   emp_no      INT NOT NULL,
   birth_date  DATE NOT NULL,
   first_name  VARCHAR(14) NOT NULL,
   last_name   VARCHAR(16) NOT NULL,
   gender      VARCHAR(1) NOT NULL,
   hire_date   DATE NOT NULL,
   PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
   dept_no     VARCHAR(4) NOT NULL,
   dept_name   VARCHAR(40) NOT NULL,
   PRIMARY KEY (dept_no),
   UNIQUE (dept_name)
);


CREATE TABLE dept_emp (
   emp_no INT NOT NULL,
   dept_no VARCHAR(4) NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no),
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
   PRIMARY KEY (emp_no,dept_no)
);


CREATE TABLE dept_manager (
  dept_no      VARCHAR(4) NOT NULL,
  emp_no       INT NOT NULL,
  from_date    DATE NOT NULL,
  to_date      DATE NOT NULL,
  FOREIGN KEY (emp_no)  REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE titles (
   emp_no      INT NOT NULL,
   title       VARCHAR(50) NOT NULL,
   from_date   DATE NOT NULL,
   to_date     DATE,
   FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
   PRIMARY KEY (emp_no,title, from_date)
);


CREATE TABLE salaries (
   emp_no      INT NOT NULL,
   salary      INT NOT NULL,
   from_date   DATE NOT NULL,
   to_date     DATE NOT NULL,
   FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
   PRIMARY KEY (emp_no, from_date)
);

select * from employees; 

-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT 
employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM
employees
LEFT JOIN salaries on employees.emp_no = salaries.emp_no;

--  List employees who were hired in 1986.

select * from employees 
where hire_date >= '1986-01-01'
AND hire_date < '1986-12-31' 
ORDER BY hire_date asc; 

							   
-- List the manager of each department with the following information: 
-- department number, department name,
-- the manager's employee number, last name, 
-- first name, and start and end employment dates.							   
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, 
dept_manager.from_date, dept_manager.to_date, 
FROM departments, dept_manager 
LEFT JOIN dept_manager on departments.dept_no = dept_manager.dept_no; 

SELECT 
employees.emp_no, employees.last_name, 
employees.first_name, employees.gender, salaries.salary
FROM
employees
LEFT JOIN salaries on employees.emp_no = salaries.emp_no;
							   							   
select * from employees; 

-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT 
employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM
employees
LEFT JOIN salaries on employees.emp_no = salaries.emp_no;

--  List employees who were hired in 1986.

select * from employees 
where hire_date >= '1986-01-01'
AND hire_date < '1986-12-31' 
ORDER BY hire_date asc; 

							   
-- List the manager of each department with the following information: 
-- department number, department name,
-- the manager's employee number, last name, 
-- first name, and start and end employment dates.							   
SELECT dept_emp.emp_no, dept_emp.dept_no, dept_emp.from_date, dept_emp.to_date,
employees.first_name, employees.last_name, departments.dept_name
FROM dept_emp  
LEFT JOIN employees on dept_emp.emp_no = employees.emp_no
LEFT JOIN departments on departments.dept_no = dept_emp.dept_no;

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.first_name, employees.last_name,
departments.dept_name
FROM employees
LEFT JOIN dept_emp on employees.emp_no = dept_emp.emp_no
LEFT JOIN departments on departments.dept_no = dept_emp.dept_no; 


-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name, employees.last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'; 
														   
-- List all employees in the Sales department, 
-- including their employee number, last name, 
-- first name, and department name.														   
														   
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM employees
LEFT JOIN dept_emp on employees.emp_no = dept_emp.emp_no
LEFT JOIN departments on departments.dept_no = dept_emp.dept_no
WHERE dept_name = 'Sales'; 


-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM employees
LEFT JOIN dept_emp on employees.emp_no = dept_emp.emp_no
LEFT JOIN departments on departments.dept_no = dept_emp.dept_no
WHERE dept_name = 'Sales' 
OR dept_name = 'Development';


-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.

select last_name, count(*)
from employees
GROUP BY last_name
ORDER BY last_name desc; 
														   
														   
														   