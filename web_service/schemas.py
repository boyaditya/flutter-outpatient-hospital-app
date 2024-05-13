from pydantic import BaseModel
from datetime import date, datetime


# ========= Appointment =========


class AppointmentBase(BaseModel):
    doctor_id: int
    patient_id: int
    date: date
    time: str
    coverage_type: str
    status: str
    queue_number: int


class AppointmentCreate(AppointmentBase):
    pass


class Appointment(AppointmentBase):
    id: int
    timestamp: datetime

    class Config:
        from_attributes = True


# ========== Doctor ==========


class DoctorBase(BaseModel):
    name: str
    img_name: str
    interest: str
    education: str
    id_specialization: int


class DoctorCreate(DoctorBase):
    pass


class Doctor(DoctorBase):
    id: int

    class Config:
        from_attributes = True


# ========== Patient ==========


class PatientBase(BaseModel):
    name: str
    date_of_birth: date
    phone: str
    nik: str
    gender: str
    user_id: int


class PatientCreate(PatientBase):
    pass


class Patient(PatientBase):
    id: int

    class Config:
        from_attributes = True


# ========== DoctorSchedule ==========


class DoctorScheduleBase(BaseModel):
    doctor_id: int
    day: str
    time: str


class DoctorScheduleCreate(DoctorScheduleBase):
    pass


class DoctorSchedule(DoctorScheduleBase):
    id: int

    class Config:
        from_attributes = True


# ========== MedicalRecord ==========


class MedicalRecordBase(BaseModel):
    appointment_id: int
    complaint: str
    diagnosis: str
    treatment: str
    notes: str


class MedicalRecordCreate(MedicalRecordBase):
    pass


class MedicalRecord(MedicalRecordBase):
    id: int

    class Config:
        from_attributes = True


# ========== Rating ==========


class RatingBase(BaseModel):
    patient_id: int
    rating: float
    comment: str
    category: str


class RatingCreate(RatingBase):
    pass


class Rating(RatingBase):
    id: int

    class Config:
        from_attributes = True


# ========== Specialization ==========


class SpecializationBase(BaseModel):
    title: str
    description: str
    img_name: str


class SpecializationCreate(SpecializationBase):
    pass


class Specialization(SpecializationBase):
    id: int

    class Config:
        from_attributes = True


# ========== User ==========


class UserBase(BaseModel):
    email: str


class UserCreate(UserBase):
    hashed_password: str


class User(UserBase):
    id: int

    class Config:
        from_attributes = True
        # orm_mode = True


class Token(BaseModel):
    access_token: str
    token_type: str