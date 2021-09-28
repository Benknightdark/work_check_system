from datetime import datetime, timedelta
from typing import Optional
from fastapi import Depends, FastAPI, HTTPException, status, APIRouter
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt
from passlib.context import CryptContext
import json
from models.jwt_model import Token, TokenData
SECRET_KEY = "bf3ed767731e2a7c77cbb1693db1468a50f4f0a1052757f9d92dbb8206ded372"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


async def get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="🖕登入後才能使用此功能🖕",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        print(token)
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        userName: str = payload.get("userName")
        userId: str = payload.get("userId")
        displayName: str = payload.get("displayName")
        print(payload)
        if userName is None:
            raise credentials_exception
        token_data = TokenData(
            userName=userName, userId=userId, displayName=displayName)
    except JWTError:
        raise credentials_exception
    if token_data.userName is None:
        raise credentials_exception
    return token_data


async def get_current_active_user(current_user: TokenData = Depends(get_current_user)):
    print(current_user)
    if current_user is None:
        raise HTTPException(status_code=400, detail="🖕使用者資料錯誤🖕")
    return current_user
