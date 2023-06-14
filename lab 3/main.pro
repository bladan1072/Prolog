domains
    card_number = integer
    full_name = string
    address = string
    phone_number = string
    age = integer
    place_of_work = string
    doctor_id = integer
    specialization = string
    date = string
    diagnosis = string
    appointment_status = string

predicates
    patient_card(card_number, full_name, address, phone_number, age, place_of_work)
    doctor(doctor_id, full_name, specialization)
    appointment(doctor_id, card_number, date, diagnosis, appointment_status)
    patients_given_sick_leave(doctor_id, list(card_number))
    patient_diagnoses(card_number, list(diagnosis))
    total_patients(doctor_id, integer)
    average_age(integer)

clauses
    % Consult the knowledge base from the file
    :-consult('knowledge_base.txt').

    run :-
        writeln("Enter a query:"),
        readln(Query),
        process_query(Query).

    process_query(Query) :-
        Query = patient_card(CardNumber, _, _, _, _, _),
        patient_card(CardNumber, FullName, Address, PhoneNumber, Age, PlaceOfWork),
        writeln("Patient ", FullName, "'s card information:"),
        writeln("Card Number: ", CardNumber),
        writeln("Address: ", Address),
        writeln("Phone Number: ", PhoneNumber),
        writeln("Age: ", Age),
        writeln("Place of Work: ", PlaceOfWork).

    process_query(Query) :-
        Query = doctor(DoctorID, _, _),
        doctor(DoctorID, FullName, Specialization),
        writeln("Doctor ", FullName, " specializes in ", Specialization).

    process_query(Query) :-
        Query = appointment(DoctorID, CardNumber, Date, Diagnosis, AppointmentStatus),
        appointment(DoctorID, CardNumber, Date, Diagnosis, AppointmentStatus),
        writeln("Appointment details:"),
        writeln("Doctor ID: ", DoctorID),
        writeln("Card Number: ", CardNumber),
        writeln("Date: ", Date),
        writeln("Diagnosis: ", Diagnosis),
        writeln("Appointment Status: ", AppointmentStatus).

    process_query(Query) :-
        Query = patients_given_sick_leave(DoctorID, Patients),
        patients_given_sick_leave(DoctorID, Patients),
        writeln("Doctor ", DoctorID, " has given sick leave to the following patients: ", Patients).

    process_query(Query) :-
        Query = patient_diagnoses(CardNumber, Diagnoses),
        patient_diagnoses(CardNumber, Diagnoses),
        writeln("Patient ", CardNumber, " has the following diagnoses: ", Diagnoses).

    process_query(Query) :-
        Query = total_patients(DoctorID, Total),
        total_patients(DoctorID, Total),
        writeln("Doctor ", DoctorID, " has a total of ", Total, " patients.").

    process_query(Query) :-
        Query = average_age(Average),
        average_age(Average),
        writeln("The average age of all patients is: ", Average).

    process_query(_) :-
        writeln("Invalid query.").

goal
    run.
