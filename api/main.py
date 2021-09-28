from fastapi import Depends, FastAPI, HTTPException, Request, Response
from routers import  account,punch
from fastapi.middleware.gzip import GZipMiddleware
import json
from fastapi.exceptions import RequestValidationError
import sys
import traceback
import os 

if os.getenv('ENVIRONMENT') == 'production':
    app = FastAPI(docs_url=None, redoc_url=None)
else:
    app = FastAPI()


@app.middleware("http")
async def custom_response(request, call_next):

    res_data = {
        "title": '',
        "status": 0,
        "errors": None,
        "data": None
    }
    response = await call_next(request)
    print(response)
    if('/docs' in request.url.path):
        print(request.url.path)
        return response
    if('/openapi.json' in request.url.path):
        print(request.url.path)
        return response
    if('/redoc' in request.url.path):
        print(request.url.path)
        return response
    try:
        body = b""
        async for chunk in response.body_iterator:
            body += chunk
        print(body)    
        cc = json.loads(body.decode('utf-8', 'ignore'),
                        strict=False)  # .decode('utf-8')
        print(response)                
        res_data['data'] = cc
        res_data['status'] = response.status_code
        res_data['title'] = str(response.status_code)

        c2 = json.dumps(res_data)
        return Response(
            content=c2,
            status_code=response.status_code,
            media_type="application/json"
        )
        # return response
    except RequestValidationError as exc:
        body = await request.body()
        res_data['errors'] = {"error_msg": exc.errors(), "body": body.decode()}
        res_data['status'] = 422
        res_data['title'] = '422'
        return Response(status_code=422,  media_type="application/json", content=res_data)
    except Exception as e:
        print(e)
        error_class = e.__class__.__name__  # 取得錯誤類型
        detail = e.args[0]  # 取得詳細內容
        cl, exc, tb = sys.exc_info()  # 取得Call Stack
        lastCallStack = traceback.extract_tb(tb)[-1]  # 取得Call Stack的最後一筆資料
        fileName = lastCallStack[0]  # 取得發生的檔案名稱
        lineNum = lastCallStack[1]  # 取得發生的行號
        funcName = lastCallStack[2]  # 取得發生的函數名稱
        errMsg = "File \"{}\", line {}, in {}: [{}] {}".format(
            fileName, lineNum, funcName, error_class, detail)
        return Response(status_code=500,
                        media_type="application/json", content=json.dumps({
                            "title": '500',
                            "status": 500,
                            "errors": errMsg,
                        }))

app.include_router(account.router)
app.include_router(punch.router)
# app.include_router(edh.router)
