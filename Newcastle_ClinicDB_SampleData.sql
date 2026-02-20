USE NHS_Newcastle_Clinic;
GO


-- INSERT: Departments
INSERT INTO Departments (department_name, department_head, phone_extension, floor_number)
VALUES
    ('General Practice', 'Dr Sarah Mitchell', '1001', 1),
    ('Physiotherapy', 'James Robson', '1002', 2),
    ('Mental Health Services', 'Dr Priya Sharma', '1003', 2),
    ('Respiratory Care', 'Dr Michael Thompson', '1004', 1),
    ('Pharmacy', 'Helen Carr', '1005', 1),
    ('Dermatology', 'Dr Fatima Ali', '1006', 2),
    ('Paediatrics', 'Dr Emily Watson', '1007', 1),
    ('Diabetes & Endocrinology', 'Dr Kwame Asante', '1008', 2);
GO

-- INSERT: Staff
INSERT INTO Staff (first_name, last_name, job_role, department_id, email, phone_number, hire_date)
VALUES
    ('Sarah', 'Mitchell', 'GP', 1, 'sarah.mitchell@nhs.net', '07700100001', '2018-03-15'),
    ('David', 'Armstrong', 'GP', 1, 'david.armstrong@nhs.net', '07700100002', '2019-06-01'),
    ('Priya', 'Sharma', 'GP', 3, 'priya.sharma@nhs.net', '07700100003', '2017-09-10'),
    ('Michael', 'Thompson', 'Specialist', 4, 'michael.thompson@nhs.net', '07700100004', '2020-01-20'),
    ('Emily', 'Watson', 'Specialist', 7, 'emily.watson@nhs.net', '07700100005', '2021-04-12'),
    ('James', 'Robson', 'Specialist', 2, 'james.robson@nhs.net', '07700100006', '2019-11-05'),
    ('Fatima', 'Ali', 'Specialist', 6, 'fatima.ali@nhs.net', '07700100007', '2020-07-22'),
    ('Kwame', 'Asante', 'GP', 8, 'kwame.asante@nhs.net', '07700100008', '2022-02-14'),
    ('Helen', 'Carr', 'Pharmacist', 5, 'helen.carr@nhs.net', '07700100009', '2018-08-30'),
    ('Laura', 'Dixon', 'Nurse', 1, 'laura.dixon@nhs.net', '07700100010', '2020-03-16'),
    ('Thomas', 'Bell', 'Nurse', 4, 'thomas.bell@nhs.net', '07700100011', '2021-01-10'),
    ('Grace', 'Okonkwo', 'Nurse', 7, 'grace.okonkwo@nhs.net', '07700100012', '2022-06-01'),
    ('Rebecca', 'Hall', 'Receptionist', 1, 'rebecca.hall@nhs.net', '07700100013', '2019-05-20'),
    ('Adam', 'Scott', 'Admin', 1, 'adam.scott@nhs.net', '07700100014', '2021-09-13'),
    ('Zara', 'Hussain', 'Pharmacist', 5, 'zara.hussain@nhs.net', '07700100015', '2023-01-09');
GO

-- INSERT: Patients
INSERT INTO Patients (nhs_number, first_name, last_name, date_of_birth, gender, address_line1, address_line2, city, postcode, phone_number, email, emergency_contact, emergency_phone, registered_gp_id, registration_date)
VALUES
    ('1234567801', 'John', 'Henderson', '1985-04-12', 'Male', '14 Grey Street', NULL, 'Newcastle upon Tyne', 'NE1 6AE', '07712345001', 'john.henderson@email.com', 'Mary Henderson', '07798765001', 1, '2022-01-15'),
    ('1234567802', 'Amara', 'Osei', '1992-08-25', 'Female', '27 Jesmond Road', 'Flat 3', 'Newcastle upon Tyne', 'NE2 1LA', '07712345002', 'amara.osei@email.com', 'Kofi Osei', '07798765002', 1, '2022-02-10'),
    ('1234567803', 'Peter', 'Clark', '1958-11-03', 'Male', '8 Heaton Park Road', NULL, 'Newcastle upon Tyne', 'NE6 5NR', '07712345003', 'peter.clark@email.com', 'Susan Clark', '07798765003', 2, '2021-06-20'),
    ('1234567804', 'Fatima', 'Khan', '1990-02-17', 'Female', '52 Westgate Road', 'Apt 12', 'Newcastle upon Tyne', 'NE1 1TT', '07712345004', 'fatima.khan@email.com', 'Ahmed Khan', '07798765004', 2, '2022-03-01'),
    ('1234567805', 'Steven', 'Brown', '1975-07-30', 'Male', '19 Gosforth High Street', NULL, 'Newcastle upon Tyne', 'NE3 1HJ', '07712345005', 'steven.brown@email.com', 'Linda Brown', '07798765005', 3, '2021-11-15'),
    ('1234567806', 'Emma', 'Taylor', '2001-12-09', 'Female', '33 Shields Road', 'Flat 7B', 'Newcastle upon Tyne', 'NE6 1DL', '07712345006', 'emma.taylor@email.com', 'Robert Taylor', '07798765006', 1, '2023-01-20'),
    ('1234567807', 'Mohammed', 'Rahman', '1968-05-14', 'Male', '5 Elswick Road', NULL, 'Newcastle upon Tyne', 'NE4 6JH', '07712345007', 'mohammed.rahman@email.com', 'Ayesha Rahman', '07798765007', 8, '2022-05-12'),
    ('1234567808', 'Claire', 'Stephenson', '1983-09-21', 'Female', '41 Chillingham Road', NULL, 'Newcastle upon Tyne', 'NE6 5XN', '07712345008', 'claire.stephenson@email.com', 'David Stephenson', '07798765008', 2, '2022-07-03'),
    ('1234567809', 'Daniel', 'Mbeki', '1995-01-28', 'Male', '16 Sandyford Road', 'Flat 2A', 'Newcastle upon Tyne', 'NE1 8JG', '07712345009', 'daniel.mbeki@email.com', 'Grace Mbeki', '07798765009', 1, '2023-03-10'),
    ('1234567810', 'Sophie', 'Reed', '2010-06-15', 'Female', '22 Fenham Hall Drive', NULL, 'Newcastle upon Tyne', 'NE4 9XB', '07712345010', NULL, 'Angela Reed', '07798765010', 5, '2022-08-22'),
    ('1234567811', 'George', 'Wilkinson', '1950-03-08', 'Male', '7 Dene Crescent', NULL, 'Newcastle upon Tyne', 'NE3 4AY', '07712345011', 'george.w@email.com', 'Margaret Wilkinson', '07798765011', 2, '2021-04-05'),
    ('1234567812', 'Lily', 'Chen', '1999-10-22', 'Female', '38 Osborne Road', 'Flat 5', 'Newcastle upon Tyne', 'NE2 2AJ', '07712345012', 'lily.chen@email.com', 'Wei Chen', '07798765012', 3, '2023-02-14'),
    ('1234567813', 'Nathan', 'Foster', '1972-08-05', 'Male', '11 Byker Wall', NULL, 'Newcastle upon Tyne', 'NE6 2DL', '07712345013', 'nathan.foster@email.com', 'Karen Foster', '07798765013', 8, '2022-09-18'),
    ('1234567814', 'Aisha', 'Patel', '1988-04-30', 'Female', '29 St Mary''s Place', NULL, 'Newcastle upon Tyne', 'NE1 7PG', '07712345014', 'aisha.patel@email.com', 'Raj Patel', '07798765014', 1, '2022-11-01'),
    ('1234567815', 'Oliver', 'Grant', '2015-02-18', 'Male', '6 Kenton Lane', NULL, 'Newcastle upon Tyne', 'NE3 3HB', '07712345015', NULL, 'Thomas Grant', '07798765015', 5, '2023-04-05'),
    ('1234567816', 'Hannah', 'Murray', '1980-11-27', 'Female', '45 Clayton Street', 'Floor 2', 'Newcastle upon Tyne', 'NE1 5PZ', '07712345016', 'hannah.m@email.com', 'Stuart Murray', '07798765016', 3, '2022-01-30'),
    ('1234567817', 'Callum', 'Turnbull', '1963-06-19', 'Male', '13 Grainger Street', NULL, 'Newcastle upon Tyne', 'NE1 5JE', '07712345017', 'callum.t@email.com', 'Joan Turnbull', '07798765017', 2, '2021-08-12'),
    ('1234567818', 'Zainab', 'Ibrahim', '1997-03-11', 'Female', '20 Northumberland Street', 'Flat 9', 'Newcastle upon Tyne', 'NE1 7DE', '07712345018', 'zainab.i@email.com', 'Yusuf Ibrahim', '07798765018', 1, '2023-05-20'),
    ('1234567819', 'Brian', 'Dodds', '1945-09-02', 'Male', '3 Armstrong Road', NULL, 'Newcastle upon Tyne', 'NE4 8QJ', '07712345019', 'brian.dodds@email.com', 'Pauline Dodds', '07798765019', 8, '2021-03-25'),
    ('1234567820', 'Jessica', 'Okonkwo', '1993-07-08', 'Female', '31 Quayside', 'Apt 14', 'Newcastle upon Tyne', 'NE1 3DE', '07712345020', 'jessica.o@email.com', 'Emeka Okonkwo', '07798765020', 2, '2022-12-08');
GO

-- INSERT: Clinic_Rooms
INSERT INTO Clinic_Rooms (room_name, room_type, floor_number, capacity, has_equipment, equipment_details, is_available)
VALUES
    ('GP Room 1', 'Consultation', 1, 2, 1, 'Blood pressure monitor, otoscope, ophthalmoscope', 1),
    ('GP Room 2', 'Consultation', 1, 2, 1, 'Blood pressure monitor, ECG machine', 1),
    ('GP Room 3', 'Consultation', 1, 2, 1, 'Blood pressure monitor, spirometer', 1),
    ('Treatment Room A', 'Treatment', 1, 3, 1, 'Examination bed, dressing trolley, nebuliser', 1),
    ('Treatment Room B', 'Treatment', 2, 3, 1, 'Examination bed, minor surgery kit', 1),
    ('Physio Suite', 'Examination', 2, 4, 1, 'Exercise equipment, ultrasound therapy unit', 1),
    ('Mental Health Room', 'Consultation', 2, 3, 0, NULL, 1),
    ('Paediatric Room', 'Consultation', 1, 4, 1, 'Child-friendly equipment, weighing scales', 1),
    ('Meeting Room 1', 'Meeting', 2, 10, 0, NULL, 1),
    ('Pharmacy Dispensary', 'Pharmacy', 1, 3, 1, 'Dispensing equipment, drug storage', 1),
    ('Reception Area', 'Reception', 1, 20, 1, 'Self-check-in kiosks', 1),
    ('Dermatology Suite', 'Examination', 2, 2, 1, 'Dermoscope, cryotherapy unit, UV light', 1);
GO

-- INSERT: Appointments (October - December 2024)
INSERT INTO Appointments (patient_id, staff_id, department_id, room_id, appointment_date, appointment_time, duration_minutes, appointment_type, status, booking_method, notes)
VALUES
    -- October 2024
    (1, 1, 1, 1, '2024-10-01', '09:00', 15, 'Routine', 'Completed', 'Online', 'Annual health check'),
    (2, 1, 1, 1, '2024-10-01', '09:30', 15, 'Routine', 'Completed', 'Phone', 'Contraception review'),
    (3, 2, 1, 2, '2024-10-02', '10:00', 20, 'Follow-Up', 'Completed', 'In-Person', 'Blood pressure follow-up'),
    (4, 2, 1, 2, '2024-10-02', '10:30', 15, 'Urgent', 'Completed', 'Phone', 'Chest pain assessment'),
    (5, 3, 3, 7, '2024-10-03', '11:00', 30, 'Routine', 'Completed', 'Online', 'Mental health review'),
    (6, 1, 1, 1, '2024-10-03', '14:00', 15, 'Routine', 'No-Show', 'Online', NULL),
    (7, 8, 8, 3, '2024-10-04', '09:15', 20, 'Follow-Up', 'Completed', 'Phone', 'Diabetes management review'),
    (8, 6, 2, 6, '2024-10-04', '10:00', 30, 'Routine', 'Completed', 'In-Person', 'Back pain physiotherapy'),
    (9, 1, 1, 1, '2024-10-07', '09:00', 15, 'Walk-In', 'Completed', 'In-Person', 'Sore throat and fever'),
    (10, 5, 7, 8, '2024-10-07', '11:00', 20, 'Routine', 'Completed', 'Phone', 'Childhood immunisations'),
    (11, 2, 1, 2, '2024-10-08', '09:30', 15, 'Routine', 'Completed', 'Online', 'Medication review - statins'),
    (12, 3, 3, 7, '2024-10-08', '14:00', 30, 'Routine', 'Completed', 'Online', 'Anxiety management session'),
    (13, 8, 8, 3, '2024-10-09', '10:00', 20, 'Follow-Up', 'Completed', 'Phone', 'HbA1c results discussion'),
    (14, 1, 1, 1, '2024-10-09', '11:00', 15, 'Telephone', 'Completed', 'Phone', 'Test results discussion'),
    (15, 5, 7, 8, '2024-10-10', '09:00', 20, 'Routine', 'Completed', 'In-Person', '12-month developmental check'),
    (16, 3, 3, 7, '2024-10-10', '15:00', 30, 'Urgent', 'Completed', 'Phone', 'Crisis intervention session'),
    (17, 2, 1, 2, '2024-10-11', '09:00', 15, 'Routine', 'Cancelled', 'Online', 'Patient cancelled - unwell'),
    (18, 7, 6, 12, '2024-10-11', '10:30', 20, 'Routine', 'Completed', 'Referral', 'Eczema assessment'),
    (19, 8, 8, 3, '2024-10-14', '09:00', 20, 'Routine', 'Completed', 'Online', 'Diabetes annual review'),
    (20, 4, 4, 4, '2024-10-14', '11:00', 30, 'Follow-Up', 'Completed', 'Referral', 'Asthma management plan review'),
    -- November 2024
    (1, 4, 4, 4, '2024-11-01', '09:30', 20, 'Home Visit', 'Completed', 'Referral', 'Spirometry test - respiratory'),
    (3, 2, 1, 2, '2024-11-04', '10:00', 15, 'Follow-Up', 'Completed', 'Phone', 'Blood pressure check'),
    (5, 3, 3, 7, '2024-11-05', '11:00', 30, 'Follow-Up', 'Completed', 'Online', 'CBT session 3'),
    (8, 6, 2, 6, '2024-11-06', '10:00', 30, 'Follow-Up', 'Completed', 'In-Person', 'Physiotherapy session 2'),
    (12, 3, 3, 7, '2024-11-07', '14:00', 30, 'Follow-Up', 'No-Show', 'Online', NULL),
    (14, 7, 6, 12, '2024-11-08', '10:00', 20, 'Routine', 'Completed', 'Online', 'Skin rash assessment'),
    (2, 1, 1, 1, '2024-11-11', '09:00', 15, 'Routine', 'Completed', 'Online', 'Flu vaccination'),
    (16, 3, 3, 7, '2024-11-12', '15:00', 30, 'Follow-Up', 'Completed', 'Phone', 'Mental health follow-up'),
    (7, 8, 8, 3, '2024-11-13', '09:15', 20, 'Follow-Up', 'Completed', 'Phone', 'Insulin adjustment review'),
    (9, 2, 1, 2, '2024-11-14', '09:00', 15, 'Follow-Up', 'Completed', 'In-Person', 'Follow-up from walk-in'),
    (4, 1, 1, 1, '2024-11-15', '14:00', 15, 'Routine', 'Completed', 'Phone', 'Routine health check'),
    (11, 2, 1, 2, '2024-11-18', '09:30', 15, 'Follow-Up', 'Completed', 'Online', 'Statin dosage review'),
    (20, 6, 2, 6, '2024-11-19', '10:00', 30, 'Routine', 'Completed', 'Referral', 'Knee injury assessment'),
    (13, 8, 8, 3, '2024-11-20', '10:00', 20, 'Follow-Up', 'Completed', 'Phone', 'Blood sugar monitoring review'),
    (6, 1, 1, 1, '2024-11-21', '09:00', 15, 'Routine', 'Completed', 'Online', 'Repeat prescription request'),
    (19, 2, 1, 2, '2024-11-22', '11:00', 20, 'Urgent', 'Completed', 'In-Person', 'Chest infection assessment'),
    -- December 2024
    (1, 1, 1, 1, '2024-12-02', '09:00', 15, 'Follow-Up', 'Completed', 'Online', 'Spirometry results review'),
    (5, 3, 3, 7, '2024-12-03', '11:00', 30, 'Follow-Up', 'Completed', 'Online', 'CBT session 4'),
    (8, 6, 2, 6, '2024-12-04', '10:00', 30, 'Follow-Up', 'Completed', 'In-Person', 'Physiotherapy session 3'),
    (10, 5, 7, 8, '2024-12-05', '11:00', 20, 'Follow-Up', 'Completed', 'Phone', 'Post-immunisation check'),
    (3, 2, 1, 2, '2024-12-06', '10:00', 15, 'Follow-Up', 'Completed', 'Phone', 'Blood pressure - stable'),
    (17, 4, 4, 4, '2024-12-09', '09:00', 20, 'Routine', 'Completed', 'Referral', 'COPD management review'),
    (18, 7, 6, 12, '2024-12-09', '10:30', 20, 'Follow-Up', 'Completed', 'Phone', 'Eczema treatment follow-up'),
    (7, 8, 8, 3, '2024-12-10', '09:15', 20, 'Follow-Up', 'Completed', 'Phone', 'Quarterly diabetes review'),
    (15, 5, 7, 8, '2024-12-11', '09:00', 20, 'Routine', 'Completed', 'In-Person', 'Developmental milestone check'),
    (16, 3, 3, 7, '2024-12-12', '15:00', 45, 'Follow-Up', 'Completed', 'Phone', 'Extended therapy session'),
    (20, 6, 2, 6, '2024-12-13', '10:00', 30, 'Follow-Up', 'Completed', 'In-Person', 'Knee rehabilitation progress'),
    (14, 1, 1, 1, '2024-12-16', '11:00', 15, 'Routine', 'Scheduled', 'Online', 'Annual health check'),
    (9, 2, 1, 2, '2024-12-17', '09:00', 15, 'Routine', 'Scheduled', 'Phone', 'General check-up'),
    (19, 8, 8, 3, '2024-12-18', '10:00', 20, 'Follow-Up', 'Scheduled', 'Phone', 'Diabetes annual review');
GO


-- INSERT: Medications
INSERT INTO Medications (medication_name, generic_name, category, dosage_form, standard_dosage, requires_review, is_controlled)
VALUES
    ('Paracetamol 500mg', 'Paracetamol', 'Analgesic', 'Tablet', '1-2 tablets every 4-6 hours, max 8 daily', 0, 0),
    ('Amoxicillin 500mg', 'Amoxicillin', 'Antibiotic', 'Capsule', '1 capsule 3 times daily for 7 days', 0, 0),
    ('Sertraline 50mg', 'Sertraline', 'Antidepressant', 'Tablet', '1 tablet daily', 1, 0),
    ('Amlodipine 5mg', 'Amlodipine', 'Antihypertensive', 'Tablet', '1 tablet daily', 1, 0),
    ('Salbutamol 100mcg', 'Salbutamol', 'Inhaler', 'Inhaler', '1-2 puffs as required', 0, 0),
    ('Atorvastatin 20mg', 'Atorvastatin', 'Statin', 'Tablet', '1 tablet daily at night', 1, 0),
    ('Cetirizine 10mg', 'Cetirizine', 'Antihistamine', 'Tablet', '1 tablet daily', 0, 0),
    ('Omeprazole 20mg', 'Omeprazole', 'Proton Pump Inhibitor', 'Capsule', '1 capsule daily before food', 1, 0),
    ('Metformin 500mg', 'Metformin', 'Other', 'Tablet', '1 tablet twice daily with meals', 1, 0),
    ('Fluticasone 50mcg', 'Fluticasone', 'Inhaler', 'Inhaler', '2 puffs twice daily', 1, 0),
    ('Ibuprofen 400mg', 'Ibuprofen', 'Analgesic', 'Tablet', '1 tablet 3 times daily with food', 0, 0),
    ('Lansoprazole 30mg', 'Lansoprazole', 'Proton Pump Inhibitor', 'Capsule', '1 capsule daily', 1, 0);
GO

select * from Medications;

-- INSERT: Prescriptions
INSERT INTO Prescriptions (patient_id, staff_id, appointment_id, medication_id, dosage, frequency, duration_days, quantity, issue_date, is_repeat, status, pharmacy_notes)
VALUES
    -- October 2024
    (1,  1, 22, 1,  '500mg',  'Every 4-6 hours as needed',    7,  28, '2024-10-01', 0, 'Dispensed', NULL),
    (3,  2, 24, 4,  '5mg',    'Once daily',                   28, 28, '2024-10-02', 1, 'Dispensed', 'Repeat prescription - monitor BP'),
    (3,  2, 24, 6,  '20mg',   'Once daily at night',          28, 28, '2024-10-02', 1, 'Dispensed', 'Check lipid panel in 3 months'),
    (4,  2, 25, 8,  '20mg',   'Once daily before breakfast',  14, 14, '2024-10-02', 0, 'Dispensed', NULL),
    (5,  3, 26, 3,  '50mg',   'Once daily in the morning',    28, 28, '2024-10-03', 1, 'Dispensed', 'Mental health team review in 4 weeks'),
    (7,  8, 28, 9,  '500mg',  'Twice daily with meals',       28, 56, '2024-10-04', 1, 'Dispensed', 'Check renal function annually'),
    (8,  6, 29, 11, '400mg',  'Three times daily with food',  10, 30, '2024-10-04', 0, 'Dispensed', 'Short course only'),
    (9,  1, 30, 2,  '500mg',  'Three times daily for 7 days',  7, 21, '2024-10-07', 0, 'Dispensed', NULL),
    (11, 2, 32, 6,  '20mg',   'Once daily at night',          28, 28, '2024-10-08', 1, 'Dispensed', 'Dose increase from 10mg'),
    (13, 8, 34, 9,  '500mg',  'Twice daily with meals',       28, 56, '2024-10-09', 1, 'Dispensed', 'HbA1c improving'),
    (18, 7, 39, 7,  '10mg',   'Once daily',                   14, 14, '2024-10-11', 0, 'Dispensed', 'For eczema-related itching'),
    (19, 8, 40, 9,  '500mg',  'Twice daily with meals',       28, 56, '2024-10-14', 1, 'Dispensed', NULL),
    (20, 4, 41, 5,  '100mcg', '1-2 puffs as required',        30,  1, '2024-10-14', 1, 'Dispensed', 'Asthma action plan provided'),
    -- November 2024
    (1,  4, 42, 5,  '100mcg', '1-2 puffs as required',        30,  1, '2024-11-01', 0, 'Dispensed', 'Prescribed after spirometry'),
    (1,  4, 42, 10, '50mcg',  '2 puffs twice daily',          30,  1, '2024-11-01', 1, 'Dispensed', 'Preventer inhaler - use daily'),
    (19, 2, 57, 2,  '500mg',  'Three times daily for 7 days',  7, 21, '2024-11-22', 0, 'Dispensed', 'Chest infection treatment'),
    (5,  3, 44, 3,  '100mg',  'Once daily in the morning',    28, 28, '2024-11-05', 1, 'Active',    'Dose increased from 50mg'),
    (3,  2, 43, 4,  '5mg',    'Once daily',                   28, 28, '2024-11-04', 1, 'Active',    'BP stable - continue'),
    (7,  8, 50, 9,  '1000mg', 'Twice daily with meals',       28, 56, '2024-11-13', 1, 'Active',    'Dose increased from 500mg'),
    -- December 2024
    (17, 4, 63, 10, '50mcg',  '2 puffs twice daily',          30,  1, '2024-12-09', 1, 'Active',    'COPD management');
GO

SELECT * FROM Prescriptions;

-- INSERT: Referrals
INSERT INTO Referrals (patient_id, referring_staff_id, appointment_id, referral_type, referred_to, department_id, priority, referral_date, status, clinical_notes, outcome)
VALUES
    (1,  1, 22,   'Internal', 'Dr Michael Thompson - Respiratory', 4, 'Routine',        '2024-10-01', 'Completed', 'Persistent cough - spirometry recommended', 'Mild asthma diagnosed - inhaler prescribed'),
    (4,  2, 25,   'External', 'Royal Victoria Infirmary - Cardiology', NULL, 'Two-Week Wait', '2024-10-02', 'Accepted', 'Chest pain with exertion - ECG normal but needs further investigation', NULL),
    (8,  1, NULL, 'Internal', 'James Robson - Physiotherapy', 2, 'Routine',             '2024-10-01', 'Completed', 'Chronic lower back pain - 6 sessions recommended', 'Good improvement after 3 sessions'),
    (12, 3, 33,   'External', 'Newcastle Talking Therapies', NULL, 'Routine',            '2024-10-08', 'Accepted', 'Generalised anxiety - CBT referral', NULL),
    (18, 1, NULL, 'Internal', 'Dr Fatima Ali - Dermatology', 6, 'Routine',              '2024-10-10', 'Completed', 'Persistent eczema not responding to emollients', 'Topical steroid course prescribed'),
    (20, 2, NULL, 'Internal', 'James Robson - Physiotherapy', 2, 'Routine',             '2024-11-15', 'Completed', 'Right knee ligament injury from sport', 'Rehabilitation programme in progress'),
    (17, 2, NULL, 'Internal', 'Dr Michael Thompson - Respiratory', 4, 'Routine',        '2024-12-01', 'Completed', 'Suspected COPD - ex-smoker, persistent breathlessness', 'COPD confirmed - management plan initiated'),
    (11, 2, 32,   'External', 'Freeman Hospital - Lipid Clinic', NULL, 'Routine',       '2024-10-08', 'Pending', 'Elevated cholesterol despite statin therapy', NULL),
    (19, 2, 57,   'Diagnostic', 'Newcastle NHS Trust - Chest X-Ray', NULL, 'Urgent',    '2024-11-22', 'Completed', 'Chest infection - rule out pneumonia', 'X-ray clear - infection resolved with antibiotics'),
    (16, 3, 37,   'External', 'Northumberland Tyne and Wear NHS - Crisis Team', NULL, 'Emergency', '2024-10-10', 'Completed', 'Acute crisis presentation - needs urgent support', 'Stabilised - ongoing therapy arranged');
GO

SELECT * FROM Referrals;

-- INSERT: Medical_Records
INSERT INTO Medical_Records (patient_id, appointment_id, staff_id, diagnosis_code, diagnosis_desc, consultation_notes, treatment_plan, follow_up_required, follow_up_date)
VALUES
    (1,  22, 1, 'R05',   'Persistent cough',              'Patient reports cough lasting 3 weeks. No fever. Non-smoker. Chest clear on auscultation. Possible mild asthma.', 'Refer to respiratory for spirometry. Paracetamol for symptom relief.', 1, '2024-11-01'),
    (2,  23, 1, 'Z30.0', 'Contraceptive management',      'Routine contraception review. No issues reported. BP within normal range.', 'Continue current oral contraceptive. Review in 12 months.', 0, NULL),
    (3,  24, 2, 'I10',   'Essential hypertension',         'Follow-up BP check. Reading 138/86. Improved from last visit (145/92). Patient compliant with medication.', 'Continue Amlodipine 5mg. Lifestyle advice given. Review in 4 weeks.', 1, '2024-11-04'),
    (4,  25, 2, 'R07.9', 'Chest pain unspecified',         'Patient presents with intermittent chest pain on exertion. ECG normal. No family history of cardiac disease. BMI 26.', 'Omeprazole trial for possible GERD. Urgent cardiology referral as precaution.', 1, '2024-11-02'),
    (5,  26, 3, 'F41.1', 'Generalised anxiety disorder',   'Patient reports ongoing anxiety symptoms. Sleep disturbed. PHQ-9 score 14. Currently on Sertraline 50mg for 6 weeks.', 'Increase Sertraline to 50mg. Begin CBT programme. Review in 4 weeks.', 1, '2024-11-05'),
    (7,  28, 8, 'E11.9', 'Type 2 diabetes',                'Quarterly review. HbA1c 58 mmol/mol (slightly above target). Weight stable. No foot complications.', 'Continue Metformin 500mg BD. Dietitian advice reinforced. Recheck HbA1c in 3 months.', 1, '2024-11-13'),
    (8,  29, 6, 'M54.5', 'Low back pain',                  'Initial physio assessment. Pain score 6/10. Limited flexion. No neurological signs.', '6-session physiotherapy programme. Core strengthening exercises. Ibuprofen for pain.', 1, '2024-11-06'),
    (9,  30, 1, 'J02.9', 'Acute pharyngitis',              'Walk-in presentation. Sore throat, mild fever 37.8C. Tonsils inflamed with exudate. No penicillin allergy.', 'Amoxicillin 500mg TDS for 7 days. Fluids and rest advised.', 0, NULL),
    (10, 31, 5, 'Z23',   'Childhood immunisations',        'Routine childhood immunisations administered. No adverse reactions during observation period. Parents counselled.', 'Next immunisation due at 12 months. Follow-up scheduled.', 1, '2024-12-05'),
    (11, 32, 2, 'E78.0', 'Hypercholesterolaemia',          'Medication review. Total cholesterol still elevated at 6.2 despite Atorvastatin 20mg. Good dietary compliance reported.', 'Increase Atorvastatin to 20mg. Consider lipid clinic referral. Recheck in 3 months.', 1, '2024-11-18'),
    (12, 33, 3, 'F41.1', 'Generalised anxiety disorder',   'First anxiety management session. Patient engaged well. Identified key triggers: work stress, social situations.', 'Weekly CBT sessions for 6 weeks. Breathing exercises and journaling prescribed.', 1, '2024-11-07'),
    (13, 34, 8, 'E11.9', 'Type 2 diabetes',                'HbA1c results: 52 mmol/mol - improved. Patient adhering to diet plan. Foot examination normal.', 'Continue current Metformin dose. Encourage physical activity. Review in 6 weeks.', 1, '2024-11-20'),
    (16, 37, 3, 'F32.1', 'Moderate depressive episode',    'Crisis presentation. Patient reporting suicidal ideation without plan. Risk assessment completed. Safety plan established.', 'Emergency referral to crisis team. Daily check-in calls for 1 week. Urgent follow-up.', 1, '2024-11-12'),
    (18, 39, 7, 'L30.9', 'Dermatitis unspecified',         'Eczema assessment. Extensive patches on forearms and behind knees. Emollients alone not controlling symptoms.', 'Topical betamethasone for 2 weeks. Continue regular emollients. Antihistamine for itch.', 1, '2024-12-09'),
    (19, 40, 8, 'E11.9', 'Type 2 diabetes',                'Annual diabetes review. HbA1c 61 mmol/mol - above target. Weight increased by 3kg. BP 142/88.', 'Consider Metformin dose increase. Dietitian referral. BP monitoring at home.', 1, '2024-12-18'),
    (20, 41, 4, 'J45.0', 'Predominantly allergic asthma',  'Asthma review. Well controlled on current inhaler regime. Peak flow 420 (predicted 440). No exacerbations.', 'Continue Salbutamol PRN. Asthma action plan reviewed and updated.', 1, '2025-04-14');
GO

SELECT * FROM Medical_Records;

-- INSERT: Room_Bookings
INSERT INTO Room_Bookings (room_id, appointment_id, staff_id, booking_date, start_time, end_time, purpose, status)
VALUES
    (1,  22, 1,  '2024-10-01', '09:00', '09:15', 'Patient Consultation', 'Completed'),
    (1,  23, 1,  '2024-10-01', '09:30', '09:45', 'Patient Consultation', 'Completed'),
    (2,  24, 2,  '2024-10-02', '10:00', '10:20', 'Patient Consultation', 'Completed'),
    (2,  25, 2,  '2024-10-02', '10:30', '10:45', 'Urgent Assessment', 'Completed'),
    (7,  26, 3,  '2024-10-03', '11:00', '11:30', 'Mental Health Consultation', 'Completed'),
    (3,  28, 8,  '2024-10-04', '09:15', '09:35', 'Diabetes Review', 'Completed'),
    (6,  29, 6,  '2024-10-04', '10:00', '10:30', 'Physiotherapy Session', 'Completed'),
    (1,  30, 1,  '2024-10-07', '09:00', '09:15', 'Walk-In Consultation', 'Completed'),
    (8,  31, 5,  '2024-10-07', '11:00', '11:20', 'Paediatric Immunisations', 'Completed'),
    (2,  32, 2,  '2024-10-08', '09:30', '09:45', 'Medication Review', 'Completed'),
    (7,  33, 3,  '2024-10-08', '14:00', '14:30', 'Anxiety Management Session', 'Completed'),
    (12, 39, 7,  '2024-10-11', '10:30', '10:50', 'Dermatology Assessment', 'Completed'),
    (4,  41, 4,  '2024-10-14', '11:00', '11:30', 'Respiratory Review', 'Completed'),
    (4,  42, 4,  '2024-11-01', '09:30', '09:50', 'Spirometry Test', 'Completed'),
    (7,  44, 3,  '2024-11-05', '11:00', '11:30', 'CBT Session', 'Completed'),
    (6,  45, 6,  '2024-11-06', '10:00', '10:30', 'Physiotherapy Session', 'Completed'),
    (1,  48, 1,  '2024-11-11', '09:00', '09:15', 'Flu Vaccination', 'Completed'),
    (6,  54, 6,  '2024-11-19', '10:00', '10:30', 'Knee Assessment', 'Completed'),
    (6,  60, 6,  '2024-12-04', '10:00', '10:30', 'Physiotherapy Session', 'Completed'),
    (4,  63, 4,  '2024-12-09', '09:00', '09:20', 'COPD Review', 'Completed'),
    (9,  NULL, 14, '2024-10-15', '13:00', '14:00', 'Staff Training - Safeguarding', 'Completed'),
    (9,  NULL, 14, '2024-11-20', '13:00', '14:30', 'Team Meeting - Q4 Planning', 'Completed');
GO

SELECT * FROM Room_Bookings;