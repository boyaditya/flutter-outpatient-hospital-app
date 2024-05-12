from os import path

from fastapi import Depends, Request, FastAPI, HTTPException
# from fastapi.responses import FileResponse
# from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer
from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI

from typing import Annotated
from pydantic import BaseModel
from sqlalchemy.orm import Session

# import crud, models, schemas
import models
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
