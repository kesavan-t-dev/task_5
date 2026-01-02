--USE DATABASE
use kesavan_db
GO

--- 1. Temporary Table
   
-- 1. Drop Table If Already Exist add condition.
IF OBJECT_ID('tempdb..#LocalTempTable') IS NOT NULL
DROP TABLE #LocalTempTable;

/*
2. Create a Local Temporary Table:
Name: #LocalTempTable
Columns: ID (INT, Identity), Name (NVARCHAR(100)), StartDate (DATE), Priority (nvarchar(20))
*/

CREATE TABLE #LocalTempTable
(
    id INT IDENTITY(1,1),
    names NVARCHAR(100),
    start_dates DATE,
    Prioritys NVARCHAR(20)
);

/*
3. Insert Sample Data:
insert the record from Task Table which have priority low.
*/
INSERT INTO #LocalTempTable (names, start_dates, Prioritys)
SELECT
    task_name,
    starts_date,
    prioritys
FROM
    task
WHERE
    prioritys='Low';



/*
--4. Query the Table:
Retrieve all rows from the temporary table.
*/

SELECT*
FROM #LocalTempTable;

/*
--- 2. Global Temporary Table

1. Drop Table If Already Exist add condition.
*/

IF OBJECT_ID('tempdb..##GlobalTempTable')IS NOT NULL
DROP TABLE ##GlobalTempTable;


/*
2. Create a Global Temporary Table:
Name: ##GlobalTempTable
Columns: ID (INT, Identity), ProjectName (VARCHAR(100)), Budget (DECIMAL(18, 2)), Priority (Nvarchar(20))
*/
CREATE TABLE ##GlobalTempTable
(
    id INT IDENTITY(1,1),
    project_name VARCHAR(100),
    Budget DECIMAL(18,2),
    Priority NVARCHAR(20)
);
/*
Insert Sample Data
(Insert records from **task table** where **priority = 'Medium'**)
*/

INSERT INTO ##GlobalTempTable (project_name, budget, prioritys)
SELECT
    p.project_name,
    p.budget,
    t.prioritys
FROM
    task t
INNERJOIN
    project p
ON
    t.project_id= p.project_id
WHERE
    t.prioritys='Medium';
--Display the table.
SELECT*
FROM ##GlobalTempTable;

--Declare table variable 
DECLARE@TableVariableTABLE
(
    task_id INT IDENTITY(1,1),
    task_name VARCHAR(100),
    due_dates DATE,
    priority NVARCHAR(20)
);

--insert data
INSERT INTO@TableVariable (task_name, due_dates, prioritys)
SELECT
    task_name,
    due_date,
    prioritys
FROM
    task
WHERE
    prioritys='High';


--Display table
SELECT*
FROM@TableVariable;


