/* =========================================================
   EMPLOYEE LEAVE MANAGEMENT SYSTEM
   PL/SQL FUNCTIONS
   ========================================================= */


/* =========================================================
   1. GET REMAINING LEAVES
   ========================================================= */

CREATE OR REPLACE FUNCTION get_remaining_leaves
(
    p_employee_id NUMBER
)
RETURN NUMBER
AS
    v_total_leaves NUMBER;
    v_used_leaves NUMBER;

BEGIN

    SELECT total_leaves,
           used_leaves
    INTO   v_total_leaves,
           v_used_leaves
    FROM leave_balance
    WHERE employee_id = p_employee_id;

    RETURN v_total_leaves - v_used_leaves;

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        RETURN NULL;

END;
/


/* =========================================================
   2. GET ANNUAL SALARY
   ========================================================= */

CREATE OR REPLACE FUNCTION get_annual_salary
(
    p_employee_id NUMBER
)
RETURN NUMBER
AS
    v_salary NUMBER;

BEGIN

    SELECT salary
    INTO v_salary
    FROM employees
    WHERE employee_id = p_employee_id;

    RETURN v_salary * 12;

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        RETURN NULL;

END;
/