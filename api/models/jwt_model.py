from pydantic import BaseModel,EmailStr
from typing import Optional

class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    userName: Optional[str] = None
    userId: Optional[str] = None
    displayName: Optional[str] = None


# class User(BaseModel):
#     username: str
#     email: Optional[str] = None
#     full_name: Optional[str] = None
#     disabled: Optional[bool] = None


# class UserInDB(User):
#     hashed_password: str