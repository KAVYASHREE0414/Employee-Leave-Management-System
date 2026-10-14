# Employee Leave Management System

## Project Overview

The Employee Leave Management System is an Oracle SQL and PL/SQL project designed to manage employee information, departments, leave requests, and employee leave balances.

The project demonstrates database design, SQL queries, joins, subqueries, aggregate functions, PL/SQL procedures, functions, conditional statements, and exception handling.

## Technologies Used

- Oracle Database
- Oracle SQL
- PL/SQL
- VS Code
- Oracle SQL Developer Extension

## Database Tables

### Departments
Stores department information.

- Department ID
- Department Name

### Employees
Stores employee details.

- Employee ID
- Employee Name
- Email
- Salary
- Joining Date
- Department ID

### Leave Balance
Stores the leave balance of each employee.

- Employee ID
- Total Leaves
- Used Leaves

Remaining leave is calculated as:

Remaining Leaves = Total Leaves - Used Leaves

### Leave Request
Stores employee leave requests.

- Leave ID
- Employee ID
- Start Date
- End Date
- Leave Type
- Status

Leave status can be:

- PENDING
- APPROVED
- REJECTED

## SQL Features Implemented

- Table creation
- Primary keys
- Foreign keys
- UNIQUE constraints
- CHECK constraints
- INSERT statements
- INNER JOIN
- WHERE clause
- GROUP BY
- COUNT
- AVG
- Subqueries
- Calculated columns

## PL/SQL Procedures

### update_salary

Updates the salary of a specific employee.

### apply_leave

Creates a new leave request for an employee.

New leave requests are created with a default status of PENDING.

### approve_leave

Approves a pending leave request after validating the employee's available leave balance.

The procedure:

1. Retrieves the leave request.
2. Checks whether the request is still PENDING.
3. Calculates the number of requested leave days.
4. Checks the employee's remaining leave balance.
5. Changes the request status to APPROVED.
6. Updates the employee's used leave balance.

It also prevents an already processed leave request from being approved again.

### reject_leave

Rejects a leave request only when its current status is PENDING.

## PL/SQL Functions

### get_remaining_leaves

Returns the remaining leave balance for an employee.

Formula:

Remaining Leaves = Total Leaves - Used Leaves

### get_annual_salary

Returns the annual salary of an employee.

Formula:

Annual Salary = Monthly Salary * 12

## Exception Handling

Basic PL/SQL exception handling is implemented for cases such as:

- Employee or leave request not found
- Duplicate leave ID
- Missing leave balance

## Project Structure

Employee-Leave-Management-System/
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_insert_data.sql
│   └── 03_queries.sql
│
├── plsql/
│   ├── 01_procedures.sql
│   └── 02_functions.sql
│
└── README.md

## Execution Order

Run the files in the following order:

1. sql/01_create_tables.sql
2. sql/02_insert_data.sql
3. plsql/01_procedures.sql
4. plsql/02_functions.sql
5. sql/03_queries.sql

## Example

Apply for leave:

BEGIN
    apply_leave(
        5,
        101,
        DATE '2026-11-10',
        DATE '2026-11-12',
        'CASUAL'
    );
END;
/

Approve leave:

BEGIN
    approve_leave(5);
END;
/

Check remaining leaves:

SELECT get_remaining_leaves(101)
FROM dual;

## Learning Outcomes

This project demonstrates practical knowledge of:

- Relational database design
- SQL joins and subqueries
- Aggregate functions
- PL/SQL procedures and functions
- SELECT INTO
- IF / ELSIF / ELSE
- Exception handling
- Data validation using constraints
- Primary key and foreign key relationships