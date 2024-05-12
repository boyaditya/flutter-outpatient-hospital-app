from sqlalchemy import Column, Integer, String, Date, DateTime, Float, ForeignKey, Text
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from database import Base


class Appointment(Base):
    __tablename__ = "appointments"

    id = Column(Integer, primary_key=True)
    doctor_id = Column(Integer, ForeignKey("doctors.id"))
    patient_id = Column(Integer, ForeignKey("patients.id"))
    date = Column(Date)
    time = Column(String(20))
    coverage_type = Column(String(20))
    status = Column(String(20))
    timestamp = Column(DateTime, default=func.now())
    queue_number = Column(Integer)

    doctor = relationship("Doctor", back_populates="appointments")
    patient = relationship("Patient", back_populates="appointments")


class Doctor(Base):
    __tablename__ = "doctors"

    id = Column(Integer, primary_key=True)
    name = Column(String(100))
    img_name = Column(String(50))
    interest = Column(Text)
    education = Column(Text)
    id_specialization = Column(Integer, ForeignKey("specializations.id"))

    appointments = relationship("Appointment", back_populates="doctor")
    specialization = relationship("Specialization", back_populates="doctors")


class Patient(Base):
    __tablename__ = "patients"

    id = Column(Integer, primary_key=True)
    name = Column(String(100))
    date_of_birth = Column(Date)
    phone = Column(String(15))
    nik = Column(String(16))
    gender = Column(String(10))
    user_id = Column(Integer, ForeignKey("users.id"))

    appointments = relationship("Appointment", back_populates="patient")
    user = relationship("User", back_populates="patients")


class DoctorSchedule(Base):
    __tablename__ = "doctor_schedules"

    id = Column(Integer, primary_key=True)
    doctor_id = Column(Integer, ForeignKey("doctors.id"))
    day = Column(String(10))
    time = Column(String(20))

    doctor = relationship("Doctor", back_populates="schedules")


class MedicalRecord(Base):
    __tablename__ = "medical_records"

    id = Column(Integer, primary_key=True)
    appointment_id = Column(Integer, ForeignKey("appointments.id"))
    complaint = Column(String(255))
    diagnosis = Column(String(255))
    treatment = Column(String(255))
    notes = Column(Text)

    appointment = relationship("Appointment", back_populates="medical_records")


class Rating(Base):
    __tablename__ = "ratings"

    id = Column(Integer, primary_key=True)
    patient_id = Column(Integer, ForeignKey("patients.id"))
    rating = Column(Float)
    comment = Column(Text)
    category = Column(String(20))

    patient = relationship("Patient", back_populates="ratings")


class Specialization(Base):
    __tablename__ = "specializations"

    id = Column(Integer, primary_key=True)
    title = Column(String(50))
    description = Column(Text)
    img_name = Column(String(50))

    doctors = relationship("Doctor", back_populates="specialization")


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    email = Column(String(255))
    hashed_password = Column(String(255))

    patients = relationship("Patient", back_populates="user")