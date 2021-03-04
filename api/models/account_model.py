from pydantic import BaseModel,EmailStr

class Login(BaseModel):
    userName:str
    password:str
class Register(Login):
    displayName: str
    email:EmailStr
