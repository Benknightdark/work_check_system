from pydantic import BaseModel

class Punch(BaseModel):
    punchType:str
    punchDateTime:str
    userId:str
    latitude:str
    longtitude:str
    wifiBSSId:str
    wifiIP:str
    wifiName:str

