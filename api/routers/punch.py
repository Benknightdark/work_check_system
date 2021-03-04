from fastapi import Depends, FastAPI, HTTPException, status,APIRouter
import json
from models import jwt_model,punch_model
from internal import db_service,jwt_service
router = APIRouter(prefix="/api/punch",tags=["Punch"])
@router.post("",summary="新增打卡資料")
async def post_punch(data:punch_model.Punch, jwt_auth:jwt_model.TokenData = Depends(jwt_service.get_current_active_user)):#
    data_dict=data.dict()
    create_data=db_service.punch_create(data_dict)
    return {'createId':str(create_data.inserted_id)}
    
@router.get("/{id}",summary="取得使用者打卡資料")
async def get_punch(id ,jwt_auth:jwt_model.TokenData = Depends(jwt_service.get_current_active_user)):#
    create_data=db_service.punch_get(id)
    return ((create_data))