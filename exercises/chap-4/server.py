from typing import Annotated
from fastapi import FastAPI, Depends, Query
from sqlmodel import Field, Session, SQLModel, create_engine, select
from pydantic.dataclasses import dataclass
import os

class User(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str
    age: int


def db_connect():
    default_url = "postgresql+psycopg2://user:password@127.0.0.1:5432/app"
    url = os.getenv("DATABASE_URL", default_url)
    print(f"Connecting to database at: {url}")
    return create_engine(url)

engine = db_connect()

def create_db_and_tables():
    SQLModel.metadata.create_all(engine)

def get_db():
    with Session(engine) as session:
        yield session

Db = Annotated[Session, Depends(get_db)]

api = FastAPI()

@api.on_event("startup")
def on_startup():
    create_db_and_tables()


@api.get("/user")
def list_users(db: Db):
    return db.exec(select(User)).all()


@dataclass
class CreateUser:
    name: str
    age: int

@api.post("/user")
def create_user(db: Db, create_user: CreateUser):
    new_user = User(**create_user.__dict__)

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return new_user


