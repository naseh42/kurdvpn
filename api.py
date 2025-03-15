from fastapi import FastAPI
from user_manager import UserManager
from xray_manager import XRayManager

app = FastAPI()
user_manager = UserManager()
xray_manager = XRayManager()

@app.get("/users")
def get_users():
    return {"users": user_manager.list_users()}

@app.post("/add_user")
def add_user(username: str, password: str, data_limit: int, expiry_date: str):
    user_manager.add_user(username, password, data_limit, expiry_date)
    return {"message": "کاربر اضافه شد"}

@app.delete("/delete_user")
def delete_user(username: str):
    user_manager.delete_user(username)
    return {"message": "کاربر حذف شد"}

@app.get("/xray_config")
def get_xray_config():
    return xray_manager.load_config()

@app.post("/restart_xray")
def restart_xray():
    xray_manager.restart_xray()
    return {"message": "سرور XRay ریست شد"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)