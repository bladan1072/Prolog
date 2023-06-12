list_patients_with_sick_leave(DoctorID, Patients) :-
    findall(PatientID, appointment(DoctorID, PatientID, _, _, yes), Patients).

list_patients_with_diagnosis(Diagnosis, Patients) :-
    findall(PatientID, appointment(_, PatientID, _, Diagnosis, _), Patients).

list_all_patients(Patients) :-
    findall(patient(ID, Name, Address, Phone, Age, Work),
            patient(ID, Name, Address, Phone, Age, Work),
            Patients).

find_patient(ID, Patient) :-
    patient(ID, Patient, _, _, _, _).

average_age(AverageAge) :-
    findall(Age, patient(_, _, _, _, Age, _), Ages),
    length(Ages, NumPatients),
    sum_list(Ages, SumAges),
    AverageAge is SumAges / NumPatients.

get_doctor_name(DoctorID, DoctorName) :-
    doctor(DoctorID, DoctorName, _).

:- consult('data.txt').