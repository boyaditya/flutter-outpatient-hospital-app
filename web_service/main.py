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


@app.get("/doctors/{doctors_id}", response_model=schemas.Doctor)
async def read_doctors(doctors_id: int, db: db_dependency):
    doctors = crud.get_doctors_by_id(db, doctors_id)
    if doctors is None:
        raise HTTPException(status_code=404, detail="Doctor not found")
    return doctors


path_doctor_img = "../img/"
@app.get("/doctors/image/{doctor_id}")
async def read_doctor_image(doctor_id: int):
    doctor = crud.get_doctor_by_id(db, doctor_id)
    if not doctor:
        raise HTTPException(status_code=404, detail="Doctor not found")
    img_name = doctor.img_name
    img_path = path_doctor_img + img_name
    if not path.exists(img_path):
        raise HTTPException(status_code=404, detail="Image file not found")
    return FileResponse(img_path)


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
    

@app.get("/specializations/{specialization_id}", response_model=schemas.Specialization)
async def read_specialization(specialization_id: int, db: db_dependency):
    specialization = crud.get_specialization_by_id(db, specialization_id)
    if specialization is None:
        raise HTTPException(status_code=404, detail="Specialization not found")
    return specialization    


path_specialization_img = "../img/" 
@app.get("/specializations/image/{specialization_id}")
async def read_specialization_image(specialization_id: int):
    specialization = crud.get_specialization_by_id(db, specialization_id)
    if not specialization:
        raise HTTPException(status_code=404, detail="Specialization not found")
    img_name = specialization.img_name
    img_path = path_specialization_img + img_name
    if not path.exists(img_path):
        raise HTTPException(status_code=404, detail="Image file not found")
    return FileResponse(img_path)


@app.get("/doctor_schedules/{doctor_id}", response_model=schemas.DoctorSchedule)
async def read_doctor_schedules(doctor_id: int, db: Session = Depends(get_db)):
    schedule = crud.get_doctor_schedules_by_doctor_id(db, doctor_id)
    if not schedule:
        raise HTTPException(status_code=404, detail="Doctor schedules not found")
    return schedule


@app.get("/medical_records/{record_id}", response_model=schemas.MedicalRecord)
async def read_medical_record(record_id: int, db: Session = Depends(get_db)):
    record = crud.get_medical_record_by_id(db, record_id)
    if record is None:
        raise HTTPException(status_code=404, detail="Medical record not found")
    return record


@app.get("/medical_records/patient/{patient_id}", response_model=schemas.MedicalRecord)
async def read_medical_records_by_patient_id(patient_id: int, db: Session = Depends(get_db)):
    medical_record = crud.get_medical_record_by_patient_id(db, patient_id)
    if not medical_record:
        raise HTTPException(status_code=404, detail="Medical record not found for this patient")
    return medical_record


@app.post("/ratings/"  ) 
def create_rating(ratings: schemas.RatingCreate, db: Session = Depends(get_db)):   
    return crud.create_rating(db=db, ratings=ratings)    