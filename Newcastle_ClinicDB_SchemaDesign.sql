-- Create the database
CREATE DATABASE NHS_Newcastle_Clinic;
GO

USE NHS_Newcastle_Clinic;
GO

-- TABLE 1: Departments
-- Stores the various departments within the community clinic

CREATE TABLE Departments (
    department_id       INT IDENTITY(1,1) PRIMARY KEY,
    department_name     VARCHAR(100) NOT NULL UNIQUE,
    department_head     VARCHAR(100) NULL,
    phone_extension     VARCHAR(10) NULL,
    floor_number        TINYINT NOT NULL DEFAULT 1,
    is_active           BIT NOT NULL DEFAULT 1,
    created_date        DATETIME NOT NULL DEFAULT GETDATE(),
    updated_date        DATETIME NULL
);
GO


-- TABLE 2: Staff
-- Stores information about all clinic staff (GPs, nurses, admin, specialists)

CREATE TABLE Staff (
    staff_id            INT IDENTITY(1,1) PRIMARY KEY,
    first_name          VARCHAR(50) NOT NULL,
    last_name           VARCHAR(50) NOT NULL,
    job_role            VARCHAR(50) NOT NULL 
                        CHECK (job_role IN ('GP', 'Nurse', 'Specialist', 'Admin', 'Pharmacist', 'Receptionist')),
    department_id       INT NOT NULL,
    email               VARCHAR(100) NOT NULL UNIQUE,
    phone_number        VARCHAR(20) NULL,
    hire_date           DATE NOT NULL,
    is_active           BIT NOT NULL DEFAULT 1,
    created_date        DATETIME NOT NULL DEFAULT GETDATE(),
    updated_date        DATETIME NULL,
    CONSTRAINT FK_Staff_Department FOREIGN KEY (department_id) 
        REFERENCES Departments(department_id)
);
GO

-- Index on staff job_role for filtering queries
CREATE NONCLUSTERED INDEX IX_Staff_JobRole ON Staff(job_role);
CREATE NONCLUSTERED INDEX IX_Staff_Department ON Staff(department_id);
GO


-- TABLE 3: Patients
-- Stores patient demographics and registration details

CREATE TABLE Patients (
    patient_id          INT IDENTITY(1,1) PRIMARY KEY,
    nhs_number          VARCHAR(10) NOT NULL UNIQUE,
    first_name          VARCHAR(50) NOT NULL,
    last_name           VARCHAR(50) NOT NULL,
    date_of_birth       DATE NOT NULL,
    gender              VARCHAR(20) NOT NULL 
                        CHECK (gender IN ('Male', 'Female', 'Non-Binary', 'Prefer Not to Say')),
    address_line1       VARCHAR(100) NOT NULL,
    address_line2       VARCHAR(100) NULL,
    city                VARCHAR(50) NOT NULL DEFAULT 'Newcastle upon Tyne',
    postcode            VARCHAR(10) NOT NULL,
    phone_number        VARCHAR(20) NOT NULL,
    email               VARCHAR(100) NULL,
    emergency_contact   VARCHAR(100) NULL,
    emergency_phone     VARCHAR(20) NULL,
    registered_gp_id    INT NULL,
    registration_date   DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    is_active           BIT NOT NULL DEFAULT 1,
    created_date        DATETIME NOT NULL DEFAULT GETDATE(),
    updated_date        DATETIME NULL,
    CONSTRAINT FK_Patient_GP FOREIGN KEY (registered_gp_id) 
        REFERENCES Staff(staff_id),
    CONSTRAINT CK_Patient_DOB CHECK (date_of_birth <= CAST(GETDATE() AS DATE)),
    CONSTRAINT CK_Patient_NHS CHECK (LEN(nhs_number) = 10)
);
GO

-- Indexes for common search patterns
CREATE NONCLUSTERED INDEX IX_Patient_LastName ON Patients(last_name, first_name);
CREATE NONCLUSTERED INDEX IX_Patient_Postcode ON Patients(postcode);
CREATE NONCLUSTERED INDEX IX_Patient_GP ON Patients(registered_gp_id);
GO


-- TABLE 4: Clinic_Rooms
-- Stores details of physical rooms available in the clinic

CREATE TABLE Clinic_Rooms (
    room_id             INT IDENTITY(1,1) PRIMARY KEY,
    room_name           VARCHAR(50) NOT NULL UNIQUE,
    room_type           VARCHAR(50) NOT NULL 
                        CHECK (room_type IN ('Consultation', 'Treatment', 'Examination', 'Meeting', 'Pharmacy', 'Reception')),
    floor_number        TINYINT NOT NULL DEFAULT 1,
    capacity            INT NOT NULL DEFAULT 1,
    has_equipment       BIT NOT NULL DEFAULT 0,
    equipment_details   VARCHAR(255) NULL,
    is_available        BIT NOT NULL DEFAULT 1,
    created_date        DATETIME NOT NULL DEFAULT GETDATE()
);
GO


-- TABLE 5: Appointments
-- Records all patient appointments with staff members

CREATE TABLE Appointments (
    appointment_id      INT IDENTITY(1,1) PRIMARY KEY,
    patient_id          INT NOT NULL,
    staff_id            INT NOT NULL,
    department_id       INT NOT NULL,
    room_id             INT NULL,
    appointment_date    DATE NOT NULL,
    appointment_time    TIME NOT NULL,
    duration_minutes    INT NOT NULL DEFAULT 15 
                        CHECK (duration_minutes BETWEEN 5 AND 120),
    appointment_type    VARCHAR(50) NOT NULL 
                        CHECK (appointment_type IN ('Routine', 'Urgent', 'Follow-Up', 'Telephone', 'Home Visit', 'Walk-In')),
    status              VARCHAR(20) NOT NULL DEFAULT 'Scheduled' 
                        CHECK (status IN ('Scheduled', 'Completed', 'Cancelled', 'No-Show', 'In Progress')),
    booking_method      VARCHAR(20) NOT NULL DEFAULT 'Online' 
                        CHECK (booking_method IN ('Online', 'Phone', 'In-Person', 'Referral')),
    notes               VARCHAR(500) NULL,
    created_date        DATETIME NOT NULL DEFAULT GETDATE(),
    updated_date        DATETIME NULL,
    CONSTRAINT FK_Appt_Patient FOREIGN KEY (patient_id) 
        REFERENCES Patients(patient_id),
    CONSTRAINT FK_Appt_Staff FOREIGN KEY (staff_id) 
        REFERENCES Staff(staff_id),
    CONSTRAINT FK_Appt_Department FOREIGN KEY (department_id) 
        REFERENCES Departments(department_id),
    CONSTRAINT FK_Appt_Room FOREIGN KEY (room_id) 
        REFERENCES Clinic_Rooms(room_id)
);
GO

-- Indexes for appointment queries
CREATE NONCLUSTERED INDEX IX_Appt_Date ON Appointments(appointment_date);
CREATE NONCLUSTERED INDEX IX_Appt_Patient ON Appointments(patient_id);
CREATE NONCLUSTERED INDEX IX_Appt_Staff ON Appointments(staff_id);
CREATE NONCLUSTERED INDEX IX_Appt_Status ON Appointments(status);
GO


-- TABLE 6: Medications
-- Reference table for all medications available at the clinic pharmacy

CREATE TABLE Medications (
    medication_id       INT IDENTITY(1,1) PRIMARY KEY,
    medication_name     VARCHAR(100) NOT NULL,
    generic_name        VARCHAR(100) NULL,
    category            VARCHAR(50) NOT NULL 
                        CHECK (category IN ('Analgesic', 'Antibiotic', 'Antidepressant', 'Antihypertensive', 
                               'Inhaler', 'Statin', 'Antihistamine', 'Proton Pump Inhibitor', 'Other')),
    dosage_form         VARCHAR(50) NOT NULL 
                        CHECK (dosage_form IN ('Tablet', 'Capsule', 'Liquid', 'Inhaler', 'Injection', 'Cream', 'Patch')),
    standard_dosage     VARCHAR(100) NOT NULL,
    requires_review     BIT NOT NULL DEFAULT 0,
    is_controlled       BIT NOT NULL DEFAULT 0,
    created_date        DATETIME NOT NULL DEFAULT GETDATE()
);
GO


-- TABLE 7: Prescriptions
-- Records prescriptions issued to patients

CREATE TABLE Prescriptions (
    prescription_id     INT IDENTITY(1,1) PRIMARY KEY,
    patient_id          INT NOT NULL,
    staff_id            INT NOT NULL,
    appointment_id      INT NULL,
    medication_id       INT NOT NULL,
    dosage              VARCHAR(100) NOT NULL,
    frequency           VARCHAR(50) NOT NULL,
    duration_days       INT NOT NULL CHECK (duration_days > 0),
    quantity            INT NOT NULL CHECK (quantity > 0),
    issue_date          DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    is_repeat           BIT NOT NULL DEFAULT 0,
    status              VARCHAR(20) NOT NULL DEFAULT 'Active' 
                        CHECK (status IN ('Active', 'Dispensed', 'Expired', 'Cancelled')),
    pharmacy_notes      VARCHAR(255) NULL,
    created_date        DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Presc_Patient FOREIGN KEY (patient_id) 
        REFERENCES Patients(patient_id),
    CONSTRAINT FK_Presc_Staff FOREIGN KEY (staff_id) 
        REFERENCES Staff(staff_id),
    CONSTRAINT FK_Presc_Appt FOREIGN KEY (appointment_id) 
        REFERENCES Appointments(appointment_id),
    CONSTRAINT FK_Presc_Med FOREIGN KEY (medication_id) 
        REFERENCES Medications(medication_id)
);
GO

CREATE NONCLUSTERED INDEX IX_Presc_Patient ON Prescriptions(patient_id);
CREATE NONCLUSTERED INDEX IX_Presc_IssueDate ON Prescriptions(issue_date);
GO


-- TABLE 8: Referrals
-- Tracks patient referrals to specialists or external services

CREATE TABLE Referrals (
    referral_id         INT IDENTITY(1,1) PRIMARY KEY,
    patient_id          INT NOT NULL,
    referring_staff_id  INT NOT NULL,
    appointment_id      INT NULL,
    referral_type       VARCHAR(50) NOT NULL 
                        CHECK (referral_type IN ('Internal', 'External', 'Emergency', 'Diagnostic')),
    referred_to         VARCHAR(100) NOT NULL,
    department_id       INT NULL,
    priority            VARCHAR(20) NOT NULL DEFAULT 'Routine' 
                        CHECK (priority IN ('Urgent', 'Routine', 'Two-Week Wait', 'Emergency')),
    referral_date       DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    status              VARCHAR(20) NOT NULL DEFAULT 'Pending' 
                        CHECK (status IN ('Pending', 'Accepted', 'Completed', 'Rejected', 'Cancelled')),
    clinical_notes      VARCHAR(500) NULL,
    outcome             VARCHAR(255) NULL,
    created_date        DATETIME NOT NULL DEFAULT GETDATE(),
    updated_date        DATETIME NULL,
    CONSTRAINT FK_Ref_Patient FOREIGN KEY (patient_id) 
        REFERENCES Patients(patient_id),
    CONSTRAINT FK_Ref_Staff FOREIGN KEY (referring_staff_id) 
        REFERENCES Staff(staff_id),
    CONSTRAINT FK_Ref_Appt FOREIGN KEY (appointment_id) 
        REFERENCES Appointments(appointment_id),
    CONSTRAINT FK_Ref_Dept FOREIGN KEY (department_id) 
        REFERENCES Departments(department_id)
);
GO

CREATE NONCLUSTERED INDEX IX_Ref_Patient ON Referrals(patient_id);
CREATE NONCLUSTERED INDEX IX_Ref_Status ON Referrals(status);
CREATE NONCLUSTERED INDEX IX_Ref_Priority ON Referrals(priority);
GO


-- TABLE 9: Medical_Records
-- Stores consultation notes and diagnoses linked to appointments

CREATE TABLE Medical_Records (
    record_id           INT IDENTITY(1,1) PRIMARY KEY,
    patient_id          INT NOT NULL,
    appointment_id      INT NOT NULL,
    staff_id            INT NOT NULL,
    diagnosis_code      VARCHAR(10) NULL,
    diagnosis_desc      VARCHAR(255) NULL,
    consultation_notes  VARCHAR(1000) NOT NULL,
    treatment_plan      VARCHAR(500) NULL,
    follow_up_required  BIT NOT NULL DEFAULT 0,
    follow_up_date      DATE NULL,
    created_date        DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_MedRec_Patient FOREIGN KEY (patient_id) 
        REFERENCES Patients(patient_id),
    CONSTRAINT FK_MedRec_Appt FOREIGN KEY (appointment_id) 
        REFERENCES Appointments(appointment_id),
    CONSTRAINT FK_MedRec_Staff FOREIGN KEY (staff_id) 
        REFERENCES Staff(staff_id)
);
GO

CREATE NONCLUSTERED INDEX IX_MedRec_Patient ON Medical_Records(patient_id);
CREATE NONCLUSTERED INDEX IX_MedRec_Diagnosis ON Medical_Records(diagnosis_code);
GO


-- TABLE 10: Room_Bookings
-- Tracks room allocations for appointments and other activities

CREATE TABLE Room_Bookings (
    booking_id          INT IDENTITY(1,1) PRIMARY KEY,
    room_id             INT NOT NULL,
    appointment_id      INT NULL,
    staff_id            INT NOT NULL,
    booking_date        DATE NOT NULL,
    start_time          TIME NOT NULL,
    end_time            TIME NOT NULL,
    purpose             VARCHAR(100) NOT NULL DEFAULT 'Patient Consultation',
    status              VARCHAR(20) NOT NULL DEFAULT 'Confirmed' 
                        CHECK (status IN ('Confirmed', 'Cancelled', 'Completed')),
    created_date        DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_RB_Room FOREIGN KEY (room_id) 
        REFERENCES Clinic_Rooms(room_id),
    CONSTRAINT FK_RB_Appt FOREIGN KEY (appointment_id) 
        REFERENCES Appointments(appointment_id),
    CONSTRAINT FK_RB_Staff FOREIGN KEY (staff_id) 
        REFERENCES Staff(staff_id),
    CONSTRAINT CK_RB_Times CHECK (end_time > start_time)
);
GO

CREATE NONCLUSTERED INDEX IX_RB_Date ON Room_Bookings(booking_date);
CREATE NONCLUSTERED INDEX IX_RB_Room ON Room_Bookings(room_id);
GO


-- TABLE 11: Audit_Log
-- Tracks important changes across the system for compliance

CREATE TABLE Audit_Log (
    log_id              INT IDENTITY(1,1) PRIMARY KEY,
    table_name          VARCHAR(50) NOT NULL,
    record_id           INT NOT NULL,
    action_type         VARCHAR(10) NOT NULL CHECK (action_type IN ('INSERT', 'UPDATE', 'DELETE')),
    action_description  VARCHAR(500) NOT NULL,
    performed_by        VARCHAR(100) NOT NULL DEFAULT SYSTEM_USER,
    action_date         DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE NONCLUSTERED INDEX IX_Audit_Table ON Audit_Log(table_name, action_date);
GO

