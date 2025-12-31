--USE DATABASE
use kesavan_db
GO
--Project Table
CREATE TABLE project
(
	project_id INT IDENTITY(1,1) PRIMARY KEY,
	project_name VARCHAR(150) UNIQUE NOT NULL,
	starts_date DATE NOT NULL,
	end_date DATE NOT NULL,
	budget MONEY ,
	statuss VARCHAR(50) DEFAULT 'Not Started',

	--Constraints for end date field
	    CONSTRAINT CHECK_end_date_After_starts_date 
        CHECK (end_date >= starts_date),
)
GO

--Inserting values:
INSERT INTO project (project_name, starts_date, end_date, budget, statuss)
VALUES 
    ('Website Redesign', '2025-01-01', '2025-06-30', 15000.00, 'In Progress'),
    ('Mobile App Development', '2025-02-15', '2025-07-15', 25000.00, 'Not Started'),
    ('Market Research', '2025-03-01', '2025-05-31', 10000.00, 'Completed'),
    ('Annual Report Preparation', '2025-04-01', '2025-12-31', 12000.00, 'In Progress')
GO

--task table creation
CREATE TABLE task(
	task_id INT IDENTITY(1,1) PRIMARY KEY,
	task_name VARCHAR(150) NOT NULL,
	descriptions VARCHAR(255) NOT NULL,
	starts_date DATE NOT NULL,
	due_date DATE NOT NULL,
		--Constraints for end date field
	    CONSTRAINT CHECK_due_date_After_starts_date 
          CHECK (due_date >= starts_date),
	prioritys VARCHAR(150) 
		CONSTRAINT CK_Task_Priority CHECK (prioritys IN ('Low', 'Medium', 'High')),
	statuss VARCHAR(70) DEFAULT 'Pending',
	project_id INT FOREIGN KEY REFERENCES project(project_id)
);
GO

--inserting task values
INSERT INTO task (task_name, descriptions, starts_date, due_date, prioritys, statuss, project_id)
VALUES 
    ('Initial Design', 'Design phase for the new website', '2025-01-02', '2025-02-28', 'High', 'Completed', 1),
    ('UI Development', 'Development of user interface components', '2025-03-01', '2025-05-15', 'Medium', 'In Progress', 1),
    ('Quality Assurance', 'Testing and quality assurance', '2025-05-16', '2025-06-15', 'High', 'Pending', 1),
    ('API Development', 'Developing APIs for the mobile app', '2025-02-16', '2025-04-30', 'Medium', 'Completed', 2),
    ('Beta Testing', 'Conducting beta testing for the mobile app', '2025-05-01', '2025-06-30', 'High', 'In Progress', 2),
    ('Survey Analysis', 'Analyzing market research surveys', '2025-03-02', '2025-04-15', 'Low', 'Completed', 3),
    ('Report Drafting', 'Drafting the final report based on research', '2025-04-16', '2025-05-30', 'Medium', 'Pending', 3),
    ('Financial Statements', 'Preparing financial statements for the annual report', '2025-04-02', '2025-07-15', 'High', 'In Progress', 4),
    ('Final Review', 'Final review and submission of the annual report', '2025-07-16', '2025-12-15', 'High', 'Pending', 4),
    ('Client Feedback Incorporation', 'Incorporating feedback from the client into the project', '2025-02-01', '2025-03-15', 'Medium', 'In Progress', 1),
    ('Launch Preparation', 'Preparing for the official launch of the mobile app', '2025-06-01', '2025-07-01', 'High', 'Pending', 2);
    


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
    Name NVARCHAR(100),
    start_dates DATE,
    Prioritys NVARCHAR(20)
);

/*
3. Insert Sample Data:
insert the record from Task Table which have priority low.
*/
INSERT INTO #LocalTempTable (Name, start_dates, Prioritys)
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

