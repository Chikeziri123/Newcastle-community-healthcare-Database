USE NHS_Newcastle_Clinic;
GO

-- QUERY 1: List all registered patients ordered by surname
SELECT 
    patient_id,
    nhs_number,
    first_name,
    last_name,
    date_of_birth,
    gender,
    postcode,
    registration_date
FROM Patients
WHERE is_active = 1
ORDER BY last_name, first_name;
GO

-- QUERY 2: List all active staff with their department and role
SELECT 
    s.staff_id,
    s.first_name + ' ' + s.last_name AS staff_name,
    s.job_role,
    d.department_name,
    s.email,
    s.hire_date
FROM Staff s
INNER JOIN Departments d ON s.department_id = d.department_id
WHERE s.is_active = 1
ORDER BY d.department_name, s.last_name;
GO

-- QUERY 3: All completed appointments in October 2024 with patient and GP details
SELECT 
    a.appointment_id,
    p.first_name + ' ' + p.last_name AS patient_name,
    s.first_name + ' ' + s.last_name AS clinician,
    s.job_role,
    d.department_name,
    a.appointment_date,
    a.appointment_time,
    a.appointment_type,
    a.status,
    a.booking_method
FROM Appointments a
INNER JOIN Patients p ON a.patient_id = p.patient_id
INNER JOIN Staff s ON a.staff_id = s.staff_id
INNER JOIN Departments d ON a.department_id = d.department_id
WHERE a.status = 'Completed'
    AND a.appointment_date BETWEEN '2024-10-01' AND '2024-10-31'
ORDER BY a.appointment_date, a.appointment_time;
GO

-- QUERY 4: Patients registered with a specific GP (Dr Sarah Mitchell)
SELECT 
    p.patient_id,
    p.nhs_number,
    p.first_name + ' ' + p.last_name AS patient_name,
    p.date_of_birth,
    p.postcode,
    s.first_name + ' ' + s.last_name AS registered_gp
FROM Patients p
INNER JOIN Staff s ON p.registered_gp_id = s.staff_id
WHERE s.first_name = 'Sarah' AND s.last_name = 'Mitchell'
ORDER BY p.last_name;
GO

-- QUERY 5: Appointments booked online vs phone vs in-person
SELECT 
    a.booking_method,
    COUNT(*) AS total_bookings,
    SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN a.status = 'No-Show' THEN 1 ELSE 0 END) AS no_shows,
    SUM(CASE WHEN a.status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled
FROM Appointments a
GROUP BY a.booking_method
ORDER BY total_bookings DESC;
GO

-- ============================================================================
-- QUERY 6: Prescriptions issued with patient, medication, and prescriber details
-- ============================================================================
SELECT 
    pr.prescription_id,
    p.first_name + ' ' + p.last_name AS patient_name,
    m.medication_name,
    pr.dosage,
    pr.frequency,
    pr.duration_days,
    pr.issue_date,
    pr.is_repeat,
    s.first_name + ' ' + s.last_name AS prescribed_by,
    pr.status
FROM Prescriptions pr
INNER JOIN Patients p ON pr.patient_id = p.patient_id
INNER JOIN Medications m ON pr.medication_id = m.medication_id
INNER JOIN Staff s ON pr.staff_id = s.staff_id
ORDER BY pr.issue_date DESC;
GO

-- ============================================================================
-- QUERY 7: All urgent and emergency referrals
-- ============================================================================
SELECT 
    r.referral_id,
    p.first_name + ' ' + p.last_name AS patient_name,
    s.first_name + ' ' + s.last_name AS referring_clinician,
    r.referral_type,
    r.referred_to,
    r.priority,
    r.referral_date,
    r.status,
    r.clinical_notes
FROM Referrals r
INNER JOIN Patients p ON r.patient_id = p.patient_id
INNER JOIN Staff s ON r.referring_staff_id = s.staff_id
WHERE r.priority IN ('Urgent', 'Emergency', 'Two-Week Wait')
ORDER BY 
    CASE r.priority 
        WHEN 'Emergency' THEN 1 
        WHEN 'Urgent' THEN 2 
        WHEN 'Two-Week Wait' THEN 3 
    END,
    r.referral_date;
GO

-- ============================================================================
-- QUERY 8: Room utilisation - how many bookings per room
-- ============================================================================
SELECT 
    cr.room_name,
    cr.room_type,
    cr.floor_number,
    COUNT(rb.booking_id) AS total_bookings,
    SUM(DATEDIFF(MINUTE, rb.start_time, rb.end_time)) AS total_minutes_used
FROM Clinic_Rooms cr
LEFT JOIN Room_Bookings rb ON cr.room_id = rb.room_id
GROUP BY cr.room_name, cr.room_type, cr.floor_number
ORDER BY total_bookings DESC;
GO

-- ============================================================================
-- QUERY 9: Patients with repeat prescriptions and their medications
-- ============================================================================
SELECT 
    p.first_name + ' ' + p.last_name AS patient_name,
    p.nhs_number,
    m.medication_name,
    pr.dosage,
    pr.frequency,
    pr.issue_date,
    pr.status
FROM Prescriptions pr
INNER JOIN Patients p ON pr.patient_id = p.patient_id
INNER JOIN Medications m ON pr.medication_id = m.medication_id
WHERE pr.is_repeat = 1
ORDER BY p.last_name, m.medication_name;
GO

-- ============================================================================
-- QUERY 10: Medical records with diagnosis for a specific patient
-- ============================================================================
SELECT 
    p.first_name + ' ' + p.last_name AS patient_name,
    mr.diagnosis_code,
    mr.diagnosis_desc,
    mr.consultation_notes,
    mr.treatment_plan,
    s.first_name + ' ' + s.last_name AS clinician,
    a.appointment_date,
    mr.follow_up_required,
    mr.follow_up_date
FROM Medical_Records mr
INNER JOIN Patients p ON mr.patient_id = p.patient_id
INNER JOIN Staff s ON mr.staff_id = s.staff_id
INNER JOIN Appointments a ON mr.appointment_id = a.appointment_id
WHERE p.last_name = 'Henderson'
ORDER BY a.appointment_date DESC;
GO



-- QUERY 11: Monthly appointment volumes (Oct-Dec 2024)
SELECT 
    FORMAT(appointment_date, 'yyyy-MM') AS month,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN status = 'No-Show' THEN 1 ELSE 0 END) AS no_shows,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled,
    CAST(SUM(CASE WHEN status = 'No-Show' THEN 1.0 ELSE 0 END) / COUNT(*) * 100 AS DECIMAL(5,2)) AS no_show_rate_pct
FROM Appointments
GROUP BY FORMAT(appointment_date, 'yyyy-MM')
ORDER BY month;
GO

-- ============================================================================
-- QUERY 12: Top prescribing clinicians
-- ============================================================================
SELECT 
    s.first_name + ' ' + s.last_name AS clinician,
    s.job_role,
    d.department_name,
    COUNT(pr.prescription_id) AS total_prescriptions,
    SUM(CASE WHEN pr.is_repeat = 1 THEN 1 ELSE 0 END) AS repeat_prescriptions,
    COUNT(DISTINCT pr.patient_id) AS unique_patients
FROM Staff s
INNER JOIN Prescriptions pr ON s.staff_id = pr.staff_id
INNER JOIN Departments d ON s.department_id = d.department_id
GROUP BY s.first_name, s.last_name, s.job_role, d.department_name
ORDER BY total_prescriptions DESC;
GO

-- ============================================================================
-- QUERY 13: Department workload analysis
-- ============================================================================
SELECT 
    d.department_name,
    COUNT(a.appointment_id) AS total_appointments,
    COUNT(DISTINCT a.patient_id) AS unique_patients,
    COUNT(DISTINCT a.staff_id) AS clinicians_active,
    AVG(a.duration_minutes) AS avg_appointment_duration,
    SUM(a.duration_minutes) AS total_clinical_minutes
FROM Departments d
INNER JOIN Appointments a ON d.department_id = a.department_id
WHERE a.status = 'Completed'
GROUP BY d.department_name
ORDER BY total_appointments DESC;
GO

-- ============================================================================
-- QUERY 14: Most commonly prescribed medications
-- ============================================================================
SELECT 
    m.medication_name,
    m.category,
    COUNT(pr.prescription_id) AS times_prescribed,
    COUNT(DISTINCT pr.patient_id) AS unique_patients,
    SUM(CASE WHEN pr.is_repeat = 1 THEN 1 ELSE 0 END) AS repeat_count
FROM Medications m
INNER JOIN Prescriptions pr ON m.medication_id = pr.medication_id
GROUP BY m.medication_name, m.category
ORDER BY times_prescribed DESC;
GO

-- QUERY 15: Patient age demographics
SELECT 
    CASE 
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) < 18 THEN 'Under 18'
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 18 AND 30 THEN '18-30'
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 31 AND 50 THEN '31-50'
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 51 AND 65 THEN '51-65'
        ELSE 'Over 65'
    END AS age_group,
    COUNT(*) AS patient_count,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Patients) AS DECIMAL(5,2)) AS percentage
FROM Patients
GROUP BY 
    CASE 
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) < 18 THEN 'Under 18'
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 18 AND 30 THEN '18-30'
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 31 AND 50 THEN '31-50'
        WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 51 AND 65 THEN '51-65'
        ELSE 'Over 65'
    END
ORDER BY age_group;
GO



-- QUERY 16: CTE - Patients with the most appointments
WITH PatientAppointments AS (
    SELECT 
        p.patient_id,
        p.first_name + ' ' + p.last_name AS patient_name,
        COUNT(a.appointment_id) AS total_appointments,
        SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed,
        SUM(CASE WHEN a.status = 'No-Show' THEN 1 ELSE 0 END) AS no_shows,
        MIN(a.appointment_date) AS first_appointment,
        MAX(a.appointment_date) AS last_appointment
    FROM Patients p
    INNER JOIN Appointments a ON p.patient_id = a.patient_id
    GROUP BY p.patient_id, p.first_name, p.last_name
)
SELECT 
    patient_name,
    total_appointments,
    completed,
    no_shows,
    first_appointment,
    last_appointment,
    DATEDIFF(DAY, first_appointment, last_appointment) AS days_span
FROM PatientAppointments
ORDER BY total_appointments DESC;
GO

-- QUERY 17: Referral pathway analysis
WITH ReferralSummary AS (
    SELECT 
        r.referral_type,
        r.priority,
        COUNT(*) AS total_referrals,
        SUM(CASE WHEN r.status = 'Completed' THEN 1 ELSE 0 END) AS completed_count,
        SUM(CASE WHEN r.status = 'Pending' THEN 1 ELSE 0 END) AS pending_count,
        SUM(CASE WHEN r.status = 'Accepted' THEN 1 ELSE 0 END) AS accepted_count
    FROM Referrals r
    GROUP BY r.referral_type, r.priority
)
SELECT 
    referral_type,
    priority,
    total_referrals,
    completed_count,
    pending_count,
    accepted_count,
    CAST(completed_count * 100.0 / total_referrals AS DECIMAL(5,2)) AS completion_rate_pct
FROM ReferralSummary
ORDER BY referral_type, priority;
GO

-- QUERY 18: Rank clinicians by appointment volume per department
SELECT 
    s.first_name + ' ' + s.last_name AS clinician,
    s.job_role,
    d.department_name,
    COUNT(a.appointment_id) AS appointment_count,
    RANK() OVER (PARTITION BY d.department_name ORDER BY COUNT(a.appointment_id) DESC) AS dept_rank,
    SUM(COUNT(a.appointment_id)) OVER (PARTITION BY d.department_name) AS dept_total,
    CAST(COUNT(a.appointment_id) * 100.0 / SUM(COUNT(a.appointment_id)) OVER (PARTITION BY d.department_name) AS DECIMAL(5,2)) AS pct_of_dept
FROM Staff s
INNER JOIN Appointments a ON s.staff_id = a.staff_id
INNER JOIN Departments d ON a.department_id = d.department_id
WHERE a.status = 'Completed'
GROUP BY s.first_name, s.last_name, s.job_role, d.department_name
ORDER BY d.department_name, dept_rank;
GO

-- QUERY 19: Window Function - Running total of prescriptions per month
SELECT 
    CONVERT(CHAR(7), pr.issue_date, 126) AS issue_month,
    COUNT(*) AS monthly_prescriptions,
    SUM(COUNT(*)) OVER (ORDER BY CONVERT(CHAR(7), pr.issue_date, 126)) AS running_total,
    AVG(pr.duration_days) AS avg_duration_days
FROM Prescriptions pr
GROUP BY CONVERT(CHAR(7), pr.issue_date, 126)
ORDER BY issue_month;
GO

-- QUERY 20: Window Function - Patient visit frequency with LAG comparison
WITH PatientVisits AS (
    SELECT 
        p.patient_id,
        p.first_name + ' ' + p.last_name AS patient_name,
        a.appointment_date,
        a.appointment_type,
        LAG(a.appointment_date) OVER (PARTITION BY p.patient_id ORDER BY a.appointment_date) AS previous_visit,
        ROW_NUMBER() OVER (PARTITION BY p.patient_id ORDER BY a.appointment_date) AS visit_number
    FROM Patients p
    INNER JOIN Appointments a ON p.patient_id = a.patient_id
    WHERE a.status = 'Completed'
)
SELECT 
    patient_name,
    appointment_date,
    appointment_type,
    previous_visit,
    DATEDIFF(DAY, previous_visit, appointment_date) AS days_between_visits,
    visit_number
FROM PatientVisits
WHERE previous_visit IS NOT NULL
ORDER BY patient_name, appointment_date;
GO



-- VIEW 1: Active Patient Summary - used for reception dashboard
CREATE VIEW vw_ActivePatientSummary AS
SELECT 
    p.patient_id,
    p.nhs_number,
    p.first_name + ' ' + p.last_name AS patient_name,
    p.date_of_birth,
    DATEDIFF(YEAR, p.date_of_birth, GETDATE()) AS age,
    p.gender,
    p.postcode,
    p.phone_number,
    s.first_name + ' ' + s.last_name AS registered_gp,
    p.registration_date,
    (SELECT COUNT(*) FROM Appointments a WHERE a.patient_id = p.patient_id AND a.status = 'Completed') AS total_completed_visits,
    (SELECT MAX(a.appointment_date) FROM Appointments a WHERE a.patient_id = p.patient_id) AS last_appointment_date
FROM Patients p
LEFT JOIN Staff s ON p.registered_gp_id = s.staff_id
WHERE p.is_active = 1;
GO

SELECT * FROM vw_ActivePatientSummary;

-- VIEW 2: Daily Clinic Schedule
CREATE VIEW vw_DailyClinicSchedule AS
SELECT 
    a.appointment_date,
    a.appointment_time,
    a.duration_minutes,
    p.first_name + ' ' + p.last_name AS patient_name,
    p.nhs_number,
    s.first_name + ' ' + s.last_name AS clinician,
    s.job_role,
    d.department_name,
    cr.room_name,
    a.appointment_type,
    a.status,
    a.booking_method,
    a.notes
FROM Appointments a
INNER JOIN Patients p ON a.patient_id = p.patient_id
INNER JOIN Staff s ON a.staff_id = s.staff_id
INNER JOIN Departments d ON a.department_id = d.department_id
LEFT JOIN Clinic_Rooms cr ON a.room_id = cr.room_id;
GO

SELECT * FROM vw_DailyClinicSchedule;

-- VIEW 3: Prescription Dashboard
CREATE VIEW vw_PrescriptionDashboard AS
SELECT 
    pr.prescription_id,
    p.nhs_number,
    p.first_name + ' ' + p.last_name AS patient_name,
    m.medication_name,
    m.category AS medication_category,
    pr.dosage,
    pr.frequency,
    pr.duration_days,
    pr.issue_date,
    pr.is_repeat,
    pr.status,
    s.first_name + ' ' + s.last_name AS prescribed_by,
    d.department_name,
    pr.pharmacy_notes
FROM Prescriptions pr
INNER JOIN Patients p ON pr.patient_id = p.patient_id
INNER JOIN Medications m ON pr.medication_id = m.medication_id
INNER JOIN Staff s ON pr.staff_id = s.staff_id
INNER JOIN Departments d ON s.department_id = d.department_id;
GO

SELECT * FROM vw_PrescriptionDashboard;

-- VIEW 4: Referral Tracking Dashboard
CREATE VIEW vw_ReferralTracking AS
SELECT 
    r.referral_id,
    p.nhs_number,
    p.first_name + ' ' + p.last_name AS patient_name,
    s.first_name + ' ' + s.last_name AS referring_clinician,
    r.referral_type,
    r.referred_to,
    r.priority,
    r.referral_date,
    r.status,
    DATEDIFF(DAY, r.referral_date, GETDATE()) AS days_since_referral,
    r.clinical_notes,
    r.outcome
FROM Referrals r
INNER JOIN Patients p ON r.patient_id = p.patient_id
INNER JOIN Staff s ON r.referring_staff_id = s.staff_id;
GO

SELECT * FROM vw_ReferralTracking;

-- Test the views
SELECT * FROM vw_ActivePatientSummary ORDER BY patient_name;
SELECT * FROM vw_DailyClinicSchedule WHERE appointment_date = '2024-10-01' ORDER BY appointment_time;
SELECT * FROM vw_PrescriptionDashboard WHERE is_repeat = 1 ORDER BY issue_date DESC;
SELECT * FROM vw_ReferralTracking WHERE status = 'Pending' ORDER BY referral_date;
GO


-- STORED PROCEDURES
USE NHS_Newcastle_Clinic
GO

-- ============================================================================
-- SP 1: Register a new patient
-- ============================================================================
CREATE PROCEDURE sp_RegisterPatient
    @nhs_number VARCHAR(10),
    @first_name VARCHAR(50),
    @last_name VARCHAR(50),
    @date_of_birth DATE,
    @gender VARCHAR(20),
    @address_line1 VARCHAR(100),
    @address_line2 VARCHAR(100) = NULL,
    @city VARCHAR(50) = 'Newcastle upon Tyne',
    @postcode VARCHAR(10),
    @phone_number VARCHAR(20),
    @email VARCHAR(100) = NULL,
    @emergency_contact VARCHAR(100) = NULL,
    @emergency_phone VARCHAR(20) = NULL,
    @registered_gp_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON

    IF EXISTS (SELECT 1 FROM Patients WHERE nhs_number = @nhs_number)
    BEGIN
        RAISERROR('Patient with this NHS number already exists.', 16, 1)
        RETURN
    END

    IF @registered_gp_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Staff WHERE staff_id = @registered_gp_id AND job_role = 'GP')
    BEGIN
        RAISERROR('Invalid GP ID. Staff member does not exist or is not a GP.', 16, 1)
        RETURN
    END

    INSERT INTO Patients (nhs_number, first_name, last_name, date_of_birth, gender, 
                          address_line1, address_line2, city, postcode, phone_number, 
                          email, emergency_contact, emergency_phone, registered_gp_id)
    VALUES (@nhs_number, @first_name, @last_name, @date_of_birth, @gender,
            @address_line1, @address_line2, @city, @postcode, @phone_number,
            @email, @emergency_contact, @emergency_phone, @registered_gp_id)

    INSERT INTO Audit_Log (table_name, record_id, action_type, action_description)
    VALUES ('Patients', SCOPE_IDENTITY(), 'INSERT', 
            'New patient registered: ' + @first_name + ' ' + @last_name + ' (NHS: ' + @nhs_number + ')')

    PRINT 'Patient registered successfully: ' + @first_name + ' ' + @last_name
END
GO

============================================================================
-- SP 2: Book an appointment
-- ============================================================================
CREATE PROCEDURE sp_BookAppointment
    @patient_id INT,
    @staff_id INT,
    @department_id INT,
    @room_id INT = NULL,
    @appointment_date DATE,
    @appointment_time TIME,
    @duration_minutes INT = 15,
    @appointment_type VARCHAR(50),
    @booking_method VARCHAR(20) = 'Online',
    @notes VARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS (SELECT 1 FROM Patients WHERE patient_id = @patient_id AND is_active = 1)
    BEGIN
        RAISERROR('Patient not found or is inactive.', 16, 1)
        RETURN
    END

    IF EXISTS (
        SELECT 1 FROM Appointments 
        WHERE staff_id = @staff_id 
        AND appointment_date = @appointment_date 
        AND appointment_time = @appointment_time
        AND status NOT IN ('Cancelled')
    )
    BEGIN
        RAISERROR('Clinician already has an appointment at this date and time.', 16, 1)
        RETURN
    END

    IF @room_id IS NOT NULL AND EXISTS (
        SELECT 1 FROM Room_Bookings 
        WHERE room_id = @room_id 
        AND booking_date = @appointment_date
        AND @appointment_time BETWEEN start_time AND end_time
        AND status = 'Confirmed'
    )
    BEGIN
        RAISERROR('Room is already booked at this date and time.', 16, 1)
        RETURN
    END

    INSERT INTO Appointments (patient_id, staff_id, department_id, room_id, appointment_date, 
                              appointment_time, duration_minutes, appointment_type, booking_method, notes)
    VALUES (@patient_id, @staff_id, @department_id, @room_id, @appointment_date,
            @appointment_time, @duration_minutes, @appointment_type, @booking_method, @notes)

    DECLARE @appt_id INT
    SET @appt_id = SCOPE_IDENTITY()

    IF @room_id IS NOT NULL
    BEGIN
        INSERT INTO Room_Bookings (room_id, appointment_id, staff_id, booking_date, start_time, 
                                    end_time, purpose)
        VALUES (@room_id, @appt_id, @staff_id, @appointment_date, @appointment_time,
                DATEADD(MINUTE, @duration_minutes, CAST(@appointment_time AS DATETIME)), 'Patient Consultation')
    END

    INSERT INTO Audit_Log (table_name, record_id, action_type, action_description)
    VALUES ('Appointments', @appt_id, 'INSERT', 
            'Appointment booked for patient ID ' + CAST(@patient_id AS VARCHAR) + 
            ' with staff ID ' + CAST(@staff_id AS VARCHAR) + 
            ' on ' + CAST(@appointment_date AS VARCHAR))

    PRINT 'Appointment booked successfully. Appointment ID: ' + CAST(@appt_id AS VARCHAR)
END
GO

-- ============================================================================
-- SP 3: Update appointment status (complete, cancel, no-show)
-- ============================================================================
CREATE PROCEDURE sp_UpdateAppointmentStatus
    @appointment_id INT,
    @new_status VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @old_status VARCHAR(20)

    SELECT @old_status = status FROM Appointments WHERE appointment_id = @appointment_id

    IF @old_status IS NULL
    BEGIN
        RAISERROR('Appointment not found.', 16, 1)
        RETURN
    END

    UPDATE Appointments 
    SET status = @new_status, updated_date = GETDATE()
    WHERE appointment_id = @appointment_id

    IF @new_status = 'Cancelled'
    BEGIN
        UPDATE Room_Bookings 
        SET status = 'Cancelled'
        WHERE appointment_id = @appointment_id
    END

    IF @new_status = 'Completed'
    BEGIN
        UPDATE Room_Bookings 
        SET status = 'Completed'
        WHERE appointment_id = @appointment_id
    END

    INSERT INTO Audit_Log (table_name, record_id, action_type, action_description)
    VALUES ('Appointments', @appointment_id, 'UPDATE', 
            'Status changed from ' + @old_status + ' to ' + @new_status)

    PRINT 'Appointment ' + CAST(@appointment_id AS VARCHAR) + ' updated to: ' + @new_status
END
GO

-- ============================================================================
-- SP 4: Issue a prescription
-- ============================================================================
CREATE PROCEDURE sp_IssuePrescription
    @patient_id INT,
    @staff_id INT,
    @appointment_id INT = NULL,
    @medication_id INT,
    @dosage VARCHAR(100),
    @frequency VARCHAR(50),
    @duration_days INT,
    @quantity INT,
    @is_repeat BIT = 0,
    @pharmacy_notes VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS (SELECT 1 FROM Patients WHERE patient_id = @patient_id AND is_active = 1)
    BEGIN
        RAISERROR('Patient not found or inactive.', 16, 1)
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Medications WHERE medication_id = @medication_id)
    BEGIN
        RAISERROR('Medication not found in formulary.', 16, 1)
        RETURN
    END

    DECLARE @is_controlled BIT
    SELECT @is_controlled = is_controlled FROM Medications WHERE medication_id = @medication_id

    IF @is_controlled = 1
    BEGIN
        PRINT 'WARNING: This is a controlled medication. Additional verification may be required.'
    END

    INSERT INTO Prescriptions (patient_id, staff_id, appointment_id, medication_id, dosage, 
                               frequency, duration_days, quantity, is_repeat, pharmacy_notes)
    VALUES (@patient_id, @staff_id, @appointment_id, @medication_id, @dosage,
            @frequency, @duration_days, @quantity, @is_repeat, @pharmacy_notes)

    INSERT INTO Audit_Log (table_name, record_id, action_type, action_description)
    VALUES ('Prescriptions', SCOPE_IDENTITY(), 'INSERT',
            'Prescription issued for patient ID ' + CAST(@patient_id AS VARCHAR) + 
            ' - Medication ID ' + CAST(@medication_id AS VARCHAR))

    PRINT 'Prescription issued successfully.'
END
GO

-- ============================================================================
-- SP 5: Generate clinic performance report for a given month
-- ============================================================================
CREATE PROCEDURE sp_MonthlyClinicReport
    @report_year INT,
    @report_month INT
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @start_date DATE
    DECLARE @end_date DATE
    SET @start_date = DATEFROMPARTS(@report_year, @report_month, 1)
    SET @end_date = EOMONTH(@start_date)

    PRINT '============================================'
    PRINT 'MONTHLY CLINIC REPORT'
    PRINT 'Period: ' + CAST(@start_date AS VARCHAR) + ' to ' + CAST(@end_date AS VARCHAR)
    PRINT '============================================'
    PRINT ''

    -- Appointment Summary
    PRINT '--- APPOINTMENT SUMMARY ---'
    SELECT 
        COUNT(*) AS total_appointments,
        SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed,
        SUM(CASE WHEN status = 'No-Show' THEN 1 ELSE 0 END) AS no_shows,
        SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled,
        CAST(SUM(CASE WHEN status = 'No-Show' THEN 1.0 ELSE 0 END) / NULLIF(COUNT(*), 0) * 100 AS DECIMAL(5,2)) AS no_show_rate_pct,
        COUNT(DISTINCT patient_id) AS unique_patients,
        COUNT(DISTINCT staff_id) AS active_clinicians
    FROM Appointments
    WHERE appointment_date BETWEEN @start_date AND @end_date

    -- Department Breakdown
    PRINT '--- DEPARTMENT BREAKDOWN ---'
    SELECT 
        d.department_name,
        COUNT(a.appointment_id) AS appointments,
        AVG(a.duration_minutes) AS avg_duration
    FROM Departments d
    LEFT JOIN Appointments a ON d.department_id = a.department_id 
        AND a.appointment_date BETWEEN @start_date AND @end_date
    GROUP BY d.department_name
    HAVING COUNT(a.appointment_id) > 0
    ORDER BY appointments DESC

    -- Prescription Summary
    PRINT '--- PRESCRIPTION SUMMARY ---'
    SELECT 
        COUNT(*) AS total_prescriptions,
        SUM(CASE WHEN is_repeat = 1 THEN 1 ELSE 0 END) AS repeat_prescriptions,
        COUNT(DISTINCT patient_id) AS patients_prescribed
    FROM Prescriptions
    WHERE issue_date BETWEEN @start_date AND @end_date

    -- Referral Summary
    PRINT '--- REFERRAL SUMMARY ---'
    SELECT 
        priority,
        COUNT(*) AS total_referrals,
        SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed
    FROM Referrals
    WHERE referral_date BETWEEN @start_date AND @end_date
    GROUP BY priority

    PRINT ''
    PRINT '============================================'
    PRINT 'END OF REPORT'
    PRINT '============================================'
END
GO



-- TRIGGER 1: Audit patient record updates
CREATE TRIGGER trg_AuditPatientUpdate
ON Patients
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Audit_Log (table_name, record_id, action_type, action_description)
    SELECT 
        'Patients',
        i.patient_id,
        'UPDATE',
        'Patient record updated for: ' + i.first_name + ' ' + i.last_name + ' (NHS: ' + i.nhs_number + ')'
    FROM inserted i;
    
    -- Auto-set updated_date
    UPDATE p
    SET updated_date = GETDATE()
    FROM Patients p
    INNER JOIN inserted i ON p.patient_id = i.patient_id;
END;
GO

-- TRIGGER 2: Audit appointment status changes
CREATE TRIGGER trg_AuditAppointmentUpdate
ON Appointments
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Audit_Log (table_name, record_id, action_type, action_description)
    SELECT 
        'Appointments',
        i.appointment_id,
        'UPDATE',
        'Appointment updated. Status: ' + d.status + ' -> ' + i.status + 
        ' for patient ID ' + CAST(i.patient_id AS VARCHAR)
    FROM inserted i
    INNER JOIN deleted d ON i.appointment_id = d.appointment_id
    WHERE i.status <> d.status;
END;
GO

-- TRIGGER 3: Log new referrals for compliance tracking
CREATE TRIGGER trg_AuditNewReferral
ON Referrals
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Audit_Log (table_name, record_id, action_type, action_description)
    SELECT 
        'Referrals',
        i.referral_id,
        'INSERT',
        'New ' + i.priority + ' ' + i.referral_type + ' referral created for patient ID ' + 
        CAST(i.patient_id AS VARCHAR) + ' to ' + i.referred_to
    FROM inserted i;
END;
GO


-- UPDATE 1: Update a patient's phone number
UPDATE Patients 
SET phone_number = '07799887766'
WHERE patient_id = 1;
GO

-- UPDATE 2: Cancel a scheduled appointment
UPDATE Appointments 
SET status = 'Cancelled', updated_date = GETDATE(), notes = 'Patient requested cancellation'
WHERE appointment_id = 48;
GO

-- UPDATE 3: Mark prescription as dispensed
UPDATE Prescriptions 
SET status = 'Dispensed'
WHERE prescription_id = 17 AND status = 'Active';
GO

-- DELETE: Remove a test room booking (with safety check)
-- Demonstrating safe deletion with EXISTS check
IF EXISTS (SELECT 1 FROM Room_Bookings WHERE booking_id = 22 AND status = 'Cancelled')
BEGIN
    DELETE FROM Room_Bookings WHERE booking_id = 22;
    PRINT 'Cancelled room booking removed.';
END
ELSE
BEGIN
    PRINT 'Booking not found or not in Cancelled status. No deletion performed.';
END;
GO


-- EXECUTE STORED PROCEDURES (Testing)

-- Test: Register a new patient
EXEC sp_RegisterPatient 
    @nhs_number = '1234567821',
    @first_name = 'Khadija',
    @last_name = 'Adebayo',
    @date_of_birth = '1991-06-15',
    @gender = 'Female',
    @address_line1 = '17 Dean Street',
    @city = 'Newcastle upon Tyne',
    @postcode = 'NE1 1PG',
    @phone_number = '07712345021',
    @email = 'khadija.a@email.com',
    @emergency_contact = 'Yusuf Adebayo',
    @emergency_phone = '07798765021',
    @registered_gp_id = 1;
GO

-- Test: Book an appointment
EXEC sp_BookAppointment 
    @patient_id = 1,
    @staff_id = 1,
    @department_id = 1,
    @room_id = 1,
    @appointment_date = '2024-12-20',
    @appointment_time = '09:00',
    @duration_minutes = 15,
    @appointment_type = 'Follow-Up',
    @booking_method = 'Online',
    @notes = 'Follow-up on respiratory results';
GO

-- Test: Generate October 2024 monthly report
EXEC sp_MonthlyClinicReport @report_year = 2024, @report_month = 10;
GO

-- View audit log
SELECT * FROM Audit_Log ORDER BY action_date DESC;
GO
