create database Company_Employee;
use Company_Employee;
CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50),
    Dept_Location VARCHAR(50)
);

CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Job_Role VARCHAR(50),
    Dept_ID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Project (
    Proj_ID INT PRIMARY KEY,
    Proj_Name VARCHAR(50),
    Proj_Location VARCHAR(50)
);

CREATE TABLE Works_For (
    Emp_ID INT,
    Proj_ID INT,
    job_role varchar(10),
    PRIMARY KEY (Emp_ID, Proj_ID),
    FOREIGN KEY (Emp_ID) REFERENCES Employee(Emp_ID),
    FOREIGN KEY (Proj_ID) REFERENCES Project(Proj_ID)
);
CREATE TABLE Gets (
    Emp_ID INT,
    incentive_date date,
    Incentive DECIMAL(10,2),
    FOREIGN KEY (Emp_ID) REFERENCES Employee(Emp_ID)
);
INSERT INTO Department VALUES
(10, 'HR', 'Bengaluru'),
(20, 'Finance', 'Hyderabad'),
(30, 'IT', 'Mysuru'),
(40, 'Sales', 'Bengaluru'),
(50, 'Marketing', 'Chennai');

INSERT INTO Employee VALUES
(1, 'Anil', 'Manager', 10, 60000),
(2, 'Ravi', 'Analyst', 20, 50000),
(3, 'Sneha', 'Developer', 30, 55000),
(4, 'Divya', 'Executive', 40, 45000),
(5, 'Kiran', 'Clerk', 50, 35000),
(6, 'Rahul', 'Tester', 30, 40000);

INSERT INTO Project VALUES
(101, 'Payroll System', 'Bengaluru'),
(102, 'ERP', 'Hyderabad'),
(103, 'CRM', 'Mysuru'),
(104, 'Website', 'Chennai'),
(105, 'Analytics', 'Bengaluru');

INSERT INTO Works_For VALUES
(1, 101,'manager'),
(2, 102,'developer'),
(3, 103,'tester'),
(4, 101,'HR'),
(5, 104,'developer'),
(6, 103,'tester');

INSERT INTO Gets VALUES
(1,'2024-10-11' ,3000),
(2,'2023-1-23',2000),
(3,'2021-9-30', NULL),
(4, '2021-10-9',2500),
(5,'2021-10-30' ,NULL),
(6,  '2025-10-9',1000);

SELECT DISTINCT w.emp_id
FROM works_for w
JOIN project p
  ON w.proj_id = p.proj_id
WHERE p.proj_location IN ('Bengaluru', 'Hyderabad', 'Mysuru')
ORDER BY w.emp_id;
SELECT Emp_ID
FROM Employee
WHERE Emp_ID NOT IN (
    SELECT Emp_ID FROM Gets WHERE Incentive IS NOT NULL
);
SELECT e.Emp_Name, e.Emp_ID, d.Dept_Name, e.Job_Role,
       d.Dept_Location, p.Proj_Location
FROM Employee e
JOIN Department d ON e.Dept_ID = d.Dept_ID
JOIN Works_For w ON e.Emp_ID = w.Emp_ID
JOIN Project p ON w.Proj_ID = p.Proj_ID
WHERE d.Dept_Location = p.Proj_Location;
