from pydantic import BaseModel


class PasswordLoginBody(BaseModel):
    username: str
    password: str


class TokenLoginBody(BaseModel):
    token: str