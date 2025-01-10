Here’s a structured list of **basic PostgreSQL commands** for various operations:

---

### **1. Database Operations**
- **Create a Database**:
  ```sql
  CREATE DATABASE dbname;
  ```
- **Connect to a Database**:
  ```sql
  \c dbname
  ```
- **List All Databases**:
  ```sql
  \l
  ```
- **Drop a Database**:
  ```sql
  DROP DATABASE dbname;
  ```

---

### **2. Table Operations**
- **Create a Table**:
  ```sql
  CREATE TABLE tablename (
      id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      email VARCHAR(100) UNIQUE
  );
  ```
- **View All Tables**:
  ```sql
  \dt
  ```
- **View Table Schema**:
  ```sql
  \d tablename
  ```
- **Drop a Table**:
  ```sql
  DROP TABLE tablename;
  ```

---

### **3. Insert, Select, Update, and Delete Operations**
- **Insert Data**:
  ```sql
  INSERT INTO tablename (column1, column2) VALUES ('value1', 'value2');
  ```
- **Select Data**:
  ```sql
  SELECT * FROM tablename;
  SELECT column1, column2 FROM tablename;
  ```
- **Update Data**:
  ```sql
  UPDATE tablename
  SET column1 = 'new_value'
  WHERE condition;
  ```
- **Delete Data**:
  ```sql
  DELETE FROM tablename
  WHERE condition;
  ```

---

### **4. Constraints**
- **Add Common Constraints While Creating a Table**:
  ```sql
  CREATE TABLE example (
      id SERIAL PRIMARY KEY,
      name VARCHAR(50) NOT NULL,
      email VARCHAR(100) UNIQUE,
      created_at DATE DEFAULT CURRENT_DATE
  );
  ```

---

### **5. Filtering and Conditions**
- **Using WHERE**:
  ```sql
  SELECT * FROM tablename WHERE column1 = 'value';
  ```
- **Using ORDER BY**:
  ```sql
  SELECT * FROM tablename ORDER BY column1 ASC;
  ```
- **Using LIMIT**:
  ```sql
  SELECT * FROM tablename LIMIT 10;
  ```

---

### **6. Alter Table Operations**
- **Add a Column**:
  ```sql
  ALTER TABLE tablename ADD COLUMN new_column VARCHAR(50);
  ```
- **Modify a Column**:
  ```sql
  ALTER TABLE tablename ALTER COLUMN column_name TYPE new_data_type;
  ```
- **Drop a Column**:
  ```sql
  ALTER TABLE tablename DROP COLUMN column_name;
  ```

---

### **7. Joins**
- **Inner Join**:
  ```sql
  SELECT a.column1, b.column2
  FROM table1 a
  INNER JOIN table2 b ON a.common_column = b.common_column;
  ```
- **Left Join**:
  ```sql
  SELECT a.column1, b.column2
  FROM table1 a
  LEFT JOIN table2 b ON a.common_column = b.common_column;
  ```

---

### **8. Indexing**
- **Create an Index**:
  ```sql
  CREATE INDEX index_name ON tablename(column_name);
  ```
- **Drop an Index**:
  ```sql
  DROP INDEX index_name;
  ```

---

### **9. Transactions**
- **Begin a Transaction**:
  ```sql
  BEGIN;
  ```
- **Commit a Transaction**:
  ```sql
  COMMIT;
  ```
- **Rollback a Transaction**:
  ```sql
  ROLLBACK;
  ```

---

### **10. Miscellaneous Commands**
- **Check PostgreSQL Version**:
  ```sql
  SELECT version();
  ```
- **Exit the PostgreSQL CLI**:
  ```sql
  \q
  ```
- **Clear Screen**:
  ```sql
  /! cls
  ```

---
