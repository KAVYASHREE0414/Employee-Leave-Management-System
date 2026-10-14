/* =========================================================
   EMPLOYEE LEAVE MANAGEMENT SYSTEM
   PL/SQL PROCEDURES
   ========================================================= */


/* =========================================================
   1. UPDATE EMPLOYEE SALARY
   ========================================================= */

CREATE OR REPLACE PROCEDURE update_salary
(
    p_employee_id NUMBER,
    p_new_salary NUMBER
)
AS
BEGIN

    UPDATE employees
    SET salary = p_new_salary
    WHERE employee_id = p_employee_id;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('EMPLOYEE NOT FOUND');
    ELSE
        DBMS_OUTPUT.PUT_LINE('SALARY UPDATED SUCCESSFULLY');
    END IF;

END;
/


/* =========================================================
   2. APPLY FOR LEAVE
   ========================================================= */

CREATE OR REPLACE PROCEDURE apply_leave
(
    p_leave_id NUMBER,
    p_employee_id NUMBER,
    p_start_date DATE,
    p_end_date DATE,
    p_leave_type VARCHAR2
)
AS
BEGIN

    INSERT INTO leave_request
    (
        leave_id,
        employee_id,
        start_date,
        end_date,
        leave_type
    )
    VALUES
    (
        p_leave_id,
        p_employee_id,
        p_start_date,
        p_end_date,
        p_leave_type
    );

    DBMS_OUTPUT.PUT_LINE('LEAVE REQUEST SUBMITTED SUCCESSFULLY');

EXCEPTION

    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('LEAVE ID ALREADY EXISTS');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR APPLYING FOR LEAVE');

END;
/


/* =========================================================
   3. APPROVE LEAVE
   ========================================================= */

CREATE OR REPLACE PROCEDURE approve_leave
(
    p_leave_id NUMBER
)
AS

    v_employee_id NUMBER;
    v_start_date DATE;
    v_end_date DATE;
    v_leave_days NUMBER;

    v_total_leaves NUMBER;
    v_used_leaves NUMBER;

    v_status VARCHAR2(20);

BEGIN

    /* -----------------------------------------------------
       Get employee, leave dates and current leave status
       ----------------------------------------------------- */

    SELECT employee_id,
           start_date,
           end_date,
           status
    INTO   v_employee_id,
           v_start_date,
           v_end_date,
           v_status
    FROM leave_request
    WHERE leave_id = p_leave_id;


    /* -----------------------------------------------------
       Calculate number of requested leave days
       +1 includes both start date and end date
       ----------------------------------------------------- */

    v_leave_days := v_end_date - v_start_date + 1;


    /* -----------------------------------------------------
       Get employee leave balance
       ----------------------------------------------------- */

    SELECT total_leaves,
           used_leaves
    INTO   v_total_leaves,
           v_used_leaves
    FROM leave_balance
    WHERE employee_id = v_employee_id;


    /* -----------------------------------------------------
       Check leave request status first
       ----------------------------------------------------- */

    IF v_status <> 'PENDING' THEN

        DBMS_OUTPUT.PUT_LINE(
            'LEAVE REQUEST ALREADY PROCESSED'
        );


    /* -----------------------------------------------------
       Check whether sufficient leave balance exists
       ----------------------------------------------------- */

    ELSIF (v_total_leaves - v_used_leaves) >= v_leave_days THEN


        /* Approve leave request */

        UPDATE leave_request
        SET status = 'APPROVED'
        WHERE leave_id = p_leave_id;


        /* Update employee used leaves */

        UPDATE leave_balance
        SET used_leaves = used_leaves + v_leave_days
        WHERE employee_id = v_employee_id;


        DBMS_OUTPUT.PUT_LINE(
            'LEAVE APPROVED SUCCESSFULLY'
        );


    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'INSUFFICIENT LEAVE BALANCE'
        );

    END IF;


EXCEPTION

    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE(
            'LEAVE REQUEST OR LEAVE BALANCE NOT FOUND'
        );

END;
/


/* =========================================================
   4. REJECT LEAVE
   ========================================================= */

CREATE OR REPLACE PROCEDURE reject_leave
(
    p_leave_id NUMBER
)
AS

    v_status VARCHAR2(20);

BEGIN

    /* Get current leave status */

    SELECT status
    INTO v_status
    FROM leave_request
    WHERE leave_id = p_leave_id;


    /* Only pending requests can be rejected */

    IF v_status <> 'PENDING' THEN

        DBMS_OUTPUT.PUT_LINE(
            'LEAVE REQUEST ALREADY PROCESSED'
        );

    ELSE

        UPDATE leave_request
        SET status = 'REJECTED'
        WHERE leave_id = p_leave_id;

        DBMS_OUTPUT.PUT_LINE(
            'LEAVE REQUEST REJECTED SUCCESSFULLY'
        );

    END IF;


EXCEPTION

    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE(
            'LEAVE REQUEST NOT FOUND'
        );

END;
/