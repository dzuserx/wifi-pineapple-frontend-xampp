from fastapi import APIRouter
from backend.app.crud import get_activity_logs, create_activity_log
from backend.app.schemas import ActivityLog, ActivityLogCreate

router = APIRouter()

@router.get("/activity-logs/", response_model=list[ActivityLog])
async def read_activity_logs():
    return await get_activity_logs()

@router.post("/activity-logs/", response_model=ActivityLog)
async def create_activity_log_endpoint(log: ActivityLogCreate):
    await create_activity_log(log.dict())
    return log
