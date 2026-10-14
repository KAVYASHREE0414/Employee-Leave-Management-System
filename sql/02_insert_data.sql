/* =========================================================
   EMPLOYEE LEAVE MANAGEMENT SYSTEM
   SAMPLE DATA
   ========================================================= */


/* =========================================================
   1. INSERT DEPARTMENTS
   ========================================================= */

INSERT ALL
    INTO departments (department_id, department_name)
    VALUES (10, 'IT')

    INTO departments (department_id, department_name)
    VALUES (20, 'HR')

    INTO departments (department_id, department_name)
    VALUES (30, 'Finance')

SELECT * FROM dual;


/* =========================================================
   2. INSERT EMPLOYEES
   ========================================================= */

INSERT ALL

    INTO employees
        (employee_id, employee_name, email, salary, joining_date, department_id)
    VALUES
        (101, 'Ravi', 'ravi@gmail.com', 50000,
         TO_DATE('10-JAN-2024', 'DD-MON-YYYY'), 10)

    INTO employees
        (employee_id, employee_name, email, salary, joining_date, department_id)
    VALUES
        (102, 'Priya', 'priya@gmail.com', 60000,
         TO_DATE('15-MAR-2023', 'DD-MON-YYYY'), 20)

    INTO employees
        (employee_id, employee_name, email, salary, joining_date, department_id)
    VALUES
        (103, 'Arjun', 'arjun@gmail.com', 55000,
         TO_DATE('20-JUN-2024', 'DD-MON-YYYY'), 10)

    INTO employees
        (employee_id, employee_name, email, salary, joining_date, department_id)
    VALUES
        (104, 'Sneha', 'sneha@gmail.com', 65000,
         TO_DATE('05-FEB-2022', 'DD-MON-YYYY'), 30)

SELECT * FROM dual;


/* =========================================================
   3. INSERT LEAVE BALANCES
   ========================================================= */

INSERT ALL

    INTO leave_balance
        (employee_id, total_leaves, used_leaves)
    VALUES
        (101, 20, 5)

    INTO leave_balance
        (employee_id, total_leaves, used_leaves)
    VALUES
        (102, 20, 8)

    INTO leave_balance
        (employee_id, total_leaves, used_leaves)
    VALUES
        (103, 20, 2)

    INTO leave_balance
        (employee_id, total_leaves, used_leaves)
    VALUES
        (104, 20, 10)

SELECT * FROM dual;


/* =========================================================
   4. INSERT LEAVE REQUESTS
   ========================================================= */

INSERT ALL

    INTO leave_request
        (leave_id, employee_id, start_date, end_date, leave_type, status)
    VALUES
        (1, 101,
         TO_DATE('20-OCT-2026', 'DD-MON-YYYY'),
         TO_DATE('22-OCT-2026', 'DD-MON-YYYY'),
         'SICK', 'APPROVED')

    INTO leave_request
        (leave_id, employee_id, start_date, end_date, leave_type, status)
    VALUES
        (2, 102,
         TO_DATE('25-OCT-2026', 'DD-MON-YYYY'),
         TO_DATE('26-OCT-2026', 'DD-MON-YYYY'),
         'CASUAL', 'PENDING')

    INTO leave_request
        (leave_id, employee_id, start_date, end_date, leave_type, status)
    VALUES
        (3, 103,
         TO_DATE('01-NOV-2026', 'DD-MON-YYYY'),
         TO_DATE('03-NOV-2026', 'DD-MON-YYYY'),
         'VACATION', 'PENDING')

    INTO leave_request
        (leave_id, employee_id, start_date, end_date, leave_type, status)
    VALUES
        (4, 104,
         TO_DATE('15-OCT-2026', 'DD-MON-YYYY'),
         TO_DATE('16-OCT-2026', 'DD-MON-YYYY'),
         'CASUAL', 'REJECTED')

SELECT * FROM dual;


/* =========================================================
   SAVE INSERTED DATA
   ========================================================= */

COMMIT;