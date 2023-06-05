domains
    id = symbol
    name = string
    address = string
    phone = string
    age = integer
    work = string
    specialization = string
    date = string
    diagnosis = string
    sickleave = yes_no

    yes_no = yes; no

predicates
    patient(id, name, address, phone, age, work)
    doctor(id, name, specialization)
    appointment(doctor_id, patient_id, date, diagnosis, sickleave)
    visited_doctor(PatientID: id, Date: date, Doctor: doctor)
    patient_diagnoses(PatientID: id, Diagnoses: list(diagnosis))
    patients_with_sick_leave(DoctorID: id, Patients: list(id))
    patients_with_diagnosis(Diagnosis: diagnosis, Patients: list(id))
    average_patient_age(AverageAge: float)

clauses
    % sample patient data
    patient(1, "John Doe", "123 Main St.", "555-1234", 35, "Acme Inc.").
    patient(2, "Jane Smith", "456 Elm St.", "555-5678", 28, "XYZ Corp.").
    patient(3, "Michael Johnson", "789 Oak St.", "555-9876", 42, "ABC Company").
    patient(4, "Emily Davis", "321 Pine St.", "555-5432", 50, "XYZ Corp.").
    patient(5, "Sarah Thompson", "654 Cedar St.", "555-3456", 22, "Acme Inc.").

    % sample doctor data
    doctor(10, "Dr. Johnson", "Cardiology").
    doctor(20, "Dr. Lee", "Pediatrics").
    doctor(30, "Dr. Martinez", "Dermatology").
    doctor(40, "Dr. Taylor", "Orthopedics").

    % sample appointment data
    appointment(10, 1, "2023-05-08", "High blood pressure", yes).
    appointment(20, 1, "2023-05-09", "Fever", no).
    appointment(10, 2, "2023-05-10", "Chest pain", yes).
    appointment(20, 2, "2023-05-11", "Sore throat", yes).
    appointment(10, 2, "2023-05-12", "Acid reflux", no).
    appointment(20, 1, "2023-05-13", "Ear infection", no).
    appointment(30, 3, "2023-05-14", "Eczema", yes).
    appointment(40, 4, "2023-05-15", "Fractured arm", yes).
    appointment(10, 5, "2023-05-16", "Allergic reaction", no).
    appointment(20, 5, "2023-05-17", "Common cold", no).
    appointment(30, 4, "2023-05-18", "Psoriasis", yes).
    appointment(40, 3, "2023-05-19", "Knee pain", no).
    appointment(10, 4, "2023-05-20", "High blood pressure", yes).
    appointment(20, 5, "2023-05-21", "Bronchitis", yes).
    appointment(30, 2, "2023-05-22", "Acne", no).

    % rule to find all doctors visited by a patient on a specific date
    visited_doctor(PatientID, Date, Doctor) :-
        appointment(DoctorID, PatientID, Date, _, _),
        doctor(DoctorID, Doctor, _).

    % rule to find all diagnoses of a patient over all appointments
    patient_diagnoses(PatientID, Diagnoses) :-
        findall(Diagnosis, appointment(_, PatientID, _, Diagnosis, _), Diagnoses).

    % rule to find all patients given sick leave by a certain doctor
    patients_with_sick_leave(DoctorID, Patients) :-
        findall(PatientID, appointment(DoctorID, PatientID, _, _, yes), Patients).

    % rule to find all patients with a certain diagnosis
    patients_with_diagnosis(Diagnosis, Patients) :-
        findall(PatientID, appointment(_, PatientID, _, Diagnosis, _), Patients).

    % rule to calculate the average age of patients
    average_patient_age(AverageAge) :-
        findall(Age, patient(_, _, _, _, Age, _), Ages),
        sum_list(Ages, TotalAge),
        length(Ages, NumPatients),
        AverageAge is TotalAge / NumPatients.
