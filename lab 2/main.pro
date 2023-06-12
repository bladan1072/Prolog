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

num_patients(Num) :-
    findall(ID, patient(ID, _, _, _, _, _), IDs),
    length(IDs, Num).

max_age(MaxAge) :-
    findall(Age, patient(_, _, _, _, Age, _), Ages),
    max_list(Ages, MaxAge).

doctors_with_diagnosis(Diagnosis, Doctors) :-
    findall(DoctorID, appointment(DoctorID, _, _, Diagnosis, _), DoctorIDs),
    list_doctors_by_ids(DoctorIDs, Doctors).

list_doctors_by_ids([], []).
list_doctors_by_ids([DoctorID|Rest], [Doctor|Doctors]) :-
    get_doctor_name(DoctorID, Doctor),
    list_doctors_by_ids(Rest, Doctors).

:- consult('data.txt').