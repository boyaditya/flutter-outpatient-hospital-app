from sqlalchemy.orm import Session
import models, schemas
import bcrypt


def get_user_by_email(db: Session, email: str):
    return db.query(models.User).filter(models.User.email == email).first()


def create_user(db: Session, user: schemas.UserCreate):
    hashed_password = bcrypt.hashpw(user.hashed_password.encode('utf-8'), bcrypt.gensalt())
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