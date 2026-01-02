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
-- First method
CREATE TABLE #local_temp_table
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

INSERT INTO #local_temp_table (names, start_dates, Prioritys)
SELECT
    task_name,
    starts_date,
    prioritys
FROM
    task
WHERE
    prioritys='Low';

/*
--second method 
SELECT 
    task_name,
    starts_date,
    prioritys
INTO #local_table
FROM 
    task
WHERE 
    prioritys = 'low'
GO
select * from #local_table

*/

/*
                --4. Query the Table:
                Retrieve all rows from the temporary table.
*/

SELECT*
FROM #local_temp_table;

/*
--- 2. Global Temporary Table

1. Drop Table If Already Exist add condition.
*/

IF OBJECT_ID('tempdb..##GlobalTempTable')IS NOT NULL
DROP TABLE ##global_temp_table;


/*
2. Create a Global Temporary Table:
Name: ##GlobalTempTable
Columns: ID (INT, Identity), ProjectName (VARCHAR(100)), Budget (DECIMAL(18, 2)), Priority (Nvarchar(20))
*/

CREATE TABLE ##global_temp_table
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

INSERT INTO ##global_temp_table (project_name, budget, Priority)
SELECT
    p.project_name,
    p.budget,
    t.prioritys
FROM
    task t
INNER JOIN
    project p
ON
    t.project_id= p.project_id
WHERE
    t.prioritys='Medium';

--Display the table.
SELECT*
FROM ##global_temp_table;


--Declare table variable 

DECLARE @table_variable TABLE
(
    task_id INT IDENTITY(1,1),
    task_name VARCHAR(100),
    due_dates DATE,
    prioritys NVARCHAR(20)
);

INSERT INTO @table_variable (task_name, due_dates, prioritys)
SELECT
    task_name,
    due_date,
    prioritys
FROM
    task
WHERE
    prioritys='High';

SELECT*
FROM @table_variable;




