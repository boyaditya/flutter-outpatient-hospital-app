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