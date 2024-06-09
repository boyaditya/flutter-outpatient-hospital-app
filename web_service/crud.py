from sqlalchemy.orm import Session
import models, schemas
import bcrypt
from sqlalchemy import func
from sqlalchemy.orm import joinedload
from sqlalchemy import desc


# SALT = b'$2b$12$0nFckzktMD0Fb16a8JsNA.'
SALT = b"$2b$12$/bGt5NNwhngAxpF2Txdf5u"


def get_user_by_email(db: Session, email: str):
    return db.query(models.User).filter(models.User.email == email).first()


def create_user(db: Session, user: schemas.UserCreate):
    hashed_password = hash_password(user.hashed_password)
    db_user = models.User(email=user.email, hashed_password=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


def get_doctors(db: Session):
    return db.query(models.Doctor).all()


def get_doctors_by_id(db: Session, doctors_id: int):
    return db.query(models.Doctor).filter(models.Doctor.id == doctors_id).first()


def get_doctor_by_name(db: Session, doctor_name: str):
    return (
        db.query(models.Doctor)
        .filter(models.Doctor.name.ilike(f"%{doctor_name}%"))
        .all()
    )


def get_user_by_id(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.id == user_id).first()


def delete_user_by_id(db: Session, user_id: int):
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if user:
        db.delete(user)
        db.commit()
        return user
    return None


def get_specializations(db: Session):
    return db.query(models.Specialization).all()


def get_specialization_by_id(db: Session, specialization_id: int):
    return (
        db.query(models.Specialization)
        .filter(models.Specialization.id == specialization_id)
        .first()
    )


def get_doctor_schedules(db: Session):
    return db.query(models.DoctorSchedule).all()


def get_doctor_schedules_by_doctor_id(
    db: Session, doctor_id: int
) -> models.DoctorSchedule:
    return (
        db.query(models.DoctorSchedule)
        .filter(models.DoctorSchedule.doctor_id == doctor_id)
        .all()
    )


def get_medical_record_by_id(db: Session, record_id: int):
    return (
        db.query(models.MedicalRecord)
        .filter(models.MedicalRecord.id == record_id)
        .first()
    )


def get_medical_records_by_user_id(db: Session, user_id: int):
    return (
        db.query(models.MedicalRecord)
        .join(models.Appointment)
        .join(models.Patient)
        .filter(models.Patient.user_id == user_id)
        .order_by(desc(models.MedicalRecord.id))
        .all()
    )


def get_medical_record_by_patient_id(
    db: Session, patient_id: int
) -> models.MedicalRecord:
    medical_record = (
        db.query(models.MedicalRecord)
        .filter(models.MedicalRecord.appointment.has(patient_id=patient_id))
        .first()
    )
    return medical_record


def create_medical_record(db: Session, medical_record: schemas.MedicalRecordCreate):
    db_medical_record = models.MedicalRecord(
        appointment_id=medical_record.appointment_id,
        complaint=medical_record.complaint,
        diagnosis=medical_record.diagnosis,
        treatment=medical_record.treatment,
        notes=medical_record.notes,
    )
    db.add(db_medical_record)
    db.commit()
    db.refresh(db_medical_record)
    return db_medical_record


def create_rating(db: Session, ratings: schemas.RatingCreate):
    db_ratings = models.Rating(
        user_id=ratings.user_id,
        rating=ratings.rating,
        comment=ratings.comment,
        category=ratings.category,
    )
    db.add(db_ratings)
    db.commit()
    db.refresh(db_ratings)
    return db_ratings


def get_user_by_email(db: Session, email: str):
    return db.query(models.User).filter(models.User.email == email).first()


def create_patient(db: Session, patient: schemas.PatientCreate):
    db_patient = models.Patient(**patient.dict())
    db.add(db_patient)
    db.commit()
    db.refresh(db_patient)
    return db_patient


def get_patients(db: Session):
    return db.query(models.Patient).all()


def get_patients_by_user_id(db: Session, user_id: int):
    return db.query(models.Patient).filter(models.Patient.user_id == user_id).all()


def get_patient_by_id(db: Session, patient_id: int):
    return db.query(models.Patient).filter(models.Patient.id == patient_id).first()


def update_patient(db: Session, patient_id: int, patient_data: schemas.PatientCreate):
    db_patient = (
        db.query(models.Patient).filter(models.Patient.id == patient_id).first()
    )
    if db_patient:
        for key, value in patient_data.dict().items():
            setattr(db_patient, key, value)
        db.commit()
        db.refresh(db_patient)
    return db_patient


def delete_patient_by_id(db: Session, patient_id: int):
    # Mencari pasien berdasarkan ID
    patient = db.query(models.Patient).filter(models.Patient.id == patient_id).first()
    if patient:
        # Menghapus pasien
        db.delete(patient)
        db.commit()
        # Mengembalikan pasien yang dihapus
        return patient
    return None


# def create_appointment(db: Session, appointment: schemas.AppointmentCreate):
#     db_appointment = models.Appointment(**appointment.dict())
#     db.add(db_appointment)
#     db.commit()
#     db.refresh(db_appointment)
#     return db_appointment


def create_appointment(db: Session, appointment: schemas.AppointmentCreate):
    # Get the maximum queue number for the given doctor, date, and time
    max_queue_number = (
        db.query(func.max(models.Appointment.queue_number))
        .filter(
            models.Appointment.doctor_id == appointment.doctor_id,
            models.Appointment.date == appointment.date,
            models.Appointment.time == appointment.time,
        )
        .scalar()
    )

    print(max_queue_number)

    # If there are no appointments for the given doctor, date, and time, set the queue number to 1
    if max_queue_number is None:
        max_queue_number = 1
    else:
        max_queue_number += 1

    # Create the new appointment
    db_appointment = models.Appointment(
        doctor_id=appointment.doctor_id,
        patient_id=appointment.patient_id,
        date=appointment.date,
        time=appointment.time,
        coverage_type=appointment.coverage_type,
        status=appointment.status,
        queue_number=max_queue_number,
    )

    db.add(db_appointment)
    db.commit()
    db.refresh(db_appointment)

    return db_appointment


def get_appointments_by_user_id(db: Session, user_id: int):
    return (
        db.query(models.Appointment)
        .join(models.Patient)
        .filter(models.Patient.user_id == user_id)
        .options(joinedload(models.Appointment.patient))
        .order_by(
            desc(models.Appointment.id)
        )  # Sort by appointment id in descending order
        .all()
    )


def get_appointment_by_id(db: Session, appointment_id: int):
    return (
        db.query(models.Appointment)
        .filter(models.Appointment.id == appointment_id)
        .first()
    )


def get_appointments_by_patient_id(db: Session, patient_id: int):
    return (
        db.query(models.Appointment)
        .filter(models.Appointment.patient_id == patient_id)
        .all()
    )


def get_appointments_scheduled_by_patient_id(db: Session, patient_id: int):
    return (
        db.query(models.Appointment)
        .filter(models.Appointment.patient_id == patient_id)
        .filter(models.Appointment.status == "Scheduled")
        .first()
    )


def insert_status(db: Session, user_id: int, status: str):
    new_status = models.Status(user_id=user_id, status=status)
    db.add(new_status)
    db.commit()
    db.refresh(new_status)
    return new_status


def update_appointment_status(db: Session, appointment_id: int, new_status: str):
    appointment = (
        db.query(models.Appointment)
        .filter(models.Appointment.id == appointment_id)
        .first()
    )
    if not appointment:
        return None
    appointment.status = new_status
    db.commit()
    db.refresh(appointment)
    return appointment


def delete_appointment_by_id(db: Session, appointment_id: int):
    appointment = (
        db.query(models.Appointment)
        .filter(models.Appointment.id == appointment_id)
        .first()
    )
    if not appointment:
        return None
    db.delete(appointment)
    db.commit()
    return appointment


def hash_password(password: str):
    return bcrypt.hashpw(password.encode("utf-8"), SALT)
