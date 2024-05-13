from sqlalchemy.orm import Session
import models, schemas
import bcrypt


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


def get_user_by_id(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.id == user_id).first()


def delete_user_by_id(db: Session, user_id: int):
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if user:
        db.delete(user)
        db.commit()
        return user
    return None


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