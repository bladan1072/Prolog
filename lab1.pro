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

clauses
    % sample patient data
    patient(1, "John Doe", "123 Main St.", "555-1234", 35, "Acme Inc.").
    patient(2, "Jane Smith", "456 Elm St.", "555-5678", 28, "XYZ Corp.").

    % sample doctor data
    doctor(10, "Dr. Johnson", "Cardiology").
    doctor(20, "Dr. Lee", "Pediatrics").

    % sample appointment data
    appointment(10, 1, "2023-05-08", "High blood pressure", yes).
    appointment(20, 1, "2023-05-09", "Fever", no).
    appointment(10, 2, "2023-05-10", "Chest pain", yes).
    appointment(20, 2, "2023-05-11", "Sore throat", yes).
    appointment(10, 2, "2023-05-12", "Acid reflux", no).
    appointment(20, 1, "2023-05-13", "Ear infection", no).

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
