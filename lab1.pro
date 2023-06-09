% Facts
patient_card(1, "John Doe", "123 Main St", "555-1234", 30, "XYZ Company").
patient_card(2, "Jane Smith", "456 Elm St", "555-5678", 45, "ABC Corporation").
patient_card(3, "Michael Johnson", "789 Oak St", "555-9090", 50, "123 Organization").

doctor(1, "Dr. Brown", "General Practitioner").
doctor(2, "Dr. Lee", "Cardiologist").
doctor(3, "Dr. White", "Dermatologist").

appointment(1, 1, "2023-06-14", "Fever", "Check-up", yes).
appointment(1, 2, "2023-06-15", "Chest pain", "Cardiology consultation", no).
appointment(2, 2, "2023-06-16", "High blood pressure", "Follow-up", no).
appointment(2, 3, "2023-06-17", "Skin rash", "Dermatology consultation", yes).
appointment(3, 3, "2023-06-18", "Acne", "Check-up", no).

% Rules
visited_doctor(PatientCardNumber, DoctorID) :-
    appointment(DoctorID, PatientCardNumber, _, _, _, _).

patient_diagnoses(PatientCardNumber, Diagnoses) :-
    findall(Diagnosis, appointment(_, PatientCardNumber, _, Diagnosis, _, _), Diagnoses).

given_sick_leave(PatientCardNumber) :-
    appointment(_, PatientCardNumber, _, _, _, yes).

% Queries
query(visited_doctor(PatientCardNumber, DoctorID)).
query(patient_diagnoses(PatientCardNumber, Diagnoses)).
query(given_sick_leave(PatientCardNumber)).
