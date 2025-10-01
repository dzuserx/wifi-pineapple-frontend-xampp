from fastapi import APIRouter, HTTPException
from backend.app.crud import get_clients, get_client, create_client, update_client, delete_client
from backend.app.schemas import Client, ClientCreate

router = APIRouter()

@router.get("/clients/", response_model=list[Client])
async def read_clients():
    return await get_clients()

@router.get("/clients/{mac}", response_model=Client)
async def read_client(mac: str):
    client = await get_client(mac)
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")
    return client

@router.post("/clients/", response_model=Client)
async def create_client_endpoint(client: ClientCreate):
    await create_client(client.dict())
    return client

@router.put("/clients/{mac}", response_model=Client)
async def update_client_endpoint(mac: str, client: ClientCreate):
    await update_client(mac, client.dict())
    return client

@router.delete("/clients/{mac}")
async def delete_client_endpoint(mac: str):
    await delete_client(mac)
    return {"message": "Client deleted"}
