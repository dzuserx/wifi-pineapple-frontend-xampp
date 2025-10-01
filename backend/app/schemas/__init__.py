from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from enum import Enum

class ModuleType(str, Enum):
    installed = "installed"
    available = "available"

class NetworkBase(BaseModel):
    ssid: str
    bssid: Optional[str]
    channel: Optional[int]
    signal: Optional[int]
    encryption: Optional[str]
    client_count: Optional[int]

class NetworkCreate(NetworkBase):
    pass

class Network(NetworkBase):
    class Config:
        orm_mode = True

class ClientBase(BaseModel):
    mac: str
    vendor: Optional[str]
    packets: Optional[int]
    signal: Optional[int]
    connected_ssid: Optional[str]

class ClientCreate(ClientBase):
    pass

class Client(ClientBase):
    class Config:
        orm_mode = True

class ActivityLogBase(BaseModel):
    type: str
    message: str
    timestamp: datetime
    client_mac: Optional[str]

class ActivityLogCreate(ActivityLogBase):
    pass

class ActivityLog(ActivityLogBase):
    id: int
    class Config:
        orm_mode = True
