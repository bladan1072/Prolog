implement main

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

clauses
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

    process_query(_) :-
        writeln("Invalid query.").

end implement main

goal
    run.
