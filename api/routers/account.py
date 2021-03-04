from fastapi import Depends, FastAPI, HTTPException, status,APIRouter
import json
from models import account_model,jwt_model
from internal import db_service,jwt_service
from datetime import datetime, timedelta
router = APIRouter(prefix="/api/account",tags=["Account"])

@router.post("/register", response_model=jwt_model.Token)
async def register(data:account_model.Register,summary="註冊"):
    data_dict=data.dict()
    create_data=db_service.user_create(data_dict)
    access_token_expires = timedelta(minutes=jwt_service.ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = jwt_service.create_access_token(
        data={"userName": data_dict['userName'],"userId":str(create_data.inserted_id),"displayName":data_dict['displayName']}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}

@router.post("/login", response_model=jwt_model.Token,summary="登入")
async def login(data:account_model.Login):
    data_dict=data.dict()
    query_data=db_service.user_query(data_dict)
    print(query_data)
    if query_data !=None:
        access_token_expires = timedelta(minutes=jwt_service.ACCESS_TOKEN_EXPIRE_MINUTES)
        access_token = jwt_service.create_access_token(
            data={"userName": query_data['userName'],"userId":query_data['_id']['$oid'],"displayName":query_data['displayName']}, expires_delta=access_token_expires
        )
        return {"access_token": access_token, "token_type": "bearer"}
    else:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="帳號或密碼錯誤",
            headers={"WWW-Authenticate": "Bearer"},
        ) 
                   
@router.get("/me",summary="個人資訊")
async def read_users_me(jwt_auth:jwt_model.TokenData = Depends(jwt_service.get_current_active_user)):
    user_data=jwt_auth
    print(user_data)
    return user_data

