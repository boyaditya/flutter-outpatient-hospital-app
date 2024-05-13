from sqlalchemy.orm import Session
import models, schemas
import bcrypt

SALT = b'$2b$12$0nFckzktMD0Fb16a8JsNA.'

def get_user_by_email(db: Session, email: str):
    return db.query(models.User).filter(models.User.email == email).first()


def create_user(db: Session, user: schemas.UserCreate):
    hashed_password = bcrypt.hashpw(
        user.hashed_password.encode("utf-8"), bcrypt.gensalt()
    )
    db_user = models.User(email=user.email, hashed_password=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


def get_doctors(db: Session):
    return db.query(models.Doctor).all()


def get_doctors_by_id(db: Session, doctors_id: int):
    return db.query(models.Doctor).filter(models.Doctor.id == doctors_id).first()


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
    return db.query(models.Specialization).filter(models.Specialization.id == specialization_id).first()


def get_doctor_schedules_by_doctor_id(db: Session, doctor_id: int) -> models.DoctorSchedule:
    return db.query(models.DoctorSchedule).filter(models.DoctorSchedule.doctor_id == doctor_id).first()


def get_medical_record_by_id(db: Session, record_id: int):
    return db.query(models.MedicalRecord).filter(models.MedicalRecord.id == record_id).first()


def get_medical_record_by_patient_id(db: Session, patient_id: int) -> models.MedicalRecord:
    medical_record = db.query(models.MedicalRecord).filter(models.MedicalRecord.appointment.has(patient_id=patient_id)).first()
    return medical_record


def create_rating(db: Session, ratings: schemas.RatingCreate):
    db_ratings = models.Rating(patient_id = ratings.patient_id, rating = ratings.rating, comment = ratings.comment, category = ratings.category)
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


def create_appointment(db: Session, appointment: schemas.AppointmentCreate):
    db_appointment = models.Appointment(**appointment.dict())
    db.add(db_appointment)
    db.commit()
    db.refresh(db_appointment)
    return db_appointment


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
    appointment = db.query(models.Appointment).filter(models.Appointment.id == appointment_id).first()
    if not appointment:
        return None
    db.delete(appointment)
    db.commit()
    return appointment


def hashPassword(passwd: str):
    bytePwd = passwd.encode('utf-8')
    pwd_hash = bcrypt.hashpw(bytePwd, SALT)
    return pwd_hash