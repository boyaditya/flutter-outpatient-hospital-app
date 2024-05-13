from os import path

from fastapi import Depends, Request, FastAPI, HTTPException, status

# from fastapi.responses import FileResponser
# from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer
from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI

from typing import Annotated, List
from sqlalchemy.orm import Session

import crud, models, schemas
from database import SessionLocal, engine

import jwt
from fastapi.security import OAuth2PasswordBearer
from datetime import datetime, timedelta
from fastapi.security import OAuth2PasswordRequestForm

# from jose import jwt
# import datetime

models.Base.metadata.create_all(bind=engine)

app = FastAPI(title="Web Service Athena Hospital")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


db_dependency = Annotated[Session, Depends(get_db)]


@app.get("/")
async def root():
    return {"message": "Dokumentasi API: [url]:8000/docs"}


@app.post("/users/", response_model=schemas.User, status_code=status.HTTP_201_CREATED)
async def create_user(user: schemas.UserCreate, db: db_dependency):
    db_user = crud.get_user_by_email(db, email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    return crud.create_user(db=db, user=user)


@app.get("/doctors/", response_model=List[schemas.Doctor])
async def read_doctors(db: db_dependency):
    return crud.get_doctors(db)


@app.get("/users/{user_id}", response_model=schemas.User)
async def read_user(user_id: int, db: db_dependency):
    user = crud.get_user_by_id(db, user_id)
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user


@app.delete("/users/{user_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_user(user_id: int, db: db_dependency):
    deleted_user = crud.delete_user_by_id(db, user_id)
    if deleted_user is None:
        raise HTTPException(status_code=404, detail="User not found")


@app.post("/patients/", response_model=schemas.Patient, status_code=status.HTTP_201_CREATED)
async def create_patient(patient: schemas.PatientCreate, db: db_dependency):
    # Check if the user associated with the patient exists
    user = crud.get_user_by_id(db, patient.user_id)
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    # Create the patient
    return crud.create_patient(db=db, patient=patient)


@app.get("/patients/", response_model=List[schemas.Patient])
async def read_patients(db: db_dependency):
    return crud.get_patients(db)


@app.get("/patients/{patient_id}", response_model=schemas.Patient)
async def read_patient(patient_id: int, db: db_dependency):
    patient = crud.get_patient_by_id(db, patient_id)
    if patient is None:
        raise HTTPException(status_code=404, detail="Patient not found")
    return patient


@app.delete("/patients/{patient_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_patient(patient_id: int, db: db_dependency):
    deleted_patient = crud.delete_patient_by_id(db, patient_id)
    if deleted_patient is None:
        raise HTTPException(status_code=404, detail="Patient not found")


@app.post("/appointments/", response_model=schemas.Appointment, status_code=status.HTTP_201_CREATED)
async def create_appointment(appointment: schemas.AppointmentCreate, db: db_dependency):
    return crud.create_appointment(db=db, appointment=appointment)


@app.get("/appointments/{appointment_id}", response_model=schemas.Appointment)
async def read_appointment(appointment_id: int, db: db_dependency):
    appointment = crud.get_appointment_by_id(db, appointment_id)
    if appointment is None:
        raise HTTPException(status_code=404, detail="Appointment not found")
    return appointment


@app.get("/appointments/patient/{patient_id}", response_model=List[schemas.Appointment])
async def read_appointments_by_patient_id(patient_id: int, db: db_dependency):
    appointments = crud.get_appointments_by_patient_id(db, patient_id)
    if not appointments:
        raise HTTPException(status_code=404, detail="Appointments not found for this patient")
    return appointments



@app.post("/set_status_cancelled/{appointment_id}", response_model=schemas.Appointment)
async def set_status_cancelled(appointment_id: int, db: Session = Depends(get_db)):
    appointment = crud.update_appointment_status(db=db, appointment_id=appointment_id, new_status="cancelled")
    if appointment is None:
        raise HTTPException(status_code=404, detail="Appointment not found")
    return appointment

@app.post("/set_status_scheduled/{appointment_id}", response_model=schemas.Appointment)
async def set_status_scheduled(appointment_id: int, db: Session = Depends(get_db)):
    appointment = crud.update_appointment_status(db=db, appointment_id=appointment_id, new_status="scheduled")
    if appointment is None:
        raise HTTPException(status_code=404, detail="Appointment not found")
    return appointment

@app.post("/set_status_complete/{appointment_id}", response_model=schemas.Appointment)
async def set_status_complete(appointment_id: int, db: Session = Depends(get_db)):
    appointment = crud.update_appointment_status(db=db, appointment_id=appointment_id, new_status="complete")
    if appointment is None:
        raise HTTPException(status_code=404, detail="Appointment not found")
    return appointment


@app.delete("/appointments/{appointment_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_appointment(appointment_id: int, db: db_dependency):
    deleted_appointment = crud.delete_appointment_by_id(db, appointment_id)
    if deleted_appointment is None:
        raise HTTPException(status_code=404, detail="Appointment not found")