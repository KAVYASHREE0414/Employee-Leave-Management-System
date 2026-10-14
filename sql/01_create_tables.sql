/* =========================================================
   EMPLOYEE LEAVE MANAGEMENT SYSTEM
   TABLE CREATION
   ========================================================= */


/* =========================================================
   1. DEPARTMENTS TABLE
   ========================================================= */

CREATE TABLE departments
(
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(50) NOT NULL
);


/* =========================================================
   2. EMPLOYEES TABLE
   ========================================================= */

CREATE TABLE employees
(
    employee_id NUMBER PRIMARY KEY,
    employee_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    salary NUMBER(10,2) CHECK (salary > 0),
    joining_date DATE NOT NULL,
    department_id NUMBER,

    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);


/* =========================================================
   3. LEAVE BALANCE TABLE
   ========================================================= */

CREATE TABLE leave_balance
(
    employee_id NUMBER PRIMARY KEY,
    total_leaves NUMBER NOT NULL,
    used_leaves NUMBER DEFAULT 0,

    CONSTRAINT fk_balance_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),

    CONSTRAINT chk_total_leaves
        CHECK (total_leaves >= 0),

    CONSTRAINT chk_used_leaves
        CHECK (used_leaves >= 0),

    CONSTRAINT chk_leave_balance
        CHECK (used_leaves <= total_leaves)
);


/* =========================================================
   4. LEAVE REQUEST TABLE
   ========================================================= */

CREATE TABLE leave_request
(
    leave_id NUMBER PRIMARY KEY,
    employee_id NUMBER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    leave_type VARCHAR2(30) NOT NULL,
    status VARCHAR2(20) DEFAULT 'PENDING',

    CONSTRAINT fk_leave_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),

    CONSTRAINT chk_leave_dates
        CHECK (end_date >= start_date),

    CONSTRAINT chk_leave_status
        CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED'))
);