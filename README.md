# PostgreSQL Guide

## **Basic Queries**

### Create Database
```sql
CREATE DATABASE dbname;
```

### Create Table
```sql
CREATE TABLE tablename (
    column_name data_type constraints
);

-- Example:
CREATE TABLE admin (
    id INT,
    name VARCHAR(100),
    adminId INT
);
```

### Insert Data
```sql
INSERT INTO tablename VALUES (data);

-- Example:
INSERT INTO admin VALUES (1, 'admin', 11);
```

### Common Commands
- **Clear screen**: `\! cls`
- **Connect to a database**: `\c dbname`
- **Describe a table**: `\d tablename`
- **List all databases**: `\l`
- **Select all rows from a table**: `SELECT * FROM tablename;`
- **Select specific columns**: `SELECT column_name FROM tablename;`

### Update Data
```sql
UPDATE admin SET city = 'London' WHERE id = 2;
```

### Delete Data
```sql
DELETE FROM tablename WHERE id = 1;
```

---

## **Data Types and Constraints**

### Common Data Types
- **Integer**: `INT`
- **Boolean**: `BOOLEAN`
- **String**: `VARCHAR`
- **Date**: `DATE`

### Constraints
- **Primary Key**: Ensures unique identification of rows.
- **Not Null**: Prevents NULL values.
- **Unique**: Ensures all values in a column are unique.
- **Default**: Sets a default value for the column.
- **Check**: Ensures values meet a specific condition.
- **Serial**: Auto-increment for primary keys.

---

## **Data Refining**

### Clauses
- **WHERE**: Filter rows based on a condition.
- **DISTINCT**: Remove duplicate rows.
- **ORDER BY**: Sort rows.
- **LIMIT**: Limit the number of rows returned.
- **LIKE**: Match patterns in strings.

Example:
```sql
SELECT * FROM employees WHERE emp_id = 9;
SELECT DISTINCT column_name FROM tablename;
SELECT * FROM tablename ORDER BY column_name DESC LIMIT 10;
```

### Logical Operators
- `AND`, `OR`, `NOT`, `IN`

---

## **Aggregation Functions**
- `COUNT()`: Counts rows.
- `MAX()`: Finds the maximum value.
- `SUM()`: Sums values.
- `MIN()`: Finds the minimum value.
- `AVG()`: Calculates the average.

---

## **Grouping**
```sql
SELECT column_name, COUNT(*) FROM tablename GROUP BY column_name;
```

---

## **String Functions**
- `CONCAT()`, `CONCAT_WS()`
- `SUBSTR()`, `LEFT()`, `RIGHT()`
- `LENGTH()`
- `UPPER()`, `LOWER()`
- `TRIM()`, `LTRIM()`, `RTRIM()`
- `REPLACE()`
- `POSITION()`
- `STRING_AGG()`

Example:
```sql
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;
```

---

## **Table Alterations**

### Add or Delete a Column
```sql
ALTER TABLE tablename ADD COLUMN age INT NOT NULL;
ALTER TABLE tablename DROP COLUMN age;
```

### Rename Table
```sql
ALTER TABLE tablename RENAME TO new_table_name;
-- Example:
RENAME TABLE contact TO mycontacts;
```

### Modify Column
```sql
ALTER TABLE tablename ALTER COLUMN column_name SET DATA TYPE VARCHAR(150);
ALTER TABLE tablename ALTER COLUMN column_name DROP DEFAULT;
```

---

## **Constraints**

### Add Constraints
```sql
ALTER TABLE employees ADD COLUMN contact VARCHAR(15) UNIQUE CHECK (LENGTH(contact) <= 10);
```

### Drop Constraints
```sql
ALTER TABLE employees DROP CONSTRAINT contact_key_constraint;
```

---

## **Case Expressions**
```sql
SELECT fname, salary,
CASE 
    WHEN salary <= 50000 THEN 'High'
    ELSE 'Low'
END AS salary_category
FROM employees;
```

---

## **Stored Procedures**

### Create Procedure
```sql
CREATE OR REPLACE PROCEDURE add_employee(
    fname VARCHAR,
    lname VARCHAR,
    email VARCHAR,
    dept VARCHAR,
    salary INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employees(fname, lname, email, dept, salary, hire_date)
    VALUES(fname, lname, email, dept, salary, hire_date);
END;
$$;

CALL add_employee('loss', 'anle', 'loss@gmail.com', 'finance', 4000);
SELECT * FROM employees;
SELECT DISTINCT dept FROM employees;
```

### Nested Query Example
```sql
SELECT e.employid, e.fname, e.salary
FROM employees e
WHERE e.dept = 'cse' AND e.salary = (
    SELECT MAX(emp.salary) FROM employees emp WHERE emp.dept = 'cse'
);
```

---

## **Functions**

### Create Function
```sql
CREATE OR REPLACE FUNCTION dept_max_salary(dept_name VARCHAR)
RETURNS TABLE(employid INT, fname VARCHAR, salary INT)
AS $$
BEGIN
    RETURN QUERY
    SELECT e.employid, e.fname, e.salary FROM employees e
    WHERE e.dept = dept_name AND e.salary = (
        SELECT MAX(emp.salary) FROM employees emp WHERE emp.dept = dept_name
    );
END;
$$ LANGUAGE plpgsql;

SELECT * FROM dept_max_salary('finance');
```

---

## **Window Functions**

### Examples
```sql
SELECT fname, salary, AVG(salary) OVER(ORDER BY ROUND(salary)) FROM employees;

SELECT ROW_NUMBER() OVER(PARTITION BY dept), fname, dept, salary FROM employees;

SELECT fname, salary, RANK() OVER(ORDER BY salary DESC) FROM employees;

SELECT fname, salary, DENSE_RANK() OVER(ORDER BY salary DESC) FROM employees;
```

---

## **Common Table Expressions (CTE)**

### Example: Average Salary
```sql
WITH avg_sal AS (
    SELECT dept, AVG(salary) AS avg_salary FROM employees GROUP BY dept
)
SELECT e.employid, e.fname, e.dept, e.salary, a.avg_salary
FROM employees e
JOIN avg_sal a ON e.dept = a.dept
WHERE e.salary > a.avg_salary;
```

### Example: Maximum Salary
```sql
WITH max_sal AS (
    SELECT dept, MAX(salary) AS max_salary FROM employees GROUP BY dept
)
SELECT e.employid, e.fname, e.dept, e.salary
FROM employees e
JOIN max_sal a ON e.dept = a.dept
WHERE e.salary = a.max_salary;
```

---

## **Triggers**

### Example: Check Salary Trigger
```sql
CREATE OR REPLACE FUNCTION check_salary()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.salary < 0 THEN
        NEW.salary = 0;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_update_salary
BEFORE UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION check_salary();
```
