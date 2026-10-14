/* =========================================================
   EMPLOYEE LEAVE MANAGEMENT SYSTEM
   SQL QUERIES
   ========================================================= */


/* =========================================================
   1. DISPLAY EMPLOYEES WITH THEIR DEPARTMENTS
   ========================================================= */

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.salary
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id;


/* =========================================================
   2. DISPLAY EMPLOYEE LEAVE REQUEST DETAILS
   ========================================================= */

SELECT
    e.employee_name,
    l.leave_type,
    l.start_date,
    l.end_date,
    l.status
FROM employees e
INNER JOIN leave_request l
    ON e.employee_id = l.employee_id;


/* =========================================================
   3. DISPLAY PENDING LEAVE REQUESTS
   ========================================================= */

SELECT
    e.employee_name,
    l.leave_type,
    l.start_date,
    l.end_date,
    l.status
FROM employees e
INNER JOIN leave_request l
    ON e.employee_id = l.employee_id
WHERE l.status = 'PENDING';


/* =========================================================
   4. COUNT LEAVE REQUESTS FOR EACH EMPLOYEE
   ========================================================= */

SELECT
    e.employee_name,
    COUNT(*) AS total_requests
FROM employees e
INNER JOIN leave_request l
    ON e.employee_id = l.employee_id
GROUP BY e.employee_name;


/* =========================================================
   5. EMPLOYEES EARNING ABOVE AVERAGE SALARY
   ========================================================= */

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


/* =========================================================
   6. DISPLAY EMPLOYEE LEAVE BALANCE
   ========================================================= */

SELECT
    e.employee_name,
    l.total_leaves,
    l.used_leaves,
    l.total_leaves - l.used_leaves AS remaining_leaves
FROM employees e
INNER JOIN leave_balance l
    ON e.employee_id = l.employee_id;


/* =========================================================
   7. TEST GET_REMAINING_LEAVES FUNCTION
   ========================================================= */

SELECT
    get_remaining_leaves(101) AS remaining_leaves
FROM dual;


/* =========================================================
   8. TEST GET_ANNUAL_SALARY FUNCTION
   ========================================================= */

SELECT
    get_annual_salary(101) AS annual_salary
FROM dual;


/* =========================================================
   9. DISPLAY ALL EMPLOYEES
   ========================================================= */

SELECT *
FROM employees;


/* =========================================================
   10. DISPLAY ALL LEAVE REQUESTS
   ========================================================= */

SELECT *
FROM leave_request;